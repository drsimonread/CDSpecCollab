# Installing Visual Studio Code on Windows 11 or macOS

Visual Studio Code (VS Code) is a free code editor from Microsoft. This guide installs it on your own computer and sets up the `code` terminal command, ready for connecting to your GCP VM in the next guide. Follow the section for your operating system, then continue with the shared steps at the end. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Creating SSH keys](04-create-ssh-keys.md) | Next: [Creating your GCP VM](06-create-gcp-vm.md)

## Before you start

You need permission to install software on this computer. On Windows, installing for your own account does not require administrator rights; installing for all users does.

Everything here happens on your own computer. You do not need your VM yet; VS Code is installed now so it is ready as soon as the VM exists.

## If you are on Windows 11

### Step 1: Download the installer

1. Open your web browser (Edge, Chrome or Firefox).
2. Go to the [VS Code download page](https://code.visualstudio.com/download).
3. Click the **Windows** button. This downloads the installer, usually into your **Downloads** folder.

### Step 2: Run the installer

1. Open the **Downloads** folder (click the folder icon in the taskbar, or press `Windows key + E` and select **Downloads** on the left).
2. Double-click the file you downloaded (it is named something like `VSCodeUserSetup-x64-1.xx.x.exe`).
3. If a window asks "Do you want to allow this app to make changes to your device?", click **Yes**.

### Step 3: Complete the setup wizard

1. On the licence agreement screen, select **I accept the agreement**.
2. Click **Next**.
3. Click **Next** on the following screens to accept the default folder and settings, until you reach **Select Additional Tasks**.
4. On the **Select Additional Tasks** screen, make sure **Add to PATH (requires shell restart)** is checked. This lets you open VS Code by typing `code` in a terminal, which is useful once you are working with Django from the command line; it is easy to miss, and fixing it later means rerunning the installer.
5. It is also helpful to leave these checked:
   - **Add "Open with Code" action to Windows Explorer file context menu**
   - **Add "Open with Code" action to Windows Explorer directory context menu**
   - **Register Code as an editor for supported file types**
6. Click **Next**.
7. Click **Install** and wait for the installation to finish (usually under a minute).
8. Click **Finish**. VS Code opens automatically.

You can open VS Code at any time by clicking the **Start** button, typing `Visual Studio Code` and pressing `Enter`. Now skip to [Step 6](#step-6-confirm-vs-code-installed-correctly).

## If you are on macOS

### Step 4: Download and unzip the app

1. Open Safari (or any browser).
2. Go to the [VS Code download page](https://code.visualstudio.com/download).
3. Click the **Mac Universal** button. This works on both Intel and Apple Silicon Macs, and downloads a `.zip` file, usually into your **Downloads** folder.
4. Open **Finder**, then click **Downloads** on the left side.
5. Double-click the file you downloaded (named something like `VSCode-darwin-universal.zip`) if it has not unzipped automatically. This creates **Visual Studio Code.app**.
6. Drag **Visual Studio Code.app** into your **Applications** folder. You can open a second Finder window and click **Applications** on the left side to drag it there.

### Step 5: Open VS Code for the first time

1. Open **Applications** in Finder.
2. Double-click **Visual Studio Code**.
3. If macOS asks whether you are sure you want to open an app downloaded from the Internet, click **Open**.
4. Once VS Code is open, press `Cmd+Shift+P` to open the Command Palette.
5. Type `shell command` and select **Shell Command: Install 'code' command in PATH**. This lets you open VS Code by typing `code` in a terminal later.

You can open VS Code at any time from **Launchpad**, or by pressing `Cmd+Space`, typing `Visual Studio Code` and pressing `Enter`.

## Both operating systems

### Step 6: Confirm VS Code installed correctly

1. In VS Code, open **Help** in the menu bar (on macOS, **Code** in the menu bar).
2. Click **About**.

A window shows a version number, something like `1.xx.x`. Any version number here confirms the install worked.

## If something goes wrong

**Windows: VS Code does not open after installing**: restart your computer and open it from the **Start** menu.

**macOS: "Visual Studio Code cannot be opened because the developer cannot be verified"**: right-click (or Control-click) the app in **Applications** and choose **Open**, then confirm **Open** in the dialog. This only needs to be done once. If macOS still blocks it, go to **System Settings > Privacy & Security**, scroll down and click **Open Anyway** next to Visual Studio Code.

**Typing `code` in a terminal says "command not found"**: on Windows, **Add to PATH** was not checked during install; rerun the installer and check it this time. On macOS, open VS Code, press `Cmd+Shift+P` and run **Shell Command: Install 'code' command in PATH**.

## What to do next

With VS Code installed, [create your GCP VM](06-create-gcp-vm.md) so that VS Code has something to connect to.

## Sources

- [Download Visual Studio Code](https://code.visualstudio.com/download) (VS Code documentation)
- [Setting up Visual Studio Code for Windows](https://code.visualstudio.com/docs/setup/windows) (VS Code documentation)
- [Setting up Visual Studio Code for macOS](https://code.visualstudio.com/docs/setup/mac) (VS Code documentation)
