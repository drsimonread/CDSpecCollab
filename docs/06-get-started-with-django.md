# Getting Started with Django in VS Code

Django is a "web framework": a Python package that does the repetitive work of running a web site (turning web addresses into Python function calls, filling in HTML pages, talking to a database) so that you can concentrate on what your site actually does. In this guide we create a small Django project on your Google Cloud virtual machine, run it, and view it in the browser on your laptop. Along the way you will use the **Django** extension to write a template and **GitHub Copilot** to explain unfamiliar code. No prior experience of Django is needed.

The steps are the same on Windows and macOS, because everything happens inside VS Code. Where a keyboard shortcut differs, both are given, Windows first.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- To have worked through [05 Use VS Code with your VM](05-use-vscode-with-your-vm.md). This guide assumes you can connect to the VM, open and close folders, create and save files, make a virtual environment and select the Python interpreter.
- Your Google Cloud VM running.

BEWARE: a running VM uses up your GCP Educational Credits by the hour. Part 6 reminds you to stop it.

## Part 1: Prepare a project folder

### Step 1: Connect and make a folder

1. Open VS Code and connect to your VM (**Remote-SSH: Connect to Host...** from the Command Palette).
2. Check for the **SSH:** box in the bottom-left corner.
3. Open the terminal (**Ctrl+`**).
4. Type `mkdir ~/DjangoPractice` and press **Enter** (Windows) or **Return** (macOS).
5. Open the **File** menu, choose **Open Folder...**, change the path to `/home/` followed by your username and `/DjangoPractice/`, and click **OK**.
6. If VS Code asks whether you trust the authors of the files in this folder, click **Yes, I trust the authors**.

### Step 2: Make and activate a virtual environment

1. Open the terminal (**Ctrl+`**). It starts in `DjangoPractice`, because that is the open folder.
2. Type `python3 -m venv .venv` and press **Enter** or **Return**.
3. Type `source .venv/bin/activate` and press **Enter** or **Return**.
4. Check that the command prompt now begins with `(.venv)`.

### Step 3: Install Django

1. Type `pip install django` and press **Enter** or **Return**.
2. Wait for the line beginning `Successfully installed`.
3. Type `python -m django --version` and press **Enter** or **Return**.
4. You should see a version number such as `6.1.x`. Which version you get depends on your VM's Python (Django 6 needs Python 3.12 or later, which Ubuntu 26.04 has); on an older VM you might see `5.2.x`, which also works for this guide.

Notice that Django went into `.venv`, not into the VM as a whole. A different project on the same VM can use a different version of Django without the two interfering, which is the reason we bothered with a virtual environment.

## Part 2: Create a Django project

### Step 4: Create the project

1. In the terminal, type `django-admin startproject PracticeSite` and press **Enter** or **Return**. It prints nothing if it succeeds.
2. Type `cd PracticeSite` and press **Enter** or **Return**.
3. In the Explorer, click the arrow beside the new `PracticeSite` folder to open it. Notice that it contains `manage.py` and a second folder, also called `PracticeSite`. The outer folder is the project as a whole; the inner one is its Python "package" of settings. Django has always done it this way, and it confuses everyone the first time.

### Step 5: Select the interpreter

1. In the Explorer, click `manage.py` to open it. Opening a Python file wakes the Python extension up.
2. Open the Command Palette and run **Python: Select Interpreter**.
3. Choose the entry that mentions `.venv`, usually marked **Recommended**.
4. Look at the bottom-right of the window. You should see a Python version followed by `.venv`.

If you skip this step, the Python extension cannot find Django, and every line that mentions it gets a wavy underline even though the code is correct.

### Step 6: Ask Copilot what you are looking at

`manage.py` is short but not obvious, which makes it a good first question for Copilot.

1. With `manage.py` open, open the Chat view (**Ctrl+Alt+I** on Windows, **Ctrl+Cmd+I** on macOS).
2. Type `Explain what this file does, in plain English` and press **Enter** or **Return**.
3. Read the answer. You should get a short explanation saying that `manage.py` is Django's command-line helper: the program you run to start the server, set up the database and so on.

Critical Thinking: Copilot's answer sounds authoritative. How would you check it? The [Django documentation](https://docs.djangoproject.com/) is the authority; Copilot is a well-read summariser of it, and summarisers sometimes summarise last year's version.

## Part 3: Run the development server

