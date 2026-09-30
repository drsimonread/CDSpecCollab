# Installing and Configuring Git on Your GCP VM

Git is the version control system used to track changes to code and share it with others. This guide installs git on your Ubuntu VM, configures it with your name and email so your commits are correctly attributed, and checks that the VM can use the SSH key on your own computer to push to and pull from GitHub. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Connecting VS Code to your GCP VM](07-connect-vscode-to-gcp-vm.md) | Next: [Python, Django and Copilot extensions](09-python-django-and-copilot-extensions.md)

## Before you start

You need:

1. Your SSH key added to GitHub, loaded into the SSH agent and set to be forwarded, as covered in [Creating SSH keys, Steps 8 to 11](04-create-ssh-keys.md#step-8-add-your-public-key-to-github).
2. VS Code [connected to your GCP VM](07-connect-vscode-to-gcp-vm.md), with `SSH:` followed by your VM's external IP (such as `SSH: 34.86.123.45`) showing in the bottom-left corner.

Every command in this guide is typed on the VM, not on your own computer.

## Step 1: Open a terminal on the VM

1. In the connected VS Code window, click **Terminal** in the menu bar.
2. Click **New Terminal**.

The prompt ends in `sread@cdspeccollab-vm:~$`, confirming the terminal is on the VM.

## Step 2: Check whether git is already installed

Some VM images come with git pre-installed and some do not, so it is worth checking before installing anything. Type:

```
git --version
```

If you see something like `git version 2.xx.x`, git is already installed; skip ahead to Step 6. If instead you see `Command 'git' not found`, continue to Step 3.

## Step 3: Update the list of available software

```
sudo apt update
```

`sudo` runs the command with administrator privileges, which installing software requires. On a Compute Engine VM there is usually no password to enter; if one is requested, nothing appears as you type, which is normal.

## Step 4: Install git

1. Type:

   ```
   sudo apt install git
   ```

2. When prompted `Do you want to continue? [Y/n]`, type `Y` and press Enter.

This downloads and installs git along with anything it depends on. It typically takes well under a minute.

## Step 5: Confirm git installed correctly

```
git --version
```

You should see something like `git version 2.xx.x`. The exact numbers depend on your VM's Ubuntu version; the important thing is that a version number appears instead of a "not found" error.

## Step 6: Set your name and email

Git attaches a name and email to every commit you make, so collaborators (and you, later) can see who made each change. Set these with your own details:

```
git config --global user.name "Simon Read"
git config --global user.email "sread@smcm.edu"
```

Using the same email as your GitHub account links your commits to your GitHub profile. The `--global` flag means this applies to every git repository on this VM, not just one project.

## Step 7: Set the default branch name

Newer versions of git already name a new repository's main branch `main`, but it is worth setting this explicitly so behaviour is consistent regardless of the exact version installed:

```
git config --global init.defaultBranch main
```

## Step 8: Confirm your configuration

```
git config --global --list
```

You should see your `user.name`, `user.email` and `init.defaultBranch` values listed back to you, matching what you entered in Steps 6 and 7.

## Step 9: Confirm the VM can borrow your key

When you connect, VS Code carries your agent's services along with it (you switched this on in [Creating SSH keys, Step 10](04-create-ssh-keys.md#step-10-let-your-vm-borrow-your-key)). Check it has arrived. In the VS Code terminal on the VM, type:

```
ssh-add -l
```

You should see the same line you saw on your own computer, containing `ED25519` and ending in `sread`. The key is being lent by your laptop for as long as you are connected; nothing has been copied to the VM, which is why its `.ssh` folder still contains only `authorized_keys` (the padlock that lets you in, which you should leave alone).

## Step 10: Confirm the VM can reach GitHub

1. In the same terminal, type:

   ```
   ssh -T git@github.com
   ```

   As on your own computer, type `git@github.com` exactly; the `git` is GitHub's shared account, not a placeholder for your username ([Creating SSH keys, Step 11](04-create-ssh-keys.md#step-11-confirm-github-recognises-your-key) explains why).

2. The first time, you see a message ending in `Are you sure you want to continue connecting (yes/no/[fingerprint])?`. Type `yes` and press Enter.

You should then see `Hi sread! You've successfully authenticated, but GitHub does not provide shell access.` (with your GitHub username in place of `sread`). That message is expected; it confirms the VM can reach GitHub using your key, even though GitHub does not offer you a shell.

## If something goes wrong

**"git: command not found" after installing**: close the terminal (the bin icon on the terminal panel), open a new one, and run `git --version` again. If it still fails, run `sudo apt install git` again and watch for error text partway through the install rather than at the end.

**Nothing happens when you type a password after sudo**: this is normal. Linux terminals do not display any characters, not even dots, while a password is typed. Type it anyway and press Enter.

**`ssh-add -l` on the VM says "Could not open a connection to your authentication agent"** or **"The agent has no identities"**: the key is not reaching the VM. Work through these in order:

1. On your own computer, run `ssh-add -l`. If it does not list your key, repeat [Creating SSH keys, Step 9](04-create-ssh-keys.md#step-9-load-your-key-into-the-ssh-agent).
2. Check your SSH settings file contains `ForwardAgent yes` ([Creating SSH keys, Step 10](04-create-ssh-keys.md#step-10-let-your-vm-borrow-your-key)).
3. Close the remote connection (click the green indicator in the bottom-left corner, then **Close Remote Connection**) and connect again; forwarding is set up only when a connection starts.
4. If it still fails, open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`), run `Remote-SSH: Kill VS Code Server on Host...`, choose your VM's address, and connect again.

**"Permission denied (publickey)" when testing the GitHub connection**: first check `ssh-add -l` on the VM lists your key (see above). If it does, GitHub does not have the matching public key; repeat [Creating SSH keys, Step 8](04-create-ssh-keys.md#step-8-add-your-public-key-to-github), making sure the whole line was pasted.

**"Hi sread!" shows someone else's GitHub username**: the key is attached to a different GitHub account. Remove it from that account's **SSH and GPG keys** page and add it to the right one.

## What to do next

With git installed and connected to GitHub, [add the Python, Django and GitHub Copilot extensions to VS Code](09-python-django-and-copilot-extensions.md).

## Sources

- [Using SSH agent forwarding](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding) (GitHub documentation)
- [Remote development tips and tricks](https://code.visualstudio.com/docs/remote/troubleshooting) (VS Code documentation)
- [Testing your SSH connection](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection) (GitHub documentation)
- [Ubuntu images on Compute Engine](https://docs.cloud.google.com/compute/docs/eol/ubuntu-eol) (Google Cloud documentation)
