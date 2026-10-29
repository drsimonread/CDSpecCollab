# Committing and Pushing Your Changes

Saving a file and recording it in git are two different things. Saving puts your edit on the VM's disk; a "commit" records a snapshot of your changes in the project's history, with a message saying what you did and why; a "push" sends your commits to GitHub, where the rest of the team (and a backup) can see them. This guide takes one small change through all three. No prior technical experience is needed.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need your team's repository cloned on your VM, with your own branch made and checked out: [09 Clone your team repository](09-clone-your-team-repository.md).

## Step 1: Open your repository and check your branch

1. Open VS Code, connect to your VM, and open your repository's folder (**File**, **Open Recent**, then `~/CDSpecCollab` or `~/ChesapeakeCommunityConnect`).
2. Open the terminal with **Ctrl+`**.
3. Type `git status` and press **Enter** or **Return**.
4. Check that the first line says `On branch 101-sread` (with your branch name). If it names another branch, type `git checkout 101-sread` and press **Enter** or **Return**.

BEWARE: check the branch every time, before you edit anything. Commits go onto whichever branch you are on, and work committed to `development` or `main` by mistake is much more awkward to move than work that was never there.

## Step 2: Edit a file

For practice, we edit `README.md`, the file at the top of the repository that describes the project. When you do real work, edit whichever files your task needs.

1. In the Explorer, click `README.md` to open it.
2. Add a line at the end, such as `Notes added by Your Name.`
3. Save the file (**Ctrl+S** or **Cmd+S**). Check that the filled circle on the file's tab has changed back to an **x**.

Notice that VS Code now marks `README.md` in the Explorer with an **M** (for "modified"). That comes from git: VS Code reads its status, even though we type the commands ourselves.

## Step 3: See what changed

1. Type `git status` and press **Enter** or **Return**.
2. You should see `README.md` listed under `Changes not staged for commit`, in red.
3. Type `git diff` and press **Enter** or **Return**.
4. You should see your new line, marked with a `+` at the start (lines you removed would be marked `-`). If the display fills the screen and shows a `:` at the bottom, press **q** to get the prompt back.

`git status` tells you which files changed; `git diff` shows you exactly how. Reading the diff before every commit is the cheapest way to catch a change you did not mean to make.

## Step 4: Stage the change

1. Type `git add README.md` and press **Enter** or **Return**. It prints nothing if it succeeds.
2. Type `git status` again. `README.md` should now be listed under `Changes to be committed`, in green.

"Staging" picks which changes go into the next commit. That seems like an extra step when you have changed only one file, but it lets you change three files and commit them as two separate, sensible snapshots instead of one muddle. To stage every changed file at once, you can type `git add .` (the full stop means "everything in this folder"), but check `git status` first so you know what "everything" is.

## Step 5: Commit

1. Type the following, with a message describing your change, and press **Enter** or **Return**:

   ```
   git commit -m "Add a note to the README"
   ```

2. You should see a line naming your branch and a short code, followed by `1 file changed, 1 insertion(+)`.
3. Type `git status` again. It should say `nothing to commit, working tree clean`.

The message after `-m` is what your team and your instructor see in the project's history, so make it say what the change does: "Fix map not loading on Safari", not "stuff" or "changes". Starting it with the issue number, as in `"#101 Fix map not loading on Safari"`, makes GitHub list the commit on that issue's page, so anyone reading the issue can see the work done on it. The `-m` also stops git opening a text editor to ask you for the message.

## Step 6: Push your branch to GitHub

The first time you push a new branch, you have to tell git where to send it.

1. Type the following, with your own branch name, and press **Enter** or **Return**:

   ```
   git push -u origin 101-sread
   ```

2. You should see some lines about writing objects, ending with something like `branch '101-sread' set up to track 'origin/101-sread'`.

`origin` is GitHub (the place you cloned from), and `-u` links your local branch to the new one on GitHub. From now on, on this branch, `git push` on its own is enough.

## Step 7: Confirm your change on GitHub

1. In a web browser, open your team's repository: [CDSpecCollab](https://github.com/drsimonread/CDSpecCollab) or [ChesapeakeCommunityConnect](https://github.com/drsimonread/ChesapeakeCommunityConnect).
2. Click the branch menu near the top-left of the file list (it shows **main** or **development**).
3. Choose your branch.
4. Click `README.md` and check that your new line is there.

Notice that your change is on GitHub but only on your branch: `development` does not have it yet. Putting it there is guide 12's job.

## The routine from now on

Each time you make a piece of progress, repeat Steps 3 to 5, then type `git push` and press **Enter** or **Return**. Small, frequent commits with clear messages are easier to understand, easier to merge and easier to undo than one enormous commit at the end of the week, and each push is also a backup.

## If something goes wrong

**"Please tell me who you are" when committing.** Git does not know your name and email on this VM. Do Step 6 of [07 Install git on your VM](07-install-git-on-your-vm.md), then commit again.

**"nothing added to commit but untracked files present".** You made a new file but did not stage it. Type `git add` followed by the file's name, then commit again.

**"no changes added to commit".** You skipped Step 4. Stage the file, then commit.

**My change is not in the commit.** Check the file's tab for a filled circle: if the file was not saved, git saw the old version. Save it, then stage and commit again.

**"ERROR: Permission to drsimonread/... denied to your-username".** You have not accepted the invitation to collaborate on the repository. Accept it (check your email or GitHub notifications), then push again.

**"error: src refspec 101-sread does not match any".** The branch name in your push command does not match a branch you have. Type `git status` to see your branch's exact name, and push with that.

**"Updates were rejected because the remote contains work that you do not have".** Someone else has pushed to your branch, or you pushed from another machine. Type `git pull --no-edit` and press **Enter** or **Return**, then `git push`. If `git pull` reports a conflict, resolve it as in [11 Practise a merge conflict](11-practise-a-merge-conflict.md), Step 13.

**I committed to `development` or `main` by mistake and have not pushed.** Ask your instructor before doing anything else; the fix depends on exactly what happened, and it is easy to make worse.

**A full-screen editor opened instead of finishing the command.** A command wanted a message and you did not supply one with `-m`. If the bottom of the screen shows `^X Exit`, it is nano: press **Ctrl+X** to accept the suggested message (or exit). Otherwise it is probably vim: press **Esc**, type `:q!` and press **Enter** or **Return** to quit, then run the command again with `-m "your message"`.

## What to do next

Practise the one part of the routine that needs real care before you meet it for real: [11 Practise a merge conflict](11-practise-a-merge-conflict.md).

## Sources

- [Recording changes to the repository (Pro Git book)](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)
- [git-commit reference (git documentation)](https://git-scm.com/docs/git-commit)
- [git-push reference (git documentation)](https://git-scm.com/docs/git-push)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