### Step 7: Start the server

1. In the terminal, check that you are in the outer `PracticeSite` folder (the prompt should end with `PracticeSite$`) and that the prompt begins with `(.venv)`.
2. Type `python manage.py runserver` and press **Enter** or **Return**.
3. You will probably see some red text about "unapplied migrations". This is normal for a brand-new project: it means the database has not been set up yet, and we do not need it for this guide.
4. You should then see `Starting development server at http://127.0.0.1:8000/`.
5. A message should appear in the bottom-right corner saying that your application on port 8000 is available. Click **Open in Browser**.
6. Your laptop's web browser opens and shows Django's welcome page (a rocket and the words "The install worked successfully!").

Critical Thinking: the server is running on the VM, and `127.0.0.1` means "this machine". So why does a browser on your *laptop* find it? Because Remote - SSH noticed the server starting and "forwarded the port": it carries traffic from port 8000 on your laptop through the SSH connection to port 8000 on the VM. You can see it in the **Ports** tab beside **Terminal** in the bottom panel.

Leave the server running. It watches your files and restarts itself whenever you save one, so you do not need to stop and start it while you work.

## Part 4: Make a page of your own

Now we add a page of our own: a Python "view", a web address that leads to it, and an HTML "template" for it to fill in.

### Step 8: Write a view

A "view" is the Python function that Django calls when someone visits a page.

1. In the Explorer, right-click the inner `PracticeSite` folder (the one containing `settings.py`) and choose **New File...**
2. Type `views.py` and press **Enter** or **Return**.
3. Type:

   ```python
   from django.shortcuts import render


   def hello(request):
       return render(request, "hello.html", {"name": "World"})
   ```

4. Save the file.

The dictionary `{"name": "World"}` is the "context": the values the template can use. Notice that the view says nothing about HTML; it hands the template its data and leaves the page layout to the template. Keeping the two apart is one of Django's central ideas, much as an architect draws the building and leaves the bricklaying to someone else.

### Step 9: Connect the view to a web address

1. Open `urls.py` in the same inner `PracticeSite` folder.
2. Find the line `from django.urls import path` and, on the line below it, type:

   ```python
   from . import views
   ```

3. Find the list called `urlpatterns`. Inside its square brackets, after the line containing `admin.site.urls`, add:

   ```python
       path("hello/", views.hello),
   ```

4. Save the file.

### Step 10: Tell Django where the templates are

1. Open `settings.py` in the same folder.
2. Find the line `"DIRS": [],` inside the section called `TEMPLATES`.
3. Change it to:

   ```python
           "DIRS": [BASE_DIR / "templates"],
   ```

4. Save the file.

### Step 11: Write the template

1. In the Explorer, right-click the *outer* `PracticeSite` folder (the one containing `manage.py`) and choose **New Folder...**
2. Type `templates` and press **Enter** or **Return**. We keep Django's conventional name here, because the Django extension recognises template files partly by the folder they are in.
3. Right-click the new `templates` folder, choose **New File...**, type `hello.html` and press **Enter** or **Return**.
4. Look at the bottom-right of the window. You should see **Django HTML**, not plain **HTML**. If you see **HTML**, click it and choose **Django HTML** from the list.
5. Type:

   ```html
   <!doctype html>
   <html lang="en">
   <head>
     <meta charset="utf-8">
     <title>Hello</title>
   </head>
   <body>
     <h1>Hello, {{ name }}!</h1>
   </body>
   </html>
   ```

6. Save the file.

