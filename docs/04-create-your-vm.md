# Creating Your Google Cloud VM

All your development for the team project happens on a "virtual machine" (VM): a computer that you rent by the hour in one of Google's data centres and use over the internet. In this guide we make an SSH key on your laptop (the key that will let you log in), create a Google Cloud project and a VM inside it, connect to the VM for the first time, and give it a short name so that VS Code can find it. Finally we stop the VM, which is the habit that matters most. No prior technical experience is needed.

Why a VM rather than your laptop? Because everyone's VM is set up the same way, matching the environment the finished web application will run in. Laptops differ wildly, and "it works on my machine" is the oldest excuse in software.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- VS Code with the Remote Development extension installed ([03 Install the VS Code extensions](03-install-vscode-extensions.md)). Part 5 uses it.
- A Google account, and the GCP Educational Credits your instructor sends you (usually as a link or coupon code by email). You pay for your VM solely with these credits; you never need a credit card.

BEWARE: a VM uses up your credits for every hour it is running, whether or not you are using it, and the credits are all you have to pay for it. When they run out, your VM stops working until you get more. Part 6 shows you how to stop it; do that at the end of this guide and at the end of every session.

## Part 1: Make an SSH key on your laptop

An SSH key comes as a pair of files: a private key that never leaves your laptop, and a public key that you give to the VM. When you connect, the VM checks that your laptop holds the private key that matches. It is a lock and key, except that you can hand out copies of the lock freely.

### Step 1: Open a terminal on your laptop

1. On Windows, click **Start**, type `PowerShell` and press **Enter**. On macOS, press **Cmd+Space**, type `Terminal` and press **Return**.
2. A window opens with a command prompt. Every command in Parts 1 and 4 is typed here.

### Step 2: Check for an existing key

1. Type `ls ~/.ssh` and press **Enter** or **Return**.
2. If you see `id_ed25519` and `id_ed25519.pub`, you already have a key: go to Step 4, and check the name at the end of the key as described there.
3. If you see an error saying the path does not exist, or no `id_ed25519` files, continue with Step 3.

### Step 3: Create a key

First, choose your Linux username for the VM. Use lowercase letters and digits only, starting with a letter, and no spaces: for example your college username, such as `jdoe`. Choose with care, because the VM takes your username from the label on this key, it appears in every command prompt you see, and changing it later means starting again.

1. Type the following, with your chosen username in place of `jdoe`, and press **Enter** or **Return**:

   ```
   ssh-keygen -t ed25519 -C "jdoe"
   ```

2. When asked `Enter file in which to save the key`, press **Enter** or **Return** to accept the suggested location.
3. When asked `Enter passphrase`, press **Enter** or **Return** for no passphrase, then press it again to confirm. (A passphrase protects the key if someone gets hold of your laptop, at the cost of typing it every time you connect. If you choose one, notice that nothing appears as you type it, not even dots.)
4. The terminal prints a "fingerprint" and a small box of symbols called "randomart". You can ignore both.

`-t ed25519` chooses a modern type of key; `-C "jdoe"` is the label (the "comment") that Google Cloud turns into your username.

### Step 4: Display the public key

1. Type `cat ~/.ssh/id_ed25519.pub` and press **Enter** or **Return**.
2. One long line appears, starting with `ssh-ed25519` and ending with the comment, your username. It may wrap across several lines on screen, but it is one line.
3. Check the word at the end. That is the username you will have on the VM; write it down.
4. Leave this window open. You will copy the line in Step 10.

BEWARE: only ever copy the file ending in `.pub`. The file without `.pub` is your private key; anyone who has it can log in to your VM as you.

## Part 2: Create a Google Cloud project

A "project" is Google Cloud's container for everything you create, and for the bill.

### Step 5: Create the project

