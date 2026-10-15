# Connecting Git on Your VM to GitHub

Before git on your VM can send your work to GitHub (to "push" it), GitHub needs to know that the VM is allowed to act for you. We do that with an SSH "key pair": two matching files, a private key that stays on the VM and a public key that you give to GitHub. When the VM connects, GitHub checks that the two match. No prior technical experience is needed.

Notice that this is a different key from the one on your laptop that lets you log in to the VM. That key opens the door from your laptop to the VM; this one opens the door from the VM to GitHub. A key to your flat is not a key to the office, and you need both.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- Git installed and configured on your VM: [07 Install git on your VM](07-install-git-on-your-vm.md).
- A terminal on your VM (VS Code connected to your VM, then **Ctrl+`**; or Google Cloud's browser terminal, as in guide 07, Step 1).
- Your GitHub account name and password.

## Part 1: Get a key pair on the VM

### Step 1: Look for an existing key pair

1. In the terminal on your VM, type `ls ~/.ssh` and press **Enter** or **Return**.
2. Look for a pair of files with the same name, one of them ending in `.pub`: for example `id_ed25519` and `id_ed25519.pub`.
3. If you see such a pair, go to Step 3 and use that pair.
4. If you see only `authorized_keys` (or the folder does not exist at all), there is no key pair yet: continue with Step 2.

BEWARE: leave `authorized_keys` alone. It is the list of keys allowed to log in to the VM, including the one on your laptop. Editing or deleting it can lock you out of your own VM.

### Step 2: Create a key pair

1. Type the following, with your own GitHub email address, and press **Enter** or **Return**:

   ```
   ssh-keygen -t ed25519 -C "you@example.com"
   ```

2. When asked `Enter file in which to save the key`, press **Enter** or **Return** to accept the suggested location.
3. If instead you are asked `Overwrite (y/n)?`, type `n` and press **Enter** or **Return**: you already have a key there, so go back to Step 1 and use it.
4. When asked `Enter passphrase`, press **Enter** or **Return** for no passphrase, then press it again to confirm. (A passphrase would protect the key if someone else got into your VM account, at the cost of typing it every time you push; for a course VM, no passphrase is the usual choice.)
5. The terminal prints a "fingerprint" and a small box of symbols called "randomart". You can ignore both.
6. Type `ls ~/.ssh` and press **Enter** or **Return**. You should now see `id_ed25519` and `id_ed25519.pub`.

`ed25519` is the type of key: a modern one that GitHub recommends. Making a new key pair on the VM does not change how you log in to the VM; that uses the key on your laptop and the `authorized_keys` file, which `ssh-keygen` does not touch.

### Step 3: Display the public key

1. Type `cat ~/.ssh/id_ed25519.pub` and press **Enter** or **Return**. (If your existing pair from Step 1 has a different name, use that name, ending in `.pub`.)
2. One long line appears, starting with `ssh-ed25519` and ending with your email address. It may wrap across several lines on screen, but it is one line.
3. Select the whole line with the mouse, from `ssh-ed25519` to the end of your email address.
4. Right-click the selection and choose **Copy**.

BEWARE: copy only the `.pub` file, the public half, which is safe to share. Never display, copy or paste the file without `.pub`; that is the private key, and anyone who has it can push to GitHub as you.

## Part 2: Give the public key to GitHub

### Step 4: Open your SSH key settings

1. In a web browser on your laptop, sign in to [GitHub](https://github.com).
2. Click your profile picture in the top-right corner.
3. Click **Settings**.
4. In the left-hand sidebar, click **SSH and GPG keys**.
5. Click **New SSH key**.

### Step 5: Add the key

1. In **Title**, type a label that says where the key lives, such as `Google Cloud VM`. It is only a label, to help you recognise the key later.
2. Leave **Key type** as **Authentication Key**.
3. Click in the **Key** box and paste the line you copied (**Ctrl+V** on Windows, **Cmd+V** on macOS).
4. Click **Add SSH key**.
5. If GitHub asks you to confirm your password or a two-factor code, do so.
6. You should see the key listed with the title you gave it.

## Part 3: Confirm it works

### Step 6: Test the connection

1. Back in the terminal on your VM, type `ssh -T git@github.com` and press **Enter** or **Return**.
2. The first time, you are asked whether to trust GitHub's "host key", ending with `Are you sure you want to continue connecting (yes/no/[fingerprint])?`. Type `yes` (the whole word) and press **Enter** or **Return**. This is SSH's way of introducing your VM to GitHub; it does not ask again.
3. You should see `Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.`

That last part sounds like a failure but is not: it means GitHub recognised you, and is only pointing out that it does not let anyone log in to it as if it were a computer. Your VM can now push to any repository you are allowed to change.

## If something goes wrong

**"Permission denied (publickey)" in Step 6.** GitHub did not recognise the key. Check that you pasted the whole `.pub` line, from `ssh-ed25519` to the end, with nothing missing at either end, and that you pasted the `.pub` file rather than the private one. If you have more than one pair in `~/.ssh`, check that the one you added is called `id_ed25519.pub` (or `id_rsa.pub`), because those are the names SSH tries by default.

**GitHub says "Key is invalid".** You probably copied only part of the line, or copied the private key. Repeat Step 3 and copy the whole `.pub` line.

**GitHub says "Key is already in use".** That key is already on a GitHub account, possibly yours. If Step 6 works, there is nothing to do.

**Right-click does not offer Copy in the terminal.** Select the text and press **Ctrl+C** (Windows) or **Cmd+C** (macOS). In a terminal, **Ctrl+C** copies only while text is selected; with nothing selected it stops the running command instead, which is harmless here.

**`ssh -T` hangs and then says "Connection timed out".** Your VM cannot reach GitHub on the usual SSH port. Ask your instructor; the VM's network settings may need changing.

## What to do next

Copy your team's project onto the VM: [09 Clone your team repository](09-clone-your-team-repository.md).

## Sources

- [Generating a new SSH key (GitHub documentation)](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Adding a new SSH key to your GitHub account (GitHub documentation)](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- [Testing your SSH connection (GitHub documentation)](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
