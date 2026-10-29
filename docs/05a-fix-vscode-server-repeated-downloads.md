# Fixing Repeated VS Code Server Downloads

When you connect Visual Studio Code (VS Code) to your Google Cloud VM with the **Remote - SSH** extension, VS Code first installs a small program on the VM, called the "VS Code Server" (guide 05, Step 4). It should download the server once and then reuse it. Sometimes it downloads the server several times at once, the downloads trip over one another, and the connection never finishes. This guide stops the stray downloads, clears out the half-finished copies and changes two settings so that it does not happen again. No prior technical experience is needed.

The steps are the same on Windows and macOS. Where the keys differ, both are given: **Ctrl** on Windows, **Cmd** on macOS.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- VS Code with the Remote Development extensions installed ([03 Install the VS Code extensions](03-install-vscode-extensions.md)).
- Your VM running, with the short name `gcp-vm` in your SSH configuration file ([04 Create your Google Cloud VM](04-create-your-vm.md)). If the VM was stopped and started again, check that its External IP address has not changed (guide 04, Step 17).
- A way to log in to the VM without VS Code: **PowerShell** on Windows or **Terminal** on macOS, both of which have the `ssh` command built in.

It helps to know why the downloads pile up, because the fix depends on the cause. VS Code uses a "lock file" on the VM as a sign on the door saying "installation in progress". Each new connection should see the sign and wait. The downloads multiply when:

- an earlier download was interrupted (the window was closed, the laptop slept or the network dropped), so a half-finished copy or a leftover process is still there when VS Code tries again; on the course VMs, this is the usual cause;
- several VS Code windows connect to the same VM at once (for example, after VS Code updates itself and reopens all your windows);
- your home folder lives on a shared network drive, where the sign on the door is not always seen. Your course VM keeps your home folder on its own disk, so this applies only if you also use VS Code with a college server.

## Part 1: Find out what is happening

### Step 1: Open the Remote - SSH log

The log records each attempt, which tells you which cause you are dealing with.

1. Press **Ctrl+Shift+P** (Windows) or **Cmd+Shift+P** (macOS) to open the Command Palette (a search box at the top of the window).
2. Type `Remote-SSH: Show Log` and press **Enter** (Windows) or **Return** (macOS).
3. The **Output** panel opens at the bottom of the window. Scroll through it.
4. Look for more than one line mentioning a download, and for lines mentioning a lock. Several downloads close together, or a lock that is never released, confirm the problem.
5. Make a note of the commit ID in the line beginning `Using commit id` (a long string of letters and digits). If you see two different commit IDs, two different versions of VS Code are connecting.

### Step 2: Count your VS Code windows

1. Check the taskbar (Windows) or the Dock and the **Window** menu (macOS) for every VS Code window.
2. Check whether you also have **VS Code Insiders** (a green icon) open. It installs a server of its own.

## Part 2: Stop everything

### Step 3: Close every VS Code window

Every open window may try to reconnect while you work, so they all need to go.

1. Close every VS Code window, including **VS Code Insiders** if it is open.
2. On macOS, press **Cmd+Q** with VS Code in front, because closing the windows alone leaves the app running.

### Step 4: Log in to the VM without VS Code