1. Go to the [Google Cloud console](https://console.cloud.google.com/) and sign in.
2. Click the project selector near the top-left of the page (it may say **Select a project**, or show a project's name).
3. Click **New Project**.
4. In **Project name**, type a name such as `jdoe-cosc401` (your name and the course make it easy to recognise).
5. Leave **Organisation** (or **Organization**) and **Location** as they are, unless your instructor says otherwise.
6. Click **Create**.

### Step 6: Select the project and link your credits

1. Wait a few seconds for a notification saying the project was created.
2. Click the project selector again and choose your new project.
3. Check that its name now shows at the top of the page. This matters, because everything you do next happens in whichever project is selected.
4. If you have not yet redeemed your GCP Educational Credits, open the link your instructor sent, sign in with the same Google account, and follow the instructions to redeem them. This creates a "billing account" that holds your credits.
5. Open the menu (three horizontal lines, top-left) and choose **Billing**.
6. If Google says the project has no billing account, click **Link a billing account** and choose the one holding your educational credits (its name usually mentions **Education**), then click **Set account**.
7. Check that the billing page shows your credits and their remaining balance.

BEWARE: if Google asks for a credit or debit card at any point, or offers a "free trial", stop. Your educational credits need no card; a page asking for one means you are about to set up a different, paid account. Go back and choose the billing account holding your credits instead.

## Part 3: Create the VM

### Step 7: Start creating an instance

1. Open the menu (three horizontal lines, top-left), then choose **Compute Engine**, then **VM instances**.
2. If asked to enable the **Compute Engine API**, click **Enable** and wait; it can take a minute or two.
3. Click **Create Instance**.

The page has a list of sections down the left-hand side (**Machine configuration**, **OS and storage**, **Networking**, **Security** and others). We visit four of them.

### Step 8: Machine configuration

1. In **Name**, type a name such as `instance-00`.
2. Choose a **Region** near you (for students in Maryland, **us-east4 (Northern Virginia)** is the closest). Leave **Zone** as it is.
3. Under the machine series, choose **E2**, and check that **Machine type** is **e2-medium**.

### Step 9: Choose the operating system

1. Click **OS and storage** in the list on the left.
2. Click **Change**.
3. Set **Operating system** to **Ubuntu**.
4. Set **Version** to **Ubuntu 26.04 LTS** (for **x86/64**). Do not choose a version labelled **Pro**, which costs extra.
5. Leave the disk type and size as they are, and click **Select**.

### Step 10: Allow web traffic and add your key

1. Click **Networking** in the list on the left.
2. Under **Firewall**, tick **Allow HTTP traffic** and **Allow HTTPS traffic**. These let web browsers reach the web application on your VM later on.
3. Click **Security** in the list on the left.
4. Find **Manage access** and, under it, **Add manually generated SSH keys**. Click **Add item**.
5. Go back to your terminal window from Step 4, select the whole `ssh-ed25519` line with the mouse and copy it (**Ctrl+C** on Windows, **Cmd+C** on macOS).
6. Click in the new key box on the Google Cloud page and paste (**Ctrl+V** or **Cmd+V**).
7. Check that the username Google Cloud shows beside the key matches the comment you wrote down in Step 4.

### Step 11: Create it

1. Click **Create** at the bottom of the page.
2. Wait a minute or two. Your VM appears in the **VM instances** list, and its **Status** turns into a green circle with a white tick when it is running.
3. Find the **External IP** column and write down the address, which looks like `34.86.xx.xx`.

## Part 4: Connect for the first time

### Step 12: Log in from the terminal

1. In your terminal window, type `ssh` followed by a space, your username, an `@` sign and the External IP address, for example `ssh jdoe@34.86.xx.xx`, and press **Enter** or **Return**.
2. The first time, you are asked whether to trust the VM's "fingerprint", ending with `(yes/no/[fingerprint])?`. Type `yes` (the whole word) and press **Enter** or **Return**. This is SSH's way of introducing your laptop to the VM; it does not ask again.
3. The prompt changes to something like `jdoe@instance-00:~$`. Everything you type now runs on the VM.
4. Type `exit` and press **Enter** or **Return** to log out. The prompt goes back to your laptop's.

If this works, the hard part is done: the VM exists, and it recognises your key.

## Part 5: Give your VM a short name

VS Code connects to your VM using SSH, and SSH can keep a "configuration file" of machines you use, each with a short name. Recording your VM there means VS Code lists it by name, and when its address changes (Step 16) you update one line instead of retyping everything.

### Step 13: Open your SSH configuration file in VS Code

1. Open VS Code (on your laptop; no connection needed).
2. Open the Command Palette (**Ctrl+Shift+P** or **Cmd+Shift+P**).
3. Run **Remote-SSH: Open SSH Configuration File...**
4. Choose the file in your own user folder: `C:\Users\yourname\.ssh\config` on Windows, or `/Users/yourname/.ssh/config` on macOS. VS Code creates it if it does not exist yet.

### Step 14: Add your VM

1. At the end of the file, type the following, with your own External IP address and username:

   ```
   Host gcp-vm
       HostName 34.86.xx.xx
       User jdoe
       IdentityFile ~/.ssh/id_ed25519
   ```

2. Save the file (**Ctrl+S** or **Cmd+S**).

`Host` is the short name (`gcp-vm`); `HostName` is the real address; `User` is your username on the VM; `IdentityFile` is the private key to use. Keep the indentation: SSH reads the indented lines as belonging to the `Host` line above them.

### Step 15: Test the short name

1. In your terminal window, type `ssh gcp-vm` and press **Enter** or **Return**.
2. You should arrive at the same `jdoe@instance-00:~$` prompt as in Step 12, without being asked anything.
3. Type `exit` and press **Enter** or **Return**.

## Part 6: Stop and start your VM

### Step 16: Stop the VM

Do this now, and at the end of every session.

1. In the Google Cloud console, go to **Compute Engine**, **VM instances**.
2. Tick the box at the start of your VM's row.
3. Click **Stop** in the bar at the top of the list.
4. Confirm by clicking **Stop** in the box that appears.
5. A notification says `Stopping instance-00`. It can take a minute.
6. When it says the VM is stopped, the status icon has turned into a grey circle with a white square in it. You can dismiss the notifications.

A stopped VM keeps all its files. Its disk still uses a little of your credits, but the computing time, which is most of the cost, stops.

### Step 17: Start the VM again

1. In **VM instances**, tick the box at the start of your VM's row.
2. Click **Start / Resume** in the bar at the top of the list.
3. Confirm by clicking **Start** in the box that appears.
4. Wait for the status to become a green circle with a white tick.
5. Look at the **External IP** column. The address usually changes each time the VM starts.
6. If it has changed, open your SSH configuration file again (Step 13), change the `HostName` line to the new address, and save.

Forgetting instruction 6 is the commonest reason VS Code will not connect at the start of a session; [13 A typical development session](13-a-typical-development-session.md) builds it into the routine.

## If something goes wrong

**"ssh" or "ssh-keygen" is not recognised (Windows).** The OpenSSH client is switched off. Open **Settings**, then **System** (or **Apps**), then **Optional features**, add **OpenSSH Client**, then close PowerShell and open a new window.

**"Permission denied (publickey)".** The username you typed must match the comment on your key exactly. Check the end of the line from Step 4 against what you typed, and against the username Google Cloud shows beside the key (open your VM's page, click **Edit**, and look under **Security**). If the key was pasted incompletely, delete it there, paste it again, and click **Save**.

**"Connection timed out" or "Connection refused".** Check that the VM is running (green tick) and that you are using its current External IP address. If it still fails, click **SSH** in your VM's row in the console: a browser terminal opening means the VM itself is fine and the problem is on your laptop's side.

**The VM will not start, with a message that resources are not available in the zone.** Google sometimes runs out of machines in a busy region. Wait and try again later, or create a new VM in a different region (Parts 3 to 5 again, then update `HostName` in your configuration file). A new VM starts empty: you will need to set it up again from guide 05 on and clone your repository afresh, and any work you had not pushed to GitHub stays stranded on the old one. That is one of the best reasons to commit and push at the end of every session.

**"WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!".** You are connecting to a new VM at an address your laptop remembers from an old one. If you did create a new VM, type `ssh-keygen -R` followed by a space and the address (for example `ssh-keygen -R 34.86.xx.xx`), press **Enter** or **Return**, and connect again. If you did not create a new VM, stop and ask your instructor.

**Google asks for a credit card, or says billing is not enabled.** The project is not linked to the billing account holding your educational credits. Do Step 6, instructions 4 to 7. Never enter a card; if you cannot find your credits, ask your instructor.

**I see `id_rsa` rather than `id_ed25519` in Step 2.** That is an older type of key, and it still works. Use `id_rsa.pub` in Step 4 and `id_rsa` in Step 14.

## What to do next

Connect VS Code to your VM and learn your way around it: [05 Use VS Code with your VM](05-use-vscode-with-your-vm.md).

When you have finished with the course, delete the VM (and the project, if nothing else is in it) from the console, because even a stopped VM uses a little of your credits for its disk.

## Sources

- [Creating and managing projects (Google Cloud documentation)](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- [Create and start a VM instance (Google Cloud documentation)](https://cloud.google.com/compute/docs/instances/create-start-instance)
- [Add SSH keys to VMs (Google Cloud documentation)](https://cloud.google.com/compute/docs/connect/add-ssh-keys)
- [Stop and start a VM (Google Cloud documentation)](https://cloud.google.com/compute/docs/instances/stop-start-instance)
- [Remote Development using SSH (VS Code documentation)](https://code.visualstudio.com/docs/remote/ssh)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
