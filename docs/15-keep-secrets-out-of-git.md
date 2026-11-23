# Keeping Secrets Out of Git

A "secret" is any value that gives access to something: a password, an API key, the key Django uses to sign its cookies. Your web application needs secrets to run, but they must never be committed, because both team repositories are public and anything in them, history included, can be read by anyone on the internet. In this guide we keep each secret in a file on your VM that git is told to ignore, have Django read it from there, share it with your team without putting it on GitHub, and deal with the case where one has been committed by mistake. We also look at GitHub's own feature for this, "GitHub Secrets", and at why it is not the tool for day-to-day development. No prior technical experience is needed.

If anything does not go as this guide describes, look in **If something goes wrong** at the bottom of this page. **BEWARE:** marks a trap worth reading before you act; see [00 Start here](00-start-here.md) for what each marker means.

## Before you start

You need:

- Your team repository cloned on your VM, with your own branch checked out ([09 Clone your team repository](09-clone-your-team-repository.md)).
- The project's virtual environment activated in the VS Code terminal (the prompt begins with `(.venv)`; see [06 Get started with Django](06-get-started-with-django.md), Step 2).
- The routine for committing and pushing ([10 Commit and push your changes](10-commit-and-push-your-changes.md)).

## Part 1: Why secrets need special treatment

Code describes how your application works; secrets unlock things. Think of the difference between the plans of a house, which you can happily pin up for the builders, and the key to the front door, which you would not pin up next to them. Git keeps every version of every committed file forever, so a key committed once is a key pinned to the noticeboard for good, even if a later commit removes it.

In our projects, the secrets you are likely to meet are:

- Django's `SECRET_KEY`, in `settings.py`;
- database passwords;
- API keys, such as the Google Maps key in ChesapeakeCommunityConnect;
- email account passwords, if the application sends email.

The rule is simple: the code says *which* secret it needs, by name; the value lives somewhere else.

## Part 2: Keep your secrets in a `.env` file

### Step 1: Install python-dotenv

`python-dotenv` is a small Python package that reads a file of settings and turns each line into an "environment variable": a named value that any program can look up while it runs.

1. In the VS Code terminal, check that the prompt begins with `(.venv)`.
2. Type `pip install python-dotenv` and press **Enter** (Windows) or **Return** (macOS).
3. Wait for the line beginning `Successfully installed`.
4. If your team's repository has a requirements file (usually `requirements.txt`, or a file in a `requirements` folder), add a line `python-dotenv` to it and save, so that your teammates get the package too.

### Step 2: Tell git to ignore `.env`

We do this before creating the file, so that there is never a moment when git could pick it up.

1. In the Explorer, open the file `.gitignore` at the top of your repository. (If there is none, create it with the **New File** icon.)
2. On a new line at the end, type `.env`.
3. Save the file.
4. In the terminal, type `git check-ignore -v .env` and press **Enter** or **Return**.
5. You should see a line ending in `.env`, naming `.gitignore` and the line number. That is git confirming it will ignore the file. (It works even before the file exists.)

### Step 3: Create the `.env` file

1. In the Explorer, click the top folder of your repository (where `.gitignore` is: in both team projects, the folder above the one holding `manage.py`), then click the **New File** icon.
2. Type `.env` and press **Enter** or **Return**.
3. Type one secret per line, as a name, an equals sign and the value, with no spaces around the equals sign and no quotation marks:

   ```
   DJANGO_SECRET_KEY=replace-this-with-a-long-random-string
   GOOGLE_MAPS_API_KEY=your-key-here
   ```

4. Save the file.

Notice that `.env` begins with a dot, so it is "hidden": `ls` does not show it unless you type `ls -a`, although VS Code's Explorer does.

### Step 4: Make your own Django secret key

1. In the terminal, type the following and press **Enter** or **Return**:

   ```
   python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
   ```

2. A line of about 50 random characters appears. Copy it.
3. In `.env`, replace `replace-this-with-a-long-random-string` with what you copied, and save.

Each of you can have your own key for development; it only has to stay the same on any one machine, or everyone using that copy of the site is logged out.

### Step 5: Check that git cannot see the file

1. Type `git status` and press **Enter** or **Return**.
2. Check that `.env` is **not** listed. You should see `.gitignore` (and perhaps your requirements file) listed as modified, but never `.env`.

