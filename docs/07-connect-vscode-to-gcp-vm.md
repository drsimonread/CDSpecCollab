# Connecting VS Code to Your GCP VM with Remote Development

Remote Development lets VS Code edit and run code on another machine while you keep using your normal VS Code window. Think of it as a remote control: the buttons are on your desk, but the television is in Google's data centre. This guide installs the Remote Development extensions, shows you how to find your VM's current address, and connects to it as `sread`. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Creating your GCP VM](06-create-gcp-vm.md) | Next: [Installing git on your GCP VM](08-install-git-on-gcp-vm.md)

## Before you start

You need:

1. [VS Code installed](05-install-vscode.md) on your own computer.
2. Your [SSH key pair](04-create-ssh-keys.md) on your own computer, saved in the default location (`id_ed25519` in your `.ssh` folder). VS Code finds a key there automatically; if you gave yours a different name, see "If something goes wrong" below.
3. Your [GCP VM](06-create-gcp-vm.md) created with your public key, and running (a green tick in the **VM instances** list). If you stopped it, start it again as in [Creating your GCP VM, Step 11](06-create-gcp-vm.md#step-11-start-your-instance-again-when-you-need-it).

## Why you type the address every time

Your VM's "external IP" is its address on the internet, four numbers separated by dots such as `34.86.123.45`. Google lends the VM an address when it starts and takes it back when it stops, so each time you start the VM it usually gets a different one. It is rather like a hotel room: the hotel is the same every visit, but the room number is whatever the front desk hands you that night. Rather than writing the address down somewhere that will be wrong tomorrow, you look it up and type it each time you connect, which takes a few seconds.

## Step 1: Install the Remote Development extension pack

You only need to do this once.

1. Open **Visual Studio Code**.
2. Click the **Extensions** icon in the left-hand sidebar (four small squares with one detached), or press `Ctrl+Shift+X` on Windows or `Cmd+Shift+X` on macOS.
3. In the search box, type `Remote Development`.
4. Find the entry named **Remote Development** published by **Microsoft**.
5. Click **Install**.

This installs a bundle of extensions at once (Remote - SSH, Dev Containers, WSL and Remote - Tunnels), but only **Remote - SSH** is needed for connecting to your GCP VM.

## Step 2: Find your VM's external IP

Do this every time you start your VM.

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Check that your project (for example `cdspeccollab-project`) is selected in the dropdown at the top of the page.
3. Open the navigation menu (three horizontal lines, top-left) and click **Compute Engine**, then **VM instances**.
4. Find your VM's row (for example `cdspeccollab-vm`) and check its **Status** column shows a green tick. A stopped VM has no external IP; start it first ([Creating your GCP VM, Step 11](06-create-gcp-vm.md#step-11-start-your-instance-again-when-you-need-it)).
5. Look along the same row to the **External IP** column. The number there (such as `34.86.123.45`) is your VM's current address.

If you cannot see an **External IP** column, the browser window may be too narrow; scroll the table sideways or widen the window.

## Step 3: Copy the external IP to the clipboard

1. If a copy icon (two overlapping rectangles) appears when you hover the mouse over the address, click it and skip to Step 4.
2. Otherwise, press and hold the mouse button just to the right of the last digit of the address.
3. Drag to the left until the whole address is highlighted, from the last digit back to the first. Starting at the end avoids clicking the address itself, which in some layouts is a link that opens a new browser tab.
4. Copy the highlighted text: `Ctrl+C` on Windows, `Cmd+C` on macOS.

Copy only the numbers and dots. Some layouts show a label such as `(nic0)` or an icon next to the address; leave those out.

## Step 4: Connect to your VM

1. In VS Code, click the small green **><** icon in the bottom-left corner of the window. (If you do not see it, press `Ctrl+Shift+P` on Windows or `Cmd+Shift+P` on macOS, and type `Remote-SSH: Connect to Host...` instead.)
2. Click **Connect to Host...**. A box opens at the top of the window.
3. Type your username followed by `@` (for example `sread@`).
4. Paste the external IP straight after the `@` (`Ctrl+V` on Windows, `Cmd+V` on macOS). The box should now contain something like:

   ```
   sread@34.86.123.45
   ```

   The username before the `@` must match the name at the end of your public key ([Creating SSH keys, Step 3](04-create-ssh-keys.md#step-3-choose-your-username)); it tells the VM which account to let you into.

5. Press Enter.
6. If asked for the platform of the remote host, select **Linux**.
7. If asked whether to continue connecting to a host with this fingerprint, click **Continue**. This appears the first time you connect to each new address, so expect it after most restarts.
8. Enter your key's passphrase if you set one.
9. Wait while the new window connects. The first time, VS Code installs a small server component on the VM, which can take a minute or two; a progress notification describes this.

Once connected, the indicator in the bottom-left corner shows `SSH: 34.86.123.45` (your VM's address). This confirms the window is now working with files on your VM rather than on your own computer.

VS Code remembers addresses you have used, so old ones build up in the **Connect to Host...** list. Ignore them; after a restart they point at nothing (or, worse, at someone else's VM), so always type the current address.

## Step 5: Confirm the remote connection

1. Click **Terminal** in the menu bar.
2. Click **New Terminal**.
3. Type:

   ```
   pwd
   ```

The path should be `/home/sread`, your home folder on the VM, not a folder on your own computer. The prompt also ends in `sread@cdspeccollab-vm:~$`, showing your username and the VM's name. This confirms that this terminal, and any code you run from it, executes on the VM. From now on, whenever a guide asks you to type a command on the VM, this is where you type it.

## Step 6: Open a folder and start working

1. Click **Open Folder** (or **File > Open Folder**).
2. Select `/home/sread` for now, and click **OK**.
3. If a dialog asks whether you trust the folder's authors, click **Yes, I trust the authors**; this is your own VM.

VS Code now behaves normally: editing, saving and using the built-in terminal all happen on the VM, even though the window looks the same as always.

Once you have cloned a project ([guide 10](10-clone-branch-merge-cdspeccollab.md)), open its folder (for example `/home/sread/CDSpecCollab`) instead.

## Step 7: Disconnect when finished

1. Click the green remote indicator in the bottom-left corner.
2. Select **Close Remote Connection**.
3. [Stop your VM](06-create-gcp-vm.md#step-10-stop-your-instance-when-you-are-not-using-it) in the Google Cloud Console if you have finished for the day.

Next time, start the VM and repeat Steps 2 to 4 (and 6) with its new address.

## Other kinds of remote connection

You will not need these for this course, but the extension pack you installed supports two other kinds of connection:

- **Dev Containers**: connects into a Docker container, a self-contained environment with its own tools pre-installed. With a project folder open that includes a `.devcontainer` configuration file, open the Command Palette and run `Dev Containers: Reopen in Container`.
- **WSL** (Windows only): connects into a Linux environment running inside Windows. First install WSL itself: right-click the **Start** button, choose **Terminal (Admin)**, and run `wsl --install` in the PowerShell window that opens, restarting if prompted. Then in VS Code, open the Command Palette and run `WSL: Connect to WSL`.

## If something goes wrong

**"Could not establish connection" or the connection times out**: the VM is stopped, or you used an address from a previous session. Check the **VM instances** list for a green tick, copy the current **External IP** again (Steps 2 and 3) and reconnect.

**"Permission denied (publickey)"**: the username before the `@` does not match the name at the end of the public key you added to the VM. Check the key ([Creating SSH keys, Step 6](04-create-ssh-keys.md#step-6-display-your-public-key-and-confirm-it-is-correct)) and retype the username exactly.

**Your key is not called `id_ed25519`** (for example `id_ed25519_course`): SSH only tries the default key names on its own, so tell it which key to use. In the **Connect to Host...** box, type the full command instead, for example:

- **macOS:** `ssh -i ~/.ssh/id_ed25519_course sread@34.86.123.45`
- **Windows:** `ssh -i C:\Users\sread\.ssh\id_ed25519_course sread@34.86.123.45`

**"WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!"**: Google has handed your VM an address that your computer previously saw on a different machine (addresses are recycled). Your computer is right to be suspicious, but here the cause is harmless. Open a terminal on your own computer (PowerShell on Windows, Terminal on macOS) and forget the old record for that address, replacing the example with your VM's address:

```
ssh-keygen -R 34.86.123.45
```

Then connect again and click **Continue** at the fingerprint prompt.

**The pasted address includes extra text** (such as `(nic0)` or a space): delete everything after the last digit before pressing Enter, or copy the address again more carefully.

**Other temporary connection problems**: confirm you have internet access, then restart VS Code and try again.

## What to do next

With VS Code connected to your VM, use its terminal to [install and configure git on the VM](08-install-git-on-gcp-vm.md).

## Sources

- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview) (VS Code documentation)
- [Remote development over SSH](https://code.visualstudio.com/docs/remote/ssh) (VS Code documentation)
- [Remote Development extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) (Visual Studio Marketplace)
- [Locate IP addresses for a VM instance](https://cloud.google.com/compute/docs/instances/view-ip-address) (Google Cloud documentation)
- [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) (VS Code documentation)
