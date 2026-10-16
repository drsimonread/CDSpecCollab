# A Typical Development Session

This guide is the routine you follow every time you work on the team project, from starting your VM to stopping it again. Each step is something you learnt in guides 04 to 12; here they are in the order a session needs them, with a pointer back to the full instructions. No new technical knowledge is needed.

Two parts of the routine matter more than the rest. First, a session always ends with your work committed and pushed to GitHub: until then, nobody else (your team, or your instructor) can see it, and if anything happens to your VM, it is gone. Second, a session always ends with your VM stopped, because it uses up your GCP Educational Credits for every hour it runs, and when they run out, so does your VM.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## The short version

Once the routine is familiar, this is all you need:

1. Start the VM, and check its External IP address.
2. Connect VS Code and open your repository.
3. Update `development` and bring it into your branch (or make a new branch for a new issue).
4. Work: edit, save, test, commit. Repeat.
5. Commit everything and push.
6. If the issue is finished and tested, merge your branch into `development`.
7. Check your work on GitHub.
8. Close the connection and stop the VM.

The rest of this guide spells each one out.

## Before you start

You need to have worked through guides 01 to 12, so that your VM exists, VS Code connects to it, your repository is cloned there, and you know the git routine. If you are starting a new issue, note its number from your repository's **Issues** tab.

## Part 1: Start up

### Step 1: Start your VM