BEWARE: if `.env` appears under `Untracked files`, stop. Go back to Step 2 and check the spelling in `.gitignore`. Never run `git add .` while `.env` is listed, because the full stop means "everything", secrets included.

### Step 6: Read the secrets in `settings.py`

1. Open `settings.py` (in the inner project folder, beside `urls.py`).
2. Near the top, after the existing `from pathlib import Path` line, add:

   ```python
   import os
   from dotenv import load_dotenv
   ```

3. After the line that sets `BASE_DIR`, add:

   ```python
   load_dotenv(BASE_DIR.parent / ".env")
   ```

   `BASE_DIR` is the folder holding `manage.py`; if your `.env` is in that same folder rather than the one above it, use `load_dotenv(BASE_DIR / ".env")` instead.

4. Find the line beginning `SECRET_KEY =` and replace the whole line with:

   ```python
   SECRET_KEY = os.environ["DJANGO_SECRET_KEY"]
   ```

5. Save the file.
6. Start the development server (`python manage.py runserver`) and check that the site still loads.

The square brackets make Django stop with an error if the key is missing, which is exactly what you want: a site that quietly runs without its secret is harder to debug than one that refuses to start. For a setting that may legitimately be absent, use `os.environ.get("NAME", "default")` instead.

### Step 7: Commit an example file for your teammates

Your teammates need to know which secrets the project expects, without seeing yours. The convention is a file called `.env.example` with the same names and dummy values.

1. Create a file called `.env.example` beside `.env`.
2. Copy in the names from `.env`, with placeholder values:

   ```
   DJANGO_SECRET_KEY=make-your-own-with-get_random_secret_key
   GOOGLE_MAPS_API_KEY=ask-your-team-lead
   ```

3. Save it.
4. Stage and commit `.gitignore`, `.env.example`, `settings.py` and the requirements file by name, as in guide 10, Steps 4 and 5. For example, `git add .gitignore .env.example` and so on, then `git commit -m "#123 Read secrets from .env"` with your issue number.
5. Push (`git push`).

Notice the asymmetry: `.env.example` goes into git, `.env` never does. Anyone cloning the repository copies `.env.example` to `.env` and fills in the real values.

## Part 3: Share secrets with your team

A shared secret, such as a team's Google Maps key, has to reach your teammates somehow. Choose a private route that does not leave a permanent public copy.

- **Do** pass it in person, or by a direct message to the one person who needs it.
- **Do not** put it in a GitHub issue, a commit message, a pull request, a README or a group chat with people outside the team. Issues on a public repository are as public as the code.

Where a service allows it, it is better still for each student to have their own key, so that a leak affects only one key and can be revoked without disrupting everyone.

## Part 4: GitHub Secrets, and why they are not for development

### What GitHub Secrets are

GitHub Secrets are encrypted values stored with a repository on GitHub. They exist for **GitHub Actions**: automated "workflows" that run on GitHub's own machines when something happens, such as running the tests on every push. A workflow file reads a secret by name:

```yaml
- name: Run the tests
  env:
    DJANGO_SECRET_KEY: ${{ secrets.DJANGO_SECRET_KEY }}
  run: python manage.py test
```

They are added in the repository's **Settings**, under **Secrets and variables**, then **Actions**. There is a similar set for **Codespaces** (development environments that run on GitHub), which appear inside a codespace as environment variables.

### The drawbacks

GitHub Secrets do their own job well. For development on your VM they are the wrong tool, for these reasons:

