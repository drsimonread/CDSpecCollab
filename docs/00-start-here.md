# Start Here: Setting Up for the Team Project

These guides take you from an empty laptop to working on your team's repository: installing the tools, creating your Google Cloud virtual machine (VM) and connecting to it, and then the everyday git routine of branching, committing and merging. The last guide is the routine for a typical development session, which you will follow every time you work on the project. Work through the guides in order, because each one assumes you have finished the ones before it. No prior technical experience is needed.

The same guides appear in both team repositories, CDSpecCollab and ChesapeakeCommunityConnect. Where a step depends on which team you are on, the guide shows both choices and tells you which to pick.

## The development environment

You will do your development in an environment typical of industry. It will feel unfamiliar at first, and it is easy to be confused about what is happening where, so here is the lie of the land.

**The server.** Each of you works on your own cloud-based server: a VM on Google Cloud Platform (GCP), which guide 04 shows you how to create. A VM keeps the environment in which the web applications are developed and run consistent. Developing on your own laptop leads to difficulties setting up the environment and keeping it consistent with your teammates' and with the environment the finished application will run in. The VM is where your edited files exist, where your clone of the git repository lives, and where the web application runs.

**Visual Studio Code.** Your development *interface* is Visual Studio Code (VS Code), used in a mode called "Remote Development". Once you are connected, every file you edit and every command you run is edited or run *on the server*; VS Code is only an interface, rather like a terminal, running on your laptop. To make this work, you connect to your VM each time you start a development session (guide 13).

You should also have limited access to the GitHub Copilot artificial intelligence through your GitHub account, which gives you some of the more popular AI coding systems at no charge. You reach it through VS Code, which, again, you should think of as simply an interface.

**git and GitHub.** git is a program that keeps track of the versions of the software. It lets you save your progress, much as you might in a game, and it lets other people work on the same program without interfering with your work (though any inconsistencies have to be resolved later). git keeps a complete copy of every version of the software on your server: the versions you are working on, and the versions everyone else is working on.

GitHub is the server where the definitive versions of the software are stored. You can look at them through its web interface, but you do not update files there. Changes you make on your VM appear on GitHub only once you have *committed* them and *pushed* them; until then, nobody (including your instructor) can see them.

You work on a branch of your own, made from the repository's `development` branch. A branch is like a separate reality stream. When you have done your work, you *merge* your branch into `development`, which is occasionally merged into `main` for releases.

## Which repository is yours?

| Repository | What the project does | Address you clone from |
|---|---|---|
| CDSpecCollab | Saves data sets from a scientific instrument | `git@github.com:drsimonread/CDSpecCollab.git` |
| ChesapeakeCommunityConnect | A forum for information and discussion about environmentally sound organisations, mapped with Google Maps | `git@github.com:drsimonread/ChesapeakeCommunityConnect.git` |

If you are not sure which team you are on, ask your instructor before guide 09.

## The guides, in order

| Guide | What it does | Where you work |
|---|---|---|
| [01 Apply for the GitHub Student Developer Pack](01-apply-for-github-student-developer-pack.md) | Gets your free student benefits, including Copilot | Web browser |
| [02a Install VS Code on Windows](02a-install-vscode-windows.md) or [02b Install VS Code on macOS](02b-install-vscode-macos.md) | Installs the editor; do only the one for your laptop | Your laptop |
| [03 Install the VS Code extensions](03-install-vscode-extensions.md) | Adds Remote Development, Python, Django and GitHub Copilot | Your laptop |
| [04 Create your Google Cloud VM](04-create-your-vm.md) | Makes your SSH key, creates the VM, and stops and starts it | Your laptop and a web browser |
| [05 Use VS Code with your VM](05-use-vscode-with-your-vm.md) | Connects to the VM; folders, files, Python and Copilot | VS Code, connected to your VM |
| [06 Get started with Django](06-get-started-with-django.md) | Builds a tiny Django site on the VM | VS Code, connected to your VM |
| [07 Install git on your VM](07-install-git-on-your-vm.md) | Installs and configures git | Your VM |
| [08 Connect git to GitHub](08-connect-git-to-github.md) | Lets your VM push to GitHub | Your VM and a web browser |
| [09 Clone your team repository](09-clone-your-team-repository.md) | Copies your team's project to the VM and makes your branch for an issue | Your VM |
| [10 Commit and push your changes](10-commit-and-push-your-changes.md) | Records a change and sends it to GitHub | Your VM |
| [11 Practise a merge conflict](11-practise-a-merge-conflict.md) | Creates and resolves a conflict in a throwaway repository | Your VM and a web browser |
| [12 Merge your branch into development](12-merge-your-branch-into-development.md) | Shares your work with the team, and keeps your branch up to date | Your VM |
| [13 A typical development session](13-a-typical-development-session.md) | The routine for every session, from starting the VM to stopping it | Everywhere |
| [14 Training resources](14-training-resources.md) | Tutorials for HTML, CSS, JavaScript, Python, Django and git | Web browser, and your VM |