1. Open the [Google Cloud console](https://console.cloud.google.com/) and check that your project is selected at the top of the page.
2. Go to **Compute Engine**, **VM instances**.
3. Tick the box at the start of your VM's row, click **Start / Resume** and confirm.
4. Wait for the status to become a green circle with a white tick.

Full instructions: [04 Create your Google Cloud VM](04-create-your-vm.md), Step 17.

### Step 2: Check the VM's address

1. Look at the **External IP** column for your VM.
2. Compare it with the `HostName` line in your SSH configuration file. To see that, open VS Code, open the Command Palette (**Ctrl+Shift+P** or **Cmd+Shift+P**) and run **Remote-SSH: Open SSH Configuration File...**, then choose the file in your user folder.
3. If the addresses differ, change the `HostName` line to the new address and save the file (**Ctrl+S** or **Cmd+S**).

The address usually changes each time the VM starts, and an out-of-date `HostName` is the commonest reason VS Code will not connect.

### Step 3: Connect VS Code and open your repository

1. Open the Command Palette and run **Remote-SSH: Connect to Host...**, then click `gcp-vm`.
2. Wait for the coloured **SSH:** box to appear in the bottom-left corner.
3. Open the **File** menu, choose **Open Recent**, and click your repository's folder (`~/CDSpecCollab` or `~/ChesapeakeCommunityConnect`).
4. Open the terminal with **Ctrl+`**. The prompt should end with your repository's name.
5. If your project uses a virtual environment, activate it as your team's `README.md` describes (usually `source .venv/bin/activate`), and check that the prompt now begins with `(.venv)`.

Full instructions: [05 Use VS Code with your VM](05-use-vscode-with-your-vm.md), Steps 4 and 8.

## Part 2: Get up to date

### Step 4: Check that you left things tidy last time

1. Type `git status` and press **Enter** or **Return**.
2. If it says `nothing to commit, working tree clean`, go to Step 5.
3. If it lists changed files, last session ended without a commit. Commit them now (Step 9), then carry on.
4. If it says `Your branch is ahead of 'origin/...'`, last session ended without a push. Type `git push`, press **Enter** or **Return**, then carry on.

### Step 5: Bring in your team's latest work

1. Type `git checkout development` and press **Enter** or **Return**.
2. Type `git pull` and press **Enter** or **Return**.
3. Then follow **one** of the next two instructions.
4. If you are carrying on with the same issue, type `git checkout 101-sread` (your branch), then `git merge --no-edit development`, then `git push`, pressing **Enter** or **Return** after each. If the merge reports a conflict, resolve it as in [11 Practise a merge conflict](11-practise-a-merge-conflict.md), Step 13, before pushing.
5. If you are starting a new issue, type `git checkout -b` followed by a space and the new branch's name, `issue_number-username` (for example `git checkout -b 102-sread`), and press **Enter** or **Return**.

Full instructions: [12 Merge your branch into development](12-merge-your-branch-into-development.md), Step 11, and [09 Clone your team repository](09-clone-your-team-repository.md), Step 5.

## Part 3: Work

### Step 6: Check your branch before you touch anything

1. Look at the branch name in the bar along the bottom of the VS Code window, or type `git status`.
2. It should be your branch for the issue you are working on, never `development` or `main`.

### Step 7: Work in small steps

Repeat this cycle for as long as the session lasts:

1. Edit the files your issue needs, and save each one (check for the filled circle on the tab).
2. Run the project and try your change; for the Django project, start the development server with `python manage.py runserver` and stop it with **Ctrl+C** (guide 06, Step 7).
3. When a piece of work does what it should, commit it: `git status`, `git diff`, `git add` the files, and `git commit -m "#101 What this change does"` (guide 10, Steps 3 to 5).

Small commits with clear messages are easier for you to undo and for everyone else to understand. Copilot can help along the way (guide 05, Part 8), but read everything it suggests before you accept it.

## Part 4: Finish

Start finishing at least ten minutes before you have to stop. Rushing the end of a session is how work gets lost.

### Step 8: Stop anything still running

1. If the Django development server (or anything else) is running in the terminal, click in the terminal and press **Ctrl+C**.
2. Check that the prompt has come back.

### Step 9: Commit everything

1. Type `git status` and press **Enter** or **Return**.
2. If it lists changed or new files, type `git diff` to check what changed (press **q** to get the prompt back), then `git add` each file you mean to keep.
3. Type `git commit -m "#101 ..."` with a message saying what you did, and press **Enter** or **Return**.
4. Type `git status` again. It should say `nothing to commit, working tree clean`.

If your work is only half done, commit it anyway, and say so in the message (for example `"#101 Work in progress: form validation, not yet tested"`). Half-finished work is fine on your own branch; it is only `development` that must always work.

### Step 10: Push to GitHub

1. Type `git push` and press **Enter** or **Return**. (The first time you push a new branch, git tells you to use `git push --set-upstream origin` and your branch's name; type that instead, as in guide 10, Step 6.)
2. Type `git status` and press **Enter** or **Return**.
3. Check that it says `Your branch is up to date with 'origin/101-sread'` (with your branch name).

That line is your proof that everything you committed is on GitHub. If it says `ahead of` instead, the push did not happen; read what `git push` said, and see "If something goes wrong".

### Step 11: Merge into development (only if the issue is finished)

If the work for your issue is finished and tested, merge it into `development` now, so that the team gets it: [12 Merge your branch into development](12-merge-your-branch-into-development.md), Parts 1 and 2. Then go back to your branch (guide 12, Step 9).

If the work is not finished, skip this step. Never merge half-finished work into `development`.

### Step 12: Check your work on GitHub

1. In a web browser, open your team's repository: [CDSpecCollab](https://github.com/drsimonread/CDSpecCollab) or [ChesapeakeCommunityConnect](https://github.com/drsimonread/ChesapeakeCommunityConnect).
2. Click the branch menu near the top-left of the file list and choose your branch.
3. Check that the latest commit shown above the file list is your last commit message, made a few minutes ago.

This is exactly what your instructor sees. If it is there, your session's work is safe and visible.

### Step 13: Close the connection

1. In VS Code, click the coloured **SSH:** box in the bottom-left corner.
2. Choose **Close Remote Connection**.

### Step 14: Stop your VM

1. In the Google Cloud console, go to **Compute Engine**, **VM instances**.
2. Tick the box at the start of your VM's row, click **Stop** and confirm.
3. Wait until the status icon becomes a grey circle with a white square in it.

Do not close the browser tab until the icon has changed; a VM left half-way through stopping, or forgotten entirely, keeps using up your credits. Full instructions: guide 04, Step 16.

## If something goes wrong

**VS Code will not connect.** Check that the VM is running and that `HostName` matches its current External IP address (Steps 1 and 2). If VS Code keeps trying to download or install the VS Code Server, see guide 05's "If something goes wrong".

**I forgot to push, and I have already stopped the VM.** Your work is safe on the VM's disk, but nobody can see it. Start the VM, connect, push (Steps 1 to 3, then Step 10), and stop the VM again.

**I forgot to stop the VM.** Stop it as soon as you remember (Step 14). It does no harm beyond the credits it used, but a VM left running for days can use up a large share of them; check your remaining balance on the **Billing** page.

**`git push` says "Updates were rejected".** Someone else has pushed to the same branch (or you pushed from another machine). Type `git pull --no-edit`, press **Enter** or **Return**, resolve any conflict as in guide 11, Step 13, and push again.

**`git pull` on `development` says "Your local changes would be overwritten".** You edited files while on `development`. Do not commit them there: type `git stash` and press **Enter** or **Return** to put the changes aside, switch to your branch (`git checkout 101-sread`), then type `git stash pop` to bring them back on your branch.

**The VM will not start, saying resources are not available.** Wait and try again later. If it keeps failing, you may need a new VM in a different region (guide 04, "If something goes wrong"); anything you pushed is safe on GitHub and can be cloned on to the new VM, which is the best argument there is for Step 10.

## What to do next

Come back to this guide at the start of every session until the routine is second nature, and then keep "The short version" handy. For tutorials on the languages and tools themselves, see [14 Training resources](14-training-resources.md). To return to the list of guides, see [00 Start here](00-start-here.md).

## Sources

- [Stop and start a VM (Google Cloud documentation)](https://cloud.google.com/compute/docs/instances/stop-start-instance)
- [Remote Development using SSH (VS Code documentation)](https://code.visualstudio.com/docs/remote/ssh)
- [git-stash reference (git documentation)](https://git-scm.com/docs/git-stash)
- [Linking a pull request or commit to an issue (GitHub documentation)](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
