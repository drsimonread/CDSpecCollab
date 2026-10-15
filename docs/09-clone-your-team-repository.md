# Cloning Your Team Repository and Making Your Branch

A "repository" (repo, for short) is a project folder that git keeps track of, together with its whole history. Your team's repository lives on GitHub; in this guide we "clone" it (copy it, history and all) onto your VM, switch to the team's shared `development` branch, and make a branch of your own to work on. No prior technical experience is needed.

There are two team repositories, and this guide covers both. Where the steps differ, both versions are shown: follow the one for your team and ignore the other.

| Your team's repository | Folder it makes on your VM |
|---|---|
| CDSpecCollab | `CDSpecCollab` |
| ChesapeakeCommunityConnect | `ChesapeakeCommunityConnect` |

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- Git installed, configured and connected to GitHub on your VM: [07 Install git on your VM](07-install-git-on-your-vm.md) and [08 Connect git to GitHub](08-connect-git-to-github.md).
- To have accepted the invitation to collaborate on your team's repository. GitHub emails it to you, and it also appears at the top of your [GitHub notifications](https://github.com/notifications). Without it, you can copy the repository but not send changes back. If you have not had an invitation, ask your instructor.
- An issue to work on: a task on your repository's **Issues** tab that you have been given or have taken. Your branch is named after it (Step 5).

## A word about branches

A "branch" is a separate line of work within one repository. Think of the repository as a shared document and each branch as your own photocopy: you can scribble on your copy as much as you like, and nobody else sees it until you deliberately fold your changes back in.

Your team's repository has two long-lived branches. `main` holds the finished, working project; `development` is where the team's work comes together. You never work on either directly. Instead, for each issue you work on, you make your own branch from `development`, work on it, and merge it back into `development` when it is ready (guide 12).

## Step 1: Open a terminal in your home folder

1. Open VS Code and connect to your VM (Command Palette, **Remote-SSH: Connect to Host...**).
2. If a folder is open, close it: open the **File** menu and choose **Close Folder**.
3. Open the terminal with **Ctrl+`**.
4. Type `cd ~` and press **Enter** or **Return**. This moves the terminal to your home folder (`~` is short for it), which is where the repository will go.

## Step 2: Clone the repository

1. Type the command for your team and press **Enter** or **Return**.

   For **CDSpecCollab**:

   ```
   git clone git@github.com:drsimonread/CDSpecCollab.git
   ```

   For **ChesapeakeCommunityConnect**:

   ```
   git clone git@github.com:drsimonread/ChesapeakeCommunityConnect.git
   ```

2. Wait for the prompt to come back. Git prints a few lines counting and receiving "objects", the pieces of the project's history.
3. Type `ls` and press **Enter** or **Return**. You should see a new folder named after your repository.

The address begins `git@github.com:` rather than `https://` because it uses the SSH key you set up in guide 08. That is what will let you push changes back later without typing a password.

## Step 3: Open the repository in VS Code

