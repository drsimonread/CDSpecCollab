# Creating and Finding SSH Keys on Windows and macOS

An SSH key pair is how you prove who you are to a remote server without typing a password. This guide creates one pair on your own computer, adds it to GitHub, and sets it up so your Google Cloud VM can borrow it when it talks to GitHub. You add the same public key to your VM when you create it in the [next-but-one guide](06-create-gcp-vm.md). One key pair therefore does everything in this course. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Redeeming your education credits](03-redeem-google-cloud-education-credits.md) | Next: [Installing VS Code](05-install-vscode.md)

## Before you start

You need a [GitHub account](01-create-github-account.md), for Step 8.

## What a key pair is

Generating a key produces two files that belong together, rather like a padlock and its key:

- The **private key** (for example `id_ed25519`, with no file extension) is the key. It stays on your computer permanently. Treat it like a password: never email it, never paste it into a chat or a web form, never commit it to a git repository. Anyone holding this file can log in as you.
- The **public key** (the same name ending in `.pub`) is the padlock. You hand out copies to be fitted wherever you want to get in: the Google Cloud console, GitHub, or any other server. It is safe to share.

Both files are created at the same moment and only work as a pair. If you lose the private key, the public key is useless and you generate a new pair.

## Step 1: Open a terminal

**On Windows:**

1. Click the **Start** button.
2. Type `PowerShell` and press Enter to open Windows PowerShell.

The prompt reads something like `PS C:\Users\sread>`: `PS` tells you this is PowerShell rather than the older Command Prompt (which these guides do not use), and the path is the folder you are currently in, your home folder.

**On macOS:**

1. Press `Command+Space`.
2. Type `Terminal` and press Enter.

## Step 2: Check whether you already have a key

Generating a second key when you already have one is a common source of confusion later, so check first.

**On Windows**, type:

```
dir $env:USERPROFILE\.ssh
```

`$env:USERPROFILE` is PowerShell's name for your home folder (`C:\Users\sread`), so this lists the `.ssh` folder inside it. Using the name rather than typing the path means the same command works for everyone, whatever their username.

**On macOS**, type:

```
ls -la ~/.ssh
```

If you see files named `id_ed25519` and `id_ed25519.pub` (or `id_rsa` and `id_rsa.pub`), you already have a key pair. Check which username it carries (Step 6); if it ends in `sread`, skip to Step 7. If it ends in something else, see "Changing the username on an existing key" below.

If you get a message saying the folder does not exist, or the listing is empty, you have no keys yet. Continue to Step 3.

## Step 3: Choose your username

The text at the end of a public key is called the "comment", and on Google Cloud it is not decorative. Compute Engine reads it, creates a Linux account with that exact name on the VM, and installs your key into that account. Whatever you put there becomes the username you log in as, and your home folder on the VM (`/home/sread`).

Choose it before generating the key, because changing it afterwards means generating a new pair or editing the key file. The examples throughout this set use `sread`; substitute your own.

- Use lowercase letters, digits and underscores. Start with a letter.
- No spaces, no capitals, no `@` signs and no dots; a username like `simon.read` will not behave as you expect.
- Keep it short and recognisable: `sread` or `simon_read`.
- If your instructor specified a username for the server, use exactly that. Mismatched usernames are the most common reason a connection is refused.

## Step 4: Generate the key pair

The command is identical on both systems. Windows 11 includes `ssh-keygen` (part of its built-in OpenSSH client), so nothing needs installing.

1. In the terminal from Step 1, type the following (replacing `sread` with the username you chose) and press Enter:

   ```
   ssh-keygen -t ed25519 -C "sread"
   ```

   The `-C` value is the comment described in Step 3.

2. When asked where to save the file, press Enter to accept the default location. Typing a custom path here is the most common way people lose track of their keys afterwards.

If you need more than one key (a personal one and a course one, say), give the second a distinct file name instead of overwriting the first. Type a full path at this prompt, such as `C:\Users\sread\.ssh\id_ed25519_course` on Windows or `/Users/sread/.ssh/id_ed25519_course` on macOS, and use that file name everywhere these guides say `id_ed25519`.

## Step 5: Choose whether to use a passphrase

1. When asked for a passphrase, decide:
   - Entering one encrypts the private key on disk, so someone who copies the file still cannot use it. You are asked for the passphrase when you connect, though your system can remember it for the session.
   - Pressing Enter leaves it blank, which is more convenient and is acceptable for coursework on a computer only you use.

   If this key will reach anything you would mind losing control of, use a passphrase. Nothing appears on screen as you type it, which is normal.

