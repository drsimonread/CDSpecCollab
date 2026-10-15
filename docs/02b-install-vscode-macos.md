# Installing VS Code on macOS

Visual Studio Code (VS Code) is a free code editor from Microsoft, and it is where you will write and run all the code for the team project. This guide installs it on a Mac. No prior technical experience is needed.

If your laptop runs Windows, use [02a Install VS Code on Windows](02a-install-vscode-windows.md) instead.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Step 1: Check whether VS Code is already installed

1. Open **Finder** and click **Applications** on the left.
2. If **Visual Studio Code** is there, it is already installed: go to Step 5 to confirm the version, and skip the rest if it is recent. Otherwise, continue with Step 2.

## Step 2: Download VS Code

1. Open Safari or any other web browser.
2. Go to the [VS Code download page](https://code.visualstudio.com/download).
3. Click the large **Mac** button (it may say **Mac Universal**). This version works on both Intel and Apple silicon Macs. It downloads a zip file (a compressed package) to your **Downloads** folder.

## Step 3: Unzip the download and move the app

1. Open **Finder** and click **Downloads** on the left.
2. Look for the blue **Visual Studio Code** app. Safari usually unzips downloads for you, so it may already be there.
3. If you can see only the zip file (named something like `VSCode-darwin-universal.zip`), double-click it and wait a few seconds for the **Visual Studio Code** app to appear beside it.
4. Open a second Finder window (**Cmd+N**) and click **Applications** on the left.
5. Drag **Visual Studio Code** from **Downloads** into **Applications**.

This step matters. An app run from **Downloads** cannot update itself, and macOS may warn you about it every time you open it.

## Step 4: Open VS Code for the first time

1. In the **Applications** window, double-click **Visual Studio Code**.
2. If macOS asks whether you are sure you want to open an app downloaded from the internet, click **Open**.
3. If macOS refuses to open it instead, open **System Settings**, click **Privacy & Security**, scroll down, and click **Open Anyway** next to the message about Visual Studio Code. Then confirm with your password if asked. You only need to do this once.

## Step 5: Confirm it installed correctly

1. VS Code opens with a welcome screen.
2. Open the **Code** menu (beside the Apple menu) and click **About Visual Studio Code**.
3. A box shows the version, something like `Version: 1.1xx.x`. Any version number confirms the installation worked.
4. Close the box.

## Step 6: Keep VS Code handy

1. While VS Code is running, Control-click its icon in the Dock.
2. Choose **Options**, then **Keep in Dock**.

You can also open it at any time by pressing **Cmd+Space**, typing `Visual Studio Code` and pressing **Return**.

## Step 7: Enable the `code` command in Terminal (optional)

This lets you type `code .` in Terminal to open the current folder in VS Code, which some tutorials assume. You do not need it for the rest of these guides.

1. In VS Code, press **Cmd+Shift+P** to open the "Command Palette" (a search box for every command VS Code knows).
2. Type `shell command` and choose **Shell Command: Install 'code' command in PATH**.
3. Enter your password if asked.

## Step 8: Adjust the appearance (optional)

1. To change the colour theme, press **Cmd+K**, let go, then press **Cmd+T**, and choose a theme from the list. **Light High Contrast** and **Dark High Contrast** have the strongest contrast.
2. To make everything larger, press **Cmd** and **+** together. Press **Cmd** and **-** to make it smaller again.

## Step 9: Clean up after yourself

1. Check that **Visual Studio Code** is in **Applications**, not still in **Downloads**. (If it is still in **Downloads**, deleting downloads would delete the app; go back to Step 3.)
2. In **Downloads**, click the zip file once to select it.
3. Press **Cmd+Delete** to move it to the Trash.
4. Control-click the **Trash** icon at the end of the Dock, check what is in it if you are unsure, and choose **Empty Trash**. Emptying it is permanent.

## If something goes wrong

**There is a "Visual Studio Code 2" in Downloads.** The zip was unpacked twice. Drag one copy to **Applications** and move the other, and the zip, to the Trash.

**Double-clicking the zip does nothing.** Control-click it, choose **Open With**, then **Archive Utility**.

**macOS says VS Code "cannot be opened because the developer cannot be verified".** Use **Open Anyway** in **System Settings**, **Privacy & Security**, as in Step 4.

**Typing `code` in Terminal says "command not found".** Run Step 7, then close Terminal and open a new window.

## What to do next

Add the extensions the course uses: [03 Install the VS Code extensions](03-install-vscode-extensions.md).

## Sources

- [Download Visual Studio Code](https://code.visualstudio.com/download)
- [Visual Studio Code on macOS (VS Code documentation)](https://code.visualstudio.com/docs/setup/mac)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
