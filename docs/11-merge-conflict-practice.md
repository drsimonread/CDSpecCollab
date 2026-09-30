# Practice: Working Through a Real Merge Conflict

This is a hands-on worked example that puts the [clone, branch and merge workflow](10-clone-branch-merge-cdspeccollab.md) into practice. You create a brand-new GitHub repository with the same `main`/`development` branch structure as CDSpecCollab, write a small Python script, then deliberately create two branches that edit the exact same line of that script differently, so you can watch git detect a real conflict, resolve it yourself and merge cleanly afterwards. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Cloning, branching and merging CDSpecCollab](10-clone-branch-merge-cdspeccollab.md) | Next: [Training resources](training-resources.md)

## Before you start

You need:

1. Git installed, configured and connected to GitHub over SSH on your VM, as covered in [Installing and configuring git on your GCP VM](08-install-git-on-gcp-vm.md).
2. VS Code [connected to your VM](07-connect-vscode-to-gcp-vm.md), with `SSH:` and your VM's external IP in the bottom-left corner. You edit files in VS Code's editor and type git commands in its terminal (**Terminal > New Terminal**).

The repository you create here is only for practice; feel free to delete it from GitHub once you are done.

## Step 1: Create a new repository on GitHub

1. In a browser, sign in to GitHub.
2. Click the **+** icon in the top right and select **New repository**.
3. Name it `git-merge-practice`.
4. Choose Public or Private (either works for this exercise).
5. Check **Add a README file**, and leave the `.gitignore` and licence options at their defaults.
6. Click **Create repository**.

## Step 2: Create a development branch

1. On the new repository's page, click the branch selector that currently shows **main**.
2. Type `development` into the **Find or create a branch...** box.
3. Click **Create branch: development from 'main'**.

Your practice repository now has the same `main` plus `development` structure as CDSpecCollab.

## Step 3: Clone the repository to your VM

