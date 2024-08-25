import os
import subprocess
import requests
import zipfile
from io import BytesIO
current_path = os.getcwd()+'\\'
url = 'http://192.168.56.140/payload.zip'
print("***** Starting Mass compiler *****")
print('[*]Downloading zip file')
response = requests.get(url)
with zipfile.ZipFile(BytesIO(response.content)) as z:
    print('[*]Extracting...')
    z.extractall()

# delete existing exe
# exe_files = [f for f in os.listdir(current_path) if f.endswith('.exe')]
# for file in exe_files:
    #if os.path.exists(file) and file.lower().endwith('.exe'):
        #os.remove(file)


current_path = os.getcwd()+'\\'
cpp_files = [f for f in os.listdir(current_path) if f.endswith('.cpp')]
csharp_files = [f for f in os.listdir(current_path) if f.endswith('.cs')]
compiler_options =  "/O2 /W4"
compile_path = f'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\'


print('[*]Compiling CS payload, may take a while')
# compile cs
#os.chdir('C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\')
for x in csharp_files:
    output_name = x[:-3]
    input_name = x
    # C:\Windows\Microsoft.NET\Framework64\v4.0.30319
    
    command = f'C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\csc.exe /t:exe /out:{output_name}.exe {input_name}'
    #print(command)
    os.system(command)
    #subprocess.run(['C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\csc.exe','/t:exe','/out:'+output_name+'.exe', input_name])
print('Done')
#os.chdir(current_path)
    
vs_command_prompt = r"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\Common7\Tools\VsDevCmd.bat"

print('[*]Compiling C++ payload, may take a while')
# Compile the C++ source file
for i in cpp_files:
    output_name = i[:-4]
    input_name = i
    subprocess.run([vs_command_prompt,'&&',"cl", "/O2", "/W4", input_name, f"/Fe{output_name}"+'.exe'], shell=True, text=True, capture_output=True)
print('Done')


