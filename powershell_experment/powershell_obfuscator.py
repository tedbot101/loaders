import re
import random
import string
import os
from chameleon.chameleon import Chameleon
from Defender_Scanner import denfender_scan

boolean_true = [
    '[bool]1254',
'[bool]0x12AE',
'[bool][convert]::ToInt32("111011", 2)', # Converts a string to int from base 2 (binary)
'![bool]$null',
'![bool]$False',
'[bool]"Any non empty string"',
'[bool](-12354893)',   # Boolean typecast of a negative number 
'[bool](12 + (3 * 6))',
'[bool](Get-ChildItem -Path Env: | Where-Object {$_.Name -eq "username"})',
'[bool]@(0x01BE)',
"[bool][System.Collections.ArrayList]",
"[bool][System.Collections.CaseInsensitiveComparer]",
"[bool][System.Collections.Hashtable]",
"(9999 -eq 9999)",
"([math]::Round([math]::PI) -eq (4583 - 4580))",
"[Math]::E -ne [Math]::PI",
]

config = {
        "strings": True,
        "variables": True,
        "data-types": True,
        "functions": True,
        "comments": True,
        "spaces": True,
        "cases": True,
        "nishang":True,
        #"backticks": True,
        #"random-backticks": False,
        #"backticks-list": False,
        "hex-ip": False,
        "random-type": 'r',
       # "decimal": None,
        "base64": True,
        "tfn-values": False,
        "safe": True,
        "verbose": False
    }
keywords = ['SpawnConPtyShell',]
def generate_random_name():
    # Generate a random name with 2-8 characters
    name_length = random.randint(2, 8)
    name = ''.join(random.choice(string.ascii_lowercase) for _ in range(32))
    return name



def process_line(line):
    # Remove comments
    #result = re.sub(r"[<#].*?[#>]", "", x)
    # Replace variable and function names
    line = re.sub(r'\$\w+', generate_random_name(), line)
    line = re.sub(r'function \w+', 'function ' + generate_random_name(), line)
    if 'iex' in line:
        line = line.replace('iex',"i\"'e'\"x")
    if 'IEX' in line:
        line = line.replace('IEX',"i\"'e'\"x")
    if 'pwd' in line:
        line = line.replace('pwd',"p\"''w''\"d'")
    if '$True' in line:
        line = line.replace('IEX',random.choice(boolean_true))
    if '[text.encoding]::ASCII' in line:
        line = line.replace('[text.encoding]::ASCII',"'[text.encoding]::UTF-8'")
    if '[text.encoding]' in line:
        line = line.replace('[text.encoding]','"[text"+".enco"+"ding]"')
    if ';' in line:
        line = line.replace(';',';\n')
    return line

def main(input_path):
    output_path = os.getcwd()+'/obfuscated_files'
    if not os.path.exists(output_path):
        os.makedirs(output_path)
    counter = 0
    error_counter = 0
    detection_counter = 0
    sample_list = os.listdir(input_path)
    #print(sample_list[0:10])
    
    for i in sample_list:
        print("Input File:" + input_path+i)
        try:
            
            with open(input_path+i, 'r') as infile:
                raw_string = infile.read()
                # remove comment
                matches = re.findall(r"(<#[\s\S.]*#>)", raw_string )
                for match in matches:
                    if match != None:
                        raw_string= raw_string.replace(match,'')
                    else:
                        raw_string = raw_string
                #print(lines)
            modified_lines = [process_line(line) for line in raw_string]
            output_file_name = output_path+'/'+str(counter)+'.ps1'
            with open(output_file_name , 'w') as outfile:
                outfile.writelines(modified_lines)
            print("output_file_name"+output_file_name)
            # chameleon 
            # final = Chameleon(filename=output_file_name, outfile=output_file_name, config=config)
            # final.obfuscate()
            # final.write_file()
            os.system('python chameleon\\chameleon.py -v -s -n -f -r -b  --safe --verbose ' + output_file_name + ' -o ' + output_file_name)
            counter += 1
            found, threat,path = denfender_scan(output_file_name)
            if found:
                detection_counter += 1

        except Exception as err:
            error_counter =+ 1
            print(err)

    print('Total Success : '+str(counter))
    print('Total Error : '+str(error_counter))
    print('Detected items: ' + str(detection_counter))
    print('Detection rate: '+str(detection_counter) + ' / ' + str(counter))

if __name__ == '__main__':
    #main('F:\\C2\\working\\powershell_obfuscator\\malicious_samples\\')
    main('F:\\C2\\working\\powershell_obfuscator\\powershell_reverse_shell\\')
    #main('F:\\C2\\powershell_sample\\nishang\\Shells\\')
    print("Done")