1. **They never reach your VM.** GitHub hands secrets only to workflows running on its machines (and to Codespaces). Code running on your VM cannot read them, so you need a `.env` file anyway.
2. **You cannot read one back.** Once saved, a secret's value cannot be viewed, not even by the repository's owner; you can only replace it. So GitHub cannot serve as the place your team keeps its keys: if the only copy is a GitHub Secret, the value is effectively lost.
3. **Anyone who can push a workflow can use them, and so expose them.** Every collaborator on a team repository can add a workflow file, and that workflow can send a secret anywhere it likes. The protection is only as strong as the most careless person with write access.
4. **Masking is not secrecy.** GitHub replaces a secret's exact value with three asterisks in workflow logs, but a value that has been changed in any way (encoded, split up or printed letter by letter) is not recognised and appears in full.
5. **They are missing in some workflows.** Workflows started from a fork, or by Dependabot (GitHub's automatic dependency updater), do not receive the repository's secrets, and reusable workflows only get them when passed explicitly. A workflow that works on your branch can fail mysteriously elsewhere.
6. **No history and no expiry.** GitHub keeps no record of earlier values and never reminds you to change one. Rotating a key means remembering to update it by hand everywhere it is used.
7. **Size and shape limits.** Each secret holds one text value of at most 48 KB. Files such as certificates must be encoded or encrypted to fit, and those workarounds are not masked in logs.

So: keep your development secrets in `.env`, and use GitHub Secrets only if your team adds a GitHub Actions workflow. Because both read the same names, the code does not change between the two.

## Part 5: If you commit a secret by mistake

It happens to professionals too. What matters is the order in which you put it right.

### Step 8: Revoke the secret first

Removing the file does not help: the secret is still in the history, and once pushed to a public repository, automated scanners may have copied it within minutes.

1. Tell your instructor straight away, and say which secret it was.
2. Revoke or replace the secret at its source. For an API key, delete or "regenerate" it in the service's console (in the Google Cloud console, under **APIs & Services**, then **Credentials**); for a Django `SECRET_KEY`, make a new one (Step 4), which makes the old one useless; for a password, change it.
3. Put the new value in your `.env`.

### Step 9: Stop the file being committed again

1. If the secret was in `.env`, add `.env` to `.gitignore` (Step 2), then type `git rm --cached .env` and press **Enter** or **Return**. This tells git to stop tracking the file while leaving your copy on disk.
2. If the secret was typed into code, such as `settings.py`, replace it with an `os.environ` lookup (Step 6) and move the value into `.env`.
3. Check with `git status` that `.env` is no longer listed for commit.
4. Commit and push.

Rewriting the repository's history to erase the secret is possible, but it disrupts every teammate's clone and does not un-leak anything. Revoking the secret is the fix; the rest is tidying up.

Aside: GitHub's "push protection" is switched on by default for public repositories. It recognises keys from many well-known services, such as Google API keys, and refuses a push that contains one, explaining why. It does not recognise values it has no pattern for, such as a Django `SECRET_KEY`, so it is a safety net, not a substitute for `.gitignore`.

## If something goes wrong

**`KeyError: 'DJANGO_SECRET_KEY'` when Django starts.** Django cannot find the setting. Check that `.env` is in the folder named in `load_dotenv(...)` (Step 6, instruction 3), that the name in `.env` is spelt exactly as in `settings.py`, and that there are no spaces around the equals sign.

**`ModuleNotFoundError: No module named 'dotenv'`.** The virtual environment is not active, or `python-dotenv` is not installed in it. Check for `(.venv)` at the start of the prompt, then repeat Step 1.

**`git status` lists `.env`.** The ignore rule is missing or misspelt, or the file was committed before the rule existed. Check `.gitignore` (Step 2); if `.env` was ever committed, follow Part 5.

**GitHub refuses my push, mentioning "push protection" or a secret.** Push protection found a secret in one of your commits. Do not bypass it. Treat it as Part 5: revoke the secret, then ask your instructor how to remove it from the unpushed commit.

**The Google map shows "For development purposes only", or no map at all.** The Maps key is missing, wrong, or restricted to other addresses. Check `GOOGLE_MAPS_API_KEY` in `.env`, and ask whoever manages the key whether it allows your site's address.

**A teammate's site works but mine does not, with the same code.** Their `.env` has a setting yours lacks. Compare your `.env` with `.env.example`; if `.env.example` is missing the setting, add it there and commit, so that the next person does not hit the same problem.

## What to do next

Carry on with the routine in [13 A typical development session](13-a-typical-development-session.md). Before each commit, `git status` is your last chance to spot a secret; make glancing down that list a habit.

## Sources

- [Using secrets in GitHub Actions (GitHub documentation)](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets)
- [Push protection for users (GitHub documentation)](https://docs.github.com/en/code-security/how-tos/secure-your-secrets/prevent-future-leaks/push-protection-for-users)
- [Deployment checklist: SECRET_KEY (Django documentation)](https://docs.djangoproject.com/en/stable/howto/deployment/checklist/#secret-key)
- [python-dotenv (Python Package Index)](https://pypi.org/project/python-dotenv/)
- [API security best practices (Google Maps Platform documentation)](https://developers.google.com/maps/api-security-best-practices)

---

*Prepared by Simon Read with help from Claude Opus 5.5, an AI model made by Anthropic.*
