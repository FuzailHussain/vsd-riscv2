#include <stdint.h>
#include <stdio.h>

// Define the address as a volatile pointer to 32-bit integer
#define TARGET_ADDRESS ((volatile uint32_t *)0x20000000)

#define DELAY 100

// Software delay for bare-metal RISC-V
void wait_cycles(volatile int count) {
    while (count-- > 0) {
        __asm__ volatile("nop");
    }
}

void memory_access_demo() {
    // uint32_t data_to_write = 0xDEADBEEF;
    uint32_t data_read = 0;

    // --- WRITE TO MEMORY ---
    *TARGET_ADDRESS = 0x12345678;
    // printf("Written 0x%X to address 0x20000000\n", 123);

    wait_cycles(10);
    // --- READ FROM MEMORY ---
    data_read = *TARGET_ADDRESS;

    // printf("Read 0x%X from address 0x20000000\n", data_read);
}

int main() {
    // In actual embedded systems, 0x20000000 is often a mapped register or RAM
    memory_access_demo();
    return 0;
}