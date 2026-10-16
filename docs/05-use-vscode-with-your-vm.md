# Using VS Code with Your Google Cloud VM

Visual Studio Code (VS Code) is the editor we use for the course project. In guide 03 you installed it on your laptop along with four "extensions" (add-ons that each teach VS Code one new trick): **Remote Development**, **Python**, **Django** and **GitHub Copilot Chat**. This guide shows you how to use them. We connect VS Code to your Google Cloud virtual machine, open and close folders, create, save and delete files and folders, run a Python program and try out Copilot. Every later guide in the set builds on what you learn here. No prior technical experience is needed.

The steps are the same on Windows and macOS, because everything happens inside VS Code. Where a keyboard shortcut differs, both are given, Windows first.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- VS Code installed on your laptop ([02a Install VS Code on Windows](02a-install-vscode-windows.md) or [02b Install VS Code on macOS](02b-install-vscode-macos.md)), with the four extensions above and Copilot signed in ([03 Install the VS Code extensions](03-install-vscode-extensions.md)).
- Your Google Cloud virtual machine (VM), running, with your SSH key on it and a short name (`gcp-vm`) in your SSH configuration file ([04 Create your Google Cloud VM](04-create-your-vm.md)). If the VM was stopped, start it and check whether its External IP address has changed (guide 04, Step 17).

BEWARE: a running VM uses up your GCP Educational Credits by the hour, whether or not you are using it. Part 9 shows you how to stop it when you have finished.

## Part 1: Find your way around VS Code

Before connecting to anything, it helps to know the four places in VS Code that this guide keeps sending you to.

### Step 1: Meet the Activity Bar

1. Open VS Code.
2. Look at the narrow strip of icons down the left-hand edge of the window. This is the **Activity Bar**.
3. Notice the top icon (two overlapping pages): this is the **Explorer**, which lists the files in the folder you have open.
4. Notice the icon of four small squares with one square detached: this is the **Extensions** view. You can also open it with **Ctrl+Shift+X** (Windows) or **Cmd+Shift+X** (macOS).

### Step 2: Open the Command Palette

The "Command Palette" is a search box for every command VS Code knows. When this guide says "run the command **Python: Select Interpreter**", it means: open the Command Palette, type the command's name, and choose it from the list.

1. Press **Ctrl+Shift+P** (Windows) or **Cmd+Shift+P** (macOS). A box appears at the top of the window with a `>` already typed in it.
2. Type `theme`. Notice that the list narrows as you type; you do not need to type a command's full name.
3. Press **Esc** to close the palette without running anything.

### Step 3: Open the terminal

1. Press **Ctrl+`** (the backtick key, usually to the left of **1**). This works on both Windows and macOS. A panel opens at the bottom of the window with a command prompt in it.
2. Press **Ctrl+`** again to hide it.

Notice that, at the moment, this terminal runs on your laptop. After Part 2 it will run on your VM instead, which is the whole point of Remote Development.

## Part 2: Connect to your VM

Here is the idea behind Remote Development. VS Code splits itself in two: the half you see (the window, the menus, the keyboard) stays on your laptop, and the half that does the work (reading files, running Python, running the terminal) runs on your VM. It is rather like the accelerator in a car: the pedal is under your foot, but the engine it controls is at the other end of a cable, and you rarely need to think about the cable at all. Your code, your packages and your running programs all live on the VM; your laptop only shows them to you.

### Step 4: Connect to the VM

1. Open the Command Palette (**Ctrl+Shift+P** or **Cmd+Shift+P**).
2. Run the command **Remote-SSH: Connect to Host...**
3. Click `gcp-vm` (the short name you gave your VM in guide 04) and go to instruction 5. If it is not in the list, continue with instruction 4.
4. Type your username, an `@` sign and your VM's External IP address, with no spaces, for example `jdoe@34.86.xx.xx`, and press **Enter** (Windows) or **Return** (macOS). (It is worth fixing your configuration file afterwards, as in guide 04, Part 5, so that you do not have to do this every time.)
5. A new VS Code window opens. If it asks which platform the remote host runs, choose **Linux**.
6. If it asks whether you trust the host's "fingerprint", click **Continue**. This question only appears the first time you connect to a machine; it is SSH's way of introducing you.
7. Wait. The first connection takes a minute or two, because VS Code is quietly downloading and installing its working half (the "VS Code Server") on your VM. Later connections are much faster.