1. Open the **File** menu and choose **Open Folder...**
2. Change the path in the box at the top of the window to your home folder followed by your repository's folder, for example `/home/jdoe/CDSpecCollab/` or `/home/jdoe/ChesapeakeCommunityConnect/` (with your username), and click **OK**.
3. If VS Code asks whether you trust the authors of the files in this folder, click **Yes, I trust the authors**.
4. Open the terminal again (**Ctrl+`**). Because the repository is now the open folder, the terminal starts inside it: the prompt ends with the repository's name.

Every command in this guide and the next three is typed in this terminal, inside the repository folder.

## Step 4: Switch to the development branch

1. Type `git branch -a` and press **Enter** or **Return**.
2. You should see `* main` and, among others, `remotes/origin/development`. The `*` marks the branch you are on. The `remotes/origin/` prefix means the branch exists on GitHub ("origin" is git's name for the place you cloned from) but you do not have your own copy of it yet. If the list is long, press **q** to get the prompt back.
3. Type `git checkout development` and press **Enter** or **Return**.
4. You should see `branch 'development' set up to track 'origin/development'` (or similar wording), followed by `Switched to a new branch 'development'`.

Git noticed that you had no local `development` branch but GitHub did, so it made one for you and linked it to GitHub's. "Tracking" means that later `git pull` and `git push` commands on this branch know where to go without being told.

## Step 5: Make your branch for an issue

Branches are named `issue_number-username`: the number of the GitHub issue you are working on, a dash, and your GitHub username. If `sread` is working on issue #101, the branch is `101-sread`. Anyone looking at the list of branches can then tell what each one is for and whose it is.

1. In a web browser, open your team's repository on GitHub ([CDSpecCollab](https://github.com/drsimonread/CDSpecCollab) or [ChesapeakeCommunityConnect](https://github.com/drsimonread/ChesapeakeCommunityConnect)) and click the **Issues** tab.
2. Find the issue you are working on and note its number, shown after the `#` beside its title.
3. Back in the VS Code terminal, check with `git status` that you are on `development` (Step 4).
4. Type `git checkout -b` followed by a space and your branch name, and press **Enter** or **Return**. For issue #101 and the username `sread`:

   ```
   git checkout -b 101-sread
   ```

5. You should see `Switched to a new branch '101-sread'` (with your branch name).

Use digits and lowercase letters only, with a single dash between number and username: `101-sread`, not `#101-sread`, `101_sread` or `Issue101-SRead`. Git treats branch names as exact text, so a stray capital makes a different branch.

`-b` means "make a new branch". Your branch starts as an exact copy of `development` as it is right now, and from here on, everything you commit goes onto your branch; `development` is untouched until you merge into it.

## Step 6: Confirm where you are

1. Type `git status` and press **Enter** or **Return**.
2. The first line should read `On branch 101-sread` (with your branch name), and a later line `nothing to commit, working tree clean`.

Get into the habit of typing `git status` whenever you are not sure what state things are in. It never changes anything; it only tells you where you are.

## Step 7: See which branch you are on in VS Code

1. Look at the bar along the bottom of the VS Code window, near the **SSH:** box.
2. You should see a small branch symbol followed by your branch name. VS Code reads this from git, so it always shows the branch you are on.

## If something goes wrong

**"fatal: destination path 'CDSpecCollab' already exists and is not an empty directory"** (or the same for `ChesapeakeCommunityConnect`). You have already cloned it. Open that folder (Step 3) instead of cloning again.

**"Permission denied (publickey)" or "Could not read from remote repository".** Git on your VM cannot prove who you are to GitHub. Run `ssh -T git@github.com` and, if it fails, work through [08 Connect git to GitHub](08-connect-git-to-github.md) again.

**"Repository not found".** Check the spelling of the address, including capital letters. If it is right and the repository is private, you have not yet accepted the invitation to collaborate; look in your email or GitHub notifications.

**"error: pathspec 'development' did not match any file(s) known to git".** Type `git fetch` and press **Enter** or **Return** to refresh your list of GitHub's branches, then try Step 4 again. If it still fails, check the spelling, and ask your instructor whether the branch exists.

**"fatal: a branch named '101-sread' already exists".** You made it earlier. Type `git checkout 101-sread` (without `-b`) to switch to it.

**I made my branch from `main` by mistake.** Check with `git status` that you have not committed anything, then type `git checkout development`, `git branch -D 101-sread` and `git checkout -b 101-sread`, pressing **Enter** or **Return** after each. (`-D` deletes the wrongly made branch; do this only before you have committed work to it.)

## What to do next

Make a change and send it to GitHub: [10 Commit and push your changes](10-commit-and-push-your-changes.md).

## Sources

- [git-clone reference (git documentation)](https://git-scm.com/docs/git-clone)
- [git-checkout reference (git documentation)](https://git-scm.com/docs/git-checkout)
- [Inviting collaborators to a personal repository (GitHub documentation)](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-access-to-your-personal-repositories/inviting-collaborators-to-a-personal-repository)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
