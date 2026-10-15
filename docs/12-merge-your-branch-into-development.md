# Merging Your Branch into Development

Your work is no use to the team while it sits on your own branch. "Merging" folds your branch's commits into the shared `development` branch, so that everyone else gets them the next time they update. This guide does that safely, in the same two stages you practised in guide 11, and then shows the routine that keeps your branch up to date from one work session to the next. No prior technical experience is needed.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- Your own branch on your team's repository, with at least one commit pushed to GitHub: [09 Clone your team repository](09-clone-your-team-repository.md) and [10 Commit and push your changes](10-commit-and-push-your-changes.md).
- To have worked through [11 Practise a merge conflict](11-practise-a-merge-conflict.md), because this guide sends you back to it if a conflict appears.

## The rules

The team does not use pull requests: there is nobody available to approve them. Instead, you merge your own branch into `development` from the terminal, and the team's rule is **"You break it, you fix it."** If your merge leaves `development` broken, putting it right is your job, so the steps below are arranged to make that unlikely.

The safe order is to bring `development` into your branch first (Part 1). Any conflict then happens on your own branch, where a mistake affects only your work. You check that everything still works, and only then merge your branch into `development` (Part 2), by which time there is nothing left to conflict.

The examples use the branch name `101-sread`; use your own wherever you see it.

## Part 1: Bring development into your branch

### Step 1: Open your repository and commit your work