Start guide 01 first, even though nothing else depends on it yet: GitHub's student verification can take several days, and you can carry on with the other guides while you wait.

Guides 01 to 12 are done once (or, for guides 11 and 12, until they feel familiar). Guide 13 is the one you will come back to every time. Guide 14 is different again: a list of tutorials on the languages and tools themselves, to work through alongside the others and to return to whenever the project needs something you have not met yet.

## How the team works with git

A few ground rules shape the git guides, and it helps to know them before you start.

- **Every piece of work starts as a GitHub issue.** An "issue" is a task, bug or feature recorded on the repository's **Issues** tab, and GitHub numbers each one (#101, #102 and so on).
- **Branches are named `issue_number-username`.** For each issue you work on, you make a branch from `development` named with the issue's number, a dash and your GitHub username: if `sread` works on issue #101, the branch is `101-sread`. That way anyone can tell from a branch's name what it is for and whose it is. The examples in these guides use `101-sread`; use your own.
- **Nobody merges through pull requests.** On GitHub, a "pull request" asks someone else to review and approve a merge, and there is nobody available to do that. Instead, you merge your own branch into `development` yourself, from the terminal (guide 12).
- **You break it, you fix it.** If your merge breaks `development`, fixing it is your job. That is why guide 11 has you practise a merge conflict on a throwaway repository before you go near the real one.
- **Commit and push at the end of every session.** Work that exists only on your VM is invisible to your team and your instructor, and is lost if the VM is. Guide 13 ends every session with a push.
- **Type git commands in the terminal.** Use VS Code's terminal, connected to your VM, rather than VS Code's **Source Control** view. Typed commands show you exactly what git says, and they work the same everywhere, including on a machine with no VS Code at all. The one exception is merge conflicts, which you resolve in the VS Code editor because it shows both versions side by side (guide 11).

## How to read these guides

- **Bold text** is something you will see on screen: a button, a menu or a message. `Text like this` is something you type, or a file or folder name.
- After typing a command, press **Enter** (Windows) or **Return** (macOS) to run it. The guides say "press **Enter** or **Return**".
- When a guide shows what to expect, a lowercase `x` stands for digits that will differ on your machine; `git version 2.xx.x` means any version number in that shape is fine.
- **BEWARE:** at the start of a paragraph marks a trap: a step where something can be lost, cost you credits or be hard to undo, or a mistake that is easy to make and awkward to put right. Read every BEWARE paragraph before you carry out the step it belongs to, not after.
- **Notice that** points out a detail that is easy to miss; **Aside:** marks a tangent you can skip; **Critical Thinking** asks you to stop and think about why something works the way it does.
- **When something does not go as described** (an error message, a step whose result does not match what the guide says you should see, or a screen that looks different), look in the section headed **If something goes wrong** at the bottom of the same guide. Every guide has one. It lists the problems students actually run into, each with the message or symptom you will see and what to do about it. Look there before asking for help; if your problem is not listed, then ask, and tell your instructor exactly what you typed and what appeared.

BEWARE: your VM uses up your GCP Educational Credits for every hour it runs, whether or not you are using it, and those credits are the only way you pay for it; when they run out, your VM stops working. Stop it at the end of every session (guide 13 includes this; guide 04, Step 16 shows how).

---

*Prepared by Simon Read with help from Claude, an AI assistant made by Anthropic.*
