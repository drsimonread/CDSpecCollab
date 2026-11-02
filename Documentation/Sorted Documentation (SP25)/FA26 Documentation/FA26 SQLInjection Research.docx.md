**SQL Injection Research as of 11/1/26 (Placed here for now until cdspec repo is fixed)**

Django ORM avoids the SQL construction that creates vulnerabilities. Wherever SQL is constructed without paramaterized statements
there is the possibility of malicious input modifying the intended query. 

For a summary of SQLInjection and Django see: https://semgrep.dev/blog/2020/preventing-sql-injection-a-django-authors-perspective/#preventing-sqli-in-django

So far the codebase appears free of any of the issues, but if db interaction evolves the ORM should always be used 
(avoid .raw(), especially .extra(), and db cursor) 