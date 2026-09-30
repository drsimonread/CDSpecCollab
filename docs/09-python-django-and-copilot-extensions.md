# Adding Python, Django and GitHub Copilot Support to VS Code

Extensions add features to VS Code for particular languages and tasks. This guide installs three into the VS Code window that is connected to your GCP VM: Python (autocomplete, error checking and debugging), Django (template highlighting) and GitHub Copilot (an AI assistant that suggests code and answers questions). It also signs Copilot in to your GitHub account so it picks up your student benefits. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [Installing git on your GCP VM](08-install-git-on-gcp-vm.md) | Next: [Cloning, branching and merging CDSpecCollab](10-clone-branch-merge-cdspeccollab.md)

## Before you start

You need:

1. VS Code [connected to your GCP VM](07-connect-vscode-to-gcp-vm.md). Check that the bottom-left corner shows `SSH:` followed by your VM's external IP (such as `SSH: 34.86.123.45`) before each step below; if it does not, reconnect first.
2. A [GitHub account](01-create-github-account.md), for Copilot.
3. Ideally, your [Student Developer Pack approved](02-github-student-pack-and-copilot.md). Without it, Copilot gives you the more limited Copilot Free plan instead; everything below still works.

Why does the connection matter? Extensions have to run on the same machine as your code. An extension installed on your laptop while your code lives on the VM is like a mechanic with the right tools standing in the wrong garage.

## Step 1: Install the Python extension

1. Open the Extensions view (`Ctrl+Shift+X` on Windows, `Cmd+Shift+X` on macOS).
2. Search for `Python`.
3. Find the extension named **Python**, published by **Microsoft**.
4. Click **Install**.

