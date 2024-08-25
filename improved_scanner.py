import re
import subprocess
import os
import argparse
from itertools import zip_longest
from pathlib import Path



parser = argparse.ArgumentParser(description='Scan items in a directory')
parser.add_argument('directory_path', type=str, help='Path to the directory')
parser.add_argument('extension', type=str, help='Extention of sample to scan')
parser.add_argument("-s", "--show", action="store_true", help='option to display all detected files')
args = parser.parse_args()



def defender_scan(path):
    """
    Scan a file using Windows Defender (MpCmdRun.exe) and return threat information if found.

    Args:
    - path (str): Path to the file to be scanned.

    Returns:
    - tuple: (found (bool), threat (str), path (str))
    """
    if not os.path.exists(path):
        raise FileNotFoundError(f'File not found: {path}')

    exe = r"C:\Program Files\Windows Defender\MpCmdRun.exe"

    cmd = [
        exe,
        "-Scan",
        "-ScanType", "3",
        "-File", f'"{path}"',
        "-DisableRemediation",
        "-Trace",
        "-Level", "0x10"
    ]

    try:
        proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = proc.communicate()

        if stdout:
            stdout = stdout.lower()
            if "no threats" in stdout:
                return False, 'Clean', path
            else:
                threat = re.findall(r'\s+threat\s+:\s+(.*)', stdout)[0]
                return True, threat, path

        if stderr:
            print("Standard Error:")
            print(stderr)

    except Exception as e:
        print(f"Error scanning {path}: {str(e)}")

# def split_sample(file_path):
#     """
#     Split the file into chunks and scan each chunk for threats.

#     Args:
#     - file_path (str): Path to the file to be split and scanned.
#     """
#     temp_folder = os.path.join(os.getcwd(), 'temp')
#     if not os.path.exists(temp_folder):
#         os.mkdir(temp_folder)

#     print('Splitting the sample into 2')
#     with open(file_path, 'r', encoding='utf-8') as file:
#         file_content = file.read()
#         first_half_length = round(len(file_content) //2)
#         half_split = [file_content[:first_half_length],file_content[first_half_length:]]
#         counter = 0
#         for part in half_split:
#             name= hashlib.md5(part.encode()).hexdigest()
#             temp_file_path= temp_folder + str(name)
#             with open(temp_file_path,'w') as temp_file:
#                 temp_file.write(part)
#                 found, threat,path = defender_scan(temp_file_path)
#                 if threat:
#                     print('Found threat in part' + str(counter+1))
#                     part = file

#             os.remove(temp_file_path)
#             counter += counter

#     file.close()
    

# def split_to_chunks(data, size):
#     """
#     Split a string into chunks of specified size.

#     Args:
#     - data (str): Input string to be split.
#     - size (int): Size of each chunk.

#     Returns:
#     - list: List of string chunks.
#     """
#     return [data[i:i + size] for i in range(0, len(data), size)]

def bulk_scan(scan_path,extension):
    """
    Scan a file for threats using Windows Defender and perform additional actions if threat is found.

    Args:
    - file (str): Path to the file to be scanned.
    """
    result = []
    # list of file to scan
    samples = [f for f in os.listdir(scan_path) if os.path.isfile(os.path.join(scan_path, f)) and f.lower().endswith("."+extension)]
    for sample in samples:
        print('[*] Scanning :'+ sample)
        scan_result, threat, path = defender_scan(scan_path+'\\'+sample)
        result.append((sample,scan_result))
    return result

# Example usage:
# bad_file = r'F:\\C2\test-sample\\Invoke-Mimikatz.ps1'
# good_file = r'F:\\C2\test-sample\\good_file.ps1'

# scan(bad_file)

def main():
    print("Started Scanner")
    result = bulk_scan(args.directory_path,args.extension)
    total_file_number = len(result)
    detected = 0
    not_detected = 0
    detected_list = []
    no_detected_list = []
    print('Total files: ' + str(total_file_number))
    for i in result:
        if i[1]:
            detected += 1
            detected_list.append(i[0])
        elif not i[1]:
            not_detected += 1
            no_detected_list.append(i[0])
    print('\n')
    print('[*] Result')
    print('\n')
    print('[*] Total Detected : '+ str(detected))
    print('[*] Total Not Detected : '+ str(not_detected))
    print('[*] Deteation rate : '+ str(round((detected / total_file_number)*100,2) ) + " Percent")
    print('\n')
    if args.show:
        print('[*] Detected files : ')
        print(detected_list)
        print('[*] Not Detected Files: ')
        print(no_detected_list)

    
def scan_from_cli(path):
    if args.directory_path.exists():
        print(f"Scanning items in directory: {args.directory_path}")
    for item in args.directory_path.iterdir():
        print(item)
    else:
        print(f"Directory does not exist: {args.directory_path}")

if __name__ == "__main__":
    main()