Notice that `{{ name }}` is coloured differently from the HTML around it. That is the Django extension at work: it knows that `{{ name }}` is a slot that Django fills in (here, with the `"World"` from your view's context), not text to show as it is.

### Step 12: See the page

1. Look at the terminal where the server is running. Because you saved files, it should have printed a line saying it noticed a change and reloaded itself.
2. In your laptop's browser, go to `http://127.0.0.1:8000/hello/` (or change the end of the address of the welcome page to `/hello/`).
3. You should see **Hello, World!** in large type.

If you see it, every piece is working: Remote - SSH carried your edits to the VM and the page back to your laptop, Python and Django ran the view, and the Django extension helped you write the template.

### Step 13: Change it

1. Go back to `views.py` and change `"World"` to your own name.
2. Save the file.
3. Reload the page in your browser. It should now greet you.

This edit, save, reload loop is how you will spend most of your time with Django. If a change does not appear, the first thing to check is the filled circle on the file's tab: an unsaved file is invisible to the server.

## Part 5: Ask Copilot about your code

### Step 14: Ask about a single line

1. In `views.py`, select the line beginning `return render`.
2. Press **Ctrl+I** (Windows) or **Cmd+I** (macOS) to open inline chat.
3. Type `What does render do here?` and press **Enter** or **Return**.
4. Read the answer, then press **Esc** to close inline chat.

BEWARE: if Copilot offers to change your code instead of explaining it, click **Discard** (or **Close**) unless you have read the change and understand it. You are responsible for every line you commit, whoever (or whatever) typed it.

## Part 6: Clean up after yourself

### Step 15: Stop the development server

1. Click in the terminal where the server is running.
2. Press **Ctrl+C** (on both Windows and macOS; on a Mac this is the **Control** key, not **Cmd**).
3. You should see the command prompt again.

### Step 16: Close the folder and the connection

1. Open the **File** menu and choose **Close Folder**.
2. Click the coloured **SSH:** box in the bottom-left corner and choose **Close Remote Connection**.

### Step 17: Stop your VM

1. Open the [Google Cloud console](https://console.cloud.google.com/), choose **Compute Engine**, then **VM instances**.
2. Click the three dots at the end of your VM's row, choose **Stop** and confirm.

Keep `DjangoPractice` if you want to experiment further; delete it as shown in guide 05 (Step 27) if not.

## If something goes wrong

**"No module named django".** The virtual environment is not active in this terminal. Check that the prompt begins with `(.venv)`; if not, type `source ~/DjangoPractice/.venv/bin/activate` and press **Enter** or **Return**. Every new terminal starts without it.

**"django-admin: command not found".** Same cause as above: activate the virtual environment and try again.

**Every line mentioning Django has a wavy underline.** The Python extension is using the wrong interpreter. Repeat Step 5.

**"Error: That port is already in use".** A server from earlier is still running, probably in another terminal tab. Find it and press **Ctrl+C**, or close that terminal with the bin icon in the terminal panel.

**"python: can't open file 'manage.py'".** You are in the wrong folder. Type `cd ~/DjangoPractice/PracticeSite` and press **Enter** or **Return**, then try again.

**The browser shows "This site can't be reached".** Check that the server is still running in the terminal, then look in the **Ports** tab for port 8000. If it is not listed, click **Forward a Port** and type `8000`.

**"Page not found (404)" at /hello/.** Django cannot match the address. Check the `path("hello/", views.hello),` line in `urls.py`, including the comma at the end and the slash after `hello`, and check that `urls.py` is saved.

**"TemplateDoesNotExist at /hello/".** Django cannot find `hello.html`. Check that the `templates` folder is in the outer `PracticeSite` folder (beside `manage.py`), not the inner one, and that you saved the change to `DIRS` in Step 10.

**Template code is not coloured.** Click the language name in the bottom-right corner and choose **Django HTML**. To make this permanent, open the Command Palette, run **Preferences: Open User Settings (JSON)** and add `"files.associations": { "**/templates/**/*.html": "django-html" },` inside the outer curly brackets. If **Django HTML** is not in the list at all, the Django extension is not on the VM yet; see guide 05, Step 6.

## What to do next

Set up git on your VM, ready for the team project: [07 Install git on your VM](07-install-git-on-your-vm.md).

When you want more Django, the official tutorial carries on from where this guide stops (apps, models and the database); it is listed, with tutorials for Python, HTML, CSS, JavaScript and git, in [14 Training resources](14-training-resources.md). For the team project the pattern is the same as here: connect, open your team's repository folder, activate its virtual environment and run its server.

## Sources

- [Django Tutorial in Visual Studio Code (VS Code documentation)](https://code.visualstudio.com/docs/python/tutorial-django)
- [Writing your first Django app (Django documentation)](https://docs.djangoproject.com/en/stable/intro/tutorial01/)
- [Django extension for VS Code (Visual Studio Marketplace)](https://marketplace.visualstudio.com/items?itemName=batisteo.vscode-django)
- [Remote Development using SSH: forwarding a port (VS Code documentation)](https://code.visualstudio.com/docs/remote/ssh)
- [Inline chat in VS Code (VS Code documentation)](https://code.visualstudio.com/docs/copilot/chat/inline-chat)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
