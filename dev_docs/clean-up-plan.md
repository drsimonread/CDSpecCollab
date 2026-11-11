# Clean-up plan for CDSpecCollab

This plan covers five goals for the web application in `cd_spec_viewer_web/`:

- make it secure;
- make it conform to WCAG 2.1 AA;
- make it comply with GDPR;
- clean up the CSS;
- comment the code appropriately.

The findings come from reading the `development` branch and from running scanners against it. The numbers are in "Scan results" near the end of this plan. Items marked "check" still need confirming by hand.

## How to use this plan

Each phase is a group of related changes. We suggest one GitHub issue (and one issue branch) per bullet group, following `Issue branch Instructions.txt`. Do the phases in order: later phases depend on the tests and the tidy repository that the earlier ones give us.

## Phase 0: contain the leaked secrets

BEWARE: deleting a secret from a file does not remove it from the git history. Anyone with a clone can still read it.

- `settings.py` on `development` now has an empty `SECRET_KEY` and empty email credentials, but the `main` branch and the history still hold a hard-coded key (it looks like a Google OAuth client secret) and a Gmail app password.
- Account passwords and OAuth refresh and access tokens are committed in `Documentation/`:
  - `Documentation/Google Drive/CDSpec/Email Credentials.md`;
  - `Documentation/Sorted Documentation (SP25)/Training/R&D/Email/EmailCredentials.md`;
  - every copy of the "R_D To Do (INCLUDES CERTIFICATE FOR DEPLOYMENT AT END OF DOC)" file.
- Rotate every one of these credentials at Google and Gmail. Treat them all as compromised.
- Remove the files and purge the values from history with `git filter-repo`, then force-push. Every team member must then clone again.
- Check whether the repository is public. If it is, the rotation is urgent.
- The tips of 14 remote branches (including `main`) still carry a hard-coded key or app password in `settings.py`. Delete the stale branches as part of the purge.
- The live site, `cdspeccollab.smcm.edu`, serves a TLS certificate that expired on 2023-10-07. Browsers refuse the connection. Ask the Office of Information Technology to renew it before the next release.

## Phase 1: build a safety net

We cannot safely change access rules that have no tests.

- Merge the conflicting requirements into one pinned set. `cd_spec_viewer_web/requirements.txt` pins Django 4.2.19 while `requirements/base.txt` pins Django 4.0.10 and Pillow 7.2.0; `whitenoise` is not pinned at all.
- Move to Django 5.2 LTS. Django 4.2 left security support in April 2026.
- Write tests for the visibility rules (public, student, administrator) before touching them. `cdspec/tests.py` is empty.
- Repair the existing tests in `users/tests/`. None of them runs: all four files import `cd_spec_viewer_web.users`, a package path that no longer exists, and `pytest` is missing from `requirements.txt`.
- Add continuous integration that runs the tests, `ruff`, `djlint`, `pip-audit` and `python manage.py check --deploy`.

## Phase 2: tidy the repository

- Remove the 138 files in `cd_spec_viewer_web/static/admin/`. They are `collectstatic` output; Django supplies them itself.
- Remove files that the application does not use: `oauth2.py` (a Python 2 Google sample), `package.json`, `package-lock.json`, `cd_spec_viewer_web/AI_AGILE` and `TRANSFER-EXCLUDED-FILES.txt` (600 KB).
- Remove the uploaded CSV files in `cd_spec_viewer_web/cdspecruns/` and ignore that directory. Keep one small sample as a test fixture.
- Fix `.gitignore`: it ignores migration files, yet the migrations are (correctly) tracked. Remove that rule.
- Remove the duplicated documents in `Documentation/` (many "Copy of" files).

## Phase 3: security hardening

### Settings (`cd_spec_viewer_web/cd_spec_viewer_web/settings.py`)

