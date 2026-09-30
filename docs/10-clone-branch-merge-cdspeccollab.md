# Cloning, Branching and Merging CDSpecCollab

This guide walks through the everyday git workflow for the drsimonread/CDSpecCollab repository: copying it onto your GCP VM, creating your own branch to make a change, sending that change back to GitHub, and merging it into the shared `development` branch without losing anyone's work. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Python, Django and Copilot extensions](09-python-django-and-copilot-extensions.md) | Next: [Merge conflict practice](11-merge-conflict-practice.md)

## Before you start

You need:

1. Your invitation to CDSpecCollab accepted, as covered in [Creating a GitHub account, Step 6](01-create-github-account.md#step-6-join-the-cdspeccollab-repository).
2. Git installed and configured on your VM, and able to reach GitHub using the SSH key it borrows from your own computer, as covered in [Installing and configuring git on your GCP VM](08-install-git-on-gcp-vm.md).
3. VS Code [connected to your VM](07-connect-vscode-to-gcp-vm.md), with `SSH:` and your VM's external IP (such as `SSH: 34.86.123.45`) showing in the bottom-left corner. You edit files in VS Code's editor and type git commands in its terminal (**Terminal > New Terminal**).

CDSpecCollab is a public repository, so anyone can view or clone it. Pushing changes back needs two things: your SSH key on your GitHub account, lent to the VM by your own computer (which proves who you are) and collaborator access (which says you are allowed in).

A note on branches before we start. A branch is a parallel copy of the project where you can make changes without disturbing anyone else, rather like an architect sketching on tracing paper laid over the master drawing. `development` is the shared master drawing; your own branch is your tracing paper.

## Step 1: Clone the repository

1. In VS Code's terminal, make sure you are in your home folder, then clone the repository:

   ```
   cd ~
   git clone git@github.com:drsimonread/CDSpecCollab.git
   ```

   This creates a new folder called `CDSpecCollab` in your home folder, containing the full project and its history.

   Type the address exactly as shown. It has two halves either side of the colon: `git@github.com` is GitHub's shared account, which everyone uses (your key tells GitHub who you are); `drsimonread/CDSpecCollab.git` is the repository, named after the GitHub account that owns it, here your instructor's. Your own username appears in neither half, because you are joining someone else's repository rather than cloning your own.

2. Click **File > Open Folder**.
3. Select `/home/sread/CDSpecCollab` (with your own username) and click **OK**.
4. If asked whether you trust the authors of the files in this folder, click **Yes, I trust the authors**.

The VS Code window reloads with the project's files in the Explorer sidebar on the left.

5. Open a new terminal (**Terminal > New Terminal**). It starts inside the `CDSpecCollab` folder, which is where every command in the rest of this guide is run.

## Step 2: Check out the development branch

1. See what branches exist:

   ```
   git branch -a
   ```

   You should see something like `remotes/origin/development` in the list. The `remotes/origin/` prefix means it exists on GitHub but you do not have a local copy of it yet.

2. Check it out:

   ```
   git checkout development
   ```

Because a branch of that name does not exist locally yet but does exist on GitHub, git automatically creates a local `development` branch that "tracks" `origin/development`. You see a message confirming this, something like `Branch 'development' set up to track remote branch 'development' from 'origin'.`

## Step 3: Create your own branch from development

With `development` checked out, branch off it:

```
git checkout -b 101-sread
```

This creates a new branch named `101-sread` starting from `development`'s current state, and switches you onto it. (Substitute your own branch name, as agreed with your instructor.) Everything you do from here stays isolated on this branch until you merge it; `development` is untouched in the meantime.

## Step 4: Edit a file

For this example, we edit `README.md` at the root of the project; substitute whichever file your task actually asks you to change.

1. Click `README.md` in the Explorer sidebar on the left. It opens in the editor.
2. Make your change.
3. Save with `Ctrl+S` (Windows) or `Cmd+S` (macOS).

Until you save, the file's tab shows a filled circle instead of a cross; git only sees what has been saved.

## Step 5: Check what changed

```
git status
```

You should see your file listed under `Changes not staged for commit`, in red. This confirms git has noticed the edit but has not recorded it yet.

## Step 6: Stage and commit your change

```
git add README.md
git commit -m "Describe your change here"
```

`git add` "stages" the file, marking it as ready to include in the next commit. `git commit` records that staged snapshot permanently in your branch's history, with a short message explaining what changed. Replace the example message with a real description; it is what your instructor and teammates will see in the project's history.

## Step 7: Push your branch to GitHub

```
git push -u origin 101-sread
```

`101-sread` does not exist on GitHub yet, so this creates it there and uploads your commit. The `-u` flag sets up tracking between your local branch and this new remote branch, so later pushes and pulls on this branch need no extra arguments.

## Step 8: Confirm your change on GitHub

1. In a browser, go to the [CDSpecCollab repository on GitHub](https://github.com/drsimonread/CDSpecCollab).
2. Click the branch dropdown (it shows `main` or `development` by default).
3. Select `101-sread`.
4. Open your edited file and confirm your change is there.

## Merging your branch into development

Merging is safest done in two stages. First bring `development`'s latest changes into your own branch and resolve any conflicts there, where a mistake only affects your work. Only once that is clean do you merge your finished branch back into `development`; by that point there is nothing left to conflict with.

## Step 9: Update your branch with the latest from development

1. Get the newest version of `development` from GitHub:

   ```
   git checkout development
   git pull
   ```

2. Switch back to your branch and merge `development` into it:

   ```
   git checkout 101-sread
   git merge development
   ```

**If git reports no conflicts** (a message like `Merge made by the 'ort' strategy` or `Already up to date`), push the result and move on to Step 10:

```
git push
```

**If git reports conflicts** (a message like `CONFLICT (content): Merge conflict in README.md`), git has paused the merge and needs your help deciding what the final content should be:

1. Run `git status` to see which files are listed under `Unmerged paths`; you resolve each one in turn.
2. Click the first conflicted file in the Explorer sidebar (it has a **!** or **C** beside it). Inside, git has marked the conflicting sections directly in the text:

   ```
   <<<<<<< HEAD
   your branch's version of these lines
   =======
   development's version of these lines
   >>>>>>> development
   ```

   VS Code colours the two versions differently: the "current change" (`HEAD`, your branch) and the "incoming change" (`development`). Above them is a row of clickable links: **Accept Current Change**, **Accept Incoming Change**, **Accept Both Changes** and **Compare Changes**.

3. Decide what the final content should be:
   - to keep only your version, click **Accept Current Change**;
   - to keep only `development`'s version, click **Accept Incoming Change**;
   - to combine them, click **Accept Both Changes**, then edit the result into the content you want.

   The links remove the `<<<<<<<`, `=======` and `>>>>>>>` marker lines for you. If you edit by hand instead, delete every marker line yourself.

4. Check that no marker lines remain anywhere in the file (`Ctrl+F` on Windows or `Cmd+F` on macOS, then search for `<<<<<<<`).
5. Save the file.
6. Repeat for every file `git status` listed as unmerged.
7. Stage each resolved file and commit:

   ```
   git add README.md
   git commit -m "Merge development into 101-sread, resolving conflicts"
   ```

   Supplying `-m` here means git records the merge immediately, without opening a text editor of its own.

8. Push your now-merged branch:

   ```
   git push
   ```

Saving the file is not enough on its own: `git add` is what tells git a conflict is resolved. To see a conflict happen and resolve it step by step, work through the [merge conflict practice](11-merge-conflict-practice.md).

## Step 10: Merge your branch back into development

```
git checkout development
git merge 101-sread
git push
```

Because you already reconciled every conflicting change while working on `101-sread` in Step 9, git can apply your branch to `development` cleanly. You should see a message like `Fast-forward` or `Merge made by the 'ort' strategy` with no mention of conflicts.

## Keeping your local repository and branch up to date

Do this periodically (for instance, at the start of each work session) so you are always building on the latest shared code.

## Step 11: Update your local development branch from GitHub

```
git checkout development
git pull
```

This downloads any commits made to `development` since you last checked, by yourself or anyone else, and applies them to your local copy.

## Step 12: Update your own branch from development

```
git checkout 101-sread
git merge development
```

This is the same command as Step 9; run it any time `development` has moved on since you last synced, so your branch never drifts too far out of date. If it reports conflicts, resolve them exactly as described in Step 9, then push:

```
git push
```

## If something goes wrong

**"ERROR: Permission to drsimonread/CDSpecCollab.git denied to sread"** when pushing: GitHub knows who you are but you are not a collaborator yet. Accept your invitation ([Creating a GitHub account, Step 6](01-create-github-account.md#step-6-join-the-cdspeccollab-repository)), or ask your instructor to send one, then run the push again.

**"fatal: destination path 'CDSpecCollab' already exists and is not an empty directory"**: you have already cloned it once. Skip the clone and carry on from Step 1, action 2, opening the existing `/home/sread/CDSpecCollab` folder.

**"error: pathspec 'development' did not match any file(s) known to git"**: run `git fetch` to update your list of remote branches, then try `git checkout development` again. If it still does not appear, confirm with your instructor that the branch exists and that you spelled it correctly.

**"error: Your local changes to the following files would be overwritten by checkout"**: you have uncommitted edits that conflict with the branch you are switching to. Go back to Step 6 and commit them first, then retry the checkout.

**"Please tell me who you are" when committing**: git does not have your name and email configured yet. Go back to Step 6 of [Installing and configuring git on your GCP VM](08-install-git-on-gcp-vm.md#step-6-set-your-name-and-email).

**Stuck in an unfamiliar full-screen editor in the terminal**: this can happen when a command opens an editor without `-m`, such as a bare `git commit`; the editor that opens is usually `vim`. Press `Esc`, type `:q!` and press Enter to quit without saving, then rerun the command with `-m "your message"` added. To have git open a VS Code tab instead in future, run `git config --global core.editor "code --wait"`; git then waits until you close that tab.

**A file still shows as unmerged after you have edited it**: you edited the file but have not staged it yet. Run `git add <filename>`, then continue with the commit as described in Step 9.

## What to do next

To see a merge conflict happen (and fix it) somewhere a mistake costs nothing, work through the [merge conflict practice](11-merge-conflict-practice.md).

## Sources

- [git-clone documentation](https://git-scm.com/docs/git-clone) (git documentation)
- [git-checkout documentation](https://git-scm.com/docs/git-checkout) (git documentation)
- [git-push documentation](https://git-scm.com/docs/git-push) (git documentation)
- [Resolving a merge conflict using the command line](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requests/resolving-a-merge-conflict-using-the-command-line) (GitHub documentation)
