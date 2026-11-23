

| Circular Dichroism Spectrometer Software Test Plan  Version 1.3 11/18/26 F 401 Quality Assurance & Documentation Team |
| :---: |

**Table of Contents**

[**1\. Introduction**](#1.-introduction)	[**1**](#1.-introduction)

[1.1 Purpose](#1.1-purpose)	[1](#1.1-purpose)

[1.2 Scope](#1.2-scope)	[1](#1.2-scope)

[1.3 Definitions, Acronyms, and Abbreviations](#1.3-definitions,-acronyms,-and-abbreviations)	[1](#1.3-definitions,-acronyms,-and-abbreviations)

[1.4 Document References](#1.4-document-references)	[1](#1.4-document-references)

[1.5 System Overview](#1.5-system-overview)	[1](#1.5-system-overview)

[**2\. Requirements to Be Tested**](#2.-requirements-to-be-tested)	[**2**](#2.-requirements-to-be-tested)

[**3\. Testing Approach**](#3.-testing-approach)	[**2**](#3.-testing-approach)

[3.1 White Box Testing](#3.1-white-box-testing)	[2](#3.1-white-box-testing)

[3.2 Black Box Testing](#3.2-black-box-testing)	[2](#3.2-black-box-testing)

[**4\. Test Process**](#4.-test-process)	[**3**](#4.-test-process)

[4.1 Unit Testing](#4.1-unit-testing)	[3](#4.1-unit-testing)

[4.2 System Testing](#4.2-system-testing)	[3](#4.2-system-testing)

[**5\. Reporting and Corrective Action**](#5.-reporting-and-corrective-action)	[**3**](#5.-reporting-and-corrective-action)

[**6\. Test Environment**](#6.-test-environment)	[**3**](#6.-test-environment)

[6.1 Unit Testing Environment](#6.1-unit-testing-environment)	[3](#6.1-unit-testing-environment)

[6.2 System Testing Environment](#heading=h.7wmkd71ey6t0)	[3](#heading=h.7wmkd71ey6t0)

[**7\. Test Procedures**](#7.-test-procedures)	[**3**](#7.-test-procedures)

[7.1 Legacy Tests](#heading=h.d5xug3j2eftb)	[3](#heading=h.d5xug3j2eftb)

[7.2 Unit Tests](#heading=h.93x28urk4fxd)	[8](#heading=h.93x28urk4fxd)

[7.3 System Tests](#heading=h.60zj53go8iog)	[8](#heading=h.60zj53go8iog)

**Revision History**

| Date | Version | Description | Author(s) |
| :---: | :---: | :---: | :---: |
| 10/23/2022 | 1.0 | Created STP Template | Eythan Jenkins |
| 11/9/2022 | 1.1 | Added Legacy, Unit, and System Test Bases | Eythan Jenkins, CD Spec QA Team |
| 02/08/2023 | 1.2 | Updated document | CD Spec QA Team |
| 11/18/2026 | 1.3 | Edited and Updated Document | Ji-Young Hartman, QA |

# **1\. Introduction** {#1.-introduction}

## **1.1 Purpose** {#1.1-purpose}

The purpose of this Software Test Plan (STP) is to define all testing procedures that shall be implemented in the testing of the Circular Dichroism Spectrometer (CD Spec) application.

## **1.2 Scope** {#1.2-scope}

The purpose of this STP document is to detail any and all test cases associated with the CD Spec application. All plans and specific steps that will be taken during the testing process shall be documented here. This document will be utilized by both the Research and Development (R\&D) and Quality Assurance (QA) teams to test all possible cases within the scope of the CD Spec application.

## **1.3 Definitions, Acronyms, and Abbreviations** {#1.3-definitions,-acronyms,-and-abbreviations}

| CDSpec | Circular Dichroism Spectrometer; the application |
| :---- | :---- |
| QA | Quality Assurance |
| R\&D | Research and Development |
| SRS  | Software Requirements Specification  |
| STP  | Software Test Plan |
| UM | User Management |

## **1.4 Document References** {#1.4-document-references}

| STP Testing log |  |
| :---- | :---- |

## 

## **1.5 System Overview** {#1.5-system-overview}

The CDSpec software shall be a functional database housed within a constructed web application. This software shall be utilized by both instructors and students to monitor spectral changes in structure between protein-DNA interactions. Users of this web application shall be able to create three forms of user accounts. These accounts include a public user account, a student user account, and an administrator account, each of which have specific abilities assigned to them as well as some limitations imposed. A public user account may only view protein-DNA data submitted by account types with more permissions. Public accounts may not edit data in any way or submit data themselves. A student user account may view and submit protein-DNA data. Once submitted, the student account may not edit the data in any way. An administrator account has full permissions, meaning that this account type may perform all functions of the database, including: viewing the data within the database, uploading and submitting of user data, as well as editing of any data contained within the database.

---

# **2\. Requirements to Be Tested** {#2.-requirements-to-be-tested}

Requirements to be tested are defined within the Software Requirements Specifications (SRS) document, currently at version 3.0. The SRS shall be updated in future to reflect any changes made by the client or the Research and Development team over the course of this project’s duration.

* Login (SRS 2.1.1)  
* User Creation (SRS 2.2)  
* Password Recovery (SRS 2.3)  
* Page Navigation  
* Database Search Engine (SRS 2.5.2)  
* Data Comparison (SRS 2.5.4)  
* Data Upload (SRS 2.5.5)  
* Data Editing (SRS 2.5.5.1)

---

# **3\. Testing Approach** {#3.-testing-approach}

## **3.1 White Box Testing** {#3.1-white-box-testing}

* Database functionality

## **3.2 Black Box Testing** {#3.2-black-box-testing}

QA members working on CD Spec shall test the functionality of the CD Spec application. The team will test all possible requirements that have been implemented into the application. Tests will include higher priority and core functions such as:

* Application Access (in various testing environments/browsers)  
* Account Creation  
* Data Search  
* Data Upload, valid and invalid files  
* Data Graphing

---

# **4\. Test Process** {#4.-test-process}

## **4.1 Unit Testing** {#4.1-unit-testing}

Unit testing is the first stage of testing and will be done to ensure that the integration stage can combine the pieces of the program together into a more finalized product. Unit testing will be done primarily to ensure that each specified unit is able to execute its desired functionality and produce the correct outcome.

## **4.2 Integration Testing**

\[add section about integration testing\]

## **4.2 System Testing** {#4.2-system-testing}

The application at this stage will be tested within different test environments by several different members of the QA team. The application must function in different web browsers as well as by different users.

---

# **5\. Reporting and Corrective Action** {#5.-reporting-and-corrective-action}

All errors found will be recorded on the error log document. The QA member shall also create a new issue for the error on the GitHub repo. The errors will also be recorded in the tester’s bi-weekly report and SCRUM meeting. Furthermore, at an agreed upon date, the entire QA team should review the error log document to update which errors have been resolved and are still pending. These changes to the error log should be pushed to development weekly.

---

# **6\. Test Environment** {#6.-test-environment}

## **6.1 Unit Testing Environment** {#6.1-unit-testing-environment}

Unit Testing shall be performed on the QA tester’s computer using VS code. Before conducting their first ever test, the QA tester shall ensure they have completed all set-up steps, which are located in the docs folder within the CDSpec Github repo. They shall also create a new branch with the name “\<issue number\>-\<username\>”, as per the requirements listed in docs, to run their tests. Under no circumstances shall testers conduct their tests on the main or development branches. Extraordinary environments shall be recorded in the testing procedures themselves, and shall be followed accordingly.

## **6.2 System Testing Environment**

The System testing environment shall follow the same set-up and general specifications described in section 6.1. The exception; however, is that all system tests shall be performed in a browser or multiple browsers as specified by the test’s procedures.

# **7\. Test Procedures** {#7.-test-procedures}

A new Google Sheets document, called “STP Testing Tracking”,  shall be created (and saved in the team’s google drive under the STP document) to list all testing procedures and to track the testing process. The document shall take note of the following information in the form of separate columns:

* Test \#: An ID number associated with the test. Composed of an abbreviation of the SRS heading test is associated with and a unique number to differentiate it from other tests.  
* SRS \#: The respective SRS requirement associated with the test.  
* Test Author: The name of the person who wrote the test.  
* Date: The date of when the test was written.  
* Test Evaluator: The name of the person conducting the test.  
* Evaluation Date: The date of when the test was evaluated.  
* Previous Evaluation Date: Should the test go through multiple versions, the date of when the test was previously evaluated.  
* Version Number: The version number of the test.  
* Test Purpose: A short description of the purpose of the test.  
* Test Procedures: A step by step process describing the steps needed to take place to properly evaluate the test.  
* Measure of Success: A short description of what a successful test should result in.  
* Pass/Fail: A section to denote is the test evaluation Passed or Failed  
* Failed Result: Short description of what happened instead of the expected result  
* Comment: Any additional comments/updates about the test.

Additionally the different columns within the STP Testing Tracking document have filter options allowing for easy sorting.

# **8\. Miscellaneous:**

No miscellaneous information at this time.
