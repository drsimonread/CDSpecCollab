# Installing and Configuring Git on Your VM

Git is a "version control system": it records every change made to a project, who made it and why, so that a team can work on the same code without overwriting each other and can always get back to an earlier version. In this guide we install git on your Google Cloud VM and tell it who you are, so that your changes are labelled with your name. No prior technical experience is needed.

Git goes on the VM, not on your laptop, because that is where your code lives.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need to be able to open a terminal on your VM. The usual way is VS Code's terminal, connected to the VM ([05 Use VS Code with your VM](05-use-vscode-with-your-vm.md), Steps 4 and 5). Step 1 also gives a second way, through your web browser, for when VS Code cannot connect.

## Step 1: Open a terminal on your VM

1. Open VS Code and connect to your VM (open the Command Palette with **Ctrl+Shift+P** or **Cmd+Shift+P**, and run **Remote-SSH: Connect to Host...**).
2. Check that the bottom-left corner shows the coloured **SSH:** box.
3. Open the terminal with **Ctrl+`**.

If VS Code will not connect, you can use Google Cloud's browser terminal instead; every command in this guide works the same there:

1. Sign in to the [Google Cloud console](https://console.cloud.google.com/).
2. Open the menu (three horizontal lines, top-left), then choose **Compute Engine**, then **VM instances**.
3. Check the project name at the top of the page. If it is wrong, click it and switch to the course project.
4. Find your VM in the list and check that its **Status** shows a green tick (running). If it shows a grey square, click the three dots at the end of its row and choose **Start / Resume** first.
5. In your VM's row, click **SSH**. A new browser window opens with a terminal already connected to your VM.
6. Wait for the window to finish connecting; the first time can take a little while as Google Cloud sets up access.

Either way, you should see a command prompt ending in `$`, which begins with your username and your VM's name. That is where you type every command in the rest of this guide.

## Step 2: Check whether git is already installed

Some VM images include git and some do not, so check before installing a second copy.

1. Type `git --version` and press **Enter** or **Return**.
2. If you see something like `git version 2.xx.x`, git is already installed: go to Step 5.
3. If you see `Command 'git' not found`, continue with Step 3.

## Step 3: Update the list of available software

1. Type `sudo apt update` and press **Enter** or **Return**.
2. Wait for the prompt to come back. Several lines scroll past as the VM checks for the newest versions of its software.

`sudo` means "do this as the administrator", which installing software requires, and `apt` is Ubuntu's software installer. On a Google Cloud VM you normally are not asked for a password. If you are, notice that nothing at all appears as you type it, not even dots; that is normal, so type it anyway and press **Enter** or **Return**.

## Step 4: Install git

1. Type `sudo apt install git` and press **Enter** or **Return**.
2. When asked `Do you want to continue? [Y/n]`, type `Y` and press **Enter** or **Return**.
3. Wait for the prompt to come back. This usually takes well under a minute.

## Step 5: Confirm git is installed

1. Type `git --version` and press **Enter** or **Return**.
2. You should see something like `git version 2.xx.x`. The exact numbers depend on your VM's version of Ubuntu; what matters is that a version number appears instead of "not found".

## Step 6: Tell git your name and email

Git attaches a name and an email address to every change you record (every "commit"), so that your team, your instructor and you, six weeks from now, can see who did what.

1. Type the following, with your own name between the quotation marks, and press **Enter** or **Return**:

   ```
   git config --global user.name "Your Name"
   ```

2. Type the following, with your own email address, and press **Enter** or **Return**:

   ```
   git config --global user.email "you@example.com"
   ```

Use the same email address as your GitHub account (your college address, if you followed guide 01). GitHub uses it to link your commits to your profile; with a different address, your work shows up on GitHub as belonging to nobody in particular. The `--global` part means the setting applies to every repository on this VM, not just one.

## Step 7: Set two defaults

1. Type `git config --global init.defaultBranch main` and press **Enter** or **Return**.
2. Type `git config --global pull.rebase false` and press **Enter** or **Return**.

The first makes any new repository you create on the VM start with a branch called `main`, matching GitHub. Recent versions of git do this anyway; setting it means you get the same behaviour whatever version you have.

The second needs a little more explanation. When you fetch changes from GitHub (with `git pull`, from guide 09 on) and both you and GitHub have new commits, git can combine them in two ways: "merging" (the method these guides use) or "rebasing". Without this setting, recent versions of git refuse to choose and stop with a message about "divergent branches". Setting it now means `git pull` always merges.

## Step 8: Confirm your settings

1. Type `git config --global --list` and press **Enter** or **Return**.
2. You should see four lines, matching what you typed:

   ```
   user.name=Your Name
   user.email=you@example.com
   init.defaultbranch=main
   pull.rebase=false
   ```

If a line is wrong, type its command from Step 6 or Step 7 again with the correct value; the new value replaces the old one.

## If something goes wrong

**"git: command not found" after installing.** Close the terminal (the bin icon in VS Code's terminal panel, or the browser window) and open a new one, then try `git --version` again. If it still fails, run `sudo apt install git` again and read any error text that appears partway through, not just at the end.

**The browser SSH window stays black or will not connect.** Check that the VM's status is a green tick, not a grey square. A stopped VM has no terminal to connect to; start it and try again.

**"sudo: command not found", or permission errors.** These are unusual on a standard Google Cloud Ubuntu VM. Check that you are connected to the VM: the prompt should include its name.

**"E: Could not get lock /var/lib/dpkg/lock-frontend".** The VM is installing updates by itself in the background. Wait a few minutes and try again.

**I spelt my name or email wrongly.** Run the command again with the correct value (Step 6). Commits you already made keep the old spelling; that does no harm.

## What to do next

Let your VM send work to GitHub: [08 Connect git to GitHub](08-connect-git-to-github.md).

## Sources

- [Connecting to Linux VMs using SSH-in-browser (Google Cloud documentation)](https://cloud.google.com/compute/docs/connect/ssh-in-browser)
- [Getting started: first-time git set-up (Pro Git book)](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)
- [git-config reference (git documentation)](https://git-scm.com/docs/git-config)
- [Setting your commit email address (GitHub documentation)](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