1. In VS Code's terminal, make sure you are in your home folder, then clone the repository:

   ```
   cd ~
   git clone git@github.com:sread/git-merge-practice.git
   ```

   Replace `sread` (after the colon) with your own GitHub username, because this time the repository belongs to you. Leave `git@github.com` before the colon exactly as it is; as explained in [Cloning, branching and merging CDSpecCollab, Step 1](10-clone-branch-merge-cdspeccollab.md#step-1-clone-the-repository), that part is GitHub's shared account and is the same for everyone.

2. Click **File > Open Folder**.
3. Select `/home/sread/git-merge-practice` (with your own username) and click **OK**.
4. If asked whether you trust the authors of the files in this folder, click **Yes, I trust the authors**; they are your own files.

The VS Code window reloads with `git-merge-practice` in the Explorer sidebar on the left.

5. Open a new terminal (**Terminal > New Terminal**). It starts inside the `git-merge-practice` folder, which is where every command in the rest of this guide is run.

## Step 4: Check out the development branch

```
git branch -a
git checkout development
```

## Step 5: Add a starter script

1. Confirm Python 3 is available (Ubuntu VMs normally already have it):

   ```
   python3 --version
   ```

   If that prints a version number, you are set; if it says the command is not found, install it with `sudo apt install python3`.

2. Create the example script and open it in the editor:

   ```
   code hello.py
   ```

   Typed in a connected terminal, `code` opens the file in the editor above, creating it if it does not exist yet.

3. Type the following, then save with `Ctrl+S` (Windows) or `Cmd+S` (macOS):

   ```
   def greet():
       print("Status: not started")

   greet()
   ```

4. Commit and push it to `development`:

   ```
   git add hello.py
   git commit -m "Add starter script"
   git push -u origin development
   ```

Take note of that one line, `print("Status: not started")`. It is the line both practice branches are about to change differently, which is what creates the conflict later.

## Step 6: Create two branches from the same starting point

```
git checkout -b feature-a
git checkout development
git checkout -b feature-b
```

Both `feature-a` and `feature-b` now point at the exact same commit as `development`. The copy of `hello.py` on each is identical to what you just pushed, and neither branch knows anything about changes made on the other.

## Step 7: Change the code on feature-a

1. Switch branch:

   ```
   git checkout feature-a
   ```

2. Click the `hello.py` tab in the editor (or click `hello.py` in the Explorer sidebar). VS Code always shows the version of the file on the branch you have checked out, so switching branches changes what the editor shows.
3. Change the print line to:

   ```
   print("Status: in progress")
   ```

4. Save (`Ctrl+S` or `Cmd+S`), then commit and push:

   ```
   git add hello.py
   git commit -m "Update status to in progress"
   git push -u origin feature-a
   ```

## Step 8: Merge feature-a into development

```
git checkout development
git merge feature-a
git push
```

Since `development` has not changed since `feature-a` branched off it, this merges cleanly; `development`'s copy of `hello.py` now reads "Status: in progress".

## Step 9: Change the same line on feature-b

1. Switch branch:

   ```
   git checkout feature-b
   ```

2. Click the `hello.py` tab. The editor now shows the original line again, because `feature-b` branched off `development` before `feature-a`'s change existed.
3. Change it to something different:

   ```
   print("Status: blocked")
   ```

4. Save (`Ctrl+S` or `Cmd+S`), then commit and push:

   ```
   git add hello.py
   git commit -m "Update status to blocked"
   git push -u origin feature-b
   ```

## Step 10: Bring development's changes into feature-b

```
git checkout development
git pull
git checkout feature-b
git merge development
```

This time git stops with something like `CONFLICT (content): Merge conflict in hello.py`. Both branches changed the exact same line differently since they split from the same starting point, and git has no way to guess which version you want. This is a genuine merge conflict, not a mistake.

## Step 11: Resolve the conflict

1. Run `git status` and confirm `hello.py` is listed under `Unmerged paths`.
2. Click the `hello.py` tab (or click it in the Explorer sidebar, where it now has a **!** or **C** beside it to flag the conflict).

   Inside, git has marked the conflict directly in the code:

   ```
   def greet():
   <<<<<<< HEAD
       print("Status: blocked")
   =======
       print("Status: in progress")
   >>>>>>> development

   greet()
   ```

   VS Code colours the two versions differently: the "current change" (`HEAD`, your branch, `feature-b`) in one colour and the "incoming change" (`development`) in another. Above them is a row of small clickable links: **Accept Current Change**, **Accept Incoming Change**, **Accept Both Changes** and **Compare Changes**. (A **Resolve in Merge Editor** button may also appear at the bottom right; you can ignore it for this exercise.)

3. Click **Accept Both Changes**. VS Code removes the marker lines and keeps both `print` lines, one after the other.
4. Edit the two lines down to the single line you actually want; for this example, combine them:

   ```
   def greet():
       print("Status: in progress, but blocked on review")

   greet()
   ```

   If you only wanted one version, **Accept Current Change** or **Accept Incoming Change** would keep that one and discard the other, with no editing needed. Combining is the case where you still have to type.

5. Check that no `<<<<<<<`, `=======` or `>>>>>>>` lines remain anywhere in the file.
6. Save (`Ctrl+S` or `Cmd+S`).
7. In the terminal, stage, commit and push:

   ```
   git add hello.py
   git commit -m "Merge development into feature-b, resolving conflict"
   git push
   ```

Supplying `-m` records the merge immediately without opening an extra editor. Saving the file is not enough on its own: `git add` is what tells git the conflict is resolved.

## Step 12: Merge feature-b into development

```
git checkout development
git merge feature-b
git push
```

Because the conflict was already resolved while working on `feature-b`, this merges cleanly. You should see a message like `Merge made by the 'ort' strategy` with no mention of conflicts.

## Step 13: Confirm the result

1. Look at the `hello.py` tab; it should show your resolved line.
2. In the terminal, run the script:

   ```
   python3 hello.py
   ```

It should print your resolved line. You can also open `git-merge-practice` on GitHub, switch to the `development` branch and confirm `hello.py` there matches.

## If something goes wrong

**No conflict appeared in Step 10**: this usually means `feature-b` was created after `feature-a`'s change had already been merged into `development`, so `feature-b` started from the updated line instead of the original one. Delete both feature branches (`git branch -D feature-a feature-b`) and redo Steps 6 to 10, making sure both branches are created back to back, before either one is edited or merged.

**Leftover `<<<<<<<`, `=======` or `>>>>>>>` lines after committing**: open the file again and press `Ctrl+F` (Windows) or `Cmd+F` (macOS) to search for `<<<<<<<`, `=======` and `>>>>>>>` in turn. The clickable **Accept** links remove markers for you, but hand edits do not. Delete any you find, save, then `git add hello.py` and commit again.

**No Accept Current Change / Accept Incoming Change links appear**: the file was already open with unsaved edits, or VS Code has not noticed the conflict yet. Close the tab (saving nothing), then reopen `hello.py` from the Explorer sidebar.

**The editor still shows the old line after `git checkout`**: the tab had unsaved changes, so VS Code kept your version rather than the branch's. Close the tab without saving and reopen the file. Always save before switching branches; git refuses to switch if saved-but-uncommitted changes would be overwritten, and warns you (see the [previous guide's troubleshooting](10-clone-branch-merge-cdspeccollab.md#if-something-goes-wrong)).

**`python3: command not found`**: run `sudo apt install python3` to install it, then retry Step 5.

**Stuck in an unfamiliar full-screen editor in the terminal**: this can happen if a command opens an editor without `-m`, such as a bare `git commit`; the editor is usually `vim`. Press `Esc`, type `:q!` and press Enter to quit without saving, then rerun the command with `-m "your message"` added. To have git open a VS Code tab instead in future, run `git config --global core.editor "code --wait"`; git then waits until you close that tab.

## What to do next

Having walked through a real conflict end to end on a disposable practice repository, you are ready to recognise the same situation on CDSpecCollab's actual branches. Most merges there will not conflict, but when one does, you will know what git is showing you and how to work through it. Return to the [index](index.md), or brush up on the languages with the [training resources](training-resources.md).

## Sources

- [Quickstart for repositories](https://docs.github.com/en/repositories/creating-and-managing-repositories/quickstart-for-repositories) (GitHub documentation)
- [Managing branches within your repository](https://docs.github.com/en/pull-requests/how-tos/commit-changes/managing-branches-within-your-repository) (GitHub documentation)
- [Resolving a merge conflict using the command line](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requests/resolving-a-merge-conflict-using-the-command-line) (GitHub documentation)
