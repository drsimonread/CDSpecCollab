# Installing the VS Code Extensions

On its own, VS Code is an editor that opens files and colours some text. Its usefulness comes from "extensions": add-ons that each teach it one new trick. In this guide we install the four the course uses, and sign in to GitHub Copilot:

- **Remote Development**, so that VS Code on your laptop can work on files that live on your Google Cloud VM.
- **Python**, so that it understands Python code.
- **Django**, so that it understands Django's HTML templates.
- **GitHub Copilot Chat**, an AI assistant that suggests code and answers questions about it.

Everything here happens on your laptop, and the steps are the same on Windows and macOS. Where a keyboard shortcut differs, both are given, Windows first. No prior technical experience is needed.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- VS Code installed: [02a Install VS Code on Windows](02a-install-vscode-windows.md) or [02b Install VS Code on macOS](02b-install-vscode-macos.md).
- A GitHub account. If you have not applied for student benefits yet, see [01 Apply for the GitHub Student Developer Pack](01-apply-for-github-student-developer-pack.md); you do not need to wait for approval to finish this guide.

## Part 1: Open the Extensions view

### Step 1: Open the Extensions view

1. Open VS Code.
2. Click the Extensions icon in the strip of icons down the left-hand edge of the window. It looks like four small squares with one square detached. (Or press **Ctrl+Shift+X** on Windows, **Cmd+Shift+X** on macOS.)
3. A search box appears at the top of the panel, with lists of extensions beneath it.

Every extension in this guide is installed the same way: search for it, check the name and publisher, click **Install**. Checking the publisher matters, because anybody can publish an extension, and several look-alikes share each of these names.

## Part 2: Install the extensions

### Step 2: Install Remote Development

1. In the search box, type `Remote Development`.
2. Click **Remote Development**, published by **Microsoft**.
3. Click **Install**, and wait for the button to change to a gear icon.

This is an "extension pack": one entry that installs four extensions together (**Remote - SSH**, **Dev Containers**, **WSL** and **Remote - Tunnels**). We only use **Remote - SSH**, which connects VS Code to your VM, but the others do no harm.

### Step 3: Install Python

1. In the search box, type `Python`.
2. Click **Python**, published by **Microsoft**. Avoid **Python Extension Pack** and look-alikes from other publishers.
3. Click **Install**.

The Python extension brings its own helpers with it (**Pylance**, **Python Debugger** and **Python Environments**), so they appear in your list too; you do not install them separately.

### Step 4: Install Django

1. In the search box, type `Django`.
2. Click **Django**, published by **Baptiste Darthenay** (shown as **batisteo** in some places). Of the many extensions with "Django" in the name, it is the one with by far the most installs.
3. Click **Install**.

It colours Django's template tags (text inside `{% %}` and `{{ }}`) inside HTML files and adds short "snippets" for typing them.

Aside: this extension has not been updated for some time, but it still works reliably for colouring and snippets. If you later find it lacking, **Django Template Support** by **junstyle** is a more recently maintained alternative.

### Step 5: Install GitHub Copilot Chat

1. In the search box, type `GitHub Copilot Chat`.
2. Click **GitHub Copilot Chat**, published by **GitHub** (look for the verified tick beside the publisher's name).
3. Click **Install**. If the button already shows a gear icon, recent versions of VS Code have installed it for you.

Copilot used to come as two extensions, **GitHub Copilot** and **GitHub Copilot Chat**. They have since been merged into **GitHub Copilot Chat**, so older instructions online may tell you to install both; the one is enough.

## Part 3: Sign in to Copilot

### Step 6: Sign in with your GitHub account

1. Look for the Copilot icon (a small face wearing goggles) in the bar along the bottom of the window or at the top of the window beside the search box. Click it. (If a notification in the bottom-right corner already offers to sign in, click that instead.)
2. Click the option to sign in to use Copilot.
3. Your web browser opens a GitHub page. Sign in if asked.
4. Click **Authorize Visual Studio Code**, and confirm with your password or two-factor code if GitHub asks.
5. If the browser asks whether to open Visual Studio Code, click **Open**.
6. Return to VS Code. The Copilot icon should no longer show a warning sign.

### Step 7: Confirm your Copilot plan

1. If GitHub shows a page asking you to choose or confirm a plan, choose **Copilot Free** for now, or **Copilot Student** if it is offered (it will be once guide 01 has been approved and activated).
2. Return to VS Code.

BEWARE: if any page offers a Copilot "trial" and asks for a credit or debit card, stop and close it. Neither Copilot Free nor Copilot Student needs a card, and a trial turns into a bill when it ends.

## Part 4: Confirm everything is in place

### Step 8: Check the installed list

1. In the Extensions view, clear the search box.
2. Look at the list headed **Installed**. You should see **Remote Development** (and the Remote extensions it brought), **Python**, **Pylance**, **Django** and **GitHub Copilot Chat**.
3. Look at the bottom-left corner of the window. You should see a small coloured box with a `><` symbol in it: that is the Remote Development button, which guide 05 uses to connect to your VM.

## A note about the VM

These extensions are now installed on your laptop. Once you connect to your VM, VS Code needs copies of the ones that read and run code (Python and Django in particular) on the VM as well, because that is where your code will live and run. Guide 05 shows you how to copy them across in one go (guide 05, Step 6), so you do not need to search for them again.

## A note on using Copilot for coursework

Copilot suggests code confidently even when that code is wrong, so read every suggestion before you accept it. You are responsible for every line you commit, whoever (or whatever) typed it. Check the course syllabus for what use of Copilot is allowed on assessed work: policies differ between courses, and what is fine in one class can be a violation in another. Note also that Copilot sends parts of your code to GitHub's servers to produce its suggestions.

## If something goes wrong

**The install button is greyed out or says "Install in SSH".** You are in a window connected to a remote machine. Open a new window (**File**, **New Window**) and install from there, or come back to this after guide 05.

**The sign-in page in the browser never returns to VS Code.** Go back to VS Code and look for a box asking you to paste a code or URL; copy it from the browser page. Otherwise, click the Accounts icon (a small person) at the bottom of the strip of icons on the left and sign in to GitHub from there.

**The Copilot icon still shows a warning.** Click it to read the message. If it says you have no access, check guide 01's Copilot note and choose Copilot Free in the meantime. Then open the Command Palette (**Ctrl+Shift+P** or **Cmd+Shift+P**) and run **Developer: Reload Window**.

**I cannot find the `><` box in the bottom-left corner.** Open the Command Palette and type `Remote-SSH`. If commands beginning **Remote-SSH:** appear, the extension is installed and the button is only hidden; guide 05 uses the Command Palette anyway.

## What to do next

Connect VS Code to your VM and learn your way around: [05 Use VS Code with your VM](05-use-vscode-with-your-vm.md).

## Sources

- [Remote Development extension pack (Visual Studio Marketplace)](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
- [Python extension (Visual Studio Marketplace)](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [Django extension (Visual Studio Marketplace)](https://marketplace.visualstudio.com/items?itemName=batisteo.vscode-django)
- [Set up GitHub Copilot in VS Code (VS Code documentation)](https://code.visualstudio.com/docs/copilot/setup)
- [Open source AI editor: second milestone, on merging the Copilot extensions (VS Code blog)](https://code.visualstudio.com/blogs/2025/11/04/openSourceAIEditorSecondMilestone)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