2. Enter the same passphrase again (or press Enter again) to confirm.

The command prints a "randomart image", a small block of symbols. It is a visual fingerprint, and you can ignore it. Your two files now exist in the `.ssh` folder in your home directory.

## Step 6: Display your public key and confirm it is correct

**On Windows**, display it:

```
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub
```

**On macOS**, display it:

```
cat ~/.ssh/id_ed25519.pub
```

You should see a single long line, beginning with the key type and ending with the username you supplied:

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8k2p...rest of the key... sread
```

If the line ends with `sread` (or your chosen username), the key is ready.

## Step 7: Copy the public key when you need it

You copy the public key whenever you set up a new server or add a key to GitHub. Copying straight to the clipboard avoids selection mistakes:

**On Windows:**

```
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | Set-Clipboard
```

**On macOS:**

```
pbcopy < ~/.ssh/id_ed25519.pub
```

When pasting it anywhere, paste the entire line, including the `ssh-ed25519` prefix and the trailing username, with no line breaks in the middle. A key broken across two lines is rejected, and a key pasted without its trailing username does not create the account you expect on Google Cloud.

## Step 8: Add your public key to GitHub

1. Copy your public key to the clipboard (Step 7).
2. In a browser, sign in to [GitHub](https://github.com), click your profile picture in the top right, then click **Settings**.
3. In the sidebar, click **SSH and GPG keys**.
4. Click **New SSH key**.
5. Give the key a **Title** that identifies the computer it lives on, such as `sread laptop`. This is only a label to help you recognise it later.
6. Leave **Key type** set to **Authentication Key**.
7. Paste the key into the **Key** field, then click **Add SSH key**. GitHub may ask you to confirm your password or a two-factor code.

## Step 9: Load your key into the SSH agent

The "SSH agent" is a small program on your computer that holds your unlocked private key in memory and signs things with it on request. It matters here because it can also answer requests from your VM (Step 10), which is how the VM gets to use your key without the key ever being copied there. It is rather like a notary who keeps the seal in their office: documents are sent to the notary to be stamped, but the seal itself never leaves the building.

**On Windows**, the agent is installed but switched off, and switching it on needs administrator rights (once only):

1. Right-click the **Start** button and choose **Terminal (Admin)**. Click **Yes** if Windows asks for permission.
2. In the administrator PowerShell window, type:

   ```
   Set-Service ssh-agent -StartupType Automatic
   ```

3. Then type:

   ```
   Start-Service ssh-agent
   ```

4. Close the administrator window.
5. In your ordinary PowerShell window, add your key to the agent:

   ```
   ssh-add $env:USERPROFILE\.ssh\id_ed25519
   ```

6. Enter your passphrase if you set one.

The Windows agent remembers your key from now on, even after a restart.

**On macOS**, the agent is already running:

1. In Terminal, add your key to the agent:

   ```
   ssh-add ~/.ssh/id_ed25519
   ```

2. Enter your passphrase if you set one.

The macOS agent forgets your key when you restart the computer; the setting in Step 10 adds it back automatically the next time you connect anywhere.

**On both systems**, confirm the key is loaded:

```
ssh-add -l
```

You should see one line containing `ED25519` and ending in `sread`.

## Step 10: Let your VM borrow your key

By default, the agent only answers requests from your own computer. One setting, "agent forwarding", lets it answer requests passed back along an SSH connection too, so that when git on your VM needs to prove who you are to GitHub, the request travels back to your laptop, your agent signs it, and the answer goes back to the VM. Your private key stays put.

**On Windows**, type this as one command (it adds three lines to your SSH settings file, creating the file if necessary):

```
Add-Content -Path $env:USERPROFILE\.ssh\config -Value "Host *", "    ForwardAgent yes", "    AddKeysToAgent yes"
```

**On macOS**, type:

```
printf 'Host *\n    ForwardAgent yes\n    AddKeysToAgent yes\n' >> ~/.ssh/config
```

`Host *` means "for every server"; `ForwardAgent yes` switches on forwarding; and `AddKeysToAgent yes` loads your key into the agent automatically whenever SSH uses it, which covers macOS forgetting it after a restart.

Confirm the file contains the three lines:

- **Windows:** `Get-Content $env:USERPROFILE\.ssh\config`
- **macOS:** `cat ~/.ssh/config`

A word of caution: while you are connected to a server with forwarding switched on, anyone with administrator access to that server could ask your agent to sign things for them (though never copy the key). On your own course VM that is only you, which is why this is safe here; if you later connect to servers other people run, ask whoever runs them whether forwarding is appropriate.

## Step 11: Confirm GitHub recognises your key

1. In PowerShell (Windows) or Terminal (macOS), type:

   ```
   ssh -T git@github.com
   ```

   Type `git@github.com` exactly as shown, including the word `git`; do not replace it with your own username. Every GitHub user connects as `git`, the same shared account, and GitHub works out which of its millions of users you are from your key alone. It is rather like a block of flats with a single front door: everyone uses the same door, and your key decides which flat it opens.

2. The first time, you see a message ending in `Are you sure you want to continue connecting (yes/no/[fingerprint])?`. Type `yes` and press Enter.

You should see `Hi sread! You've successfully authenticated, but GitHub does not provide shell access.` (with your GitHub username). That message is expected; it confirms GitHub accepts your key even though it does not offer you a shell. Notice that your username appears in GitHub's reply, not in the command: GitHub has recognised you from your key.

