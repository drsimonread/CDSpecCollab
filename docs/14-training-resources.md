# Training Resources

The setup guides give you working tools; they do not teach you the languages you will write with them. This page lists the tutorials that do. Work through them in roughly the order given, because each builds on the ones before it: HTML before CSS (you cannot style a page that does not exist), Python before Django (Django is a Python package), and so on.

You do not have to finish them before starting on the project. Start them alongside the setup guides, and come back to them whenever you meet something in the project that you do not yet understand.

If a link does not work, or a tutorial does not match what you see, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need nothing but a web browser for most of these. Where a tutorial asks you to install or run something, do it on your VM, in VS Code connected to it ([05 Use VS Code with your VM](05-use-vscode-with-your-vm.md)), not on your laptop: that way, what you practise matches what you will use in the project.

## The web page itself

A web page is built in three layers. HTML says what is on the page ("this is a heading, this is a list"); CSS says what it looks like ("headings are navy and large"); JavaScript says what it does when someone clicks or types.

1. [HTML tutorial (W3Schools)](https://www.w3schools.com/html/default.asp)
2. [CSS tutorial (W3Schools)](https://www.w3schools.com/css/default.asp)
3. [JavaScript tutorial (W3Schools)](https://www.w3schools.com/js/default.asp)

## Python and Django

Python is the language; Django is the "web framework" written in it that both team projects use (see [06 Get started with Django](06-get-started-with-django.md) for what a framework does for you).

4. [Python tutorial (W3Schools)](https://www.w3schools.com/python/default.asp)
5. [Django tutorial (W3Schools)](https://www.w3schools.com/django/index.php)
6. [Django at a glance (official Django overview)](https://docs.djangoproject.com/en/6.1/intro/overview/)
7. [Writing your first Django app (official Django tutorial)](https://docs.djangoproject.com/en/6.1/intro/tutorial01/)

The official tutorial (7) starts by installing Django and running the development server. You have already done both in guide 06, on your VM, so skim those parts; the tutorial proper begins with apps, models and the database, which is where guide 06 stops.

## Git and GitHub

Guides 07 to 13 teach the git commands the team routine needs. These tutorials explain what is going on underneath, which helps a great deal when something unexpected happens.

8. [Git and GitHub tutorial for beginners (Educative)](https://www.educative.io/blog/git-github-tutorial-beginners)
9. [Git tutorial (W3Schools)](https://www.w3schools.com/git/default.asp), an alternative to the Educative tutorial; you need only one of the two.

BEWARE: general git tutorials often teach pull requests, or merging through GitHub's website. Our team does not use pull requests; follow [12 Merge your branch into development](12-merge-your-branch-into-development.md) for the team's own repository, and keep the tutorials' habits for your own practice repositories.

## If something goes wrong

**A link does not work, or goes to the wrong page.** Tutorial sites reorganise from time to time. Search the site's name and the tutorial's title (for example `W3Schools CSS tutorial`), and tell your instructor so the link can be fixed.

**The Django documentation shows a different version.** The links point to Django 6.1. The version you installed is shown by `python -m django --version` (guide 06, Step 3). If it differs, use the version menu in the bottom corner of the Django documentation's pages to switch to yours; the differences between nearby versions are small, but code examples occasionally change.

**A tutorial's commands do not work on the VM.** Many tutorials assume a Windows or macOS laptop. Your VM runs Ubuntu Linux, so use `python3` where a tutorial says `python` or `py` (unless your virtual environment is active), and `source .venv/bin/activate` where it says `.venv\Scripts\activate`.

**A tutorial tells me to install Python or git.** Both are already on your VM (guides 05 and 07). Skip those steps.

## What to do next

Back to the routine: [13 A typical development session](13-a-typical-development-session.md), or the list of guides in [00 Start here](00-start-here.md).

## Sources

- [W3Schools](https://www.w3schools.com/)
- [Django documentation](https://docs.djangoproject.com/)
- [Educative: Git and GitHub tutorial for beginners](https://www.educative.io/blog/git-github-tutorial-beginners)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
