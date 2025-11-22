

# Getting Started with RISC-V on GitHub Codespaces

Follow the steps below to set up and run programs in your own Codespace.

## Step 1. Open the Repository

Go to:
[https://github.com/vsdip/vsd-riscv2](https://github.com/vsdip/vsd-riscv2)

## Step 2. Create a Codespace

1. Log in with your GitHub account.
2. Click the green **Code** button.
3. Select **Open with Codespaces** → **New codespace**.
4. Wait while the environment builds. (First time may take 10–15 minutes.)

## Step 3. Verify the Setup

In the terminal that opens, type:

```
riscv64-unknown-elf-gcc --version
spike --version
iverilog -V
```

You should see version information for each tool.

## Step 4. Run Your First Program

1. Go to the `samples` folder.
2. Compile the program:

   ```
   riscv64-unknown-elf-gcc -o sum1ton.o sum1ton.c
   ```
3. Run it with Spike:

   ```
   spike pk sum1ton.o
   ```

Expected output:

```
Sum from 1 to 9 is 45
```

## Step 5. Next Steps

* You can edit and run your own C programs.
* You can also try Verilog programs using `iverilog`.

````md
### Step 6. Open the noVNC Desktop

1. In your Codespace window, click on the **PORTS** tab.  
2. Look for the entry **noVNC Desktop (6080)** and click the **Forwarded Address** link.

   ![noVNC port](images/2.png)

3. A new browser tab will open with a directory listing. Click on `vnc_lite.html`.

   ![noVNC directory](images/3.png)

4. You should now see a Linux desktop in your browser.

   ![XFCE desktop](images/4.png)

---

### Step 7. Open a Terminal Inside the Desktop

1. On the desktop, **right-click** anywhere on the background.  
2. Select **“Open Terminal Here”** from the menu to launch a terminal window.

   ![Open terminal](images/4.png)

---

### Step 8. Navigate to the Sample Programs

In the terminal, move to the Codespace workspace and open the `samples` folder:

```bash
cd /workspaces/vsd-riscv2
cd samples
ls -ltr
````

You should see files like `sum1ton.c`, `1ton_custom.c`, `load.S`, and `Makefile`.

![samples folder](images/5.png)

---

### Step 9. Compile and Run Using Native GCC

First, compile and run the C program with the standard `gcc` compiler:

```bash
gcc sum1ton.c
./a.out
```

You should see an output similar to:

```text
Sum from 1 to 9 is 45
```

![gcc run](images/6.png)

---

### Step 10. Compile and Run on the RISC-V Toolchain

Now compile the same program for RISC-V and run it on the Spike ISA simulator:

```bash
riscv64-unknown-elf-gcc -o sum1ton.o sum1ton.c
spike pk sum1ton.o
```

You will see the proxy kernel (`pk`) and then the same program output:

```text
bbl loader
Sum from 1 to 9 is 45
```

![spike run](images/7.png)

---

### Step 11. Edit the C Program in a GUI Editor

To edit the program using a graphical editor:

```bash
gedit sum1ton.c &
```

This opens `sum1ton.c` in **gedit** on the noVNC desktop.
Modify the code (for example, change the range of the sum), save the file, and then re-run:

```bash
riscv64-unknown-elf-gcc -o sum1ton.o sum1ton.c
spike pk sum1ton.o
```

![gedit edit](images/8.png)

You have now:

* Opened a full Linux desktop inside GitHub Codespaces
* Compiled and executed a C program with native GCC
* Compiled and executed the same program on a RISC-V target using Spike
* Edited and re-built the code using a GUI editor over noVNC

```
```