BEWARE: do not close the window, close the laptop's lid or let it go to sleep while the VS Code Server is installing. An interrupted installation leaves a half-finished copy on the VM, and VS Code then tends to try the download again and again rather than finishing. If the connection is still not ready after five minutes, see "Connecting takes forever, or keeps saying it is downloading or installing the VS Code Server" in "If something goes wrong".

### Step 5: Confirm you are connected

1. Look at the bottom-left corner of the new window. You should see a coloured box containing **SSH:** followed by your VM's address or name.
2. Open the terminal (**Ctrl+`**).
3. Type `hostname` and press **Enter** or **Return**.
4. You should see your VM's name (the name you gave it in Google Cloud), not your laptop's name. If you see your VM's name, everything you type in this terminal now runs on the VM.

## Part 3: Make your extensions work on the VM

You installed the Python and Django extensions on your laptop, but the half of VS Code that needs them now lives on the VM. Extensions that only change how VS Code looks (colour themes, for example) stay on your laptop; extensions that read and run code have to be copied to the VM. You do this once per VM.

### Step 6: Copy your extensions to the VM

1. Open the **Extensions** view.
2. Look for a heading that begins **SSH:** followed by your VM's address. Below it, VS Code lists the extensions already on the VM.
3. Look for a heading such as **Local - Installed**. Extensions listed there with a greyed-out look, or with a button **Install in SSH: ...**, are on your laptop but not yet on the VM.
4. Hover the mouse pointer over the **SSH:** heading and click the small cloud icon with a downward arrow (**Install Local Extensions in 'SSH: ...'**). If you cannot see it, click the three dots (**...**) at the top of the Extensions view and look for the same command there.
5. A list of your laptop's extensions appears, each with a tick box. Tick **Python**, **Django** and anything else the list offers that you want on the VM, and click **OK**.
6. Wait until the extensions appear under the **SSH:** heading. If VS Code asks you to reload the window, click **Reload Window**.

## Part 4: Work with folders

VS Code always works on one folder at a time (strictly, one "workspace", which we come to in Step 11). The folder you open becomes the top of the Explorer; the terminal starts in it, and Copilot and the Python extension treat it as your project.

### Step 7: Make a practice folder

1. In the terminal, type `mkdir ~/VsCodePractice` and press **Enter** or **Return**. This makes a folder called `VsCodePractice` in your home folder on the VM. The terminal prints nothing if it succeeds, which is normal for Linux commands.

### Step 8: Open a folder

1. Open the **File** menu and choose **Open Folder...** (on a Mac the menu item may be **Open...**).
2. A box appears at the top of the window showing a path such as `/home/jdoe/`. Add `VsCodePractice/` to the end of it so that it reads `/home/jdoe/VsCodePractice/` (with your username), and click **OK**.
3. If VS Code asks **Do you trust the authors of the files in this folder?**, click **Yes, I trust the authors**. You made the folder a moment ago, so you do.
4. Look at the Explorer. Its top line should now read `VSCODEPRACTICE` (VS Code shows folder names in capitals there; the folder itself is unchanged).

Notice that the box in instruction 2 shows folders on the VM, not on your laptop. While you are connected, VS Code cannot see your laptop's files at all, and that is deliberate: your project lives on the VM.

### Step 9: Make a folder inside it

1. Hover the mouse pointer over `VSCODEPRACTICE` in the Explorer. A row of small icons appears beside it.
2. Click the **New Folder** icon (a folder with a plus sign).
3. Type `Scratch` and press **Enter** or **Return**.
4. You should see `Scratch` in the Explorer, with an arrow beside it that opens and closes it.

To make a folder inside another folder, click that folder first (so that it is highlighted) and then click **New Folder**; or right-click the folder and choose **New Folder...**

### Step 10: Close a folder

Closing a folder takes it out of the Explorer; it does not delete it or anything in it.

1. Open the **File** menu and choose **Close Folder**. (The shortcut is **Ctrl+K** then **F** on Windows, or **Cmd+K** then **F** on macOS: press the first pair, let go, then press the letter.)
2. The Explorer now shows **You have not yet opened a folder** with an **Open Folder** button.
3. Notice that the **SSH:** box in the bottom-left corner is still there. Closing a folder does not close your connection to the VM.
4. To reopen the folder quickly, open the **File** menu, choose **Open Recent**, and click `~/VsCodePractice [SSH: ...]`. VS Code remembers recent folders on each machine separately, which is why the VM's name appears beside it.

### Step 11: Add a second folder, then remove it

Sometimes you want two folders side by side in the Explorer: your team's project and a folder of notes, say. VS Code calls a set of folders a "workspace".

1. Open the **File** menu and choose **Add Folder to Workspace...**
2. Change the path in the box at the top of the window to your home folder (for example `/home/jdoe/`) and click **OK**.
3. Look at the Explorer. Its heading now reads **UNTITLED (WORKSPACE)**, with two folders beneath it: `VsCodePractice` and your home folder.
4. Right-click your home folder in the Explorer and choose **Remove Folder from Workspace**.
5. The home folder disappears from the Explorer. Again, nothing has been deleted; it is only no longer shown.
6. Close the workspace: open the **File** menu and choose **Close Workspace** (it replaces **Close Folder** while a workspace is open).
7. If VS Code asks whether to save the workspace configuration, click **Don't Save**. Saving it would create a file that remembers this set of folders, which we do not need.

For most of the course you only need one folder open at a time, so **Open Folder** and **Close Folder** are the commands you will use most.

## Part 5: Work with files

### Step 12: Create a file

1. Reopen `VsCodePractice` (Step 10, instruction 4).
2. Hover over `VSCODEPRACTICE` in the Explorer and click the **New File** icon (a page with a plus sign).
3. Type `notes.txt` and press **Enter** or **Return**. The file opens in the editor, in a "tab" along the top of the editing area.

### Step 13: Save a file

1. Type a line of text in `notes.txt`, such as `Remember to stop the VM.`
2. Look at the file's tab. Where you would expect a small **x**, there is now a filled circle. That circle means the file has "unsaved changes": what you see in the editor is not yet what is stored on the VM.
3. Press **Ctrl+S** (Windows) or **Cmd+S** (macOS).
4. The circle changes back to an **x**. The file is saved.

Why does this matter? Everything other than the editor (the terminal, Python, Django's web server, git) reads the file as it is stored on the VM. If you forget to save, they see the old version, and you spend ten minutes wondering why your change made no difference. Look for that circle before you run anything.

Three more ways to save are worth knowing:

- **Save As** (**Ctrl+Shift+S** or **Cmd+Shift+S**) saves the file under a new name or in a new folder, and leaves the original as it was.
- **Save All** (from the **File** menu) saves every open file at once, which is handy after editing several.
- **Auto Save** (from the **File** menu) saves every file shortly after you stop typing. It is convenient, but it means a half-finished edit is saved too; whether you turn it on is up to you.

### Step 14: Close a file

1. Click the **x** on the file's tab, or press **Ctrl+W** (Windows) or **Cmd+W** (macOS).
2. If the file has unsaved changes, VS Code asks whether to save them. Click **Save** to keep your changes, **Don't Save** to throw them away, or **Cancel** to go back to the file.

Closing a file only closes its tab. The file is still in the Explorer and on the VM.

### Step 15: Rename a file

1. Right-click `notes.txt` in the Explorer and choose **Rename...** (or click it once and press **F2** on Windows or **Return** on macOS).
2. Type `todo.txt` and press **Enter** or **Return**.

## Part 6: Delete files and folders

BEWARE: your files are on the VM, and the VM has no Recycle Bin or Bin. When VS Code deletes a file there, it may warn you that the file will be deleted permanently, and it means it. Read the name in the warning before you confirm.

### Step 16: Delete a file

1. Right-click `todo.txt` in the Explorer and choose **Delete**. (Or click it once and press **Delete** on Windows, or **Cmd+Delete** on macOS.)
2. A box asks whether you are sure, and names the file. Check the name.
3. Click **Delete** (the button may say **Delete Permanently** or **Move to Trash**, depending on the VM).
4. The file disappears from the Explorer.

### Step 17: Delete a folder

1. Right-click the `Scratch` folder in the Explorer and choose **Delete**.
2. Check the name in the box. Deleting a folder deletes everything inside it too, including folders inside folders.
3. Click **Delete** (or **Delete Permanently**).

Aside: if you delete a file by mistake and it is part of a git repository, git can usually restore the last committed version. Anything you had not committed is gone. This is one of the better arguments for committing often.

## Part 7: Run Python on the VM

### Step 18: Check that Python is on the VM

1. In the terminal, type `python3 --version` and press **Enter** or **Return**.
2. You should see something like `Python 3.1x.x`. Any version from 3.10 onwards is fine.

If you see `command not found`, see "If something goes wrong".

### Step 19: Make a virtual environment

A "virtual environment" is a private set of Python packages for one project. Without one, every project on the VM shares the same packages, and upgrading a package for one project can quietly break another; think of it as each project having its own toolbox rather than everyone borrowing from the same drawer.

1. In the terminal, make sure you are in your practice folder: type `cd ~/VsCodePractice` and press **Enter** or **Return**.
2. Type `python3 -m venv .venv` and press **Enter** or **Return**. This makes the virtual environment in a folder called `.venv`. The terminal prints nothing if it succeeds.
3. Type `source .venv/bin/activate` and press **Enter** or **Return**. This "activates" the environment for this terminal.
4. Look at the start of the command prompt. It should now begin with `(.venv)`, which is the terminal's way of reminding you which toolbox you are using.

Notice the dot at the start of `.venv`. On Linux, a name beginning with a dot is "hidden", so `ls` does not show it unless you type `ls -a`. VS Code looks for a folder called `.venv` by convention, which is why we use that name.

### Step 20: Tell VS Code to use the virtual environment

The terminal now knows about the virtual environment, but the Python extension keeps its own record of which Python to use (called the "interpreter"), and the two are not linked.

1. Create a file called `hello.py` in `VsCodePractice` (as in Step 12). Opening a Python file is what wakes the Python extension up, so do this before the next instruction.
2. Open the Command Palette and run **Python: Select Interpreter**.
3. Choose the entry that mentions `.venv`, usually marked **Recommended**.
4. Look at the bottom-right of the window. You should see a Python version followed by `.venv`.

### Step 21: Run a Python file

1. In `hello.py`, type:

   ```python
   print("Hello, World!")
   ```

2. Save the file (**Ctrl+S** or **Cmd+S**).
3. Click the **Run Python File** button (a triangle pointing right) at the top-right of the editor.
4. You should see `Hello, World!` in the terminal.

Now make a deliberate mistake to see the Python extension at work.

5. Change `print` to `prnt` and save.
6. You should see a wavy underline beneath `prnt`. Hover the mouse pointer over it and a message says that `prnt` is not defined.
7. Change it back to `print` and save. The underline disappears.

That underline is the practical payoff of the Python extension: you find the mistake when you type it, not when the program falls over.

## Part 8: Use GitHub Copilot

Copilot does two things. As you type, it shows "ghost text": a suggestion in faint grey that you can accept or ignore. And it has a chat, where you can ask questions about your code in ordinary English.

BEWARE: Copilot is often right and occasionally confidently wrong, in the manner of a well-read student who has never run the program. You are responsible for every line you commit, whoever (or whatever) typed it, so read its suggestions before accepting them. Check the course syllabus for what use of Copilot is allowed on assessed work. Also note that Copilot sends parts of your code to GitHub's servers to produce its suggestions.

### Step 22: Check that Copilot is signed in

1. Look for the Copilot icon (a small face wearing goggles) in the bar along the bottom of the window or at the top of the window beside the search box.
2. If it shows a warning sign or a slash through it, click it and follow the prompts to sign in with your GitHub account. If it shows neither, you are signed in.

### Step 23: Try the ghost text

1. In `hello.py`, on a new line at the bottom, type this comment and press **Enter** or **Return**:

   ```python
   # return the sum of the squares of a list of numbers
   ```

2. Type `def` and wait a second.
3. Faint grey text should appear, suggesting a whole function. Press **Tab** to accept it, or **Esc** to dismiss it.
4. Read what you accepted. Does it do what the comment says? (It usually does; the habit of checking is the point of the exercise.)

Notice that Copilot used your comment as its instructions. A clear comment above the code you are about to write is the best way to get a useful suggestion, and it is a good habit anyway.

### Step 24: Try the chat

1. Open the Chat view with **Ctrl+Alt+I** (Windows) or **Ctrl+Cmd+I** (macOS), or by clicking the Copilot icon and choosing to open chat. It opens as a panel at the side of the window.
2. With `hello.py` open in the editor, type `Explain what this file does` in the chat box and press **Enter** or **Return**. Copilot Chat can see the file you have open.
3. Read the answer, and compare it with what you know the file does.

You can also ask about a few lines rather than a whole file: select the lines in the editor, press **Ctrl+I** (Windows) or **Cmd+I** (macOS) for "inline chat", and type your question in the box that appears over the code.

Notice that the chat can also offer to change your files for you. Until you are confident reading its changes, ask it to explain rather than to edit.

## Part 9: Clean up after yourself

### Step 25: Close the remote connection

1. Click the coloured **SSH:** box in the bottom-left corner.
2. Choose **Close Remote Connection** from the list at the top of the window.

### Step 26: Stop your VM

BEWARE: this is the step that saves your credits. Closing VS Code does not stop the VM; it carries on running (and using up credits) until you stop it.

1. Open the [Google Cloud console](https://console.cloud.google.com/) in your browser and sign in.
2. Open the menu (three horizontal lines, top-left), then choose **Compute Engine**, then **VM instances**.
3. Click the three dots at the end of your VM's row and choose **Stop**.
4. Confirm. The VM's status icon changes from a green tick to a grey square when it has stopped.

Stopping is not deleting: your files are kept, and you start the VM again from the same menu with **Start / Resume**.

### Step 27: Delete the practice folder (optional)

Keep `VsCodePractice` if you want to experiment further. To delete it, connect to the VM again (Step 4), make sure no folder is open (Step 10), open a terminal and type `rm -r ~/VsCodePractice`, then press **Enter** or **Return**. Check what you have typed before pressing the key: `rm -r` deletes the folder and everything in it without asking, and a typo in the path could delete the wrong folder.

## If something goes wrong

**Connecting hangs, or says "Could not establish connection" or "Connection timed out".** Check that your VM is running in the Google Cloud console. Then check its External IP address: unless you reserved a fixed ("static") address, Google Cloud may give the VM a new one each time it starts. If it has changed, update the `HostName` line in your SSH configuration file (guide 04, Step 17) and connect again.

**Connecting takes forever, or keeps saying it is downloading or installing the VS Code Server.** The installation was probably interrupted (the window was closed, the laptop slept or the network dropped), and VS Code is now tripping over the half-finished copy, starting the download several times over. Waiting will not fix it; removing the broken copy will. The VS Code Server lives in a hidden folder called `.vscode-server` in your home folder on the VM, so we log in to the VM without VS Code and delete that folder. VS Code then installs a fresh copy next time you connect.

1. Close every VS Code window.
2. On Windows, open **PowerShell** (press the **Windows** key, type `PowerShell` and press **Enter**). On macOS, open **Terminal** (press **Cmd+Space**, type `Terminal` and press **Return**).
3. Type `ssh gcp-vm` and press **Enter** or **Return**. (If you have not given your VM a short name, type `ssh` followed by a space, your username, an `@` sign and the VM's External IP address instead, for example `ssh jdoe@34.86.xx.xx`.)
4. Check that the prompt now shows your username and your VM's name. Everything you type from here on runs on the VM.
5. Type `pkill -f vscode-server` and press **Enter** or **Return**. This stops any VS Code Server programs that are still running. It prints nothing, whether or not it found any.
6. Type `rm -rf ~/.vscode-server` and press **Enter** or **Return**. It prints nothing if it succeeds.
7. Type `exit` and press **Enter** or **Return** to log out of the VM.
8. Close PowerShell or Terminal, then connect again from VS Code (Step 4) and leave it alone until the **SSH:** box appears.

BEWARE: `rm -rf` deletes without asking and has no undo, so check the command letter by letter before pressing the key; the `~/.vscode-server` part matters, dot and all. Your own files are not in that folder and are not affected, but the extensions you copied to the VM are, so repeat Step 6 once you are connected again.

**"Permission denied (publickey)".** The username before the `@` must match the comment on your SSH key exactly, including capital letters. If it does, the key on your laptop may not match the one added to the VM; go back to [04 Create your Google Cloud VM](04-create-your-vm.md), Part 1.

**There is no SSH: heading in the Extensions view.** You are not connected to the VM; look for the **SSH:** box in the bottom-left corner. If it is missing, connect first (Step 4) and repeat Step 6 from the connected window.

**Open Folder shows my laptop's folders, not the VM's.** You are in a window that is not connected. Check the bottom-left corner for the **SSH:** box, and use the window that has it.

**A folder I removed from the Explorer is still there when I reopen VS Code.** You saved the workspace configuration in Step 11. Open the **File** menu, choose **Open Folder...** and open the single folder you want; VS Code then forgets the workspace for this window.

**I closed a folder and the terminal disappeared.** Closing a folder closes its terminals too. Open a new one with **Ctrl+`**.

**"python3: command not found".** Your VM's operating system image does not include Python. In the terminal, type `sudo apt update` and press **Enter** or **Return**, then `sudo apt install python3` and press **Enter** or **Return**.

**"The virtual environment was not created successfully because ensurepip is not available".** Debian and Ubuntu keep part of Python in a separate package. Type `sudo apt install python3-venv` and press **Enter** or **Return**, then repeat Step 19.

**Python: Select Interpreter does not list `.venv`.** The Python extension starts only once a `.py` file is open, so open `hello.py` first. If `.venv` is still missing, choose **Enter interpreter path...** and type `~/VsCodePractice/.venv/bin/python`. If the command itself is missing, the Python extension is not on the VM yet; repeat Step 6.

**My change made no difference when I ran the program.** Look for a filled circle on the file's tab: the file is not saved. Save it and run it again.

**No grey Copilot suggestions appear.** Check that the Copilot icon shows no warning sign; click it to see whether you are signed in and whether you have used up your monthly allowance. Then run **Developer: Reload Window** from the Command Palette.

## What to do next

Build a small web site on your VM with what you have learnt here: [06 Get started with Django](06-get-started-with-django.md).

After that, guides 07 to 13 set up git and take you through the team's routine, using the same terminal: [07 Install git on your VM](07-install-git-on-your-vm.md).

## Sources

- [Remote Development using SSH (VS Code documentation)](https://code.visualstudio.com/docs/remote/ssh)
- [Basic editing (VS Code documentation)](https://code.visualstudio.com/docs/editor/codebasics)
- [Multi-root workspaces (VS Code documentation)](https://code.visualstudio.com/docs/editor/multi-root-workspaces)
- [Getting Started with Python in VS Code (VS Code documentation)](https://code.visualstudio.com/docs/python/python-tutorial)
- [Set up GitHub Copilot in VS Code (VS Code documentation)](https://code.visualstudio.com/docs/copilot/setup)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