- Read `SECRET_KEY`, the database password and the email credentials from environment variables. The database password is currently the literal `PASS`.
- Set `DEBUG = False` outside development.
- Remove `'*'` from `ALLOWED_HOSTS`.
- Set `SECURE_SSL_REDIRECT = True` and raise `SECURE_HSTS_SECONDS` from 60 once HTTPS is proven.
- Fix the typo `LOGOUT_REDIRECT_url` (Django ignores it as written).
- Remove the duplicate `ACCOUNT_AUTHENTICATION_METHOD` and replace the deprecated allauth settings.
- Define `MEDIA_ROOT`; `urls.py` uses it but the settings never set it.
- Add a Content Security Policy.

### Access control (`cd_spec_viewer_web/cdspec/views.py`)

- `upload_csv` has no sign-in or permission check, so anyone can write files to the server. It also renders `pages/upload.html`, which does not exist. Remove the view or protect it with the `can_upload` permission.
- `IndexView.get_queryset` returns the latest 10 runs with no visibility filter. The page now loads its rows from `SpecRunJson`, which does filter, so delete the unfiltered query.
- `IndexView` raises a server error for an unknown username; return a 404 instead.
- The check in `detail` refuses a run marked "visible to students" to a user who has `can_view_all` but not `can_view_student`. Put the rule in one function and use it in `detail`, `multi` and `SpecRunJson`.
- The source file link in `detail.html` points straight at the media directory, bypassing the visibility flags. Serve downloads through a view that checks permission.
- `delete` redirects to `"/" + pk`, which is not a real page.
- Replace the hand-written `has_perm` checks with `@permission_required`.

### Cross-site scripting

- `detail.html` and `multi.html` write data into JavaScript with `|safe`, and write the CSV unit names into JavaScript strings unescaped. A crafted CSV header can run script in an administrator's browser. Use the `json_script` filter instead.
- `index.html` builds links by joining strings in JavaScript and writes `{{username|safe}}` into a script. Check that every value is escaped; build the links with DOM methods.
- The Edit button in `detail.html` is a GET form containing a CSRF token, which puts the token in the URL. Make it a plain link.

### Uploads (`cd_spec_viewer_web/cdspec/util.py`)

- Add a maximum upload size.
- Validate `NPOINTS` before using it.
- Replace the two bare `except:` clauses with specific exceptions, and log the cause.

### Third-party scripts

- The pages load scripts from seven outside hosts. `plotly-latest`, the Font Awesome kit, the colour picker and all the DataTables files load with no integrity check.
- Chart.js is loaded twice (versions 2.9.4 and 2.8.0) and appears unused.
- Self-host pinned versions of the libraries we keep, and delete the rest.
- Bootstrap 4.3.1 and jQuery 3.3.1 are old and unsupported. Move to Bootstrap 5.3, which no longer needs jQuery (DataTables still does; check).

### Accounts (`cd_spec_viewer_web/users/`)

- `AccountAdapter.clean_email` tells a visitor whether an email address is registered. Use allauth's enumeration prevention instead.
- `UserDetailView` lets any signed-in user view any other user's profile. Restrict it to the owner and staff.
- Move the admin site off the default `/admin/` path and confirm that sign-in attempts are rate-limited.

## Phase 4: templates and CSS

- `home.html`, `about.html` and `google_account/index.html` wrap their content in a second `<html>`, `<head>` and `<body>`. Remove these; the page title belongs in `{% block title %}`.
- `project.css` claims to be generated from `project.scss`. It is not: no Sass build exists, and `project.scss` holds an unrelated dark theme. Delete `static/sass/` and make `project.css` the single source.
- `detail.html` and `multi.html` use the classes `wrap`, `half`, `title` and `readout`, which are defined only in the unused `project.scss`. Define them in `project.css` or remove them.
- Organise `project.css` into commented sections (layout, components, pages) and name the colours once as custom properties.
- Replace the named colour `lightblue`, the fixed `18px` heading size and the justified text in `.about-instructions` (see phase 5).
- Move the long inline scripts in `index.html`, `detail.html` and `multi.html` into files under `static/js/`. A Content Security Policy needs this.
- Replace hard-coded paths such as `/cdspec/create` and `/admin/` with `{% url %}`.
- Delete `templates/pages/index.html` (it is empty).

## Phase 5: WCAG 2.1 AA

Use `Accessibility for CDSPEC.pdf` in the repository root as the starting checklist.

