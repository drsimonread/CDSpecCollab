# Developing Django on Google Cloud from VS Code

This set of guides takes you from having no accounts at all to working on a shared Django project that lives on a Google Cloud Platform (GCP) virtual machine (VM), edited from Visual Studio Code (VS Code) on your own computer and kept in step with your teammates through git and GitHub. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

The examples throughout use the username `sread`; substitute your own wherever you see it.

## How the pieces fit together

Before we start clicking things, it helps to know what each tool is for. Think of the project as a building site:

- **GitHub** is the site office, where the master copy of the plans is kept and everyone can see who changed what.
- **Your GCP VM** is the building site itself, a Linux computer in Google's data centre where your Python and Django code actually runs.
- **Education credits** pay the rent on the site; without them, Google will not let you build.
- **Your SSH key** is your site pass. You keep it on your laptop; it gets you onto the site, and while you are there the site can borrow it (without copying it) to prove to the office that the work is yours.
- **git** is the courier that carries changes between the site and the office (and keeps a record of every delivery).
- **VS Code** is your window onto the site from your own desk: it looks like an ordinary editor on your laptop, but once connected, everything you open, edit and run is on the VM.

## What depends on what

The order below is not arbitrary; each guide needs something an earlier one produced. You cannot install git on a VM that does not exist, you cannot create the VM until your credits are redeemed (Google would otherwise ask for a credit card) and your SSH key exists (it is added while the VM is being created), and so on.

| Guide | Needs first |
|---|---|
| 1. GitHub account | Nothing |
| 2. Student Developer Pack | 1 |
| 3. Education credits | Your instructor's coupon link |
| 4. SSH keys (including adding the key to GitHub) | 1 |
| 5. VS Code | Nothing |
| 6. GCP VM | 3 and 4 |
| 7. Connect VS Code to the VM | 4, 5 and 6 |
| 8. Git on the VM | 4 (Steps 8 to 11) and 7 |
| 9. Python, Django and Copilot extensions | 1 and 7 (2 for Copilot's student benefits) |
| 10. Clone, branch and merge | 1 (including the CDSpecCollab invitation in Step 6) and 8; 9 for comfortable editing |
| 11. Merge conflict practice | 10 |

Guides 3 and 5 do not depend on anything earlier, and guide 4 needs only guide 1, so you can do these in any order once you have a GitHub account (or while waiting for a coupon email to arrive).

## The guides, in order

### Part 1: Accounts and credits

1. [Creating a GitHub account and your first private repository](01-create-github-account.md)
2. [Applying for the GitHub Student Developer Pack (including Copilot)](02-github-student-pack-and-copilot.md)
3. [Redeeming your Google Cloud education credits](03-redeem-google-cloud-education-credits.md)

### Part 2: Your own computer

4. [Creating and finding SSH keys on Windows and macOS](04-create-ssh-keys.md)
5. [Installing VS Code on Windows 11 or macOS](05-install-vscode.md)

### Part 3: The VM and VS Code

6. [Creating your Google Cloud VM with HTTP access and your public key](06-create-gcp-vm.md)
7. [Connecting VS Code to your GCP VM with Remote Development](07-connect-vscode-to-gcp-vm.md)
8. [Installing and configuring git on your GCP VM](08-install-git-on-gcp-vm.md)
9. [Adding Python, Django and GitHub Copilot support to VS Code](09-python-django-and-copilot-extensions.md)

### Part 4: The everyday workflow

10. [Cloning, branching and merging CDSpecCollab](10-clone-branch-merge-cdspeccollab.md)
11. [Practice: working through a real merge conflict](11-merge-conflict-practice.md)

### Learning the languages

- [Training resources for HTML, CSS, Python, Django, git and JavaScript](training-resources.md)

## Where each command runs

Most confusion in this set comes from typing a command on the wrong computer, so it is worth being explicit:

| Guide | Where you work |
|---|---|
| 1 to 3 | A web browser |
| 4 and 5 | Your own computer (PowerShell on Windows, Terminal on macOS) |
| 6 | The Google Cloud Console in a browser, then a terminal on your own computer to test the connection |
| 7 | VS Code on your own computer |
| 8 to 11 | The VM, through a terminal in VS Code that is connected to it (`SSH:` and your VM's external IP, such as `SSH: 34.86.123.45`, in the bottom-left corner) |

## Every work session

1. Start your VM ([guide 6, Step 11](06-create-gcp-vm.md#step-11-start-your-instance-again-when-you-need-it)).
2. Find and copy its external IP ([guide 7, Steps 2 and 3](07-connect-vscode-to-gcp-vm.md#step-2-find-your-vms-external-ip)).
3. Connect VS Code to the VM by typing `sread@` and pasting the address ([guide 7, Step 4](07-connect-vscode-to-gcp-vm.md#step-4-connect-to-your-vm)).
4. Bring your branch up to date ([guide 10, Steps 11 and 12](10-clone-branch-merge-cdspeccollab.md#step-11-update-your-local-development-branch-from-github)).
5. Work, commit and push.
6. Disconnect VS Code and stop your VM ([guide 6, Step 10](06-create-gcp-vm.md#step-10-stop-your-instance-when-you-are-not-using-it)).

## Not yet covered

Creating a Python virtual environment, installing Django and running the development server are not covered by these guides yet; the [official Django tutorial](https://docs.djangoproject.com/en/6.1/intro/tutorial01/) listed in the [training resources](training-resources.md) covers them.