## Finding the .ssh folder

- **Windows**: the folder is `C:\Users\sread\.ssh`. File Explorer hides folders whose names begin with a dot, so open it from PowerShell instead: `explorer $env:USERPROFILE\.ssh`.
- **macOS**: the folder is `/Users/sread/.ssh`. Finder hides it too, so press `Command+Shift+G` in Finder and type `~/.ssh`.

## Telling the two files apart

If you are ever unsure which file is which, open it. The public key is one line starting with `ssh-ed25519`. The private key is many lines wrapped between `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----`. If you are looking at the BEGIN/END version, close it; that is the file that never leaves your computer.

## Changing the username on an existing key

If you already generated a key with the wrong comment, you do not have to start over. The comment is plain text at the end of the `.pub` file, and editing it changes nothing cryptographic.

- **macOS:** `ssh-keygen -c -C "sread" -f ~/.ssh/id_ed25519`
- **Windows:** `ssh-keygen -c -C "sread" -f $env:USERPROFILE\.ssh\id_ed25519`

Display the public key afterwards (Step 6) to confirm the new username appears at the end, then re-paste it anywhere you had already added the old version. Servers that already hold the old key keep using the old username until you replace it.

## If something goes wrong

**"Start-Service: Service 'OpenSSH Authentication Agent (ssh-agent)' cannot be started"** or **"Access is denied"** on Windows: the commands in Step 9 were typed in an ordinary PowerShell window rather than the administrator one. Repeat Step 9 from action 1. If your computer does not let you run anything as administrator (some managed laptops do not), ask whoever manages it, or your instructor.

**"Could not open a connection to your authentication agent"** or **"Error connecting to agent"** when running `ssh-add`: the agent is not running. On Windows, repeat Step 9 actions 1 to 4; on macOS, restart the computer and try again.

**`ssh-add -l` says "The agent has no identities"**: the agent is running but your key is not loaded. Run the `ssh-add` command from Step 9 again.

**"Permissions are too open" on macOS**: SSH refuses to use a private key that other accounts on the computer could read. Fix it with:

```
chmod 600 ~/.ssh/id_ed25519
```

**"Permission denied (publickey)" when connecting later**: the server does not recognise your key. The usual causes, in rough order of likelihood: the username before the `@` does not match the key's comment; the public key was pasted incompletely or with a line break in it; or the trailing username was trimmed off when pasting. Display the key again, check the name at the end of the line, and re-paste the whole thing.

**"Permission denied (publickey)" from `ssh -T`, having typed your own username** (such as `ssh -T sread@github.com`): GitHub has no account called `sread` to log in to; the account is always `git`. Retype the command as `ssh -T git@github.com`.

**You forgot the passphrase**: it cannot be recovered. Generate a new key pair and add the new public key to your servers.

## What to do next

Keep the terminal handy; you will copy this same public key again in [Creating your GCP VM](06-create-gcp-vm.md). First, [install VS Code](05-install-vscode.md).

## Sources

- [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) (GitHub documentation)
- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) (GitHub documentation)
- [Using SSH agent forwarding](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding) (GitHub documentation)
- [Remote development tips and tricks: using SSH keys and the SSH agent](https://code.visualstudio.com/docs/remote/troubleshooting) (VS Code documentation)
- [OpenSSH for Windows overview](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_overview) (Microsoft Learn)
- [Create SSH keys](https://cloud.google.com/compute/docs/connect/create-ssh-keys) (Google Cloud documentation)
- [Add SSH keys to VMs](https://cloud.google.com/compute/docs/connect/add-ssh-keys) (Google Cloud documentation)