- Add a "skip to content" link and a `<main>` landmark in `base.html`.
- Fix the heading order: the About page jumps from `<h1>` to `<h3>`, the 500 page does the same, and the index page has no heading at all.
- Both the Sign Up and Sign In links have `id="log-in-link"`. An id must be unique.
- The hidden text "(current)" is always announced on Home and Index. Use `aria-current="page"` on the active link only.
- On the About page, some links lose their `href` depending on sign-in state, which leaves them unreachable by keyboard. Show plain text instead.
- Selecting rows for Multi-Graph works only with a mouse click. Add a checkbox in each row.
- The colour wheel cannot be used from the keyboard, and its text input has no label. Offer a labelled list of colour choices.
- The Description and Datapoints text areas in `detail.html` have no programmatic label.
- Each chart needs a text alternative: a summary and the data as a table.
- In Multi-Graph, the lines differ only by colour. Add line styles or markers.
- Give status messages `role="alert"` or `role="status"`.
- Remove justified text, and use relative units (`rem`) for font sizes.
- Fix the three measured contrast failures (the target is 4.5:1 for all text):
  - body links, `#007bff` on white, 3.97:1;
  - navigation links, `#7c7d7d` on `#f8f9fa`, 3.91:1;
  - primary buttons, white on `#007bff`, 3.97:1.
- The Edit page renders `{{ form.as_ul }}` with no surrounding `<ul>`, so its four list items have no list. Use crispy forms, as the Upload page does.
- The page titles of the account pages contain the text of HTML comments (for example "Sign In <!-- Set the page title to "Sign In" -->"). Remove the comments from inside `{% block head_title %}`.
- Check: contrast of `.alert-error`, reflow at a width of 320 px, and a visible focus indicator.
- Test every page with axe, with the keyboard alone, and with a screen reader (VoiceOver or NVDA).

## Phase 6: GDPR

Aside: we are not lawyers. Ask the College's counsel or the Office of Information Technology whether GDPR applies to this site and how it sits alongside FERPA.

- Write a data inventory: username, name, email address, Google profile, password hash, the free-text "Run by" names, server logs and cookies.
- Publish a privacy notice that states what we collect, why, the lawful basis, how long we keep it and whom to contact.
- Publish a cookie statement. The site sets only strictly necessary cookies (session and CSRF), so it needs no consent banner, but it must say so. The `development` branch currently has no notice at all.
- Self-hosting the libraries (phase 3) stops every visitor's IP address going to seven outside hosts.
- Add self-service data export and account deletion. `SpecRun.upload_user_string` keeps the username after the account is deleted, which conflicts with the right to erasure; decide whether to anonymise it.
- Set retention periods for accounts, uploaded runs and logs.
- Confirm consent for the contributor names on the home page.
- Send mail from a College service account, not a personal Gmail account.
- Limit what staff can see in the admin site to what their role needs.
- Record the processing agreement with the hosting provider, and write a short breach-response procedure.

## Phase 7: comments and documentation

- Add a docstring to every module, class and function, saying what it does and why.
- Delete commented-out code (for example in `cdspec/util.py`, `users/views.py` and `index.html`). Git remembers it for us.
- In templates, replace HTML comments (`<!-- -->`) with Django comments (`{# #}`). HTML comments are sent to every visitor; several templates have one on almost every line.
- Remove comments that only repeat the code, and fix comments that are wrong (for example the "generated from project.scss" header).
- Correct the settings comments, several of which describe the wrong thing.
- Rewrite `READBEFOREDEPLOYMENT.txt` as a numbered deployment checklist.
- Update `README.md`: its documentation links point at a different repository.

## Phase 8: verify and release

- Run the tests and `python manage.py check --deploy`.
- Repeat the accessibility tests from phase 5.
- Deploy to a staging server and walk through every user role.
- Deploy to production.

## Scan results

These are the baseline numbers for the `development` branch. Run the same scanners again after each phase; the numbers should only go down.

### What was scanned, and how

- The live site was not scanned, because its certificate has expired (see phase 0).
- The dynamic scans ran against a local copy of the application, with a throwaway SQLite database, two seeded runs and two test accounts.
- The application was installed with Django 4.2.19 on Python 3.15.
- No scanner changed any file in the repository.

