# Creating a GitHub Account and Your First Private Repository

GitHub is a website that stores git repositories online so that you and your teammates can share code and see its full history. This guide walks through signing up for GitHub, creating your first private repository and joining the class project repository. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Next: [GitHub Student Developer Pack](02-github-student-pack-and-copilot.md)

## Two things to decide before you start

**Use your college email address.** Sign up with your school email (your `@smcm.edu` address, or whatever your institution issues). This matters for two reasons: it is what qualifies you for the free [GitHub Student Developer Pack](02-github-student-pack-and-copilot.md) benefits (including Copilot access), and it keeps your academic work associated with an account your instructors can verify.

**Choose a professional username.** Your GitHub username becomes part of every repository URL you create, and it is one of the first things employers see when you share your work. Some guidance:

- Good choices: your real name or a variation of it (`sread`, `simon-read`, `simonreaddev`).
- Avoid: nicknames, gaming handles, jokes, references you would have to explain in an interview, or anything with numbers that look arbitrary (`xXcoderXx99`).
- Assume a hiring manager will read it. If you would be uncomfortable putting it on a CV, pick something else.

Changing your username later is possible but breaks links to your existing repositories, so it is worth getting right the first time.

## Step 1: Create your account

1. Open your web browser and go to the [GitHub signup page](https://github.com/signup).
2. Enter your **college email address** when prompted.
3. Create a password. Use something strong that you do not use elsewhere.
4. Enter your chosen **username**, following the guidance above. GitHub tells you if it is already taken.
5. Choose whether to receive product updates by email, then continue.
6. Complete the puzzle or verification challenge GitHub shows to confirm you are a person.
7. Click **Create account**.

## Step 2: Verify your email

1. Check your college email inbox for a message from GitHub containing a launch code.
2. Enter that code on the GitHub page to verify your address.
3. GitHub may ask a few optional questions about how you plan to use it. You can answer or skip them.

## Step 3: Turn on two-factor authentication (strongly recommended)

GitHub requires two-factor authentication (2FA) for many accounts, and it protects your work regardless.

1. Click your profile picture in the top-right corner, then **Settings**.
2. In the left sidebar, click **Password and authentication**.
3. Under "Two-factor authentication", click **Enable two-factor authentication** and follow the prompts. An authenticator app on your phone is the most common option.
4. **Save the recovery codes GitHub gives you somewhere safe.** If you lose access to your phone, these are how you get back into your account.

## Step 4: Create your first private repository

A repository (or "repo") is a folder for a single project, along with its full history of changes.

1. Click the **+** icon in the top-right corner of any GitHub page.
2. Select **New repository**.
3. Under **Repository name**, type a short, descriptive name using hyphens instead of spaces (for example `my-first-project` or `cs101-assignments`).
4. Optionally add a **Description**: one line explaining what the project is.
5. Under visibility, select **Private**. This means only you (and anyone you specifically invite) can see it. You can make it public later if you want to show it off.
6. Check the box for **Add a README file**. This creates a starting file that describes your project, and it means the repository will not be empty.
7. Leave the `.gitignore` and licence options alone for now unless your instructor told you otherwise.
8. Click **Create repository**.

## Step 5: Confirm it worked

Your new repository page opens, showing the `README.md` file you just created. The repository name at the top has a grey **Private** label next to it, confirming only you can see it.

## Step 6: Join the CDSpecCollab repository

The class project, CDSpecCollab, belongs to your instructor's GitHub account. Anyone can look at it, but only invited "collaborators" can send changes back to it, much as anyone may read a noticeboard but only staff hold the key to its glass door. You get that key by accepting an invitation.

1. Send your GitHub username (for example `sread`) to your instructor, by whatever route the course asks for.
2. Wait for an email from GitHub saying you have been invited to collaborate on **drsimonread/CDSpecCollab**. It goes to the email address on your GitHub account.
3. Click **View invitation** in the email (or go to the [CDSpecCollab invitations page](https://github.com/drsimonread/CDSpecCollab/invitations) while signed in to GitHub).
4. Click **Accept invitation**.

GitHub opens the CDSpecCollab repository page. Invitations expire after a few days, so if the link says it is no longer valid, ask your instructor to send a new one.

You do not need to wait for the invitation before carrying on with the next guides; you only need it by the time you reach [Cloning, branching and merging CDSpecCollab](10-clone-branch-merge-cdspeccollab.md).

## What to do next

If you have not already, this is a good time to [apply for the GitHub Student Developer Pack](02-github-student-pack-and-copilot.md) using the same college email address.

## Sources

- [Creating an account on GitHub](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github) (GitHub documentation)
- [Creating a new repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) (GitHub documentation)
- [GitHub Student Developer Pack](https://education.github.com/pack)