1. Open VS Code, connect to your VM and open your repository's folder (`~/CDSpecCollab` or `~/ChesapeakeCommunityConnect`).
2. Open the terminal (**Ctrl+`**).
3. Type `git status` and press **Enter** or **Return**.
4. Check that you are on your own branch and that it says `nothing to commit, working tree clean`. If you have uncommitted changes, commit and push them first ([10 Commit and push your changes](10-commit-and-push-your-changes.md), Steps 3 to 6).

### Step 2: Get the latest development from GitHub

1. Type `git checkout development` and press **Enter** or **Return**.
2. Type `git pull` and press **Enter** or **Return**.
3. You should see either `Already up to date.` or a list of the files your teammates have changed since you last pulled.

`git pull` fetches the new commits from GitHub and adds them to your copy of the branch. Your copy of `development` does not update by itself; it is only ever as new as your last pull.

### Step 3: Merge development into your branch

1. Type `git checkout 101-sread` and press **Enter** or **Return**.
2. Type `git merge --no-edit development` and press **Enter** or **Return**.
3. Read what git says, and continue with Step 4 or Step 5 to match.

### Step 4: If there was no conflict

You see `Already up to date.`, `Fast-forward`, or `Merge made by the 'ort' strategy.`, with no mention of `CONFLICT`.

1. Type `git push` and press **Enter** or **Return**.
2. Go to Step 6.

### Step 5: If there was a conflict

You see one or more lines beginning `CONFLICT (content): Merge conflict in`, followed by `Automatic merge failed`.

1. Type `git status` and press **Enter** or **Return**. Every file under `Unmerged paths` needs resolving.
2. Resolve each file in the VS Code editor exactly as in [11 Practise a merge conflict](11-practise-a-merge-conflict.md), Step 13: read both versions, choose or combine them, remove every conflict marker, and save.
3. Stage each resolved file: type `git add` followed by the file's name, and press **Enter** or **Return**.
4. Type `git status` and check that it says `All conflicts fixed but you are still merging`.
5. Type `git commit -m "Merge development into 101-sread, resolving conflicts"` (with your branch name) and press **Enter** or **Return**.
6. Type `git push` and press **Enter** or **Return**.

If you are unsure what a teammate's change was for, ask them before you choose between the versions. If you want to stop and think, `git merge --abort` puts your branch back exactly as it was before Step 3.

### Step 6: Check that the project still works

Your branch now contains everyone's latest work as well as yours, so this is the moment to find out whether they work together.

1. Run the project as your team's `README.md` describes; for the Django project, that means activating its virtual environment and running its development server, as in [06 Get started with Django](06-get-started-with-django.md).
2. Try the part you changed, and at least glance at the parts your teammates changed.
3. If anything is broken, fix it on your branch, commit and push, and check again. Do not go on to Part 2 until it works.

## Part 2: Merge your branch into development

### Step 7: Check that development has not moved on

A teammate may have merged into `development` while you were busy with Part 1.

1. Type `git checkout development` and press **Enter** or **Return**.
2. Type `git pull` and press **Enter** or **Return**.
3. If it says `Already up to date.`, continue with Step 8.
4. If new commits arrive, go back to Step 3 and bring them into your branch first, then return here.

### Step 8: Merge your branch

1. Type `git merge --no-edit 101-sread` (with your branch name) and press **Enter** or **Return**.
2. You should see `Fast-forward` or `Merge made by the 'ort' strategy.`, with no mention of conflicts, because Part 1 already settled them.
3. Type `git push` and press **Enter** or **Return**.

### Step 9: Go back to your own branch

1. Type `git checkout 101-sread` and press **Enter** or **Return**.

Do this straight away, so that your next edit goes onto your branch and not onto `development`.

What happens next depends on the issue:

- If there is more to do on the same issue, keep working on this branch, and merge it again in the same way when the next piece is ready.
- If the issue is finished, say so on the issue's page on GitHub (and close it, if your team does that). For your next issue, make a new branch from the up-to-date `development`, named for that issue: `git checkout development`, `git pull`, then `git checkout -b` followed by the new name, as in [09 Clone your team repository](09-clone-your-team-repository.md), Step 5.

### Step 10: Confirm on GitHub

1. In a web browser, open your team's repository ([CDSpecCollab](https://github.com/drsimonread/CDSpecCollab) or [ChesapeakeCommunityConnect](https://github.com/drsimonread/ChesapeakeCommunityConnect)).
2. Switch the branch menu to **development**.
3. Check that your change is there, and tell your team you have merged, so that they can pull it.

## Part 3: Keep your branch up to date

Do this at the start of every work session, so that you always build on the team's latest code and your branch never drifts far from `development`. The further a branch drifts, the bigger and nastier its eventual conflicts.

### Step 11: Update development, then your branch

1. Open your repository and the terminal, as in Step 1, and check with `git status` that you have no uncommitted changes.
2. Type `git checkout development` and press **Enter** or **Return**.
3. Type `git pull` and press **Enter** or **Return**.
4. Type `git checkout 101-sread` and press **Enter** or **Return**.
5. Type `git merge --no-edit development` and press **Enter** or **Return**.
6. If git reports a conflict, resolve it as in Step 5. Otherwise, type `git push` and press **Enter** or **Return**.

Notice that this is Part 1 again, without the merge into `development` at the end. Running it often is what keeps Part 2 dull, which is exactly how merges should be.

## If something goes wrong

**Step 8 reports a conflict.** Development moved on after Step 7, or you skipped Part 1. Type `git merge --abort` and press **Enter** or **Return**; `development` goes back to how it was. Then go back to Step 3.

**"Updates were rejected because the remote contains work that you do not have" when pushing development.** A teammate pushed to `development` between your Step 7 and Step 8. Type `git pull --no-edit` and press **Enter** or **Return**. If that merges cleanly, check the project still works and push again; if it reports a conflict, resolve it as in Step 5 and then push.

**`development` is broken after my merge.** Tell your team at once, so that nobody builds on it. Then fix it: find the problem on your branch, commit the fix, and merge again (Parts 1 and 2). If you cannot see how to fix it, ask your instructor; do not try to undo pushed commits on `development` yourself.

**"error: Your local changes to the following files would be overwritten by checkout".** You have uncommitted changes. Commit them (guide 10) before switching branches.

**"Your branch and 'origin/development' have diverged".** You committed to `development` directly by mistake. Stop and ask your instructor before pushing anything.

**"fatal: refusing to merge unrelated histories".** You are in the wrong repository folder. Check the prompt and the folder open in VS Code.

**A full-screen editor opened.** You left out `--no-edit` or `-m`. If the bottom shows `^X Exit`, it is nano: press **Ctrl+X** to accept the suggested message. Otherwise it is probably vim: press **Esc**, type `:wq` and press **Enter** or **Return**.

## What to do next

That is the whole git routine. [13 A typical development session](13-a-typical-development-session.md) puts it together with starting and stopping your VM into the checklist you follow every time you work: update your branch (Step 11), work and commit (guide 10), push before you stop, and merge into `development` (Parts 1 and 2) whenever a piece of work is finished and tested.

## Sources

- [Basic branching and merging (Pro Git book)](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
- [git-merge reference (git documentation)](https://git-scm.com/docs/git-merge)
- [git-pull reference (git documentation)](https://git-scm.com/docs/git-pull)
- [Resolving a merge conflict using the command line (GitHub documentation)](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line)

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