### Summary

| Scanner | What it checks | Result |
| --- | --- | --- |
| pip-audit 2.10.1 | Known vulnerabilities in dependencies | 143 advisories in 15 of 36 packages (`cd_spec_viewer_web/requirements.txt`); 88 advisories in 3 of 15 packages (`requirements/base.txt`) |
| Bandit 1.9.4 | Insecure Python patterns | 3 low-severity findings, all in `settings.py` |
| detect-secrets 1.5.0 | Secrets in the working tree | 10 hits in 6 files; none is a live secret |
| Git history search | Secrets in old commits and branches | 2 secret keys and 1 app password; 14 branch tips affected |
| `manage.py check --deploy` | Django deployment settings | 2 warnings |
| Response headers | Browser security headers | No Content Security Policy |
| pytest with coverage | The existing tests | 0 tests run; 4 files fail to import |
| Ruff 0.17.4 | Python style, bugs and docstrings | 250 findings |
| djLint 1.50.0 | Template structure and style | 102 findings in 35 files |
| axe-core 4.10.3 | WCAG 2.1 A and AA rules | Failures on all 14 pages scanned |

### Dependencies (pip-audit)

Advisories per package in `cd_spec_viewer_web/requirements.txt`:

| Package | Pinned version | Advisories |
| --- | --- | --- |
| pillow | 10.4.0 | 51 |
| django | 4.2.19 | 31 |
| pyjwt | 2.9.0 | 17 |
| pyasn1 | 0.6.1 | 9 |
| urllib3 | 2.2.3 | 8 |
| cryptography | 44.0.0 | 7 |
| sqlparse | 0.5.3 | 6 |
| django-allauth | 65.3.1 | 3 |
| setuptools | 75.3.0 | 3 |
| protobuf | 5.29.3 | 2 |
| requests | 2.32.3 | 2 |
| certifi | 2024.12.14 | 1 |
| httplib2 | 0.22.0 | 1 |
| idna | 3.10 | 1 |
| wheel | 0.45.1 | 1 |

- pip-audit refuses a file with an unpinned package, so `whitenoise` was left out of this run.
- `requirements/base.txt` is worse per package: pillow 7.2.0 has 70 advisories, django 4.0.10 has 15 and django-allauth 0.50.0 has 3.
- Notice that the application has no image field and does not use the Gmail API backend, so pillow (51 advisories) and the Google API packages (with pyasn1, httplib2 and protobuf) look removable. Removing unused packages in phase 1 clears many advisories without any upgrade. Check first: django-allauth's Google sign-in still needs pyjwt, cryptography and requests.

### Secrets

- detect-secrets found 10 hits. Four are the integrity hashes in `base.html` (false positives). Six are the placeholder database password `PASS`, in `settings.py`, `AI_AGILE` and three setup guides.
- BEWARE: detect-secrets did not flag the real passwords and tokens in `Documentation/` (phase 0). They are written as prose ("Password: ..."), which the scanner does not recognise. A clean scan does not mean a clean repository.
- Bandit's three findings are the same placeholder password and the two empty strings in `settings.py`.

### Django settings and headers

- `check --deploy` reports `security.W008` (`SECURE_SSL_REDIRECT` is not `True`) and `security.W018` (`DEBUG` is `True`).
- The check needs a non-empty `SECRET_KEY`; with the committed empty value the application does not start at all.
- The responses carry `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`, `Referrer-Policy: same-origin` and `Cross-Origin-Opener-Policy: same-origin`. There is no `Content-Security-Policy` header.

### Behaviour confirmed on the local copy

Each of these confirms a finding in phase 3:

- `GET /cdspec/upload/` returns a server error (500): the template is missing.
- A visitor who is not signed in can `POST` a file to `/cdspec/upload/`. The response is a 500, but the file is saved on the server.
- `/cdspec/uploadedby=nobody/` returns a 500 for a username that does not exist.
- For a run that is neither public nor visible to students, a visitor who is not signed in is redirected away from the run's page, but can still download its source file from `/media/`. (With `DEBUG` off, this depends on how the web server serves `/media/`. Check.)
- The JSON list and the Multi-Graph page did hide the private run correctly.