1. On Windows, press the **Windows** key, type `PowerShell` and press **Enter**. On macOS, press **Cmd+Space**, type `Terminal` and press **Return**.
2. Type `ssh gcp-vm` and press **Enter** or **Return**. (If you have not given your VM a short name, type `ssh` followed by a space, your username, an `@` sign and the VM's External IP address instead, for example `ssh jdoe@34.86.xx.xx`.)
3. If you gave your SSH key a passphrase, type it when asked. Nothing appears on screen as you type, not even dots, which is normal. If you did not, you go straight in.
4. You should see a prompt such as `jdoe@instance-00:~$`, which means you are now typing commands on the VM, not your own computer.

### Step 5: Stop any leftover server processes

1. Type `pgrep -u "$USER" -fl vscode-server` and press **Enter** or **Return**. This lists any VS Code Server programs still running for you.
2. If it prints nothing, skip to Step 6.
3. If it prints one or more lines, type `pkill -u "$USER" -f vscode-server` and press **Enter** or **Return**. This stops them. It affects only your own programs.
4. Type `pgrep -u "$USER" -fl vscode-server` again. It should now print nothing.

## Part 3: Clear out the half-finished copies

### Step 6: Check that there is room on the VM

A full disk makes every download fail, and VS Code then keeps trying.

1. Type `df -h ~` and press **Enter** or **Return**.
2. Look at the **Use%** column. If it shows 95% or more, delete some of your own files you no longer need before you continue (the VS Code Server needs roughly 200 MB). Large leftovers are often old virtual environments (`.venv` folders) from projects you have finished with.

### Step 7: Delete the VS Code Server folder

VS Code keeps everything it installs on the VM in a hidden folder called `.vscode-server` in your home folder. Deleting it removes every half-finished download and every stale lock. VS Code rebuilds it the next time you connect, so none of your own files are lost.

BEWARE: `rm -rf` deletes without asking and has no undo, and there is no bin on the VM. Type the command exactly, checking the `~/` and the full stop before `vscode-server`.

1. Type `rm -rf ~/.vscode-server` and press **Enter** or **Return**. Nothing is printed when it succeeds.
2. Type `ls -a ~` and press **Enter** or **Return**. The list should no longer include `.vscode-server`.
3. Type `exit` and press **Enter** or **Return** to log out of the VM.
4. Close PowerShell or Terminal.

## Part 4: Change two settings

### Step 8: Keep lock files in the VM's `/tmp` folder

This setting moves the "installation in progress" sign from your home folder to the VM's `/tmp` folder, where it is always reliable. On your course VM it makes little difference, but it costs nothing and protects you if you ever connect to a college server with a shared home folder.

1. Open VS Code, but do not connect to the VM yet.
2. Press **Ctrl+,** (Windows) or **Cmd+,** (macOS) to open **Settings**.
3. In the search box at the top, type `remote ssh lockfiles`.
4. Tick **Remote.SSH: Lockfiles in Tmp**.

### Step 9: Choose where the server is downloaded (only if Step 1 showed failed downloads)

By default, the VM downloads the server from the internet itself. If it cannot reach the download site, every attempt fails and VS Code tries again. This setting makes your laptop download the server and copy it across instead.

1. In the **Settings** search box, type `remote ssh local server download`.
2. Under **Remote.SSH: Local Server Download**, choose **always** from the drop-down list.

Leave it on **auto** (the default) if the log in Step 1 showed downloads starting but no errors.

## Part 5: Shake down the fix

### Step 10: Reconnect with one window

1. Open the Command Palette and run **Remote-SSH: Connect to Host...**, then click `gcp-vm`.
2. Wait for the coloured **SSH:** box to appear in the bottom-left corner. The first connection after Step 7 takes longer than usual, because the server is downloaded afresh; leave the window alone, and do not let the laptop sleep, until it finishes.
3. Run `Remote-SSH: Show Log` again, as in Step 1. You should see one download, not several.

### Step 11: Check that a second window reuses the server

1. In the connected window, choose **File** and then **New Window**.
2. Connect the new window to `gcp-vm`, as in Step 10.
3. It should connect within a few seconds, without a new download in the log.
4. Close the second window.

If both windows connected and the log shows a single download, the problem is fixed.

### Step 12: Put your extensions back on the VM

Deleting `.vscode-server` in Step 7 also removed the extensions you copied to the VM.

1. Open the **Extensions** view and look under the **SSH:** heading.
2. If **Python** and **Django** are missing, copy them across again as in guide 05, Step 6.

## If something goes wrong

**The downloads still multiply after Step 10.** Something reconnected while you were working. Repeat Steps 3 to 7 and make sure every VS Code window (including VS Code Insiders, and VS Code on any other computer you use) is closed first.

**pgrep keeps finding processes after pkill in Step 5.** A VS Code window somewhere is still connected and restarting them. Close it, then repeat Step 5.

**rm reports "Device or resource busy" or "Directory not empty" in Step 7.** A process still has a file open. Repeat Step 5, wait 10 seconds and try Step 7 again.

**ssh says "Permission denied (publickey)" in Step 4.** The username or key does not match what the VM expects. See "Permission denied (publickey)" in guide 05's "If something goes wrong".

**ssh says "Connection timed out" in Step 4.** The VM is stopped or its address has changed. Check it is running and update `HostName` if needed (guide 04, Step 17).

**The connection now fails with a timeout instead.** If you chose **always** in Step 9, set it back to **auto** and try again. If you did not, ask your instructor whether your VM can reach `update.code.visualstudio.com`.

**The problem comes back every time VS Code updates.** VS Code restores all your remote windows at once after an update. Before you click **Restart to Update**, close all but one remote window.

## What to do next

If the fix holds, carry on where you left off: guide 05, or [13 A typical development session](13-a-typical-development-session.md). If the log still shows repeated downloads, copy the whole log from Step 1 into an email to your instructor; it shows exactly where the installation goes wrong.

## Sources

- [Remote - SSH troubleshooting tips in the VS Code documentation](https://code.visualstudio.com/docs/remote/troubleshooting)
- [Remote - SSH troubleshooting page on the VS Code Remote wiki](https://github.com/microsoft/vscode-remote-release/wiki/Remote-SSH-Troubleshooting)
- [University of Chicago Techstaff advice on VS Code with shared home folders](https://howto.cs.uchicago.edu/techstaff:vscode)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
