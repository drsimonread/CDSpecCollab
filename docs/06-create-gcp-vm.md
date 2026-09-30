# Creating Your Google Cloud VM with HTTP Access and Your Public Key

A virtual machine (VM) is a computer that exists only as software, running in someone else's data centre; you rent it by the hour. This guide creates a Google Cloud project paid for by your education credits, creates an Ubuntu VM on Compute Engine, allows web traffic to reach it, and installs your SSH public key so you can log in as `sread`. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Installing VS Code](05-install-vscode.md) | Next: [Connecting VS Code to your GCP VM](07-connect-vscode-to-gcp-vm.md)

## Before you start

You need:

1. Your Google Cloud education credits redeemed, as covered in [Redeeming your education credits](03-redeem-google-cloud-education-credits.md). Without them, Google asks for a credit card at Step 1.
2. An SSH key pair on your own computer whose public key ends in your username (`sread` in these examples), as covered in [Creating SSH keys](04-create-ssh-keys.md).

**A VM costs money for every hour it runs**, whether or not you are using it. Once it is created, get into the habit of stopping it at the end of each work session ([Step 10](#step-10-stop-your-instance-when-you-are-not-using-it)).

## Step 1: Create a Google Cloud project

A project is a container that holds your VM and everything connected to it, along with the billing account that pays for them.

1. Go to the [Google Cloud Console](https://console.cloud.google.com/) and sign in with the Google account that holds your education credits.
2. Click the project dropdown at the top of the page (it may say **Select a project** or show an existing project name).
3. Click **New Project** in the window that opens.
4. Enter a **Project name**, for example `cdspeccollab-project`.
5. If a **Billing account** field appears, select the billing account named after your course. This is what makes your credits, rather than a credit card, pay for the project.
6. Leave the **Organization** and **Location** fields at their defaults unless your instructor told you otherwise.
7. Click **Create**.
8. Wait a few seconds, then make sure your new project is selected in the dropdown at the top of the page. This matters because every later step applies to whichever project is currently selected.

## Step 2: Confirm the project uses your education credits

1. Open the navigation menu (three horizontal lines, top-left) and click **Billing**.
2. If the page says **This project has no billing account**, click **Link a billing account**, select the billing account named after your course, and click **Set account**.
3. Otherwise, check that the billing account shown is the one named after your course.

## Step 3: Enable the Compute Engine API

1. In the navigation menu, click **Compute Engine**, then **VM instances**.
2. The first time you do this in a new project, Google shows a **Compute Engine API** page. Click **Enable**.
3. Wait for it to finish (this can take a minute or two). The **VM instances** page appears when it is ready.

## Step 4: Start creating the VM

1. On the **VM instances** page, click **Create Instance**.
2. Give the instance a **Name**, for example `cdspeccollab-vm`.
3. Choose a **Region** and **Zone**. The defaults are fine if you are unsure; for students in Maryland, `us-east4` (Northern Virginia) is close by.
4. Under **Machine configuration**, leave the default machine type (for example `e2-medium`) unless your instructor specified another.

## Step 5: Choose Ubuntu for the boot disk

1. Under **Boot disk** (in some layouts, the **OS and storage** section), click **Change**.
2. Click the **Operating system** dropdown and select **Ubuntu**.
3. Click the **Version** dropdown and select the newest Ubuntu LTS option that is not labelled "Pro" (something like `Ubuntu 24.04 LTS`; pick the highest version number shown, since Google periodically adds newer releases).
4. Leave the disk type and size at their defaults.
5. Click **Select**.

## Step 6: Allow HTTP traffic

1. Scroll down to the **Firewall** section (in some layouts, under **Networking**).
2. Check **Allow HTTP traffic**.
3. If your app also needs HTTPS, check **Allow HTTPS traffic** as well.

This automatically creates a firewall rule that opens port 80 (and 443, if selected) to the internet, so a web browser anywhere can reach a web server on your VM.

## Step 7: Add your SSH public key and create the VM

1. On your own computer, copy your public key to the clipboard (from [Creating SSH keys, Step 7](04-create-ssh-keys.md#step-7-copy-the-public-key-when-you-need-it)):
   - **Windows:** `Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | Set-Clipboard`
   - **macOS:** `pbcopy < ~/.ssh/id_ed25519.pub`
2. Back in the Create Instance page, click **Advanced options** to expand it, then click **Security**.
3. Find the **SSH Keys** section and click **Add item** (or **Show and edit** if keys are already listed).
4. Paste your key into the box. Check that it is one line, starts with `ssh-ed25519` and ends with `sread`; that trailing name is the Linux account Google creates for you.
5. Click **Done**.
6. Review your settings, then click **Create** at the bottom of the page.
7. Wait a minute or two for the instance to start. It appears in your **VM instances** list with a green tick once it is running.

## Step 8: Connect to your VM from your own computer

1. In the **VM instances** list, find the **External IP** address next to your instance (four numbers separated by dots, such as `34.86.123.45`); [Connecting VS Code, Steps 2 and 3](07-connect-vscode-to-gcp-vm.md#step-2-find-your-vms-external-ip) describe finding and copying it in detail.
2. Open a terminal on your own computer (PowerShell on Windows, Terminal on macOS).
3. Type the following, replacing `EXTERNAL_IP` with your instance's external IP:
   - **macOS:** `ssh -i ~/.ssh/id_ed25519 sread@EXTERNAL_IP`
   - **Windows:** `ssh -i $env:USERPROFILE\.ssh\id_ed25519 sread@EXTERNAL_IP`
4. The first time you connect, you see a message ending in `Are you sure you want to continue connecting (yes/no/[fingerprint])?`. Type `yes` and press Enter. This records the VM's identity so your computer can warn you if something ever impersonates it.
5. If you set a passphrase on your key, enter it (nothing appears as you type, which is normal).

You should see a welcome message from Ubuntu followed by a prompt such as `sread@cdspeccollab-vm:~$`. The name before the `@` must match the one at the end of your key; if they differ, the VM looks for an account that does not hold your key and refuses the connection.

Type `exit` and press Enter to disconnect. From now on you will mostly connect through VS Code instead, but this command is a useful check whenever VS Code will not connect.

## Step 9: Confirm HTTP access works (optional)

1. While connected (Step 8), install a test web server:

   ```
   sudo apt update
   sudo apt install -y apache2
   ```

2. In a web browser on your own computer, go to `http://EXTERNAL_IP` (your VM's external IP).

You should see the Apache default page, confirming the firewall rule from Step 6 works. Remove the test server afterwards, so it does not get in the way of your own web applications later:

```
sudo apt remove -y apache2
```

## Step 10: Stop your instance when you are not using it

Google charges your credits for a VM the whole time it runs. Stop it whenever you finish for the day.

1. Go to **Compute Engine > VM instances**.
2. Check the box next to your instance's name.
3. Click **Stop** at the top of the page (or click the three dots at the end of the row and select **Stop**).
4. Confirm if prompted.

After a minute, the instance's status changes to a grey "stopped" icon. A stopped instance still incurs a small charge for its disk storage, but not for its compute (CPU and memory) time, which is usually the bulk of the cost.

## Step 11: Start your instance again when you need it

1. Go to **Compute Engine > VM instances**.
2. Check the box next to your stopped instance.
3. Click **Start / Resume** at the top of the page.
4. Wait a minute for it to boot.
5. Note the **External IP** again. It usually changes each time you stop and start the instance, so look it up each time before connecting ([Connecting VS Code, Steps 2 to 4](07-connect-vscode-to-gcp-vm.md#step-2-find-your-vms-external-ip)).

## The SSH button in the Console

Each row in the **VM instances** list has an **SSH** button that opens a terminal in your browser without using your key. It is handy for checking that a VM is alive when nothing else will connect. Be aware, though, that it may log you in under a username derived from your Google account rather than `sread`, and files you create there then live in a different home folder from the one VS Code uses. For everyday work, use VS Code or the `ssh` command from Step 8.

## If something goes wrong

**Google asks for a credit card when creating the project**: the project is not linked to your education billing account. Select the billing account named after your course (Step 1 or Step 2).

**"Permission denied (publickey)"**: the name before the `@` does not match the end of the key you pasted in Step 7, or the key was pasted incompletely. Check the key on your computer ([Creating SSH keys, Step 6](04-create-ssh-keys.md#step-6-display-your-public-key-and-confirm-it-is-correct)), then in the Console click your instance's name, click **Edit**, and correct the entry under **SSH Keys**.

**The connection times out**: the VM is stopped, or you are using an old external IP. Check the **VM instances** list for a green tick and the current IP.

## Cleaning up at the end of the course

If you are finished with the instance permanently rather than pausing it, go to **VM instances**, select your instance and click **Delete** to avoid any ongoing charges, including disk storage. If you no longer need the project either, delete it from **IAM & Admin > Manage Resources**.

## What to do next

With your VM running and reachable, [connect VS Code to it](07-connect-vscode-to-gcp-vm.md).

## Sources

- [Creating and managing projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects) (Google Cloud documentation)
- [Create a VM instance from a public image](https://cloud.google.com/compute/docs/instances/create-start-instance) (Google Cloud documentation)
- [Add SSH keys to VMs](https://cloud.google.com/compute/docs/connect/add-ssh-keys) (Google Cloud documentation)
- [VPC firewall rules](https://cloud.google.com/firewall/docs/firewalls) (Google Cloud documentation)
- [Stop and start a VM](https://cloud.google.com/compute/docs/instances/stop-start-instance) (Google Cloud documentation)