### Tests

- `python manage.py test` and `pytest` both fail before running anything.
- Because no test runs, the 23% coverage figure only reflects lines executed on import. `cdspec/views.py`, `cdspec/util.py` and `users/views.py` are at 0%.

### Python code (Ruff)

Rules selected: `E`, `F`, `W`, `B`, `S`, `DJ`, `UP` and `D1`, over `cd_spec_viewer_web/` and `oauth2.py`, leaving out migrations and `static/`.

| Group | Findings |
| --- | --- |
| Missing docstrings (`D100` to `D106`) | 95 |
| Whitespace and end of file (`W291`, `W292`, `W293`) | 59 |
| Lines over the length limit (`E501`) | 38 |
| `assert` in tests (`S101`) | 18 |
| Outdated syntax (`UP`) | 15 |
| Unused or repeated imports (`F401`, `F811`) | 9 |
| Bare `except` and re-raise without cause (`E722`, `B904`) | 4 |
| Django model issues (`DJ001`, `DJ012`) | 5 |
| Other | 7 |

- Ruff can fix 72 of these automatically with `ruff check --fix`.
- The 95 missing docstrings are the work list for phase 7.
- `oauth2.py` uses `raw_input`, which does not exist in Python 3. The file cannot work; this supports deleting it in phase 2.

### Templates (djLint)

| Rule | Meaning | Findings |
| --- | --- | --- |
| `T001`, `T002`, `T032` | Template tag spacing and quoting | 53 |
| `H014` | Extra blank lines | 7 |
| `H024` | Unneeded `type` on scripts and styles | 7 |
| `H012` | Spaces around `=` in attributes | 6 |
| `H043` | Button without a `type` attribute | 6 |
| `H029` | Upper-case form method | 5 |
| `D018` | Hard-coded internal link (use `{% url %}`) | 4 |
| `H005`, `H007`, `H030` | Nested `<html>` with no `lang`, doctype or description | 8 |
| `H053` | Duplicate id (`log-in-link`) | 1 |
| Other | | 5 |

`djlint --reformat` fixes the spacing rules. The rest feed phases 4 and 5.

### Accessibility (axe-core)

axe-core ran with the WCAG 2.0 and 2.1 level A and AA rules on 14 pages: eight as a visitor and six signed in as an administrator.

| Page | Failed rules |
| --- | --- |
| Home (`/`) | `color-contrast` |
| About (`/about/`) | `color-contrast` |
| Index (`/cdspec/`) | `color-contrast` |
| Run detail (`/cdspec/1/`) | `color-contrast`; `label` (3 fields) |
| Multi-Graph (`/cdspec/multi/1/2/`) | `color-contrast`; `label` (3 fields) |
| Upload (`/cdspec/create/`) | `color-contrast` |
| Edit (`/cdspec/1/edit/`) | `color-contrast`; `listitem` (4 items) |
| Sign in, sign up, password reset, sign out | `color-contrast` |
| Profile, profile update, email addresses | `color-contrast` |

- `color-contrast` fails on every page, because the navigation bar is on every page. The three colour pairs are listed in phase 5.
- `label` is rated critical: the two read-only text areas and the colour input on the detail page, and three inputs on the Multi-Graph page, have no accessible name.
- axe-core also marked the "skip link" rule (`bypass`) and many contrast checks inside the charts as "needs review".
- BEWARE: an automated scanner finds only a part of all accessibility problems. It cannot judge keyboard operation, reading order, the meaning of a chart, or reflow. The manual checks in phase 5 are still needed.
- Not scanned: the admin site, the 403, 404 and 500 pages, and the email templates.

## Decisions needed

- The site lives on an `smcm.edu` address. Should it follow the SMCM web style guide and brand colours, or stay with plain Bootstrap?
- Does GDPR formally apply, or is it a standard we choose to meet?
- Which libraries do we keep: Plotly only, or Plotly and DataTables?

---

Prepared by Simon Read with Claude (Fable 5.2).
