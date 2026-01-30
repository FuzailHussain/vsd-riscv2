# Task 1 Submission

## Program 1 execution 

 ![alt text](<Screenshot 2026-01-20 at 1.09.21 PM.png>)
 
 ![alt text](<Screenshot 2026-01-20 at 1.36.39 PM.png>)

## Answers to Understanding check

1. samples/sum1ton.c
2. compiled with riscv64-unknown-elf-gcc cmd which is risc version of gcc, run with spike pk to run on simulator
for real device we flash the memory with build flash, which is using iceprog, after generating bitstream.
3. For RAM it is through RAM module and for IO it is through checking isIO flag
4. We can integrate IP by adding it as memory mapped IO