# Practising a Merge Conflict

Most merges are uneventful: git combines two branches' changes by itself. A "merge conflict" happens when two branches have changed the same lines in different ways since they split, and git cannot know which version you want, so it stops and asks you. This guide makes a conflict on purpose, in a throwaway repository of your own, so that the first one you resolve is one where a mistake costs nothing. No prior technical experience is needed.

We build a small repository with the same `main` and `development` branches as your team's, write a three-line Python script, change the same line differently on two branches, and then resolve the clash in the VS Code editor.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- Git installed, configured and connected to GitHub on your VM: [07 Install git on your VM](07-install-git-on-your-vm.md) and [08 Connect git to GitHub](08-connect-git-to-github.md).
- To be comfortable with branching, committing and pushing: [09 Clone your team repository](09-clone-your-team-repository.md) and [10 Commit and push your changes](10-commit-and-push-your-changes.md). This guide uses the same commands without explaining them again.

## Part 1: Set up a practice repository

### Step 1: Create a repository on GitHub

1. In a web browser, sign in to [GitHub](https://github.com).
2. Click the **+** icon in the top-right corner and choose **New repository**.
3. In **Repository name**, type `GitMergePractice`.
4. Choose **Public** or **Private**; either works.
5. Turn on **Add a README file** (it may be a tick box or a switch).
6. Leave the `.gitignore` and licence options as they are.
7. Click **Create repository**.

### Step 2: Create a development branch on GitHub

1. On the new repository's page, click the branch menu, which shows **main**.
2. Type `development` in the box at the top of the menu.
3. Click **Create branch: development from 'main'**.

Your practice repository now has the same `main` and `development` structure as your team's.

### Step 3: Clone it to your VM

1. In VS Code, connected to your VM, close any open folder (**File**, **Close Folder**) and open the terminal (**Ctrl+`**).
2. Type `cd ~` and press **Enter** or **Return**.
3. Type the following, with your own GitHub username in place of `your-username`, and press **Enter** or **Return**:

   ```
   git clone git@github.com:your-username/GitMergePractice.git
   ```

### Step 4: Open it in VS Code

1. Open the **File** menu, choose **Open Folder...**, change the path to your home folder followed by `GitMergePractice/` (for example `/home/jdoe/GitMergePractice/`), and click **OK**.
2. If VS Code asks whether you trust the authors, click **Yes, I trust the authors**.
3. Open the terminal (**Ctrl+`**). The prompt should end with `GitMergePractice`.

### Step 5: Switch to the development branch

1. Type `git checkout development` and press **Enter** or **Return**.
2. You should see `Switched to a new branch 'development'`.

### Step 6: Add a starter script

1. In the Explorer, click the **New File** icon beside `GITMERGEPRACTICE`, type `hello.py` and press **Enter** or **Return**.
2. Type:

   ```python
   def greet():
       print("Status: not started")

   greet()
   ```

3. Save the file.
4. In the terminal, type `python3 hello.py` and press **Enter** or **Return**. You should see `Status: not started`.

Notice the line `print("Status: not started")`. It is the line that the two branches are about to change in different ways.

### Step 7: Commit and push the script

1. Type `git add hello.py` and press **Enter** or **Return**.
2. Type `git commit -m "Add starter script"` and press **Enter** or **Return**.
3. Type `git push` and press **Enter** or **Return**.

## Part 2: Make two conflicting changes

### Step 8: Create two branches from the same starting point

1. Type `git checkout -b feature-a` and press **Enter** or **Return**.
2. Type `git checkout development` and press **Enter** or **Return**.
3. Type `git checkout -b feature-b` and press **Enter** or **Return**.

Both new branches now start from exactly the same commit as `development`, and neither knows anything about what will happen on the other. Do these three commands back to back, before editing anything; the conflict depends on it.

### Step 9: Change the line on feature-a

1. Type `git checkout feature-a` and press **Enter** or **Return**.
2. In `hello.py`, change the `print` line to:

   ```python
       print("Status: in progress")
   ```

3. Save the file.
4. Type `git add hello.py`, then `git commit -m "Update status to in progress"`, then `git push -u origin feature-a`, pressing **Enter** or **Return** after each.

Notice that VS Code shows each file as it is on the branch you have checked out. When you switch branches, git rewrites the files on disk and VS Code's editor follows. This is why you must save, and preferably commit, before switching: an unsaved edit in the editor belongs to no branch at all.

### Step 10: Merge feature-a into development

1. Type `git checkout development` and press **Enter** or **Return**.
2. Type `git merge --no-edit feature-a` and press **Enter** or **Return**.
3. You should see `Fast-forward` and `hello.py | 2 +-`. There is no conflict, because `development` had not changed since `feature-a` was made.
4. Type `git push` and press **Enter** or **Return**.

`--no-edit` tells git to accept its standard message if the merge needs a commit of its own, instead of opening an editor to ask you for one.

### Step 11: Change the same line on feature-b

1. Type `git checkout feature-b` and press **Enter** or **Return**.
2. Look at `hello.py` in the editor. It still says `Status: not started`, because `feature-b` was made before `feature-a`'s change existed.
3. Change the `print` line to something different:

   ```python
       print("Status: blocked")
   ```

4. Save the file.
5. Type `git add hello.py`, then `git commit -m "Update status to blocked"`, then `git push -u origin feature-b`, pressing **Enter** or **Return** after each.

## Part 3: Meet the conflict and resolve it

### Step 12: Bring development's changes into feature-b

This is exactly what you will do on your team's repository before merging your own branch (guide 12): first bring `development` into your branch, so that any conflict happens on your branch, where only your work is at stake.

1. Type `git checkout development` and press **Enter** or **Return**.
2. Type `git pull` and press **Enter** or **Return**. (Here nothing new arrives, but on the team repository this is how you get your teammates' latest work.)
3. Type `git checkout feature-b` and press **Enter** or **Return**.
4. Type `git merge --no-edit development` and press **Enter** or **Return**.
5. Git stops with `CONFLICT (content): Merge conflict in hello.py` and `Automatic merge failed; fix conflicts and then commit the result.`

This is not an error and nothing is broken. Git has done what it could, paused the merge half-way, and is waiting for you to decide what `hello.py` should say.

### Step 13: Resolve the conflict in VS Code

1. Type `git status` and press **Enter** or **Return**. `hello.py` is listed under `Unmerged paths`. When a real merge stops, this list is your to-do list: every file in it needs resolving.
2. Open `hello.py` in the editor (click it in the Explorer, or look at its tab if it is already open). VS Code highlights the conflict:

   ```
   def greet():
   <<<<<<< HEAD (Current Change)
       print("Status: blocked")
   =======
       print("Status: in progress")
   >>>>>>> development (Incoming Change)

   greet()
   ```

3. Read the two halves. The top half, marked **Current Change** and usually shaded green, is your branch's version (`HEAD` is git's name for the branch you are on, here `feature-b`). The bottom half, marked **Incoming Change** and usually shaded blue, is the version arriving from `development`. The `<<<<<<<`, `=======` and `>>>>>>>` lines are "conflict markers" that git wrote into the file to show you where the two versions begin and end.
4. Look at the small grey links just above the conflict: **Accept Current Change**, **Accept Incoming Change**, **Accept Both Changes** and **Compare Changes**. The first keeps only your version; the second keeps only `development`'s; the third keeps both, one after the other; the fourth shows them side by side without changing anything.
5. Click **Accept Both Changes**. The markers disappear and both `print` lines remain.
6. Edit the two lines into the one you actually want, for example:

   ```python
       print("Status: in progress, but blocked on review")
   ```

7. Check that no `<<<<<<<`, `=======` or `>>>>>>>` line remains anywhere in the file.
8. Save the file.

On a real project, the right resolution depends on what both changes were for, and is often neither "mine" nor "theirs" but a combination. If you cannot tell what the other change was for, ask the teammate who made it before choosing; that is far cheaper than discovering later that you deleted their work.

### Step 14: Finish the merge

1. Type `python3 hello.py` and press **Enter** or **Return**. You should see your combined line. (Always check that the code still runs before finishing a merge; a resolution can be tidy and still be wrong.)
2. Type `git add hello.py` and press **Enter** or **Return**. Staging the file is how you tell git that this conflict is resolved.
3. Type `git status` and press **Enter** or **Return**. It should say `All conflicts fixed but you are still merging`.
4. Type `git commit -m "Merge development into feature-b, resolving conflict"` and press **Enter** or **Return**.
5. Type `git push` and press **Enter** or **Return**.

### Step 15: Merge feature-b into development

1. Type `git checkout development` and press **Enter** or **Return**.
2. Type `git merge --no-edit feature-b` and press **Enter** or **Return**.
3. This time there is no conflict, because you already settled it on `feature-b`. You should see `Fast-forward` and no mention of conflicts.
4. Type `git push` and press **Enter** or **Return**.

### Step 16: Confirm the result

1. Type `python3 hello.py` and press **Enter** or **Return**. You should see your combined line.
2. In your browser, open `GitMergePractice` on GitHub, switch the branch menu to **development** and click `hello.py`. It should match.

That two-stage pattern (bring `development` into your branch and settle any conflicts there, then merge your branch into `development`) is the whole of guide 12.

## Part 4: Clean up after yourself

### Step 17: Delete the practice repository (optional)

Keep it if you want to practise again; it does no harm. To remove it:

1. In VS Code, close the folder (**File**, **Close Folder**).
2. In the terminal, type `rm -rf ~/GitMergePractice` and press **Enter** or **Return**. Check what you typed before pressing the key: `rm -rf` deletes the folder and everything in it without asking, and there is no bin on the VM.
3. On GitHub, open the repository, click **Settings**, scroll to the **Danger Zone** at the bottom, click **Delete this repository** and follow the prompts, which ask you to type the repository's name to confirm. This cannot be undone.

## If something goes wrong

**No conflict appeared in Step 12.** `feature-b` was probably made after `feature-a` had been merged, so it already contained the change. Type `git checkout development`, then `git branch -D feature-a feature-b`, then repeat from Step 8, making both branches back to back before editing either.

**The Accept Current Change links do not appear.** Close the file's tab and open it again. If they still do not appear, edit the file by hand: keep the lines you want, and delete the three marker lines.

**I see a "Resolve in Merge Editor" button.** That opens a three-panel view of the same conflict. You can use it, but the inline links in Step 13 are simpler; this guide does not need it.

**I committed with a marker line still in the file.** Open the file, delete the leftover markers, save, and commit again with `git add hello.py` and `git commit -m "Remove leftover conflict markers"`. Git does not remove markers for you; it only puts them there.

**I want to give up on the merge and start it again.** Type `git merge --abort` and press **Enter** or **Return**. The branch goes back to how it was before Step 12.

**"error: Your local changes to the following files would be overwritten by checkout".** You have unsaved or uncommitted changes and tried to switch branches. Commit them (or undo them) first, then switch.

**`python3: command not found`.** Type `sudo apt install python3` and press **Enter** or **Return**, then try again.

**A full-screen editor opened.** If the bottom shows `^X Exit`, it is nano: press **Ctrl+X**. Otherwise it is probably vim: press **Esc**, type `:wq` and press **Enter** or **Return** to accept the suggested message.

## What to do next

Do the same on your team's repository with your own branch: [12 Merge your branch into development](12-merge-your-branch-into-development.md).

## Sources

- [Creating a new repository (GitHub documentation)](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)
- [Creating and deleting branches within your repository (GitHub documentation)](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository)
- [Resolving a merge conflict using the command line (GitHub documentation)](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line)
- [Source control in VS Code, including merge conflicts (VS Code documentation)](https://code.visualstudio.com/docs/sourcecontrol/overview)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
