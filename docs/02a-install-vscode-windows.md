# Installing VS Code on Windows

Visual Studio Code (VS Code) is a free code editor from Microsoft, and it is where you will write and run all the code for the team project. This guide installs it on a Windows 10 or Windows 11 laptop. No prior technical experience is needed.

If your laptop is a Mac, use [02b Install VS Code on macOS](02b-install-vscode-macos.md) instead.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need permission to install software on your laptop. The version this guide installs (the "User Installer") installs for your account only, so it does not need administrator rights.

## Step 1: Check whether VS Code is already installed

1. Click the **Start** button.
2. Type `Visual Studio Code`.
3. If **Visual Studio Code** appears as an app, it is already installed: go to Step 6 to confirm the version, and skip the rest if it is recent. Otherwise, continue with Step 2.

## Step 2: Download the installer

1. Open your web browser (Edge, Chrome or Firefox).
2. Go to the [VS Code download page](https://code.visualstudio.com/download).
3. Click the large **Windows** button. The installer downloads to your **Downloads** folder.

## Step 3: Run the installer

1. Open **File Explorer** (the folder icon in the taskbar, or press **Windows+E**).
2. Click **Downloads** on the left.
3. Double-click the file you downloaded. It is named something like `VSCodeUserSetup-x64-1.xxx.x.exe`.
4. If Windows asks whether you want to allow this app to make changes to your device, click **Yes**.

## Step 4: Work through the setup wizard

1. On the licence agreement screen, select **I accept the agreement**, then click **Next**.
2. Leave the installation folder as it is and click **Next**.
3. Leave the Start menu folder as it is and click **Next**.
4. On the **Select Additional Tasks** screen, make sure **Add to PATH (requires shell restart)** is ticked. It usually is already; check it anyway, because this is the box that lets you type `code` in a terminal to open VS Code, which some later instructions assume.
5. Also tick **Add "Open with Code" action to Windows Explorer file context menu** and the matching **directory context menu** option. They let you right-click a file or folder and open it in VS Code.
6. Click **Next**, then click **Install**.
7. Wait for the installation to finish. This usually takes under a minute.
8. Click **Finish**. VS Code opens.

## Step 5: Find VS Code again later

1. Click the **Start** button.
2. Type `Visual Studio Code` and press **Enter**.
3. To keep it handy, right-click its icon in the taskbar while it is running and choose **Pin to taskbar**.

## Step 6: Confirm it installed correctly

1. In VS Code, open the **Help** menu and click **About**.
2. A box shows the version, something like `Version: 1.1xx.x`. Any version number confirms the installation worked.
3. Click **OK** (or **Copy**, then close the box).

## Step 7: Adjust the appearance (optional)

VS Code comes with several colour themes and a zoom setting, which are worth changing if the text is hard to read.

1. To change the theme, press **Ctrl+K**, let go, then press **Ctrl+T**, and choose a theme from the list. **Light High Contrast** and **Dark High Contrast** have the strongest contrast.
2. To make everything larger, press **Ctrl** and **+** together. Press **Ctrl** and **-** to make it smaller again.

## Step 8: Clean up after yourself

The installer is no longer needed once VS Code works, and you can always download it again.

1. Open **File Explorer** and click **Downloads**.
2. Click the installer file (`VSCodeUserSetup-x64-1.xxx.x.exe`) once to select it.
3. Press **Delete**.
4. Open the **Recycle Bin** on the desktop, check that it contains only things you mean to delete, then click **Empty Recycle Bin** and confirm. Emptying it is permanent.

Deleting the installer does not affect VS Code itself, which is installed elsewhere.

## If something goes wrong

**Windows says the app is not from the Microsoft Store, or that it protected your PC.** Click **More info**, check that the publisher is **Microsoft Corporation**, then click **Run anyway**. If the publisher is anything else, delete the file and download it again from the VS Code download page.

**VS Code did not open after clicking Finish.** Open it from the **Start** menu (Step 5). If it still does not open, restart your laptop and try again.

**Typing `code` in a terminal says "'code' is not recognized".** Close every terminal window and open a new one: Windows reads the PATH only when a program starts. If it still fails, run the installer again and make sure **Add to PATH** is ticked (Step 4). You do not need `code` for the rest of these guides, so this can wait.

## What to do next

Add the extensions the course uses: [03 Install the VS Code extensions](03-install-vscode-extensions.md).

## Sources

- [Download Visual Studio Code](https://code.visualstudio.com/download)
- [Visual Studio Code on Windows (VS Code documentation)](https://code.visualstudio.com/docs/setup/windows)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