Because you are connected to a remote host, the Extensions view is now split into two groups: **LOCAL - INSTALLED** and **SSH: 34.86.123.45 - INSTALLED** (with your VM's current address). Installing from within this connected window adds Python to the remote group. The Python extension also installs a companion extension called Pylance automatically; you do not need to search for it separately.

## Step 2: Confirm the Python extension is active

1. Open the Extensions view again.
2. Look under **SSH: 34.86.123.45 - INSTALLED**. You should see **Python** and **Pylance** listed there.
3. If you have a `.py` file on the VM, open it. The status bar at the bottom should show a Python version, confirming VS Code has detected a Python interpreter on the VM.

## Step 3: Install a Django extension

1. In the Extensions view, search for `Django`.
2. Find the extension named **Django**, published by **batisteo**.
3. Click **Install**.

It adds syntax highlighting and snippets for Django's template tags inside `.html` files, and highlighting for Django-specific Python patterns.

This extension has not been updated in some time, but it remains the most widely used option for Django template support and works reliably for highlighting and snippets. If you later find it does not cover something you need, **Django Template Support** by **junstyle** is a more recently maintained alternative that also adds automatic formatting.

## Step 4: Install the GitHub Copilot Chat extension

GitHub Copilot is an AI assistant: it suggests code as you type and answers questions about your code in a chat panel. Think of Copilot as a well-read apprentice looking over your shoulder. It has seen a great deal of code and is quick to suggest the next few lines, and it is often right. It is also, occasionally, confidently wrong, and it has no idea what your assignment asked for. You are still the one signing off on the work, so read every suggestion before you accept it, exactly as you would check an apprentice's work before it goes out of the door.

**Check your course's policy on AI tools before using Copilot for assessed work.** Having Copilot installed is not the same as being allowed to use it for every assignment.

1. In the Extensions view, search for `GitHub Copilot Chat`.
2. Find the extension named **GitHub Copilot Chat**, published by **GitHub**.
3. Click **Install**.
4. If the extension's page also shows a button such as **Install in SSH: 34.86.123.45**, click that too.

Despite its name, this one extension provides both the chat panel and the suggestions that appear as you type. Older guides (and older videos) tell you to install a separate extension called plain **GitHub Copilot** as well; that extension was merged into GitHub Copilot Chat and deprecated in early 2026, so if you see it marked as deprecated, leave it alone.

Recent versions of VS Code may already show a Copilot icon at the right-hand end of the status bar (the strip along the bottom of the window) before you install anything. If so, hovering over it and choosing **Use AI Features** installs the extension for you and takes you straight to Step 5; either route ends in the same place.

## Step 5: Sign in with your GitHub account

1. Hover over the Copilot icon at the right-hand end of the status bar.
2. Select **Use AI Features** (or **Sign in**, if that is what the menu offers).
3. In the dialog that appears, choose **Continue with GitHub**.
4. Your web browser opens a GitHub page. If it asks you to sign in, use the GitHub account that holds your student benefits (the one with your `@smcm.edu` address, such as `sread`).
5. Click **Authorize Visual-Studio-Code** (the exact wording may differ slightly). GitHub may ask for your two-factor code.
6. When the browser asks whether to open Visual Studio Code, click **Open** (or **Open Visual Studio Code**).
7. Return to VS Code.

Why the trip through the browser? VS Code never sees your GitHub password. GitHub checks who you are on its own website, then hands VS Code a "token", a sort of visitor's badge that lets it use Copilot on your behalf and that you can revoke at any time from your GitHub settings.

## Step 6: Confirm which account and plan you are using

1. Click the **Accounts** icon near the bottom of the left-hand sidebar (a head-and-shoulders outline). Your GitHub username (for example `sread`) should be listed as signed in.
2. In a browser, open your [GitHub Copilot settings](https://github.com/settings/copilot) and check which plan is shown.

If your Student Developer Pack has been approved, the plan reflects your student benefits; if not, you are on Copilot Free, which gives a monthly allowance of suggestions and chat messages. See the [note about Copilot](02-github-student-pack-and-copilot.md#a-note-about-github-copilot) in guide 2 for why the exact student plan varies.

## Step 7: Confirm everything is in place

Check the following:

1. The bottom-left corner still shows `SSH:` and your VM's external IP.
2. The Extensions view, under **SSH: 34.86.123.45 - INSTALLED**, lists Python, Pylance, Django and GitHub Copilot Chat. (If GitHub Copilot Chat appears under **LOCAL - INSTALLED** instead, that is fine too, provided the Copilot icon shows in the status bar.)
3. If you open an `.html` file that contains Django template tags (text wrapped in `{% %}` or `{{ }}`), those sections appear in a different colour from the surrounding HTML, confirming the Django extension recognises them.

## Step 8: Try a Copilot suggestion

1. Open a terminal (**Terminal > New Terminal**) and create a scratch file in your home folder:

   ```
   code copilot-test.py
   ```

   The `code` command, typed in a connected terminal, opens the file in the editor above.

2. In the new file, type this comment and press Enter:

   ```
   # function that returns the square of a number
   ```

3. Type `def` and pause for a second or two.

Copilot's suggestion appears in faint grey text after your cursor, something like `square(n): return n * n`. This grey text is called "ghost text": it is only a suggestion and is not part of your file yet.

4. Press `Tab` to accept the suggestion, or `Esc` to dismiss it.

## Step 9: Try the Copilot chat panel

1. Open the Chat view: press `Ctrl+Alt+I` on Windows or `Ctrl+Cmd+I` on macOS (or click the Copilot icon in the title bar at the top of the window).
2. Type a question about the file you have open, such as `What does this function do?`, and press Enter.

Copilot replies in the panel. It can see the file you have open, which is why the question does not need to say which function you mean.

## Step 10: Tidy up

Close `copilot-test.py` without saving (or save it and delete it afterwards with `rm copilot-test.py` in the terminal). It is only there for this exercise, and a stray file in your home folder is harmless but untidy.

## Turning Copilot off

If your course asks you to work without AI assistance for an assignment:

1. Open the Extensions view (`Ctrl+Shift+X` on Windows, `Cmd+Shift+X` on macOS).
2. Find **GitHub Copilot Chat** in the list of installed extensions (type `GitHub Copilot Chat` in the search box if you cannot see it).
3. Click the extension to open its page.
4. Click the small arrow beside the **Disable** button to see the two choices:
   - **Disable** switches Copilot off in every project.
   - **Disable (Workspace)** switches it off only for the folder you currently have open, such as the assignment you are working on.
5. Click the one you want.
6. If VS Code shows a **Restart Extensions** (or **Reload Window**) button, click it.

The Copilot icon disappears from the status bar, and no suggestions or chat appear until you switch it back on. Uninstalling is not necessary; disabling leaves the extension and your sign-in in place, like switching off a light rather than removing the bulb.

To switch Copilot back on, repeat actions 1 to 3 above and click **Enable**, then **Restart Extensions** if asked.

If you are connected to your VM, do this in the connected window, so that the change applies where your code actually lives.

## If something goes wrong

**Extensions you installed do not seem to work**: this almost always means they were installed into the **LOCAL - INSTALLED** group instead of the remote one. Reconnect with Remote-SSH, confirm the bottom-left corner shows `SSH:` and your VM's external IP, and reinstall the extension from within that connected window.

**No Python version appears in the status bar**: the Python extension only starts once a `.py` file is open, so open one first. If there is still no version, open a terminal in the connected window and run `python3 --version`; if that says the command is not found, install Python with `sudo apt install python3`.

**There is no Copilot icon in the status bar**: the extension is not installed or not enabled. Open the Extensions view, search for `GitHub Copilot Chat` and check that it shows as installed and enabled. If it is, press `Ctrl+Shift+P` / `Cmd+Shift+P` and run `Developer: Reload Window`.

**The browser never hands you back to VS Code**: switch back to VS Code yourself. If it is still waiting for sign-in, cancel and repeat Step 5; allow the browser to open VS Code when it asks.

**You signed in with the wrong GitHub account**: click the **Accounts** icon, select your account and choose **Sign out**, then repeat Step 5 with the right account.

**Suggestions appear in local files but not in files on your VM**: open the Extensions view while connected and check whether GitHub Copilot Chat needs installing under the **SSH:** group as well (Step 4, action 4).

**"You have reached your monthly limit"** (or similar): you are on Copilot Free and have used its allowance. Check whether your Student Developer Pack has been approved ([guide 2](02-github-student-pack-and-copilot.md)); student benefits usually carry a higher allowance.

**Suggestions are wrong or nonsensical**: this is normal from time to time. Dismiss them with `Esc` and keep typing; Copilot works better once the file contains more of your own code for it to go on.

## What to do next

With your tools in place, [clone the CDSpecCollab project and start working on your own branch](10-clone-branch-merge-cdspeccollab.md). If you are new to Python or Django themselves, the [training resources](training-resources.md) are a good companion.

## Sources

- [Python extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python) (Visual Studio Marketplace)
- [Django extension](https://marketplace.visualstudio.com/items?itemName=batisteo.vscode-django) (Visual Studio Marketplace)
- [Remote development over SSH](https://code.visualstudio.com/docs/remote/ssh) (VS Code documentation)
- [Set up GitHub Copilot in VS Code](https://code.visualstudio.com/docs/setup/copilot) (VS Code documentation)
- [GitHub Copilot frequently asked questions](https://code.visualstudio.com/docs/agents/agent-troubleshooting/faq) (VS Code documentation)
- [Open source AI editor: second milestone](https://code.visualstudio.com/blogs/2025/11/04/openSourceAIEditorSecondMilestone) (VS Code blog, on merging the GitHub Copilot extension into GitHub Copilot Chat)
- [GitHub Copilot settings](https://github.com/settings/copilot) (GitHub)
