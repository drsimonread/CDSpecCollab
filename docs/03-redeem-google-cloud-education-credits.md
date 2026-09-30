# Redeeming Your Google Cloud Education Credits

Google Cloud charges for every virtual machine (VM) while it runs, so before you can create one you need a way to pay for it. Education credits are that way: your instructor applies for them on behalf of the class, and each student redeems a coupon that creates a Google Cloud billing account funded by the credits. This guide walks through requesting and redeeming your coupon. No prior technical experience is needed.

These instructions were generated using Anthropic's Claude and have not been verified. They may contain mistakes.

[Index](index.md) | Previous: [GitHub Student Developer Pack](02-github-student-pack-and-copilot.md) | Next: [Creating SSH keys](04-create-ssh-keys.md)

## Before you start

You need:

1. The student coupon link your instructor sends you (usually by email or in the course's learning management system). Only your instructor can obtain this link; there is no public signup page for course credits.
2. Access to your college email inbox, which is how Google confirms you are a student.
3. A web browser. Step 1 below makes sure you have a Google account to hold the credits.

## Step 1: Make sure you have a Google account

Your credits are attached to a Google account, and that same account is the one you sign in to the Google Cloud Console with for the rest of the course. Credits redeemed on one account cannot be moved to another, so decide now which one you will use.

1. If you already sign in to Gmail or Google Drive with your college email address, your college address is a Google account; use it and skip to Step 2.
2. If you already have a personal Google account (a Gmail address, for example) that you are happy to use for coursework, you can use that and skip to Step 2.
3. Otherwise, go to the [Google account signup page](https://accounts.google.com/signup).
4. Enter your first and last name, then the basic details Google asks for (such as your date of birth).
5. When asked to choose an email address, choose **Use your existing email** (the wording varies slightly) and enter your college email address, for example `sread@smcm.edu`. This creates a Google account that uses your college address rather than a new Gmail one.
6. Check your college inbox for a verification code from Google and enter it.
7. Create a strong password that you do not use elsewhere, and finish the remaining prompts.

## Step 2: Request your coupon

1. Open the link your instructor sent you.
2. Enter your first name, last name and **college email address** (for example `sread@smcm.edu`).
3. Submit the form.
4. Check your college inbox for a verification email from Google.
5. Click the link in that email to confirm you are a student.

A second email then arrives containing your coupon code. It can take a few minutes; check your junk or spam folder if it has not appeared.

## Step 3: Redeem the coupon

1. Open the coupon email and click **Redeem now**.
2. Sign in with the Google account from Step 1, if you are not already signed in. Check the account shown in the top-right corner of the page; this is the step where credits most often end up on the wrong account.
3. If the **Coupon code** field is not already filled in, copy **Your code** from the email and paste it in.
4. Read the terms and click **Accept and continue**.

Google now creates a new billing account, named after your course, that draws on your credits rather than on a credit card.

## Step 4: Confirm your credits are active

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Open the navigation menu (three horizontal lines, top-left) and click **Billing**.
3. If you are asked to choose a billing account, select the one named after your course.
4. In the left sidebar, click **Credits**.

You should see your education credit listed, with its original amount and the amount remaining. That billing account is the one you select when you [create your project and VM](06-create-gcp-vm.md).

## Making your credits last

Credits are finite and expire (typically one year after you redeem them), so it pays to be frugal:

- Stop your VM whenever you finish a work session; a running VM draws on your credits every hour, whether or not you are using it. The [VM guide](06-create-gcp-vm.md#step-10-stop-your-instance-when-you-are-not-using-it) shows how.
- Check the **Credits** page from Step 4 now and then, so you notice if something is running that should not be.
- Products in Google Cloud's free tier do not count against your education credits.

## If something goes wrong

**The coupon email never arrives**: check your junk folder, then confirm you typed your college email correctly in Step 2. If both are fine, ask your instructor; the course may have run out of coupons.

**"This coupon has already been redeemed"**: each coupon works once. You may have redeemed it on a different Google account; sign in to the Console with each of your Google accounts and check **Billing > Credits**.

**You are asked for a credit card when creating a project**: the project is not linked to your education billing account. Cancel, then select the billing account named after your course when prompted.

## What to do next

With credits in place, [create the SSH keys](04-create-ssh-keys.md) you will need when you create your VM.

## Sources

- [Get and redeem education credits](https://docs.cloud.google.com/billing/docs/how-to/edu-grants) (Google Cloud documentation)
- [Redeem credits for use on Google Cloud](https://codelabs.developers.google.com/codelabs/cloud-codelab-credits) (Google Codelabs)
