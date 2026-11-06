

| Circular Dichroism Spectrometer Software Design Description Version 4.0 02-06-2023 402 Quality Assurance & Documentation Team  |
| :---: |

---

*the photos have been downloaded, will be uploaded into a folder like in ccc to be reinserted*

**Table of Contents**

[**1\. Introduction\. 2**](#1-Introduction)

* [**1.1\. Purpose\. 2**](#11-purpose)

* [**1.2\. Scope\. 3**](#12-scope)

* [**1.3\. Definitions, Acronyms, and Abbreviations\. 3**](#13-definitions-acronyms-and-abbreviations)

* [**1.4\. Document References\. 3**](#14-document-references)

* [**1.5\. System Overview\. 3**](#15-system-overview)

[**2\. Data Design\. 3**](#2-data-design)

* [**2.1\. Internal Data Structures\. 4**](#21-internal-data-structures)

* [**2.2\. Data Flow Diagrams\. 4**](#22-data-flow-diagrams)*this needs restoring*

* [**2.3\. Data Dictionary\. 4**](#23-data-dictionary)

[**3\. Architecture Design\. 5**](#3-architecture-design)

* [**3.1\. Program Structure\. 5**](#31-program-structure)*this needs restoring*

[**4\. Interface Design\. 6**](#4-interface-design)

* [**4.1 Internal System Interfaces\. 6**](#41-internal-system-interfaces)

* [**4.2 External System Interfaces\. 7**](#42-external-system-interfaces)

* [**4.3 User Interfaces\. 7**](#43-user-interfaces)

[**5\. Procedural Design\. 13**](#5-procedural-design)

[**6\. Miscellaneous\. 15**](#6-miscellaneous)

**Revision History**

| Date | Version | Description | Author(s) |
| :---: | :---: | :---: | :---: |
|  10/1/20 |  1.0 | Software Design Description First Release  |  Annette Orr, Braden Clough, Cameron Carpenter, Edward Park |
| 3/8/21  |  2.0 | Software Design Description Second Release  | Annette Orr, Christopher Beatrez, Faith Meyer, Edward Park  |
| 9/14/22 | 3.0 | Software Design Description Release  | Mathias Boddicker,  Victor Riley, Marian Marteja, Liam Pratt, Jordan Reece, Gavin McDonald |
| 2/6/23 | 4.0 |  Software Design Description Fourth Release | Isabella Stephens, Liam Pratt, Jordan Reece, Mathias Boddicker, Gavin McDonald |

# 1\. Introduction** 

## **1.1\. Purpose** 

This Software Design Document (SDD) is intended to provide a detailed description of the Circular Dichroism Spectrometer (CD Spec) application via the use of visual diagrams and models. This SDD will describe the CD Spec application through these provided diagrams and will detail the architecture and design of the application. All aspects of the application will be defined visually, including the design of the application’s data, interfaces, as well as its overall architectural design. This document's primary function is to provide the viewer with an understanding of the CD Spec application’s structuring, both internal and external, as well as to be a useful tool for all parties involved in the development of this application, including the client and developers, as well as future users of the software.

* **Data Design:** the application’s data design shall provide an understanding of the application’s data and how it will be stored and/or used. The data design will also include data flow diagrams that illustrate how the data will be processed within the CD Spec application.  
* **Architecture Design:** the architecture design will illustrate the overall structure of the CD Spec application, and all its components and functionalities, as well as their relationships within the system. This element of the application acts as the blueprints of the overall application, illustrating what the application will look like when developed.  
* **Interface Design:** the interface design will illustrate the CD Spec application’s appearance and how it will be viewed from the user’s perspective. Here, the design of the software’s screen is captured via a screenshot of the current state of the application for the viewer’s understanding. Also known as the presentation layer, this design element will also present all internal or external interfaces within the application.  
* **Procedural Design:** the procedural design shall detail the internal logic that will make up the CD Spec application. This design illustrates how the program will function on the programming level, and will be explained via the usage of visual imagery in the form of model representations.

## **1.2 Scope**

This Software Design document pertains to the CD Spec application project and all of its associated files, data, and documentation. The SDD will be used by team members to illustrate the overall architectural structure and components of the CD Spec application as documented and described in the associated Software Development Plan (SDP) as well as the latest, updated version of the Software Requirements Specifications (SRS) document. This document also pertains to the latest Software Test Plan (STP) as it can be used to visualize the components that will need to be tested for application completion.

## **1.3\. Definitions, Acronyms, and Abbreviations**

* **SDD** - Software Design Document  
* **SDP** - Software Development Plan  
* **SRS** - Software Requirements Specification  
* **STP** - Software Test Plan  
* **CD Spec** - Circular Dichroism Spectrometer

## **1.4\. Document References**

* Software Development Plan, ver 3.0, released 10/31/22  
* Software Requirements Specifications, ver 3.0, released 09/12/22  
* Software Test Plan, ver 1.1, released 11/09/22

## **1.5\. System Overview** 

The Circular Dichroism Spectrometer (CD Spec) application is an online database created for research and education purposes. This application shall be utilized by both the instructors and students to monitor spectral changes in structure between protein-DNA interactions. Users of this application shall be able to create three forms of accounts, including an administrator account with full permissions, a student account with limited permissions as specified by the administrator, and public accounts with the least amount of permissions available. A public user may only download and view data within the database, they may not upload, edit, or delete any data from the database. A student account has increased privileges, as students may upload and edit data within the database, with administrator supervision, as well as download any and all data uploaded. Administrator accounts have full access to all functions of this database, meaning these accounts may upload, edit, delete, and download all data entering and exiting the database.

# **2\. Data Design**

## **2.1\. Internal Data Structures** 

The system will store and maintain the following data:

* Login Page   
* Search Engine  
* Upload Page   
* Post upload Display Page   
* Create Account   
* Create username   
* Forgot Password   
* Reset Password   
* Create new password   
* Help   
* Google button   
* Data Explorer

## **2.2\. Data Flow Diagrams** 

**![][image1]**
This image will get restored.

## **2.3\. Data Dictionary** 

* **Login Page -** This part of the software will handle data accessibility by verifying account credentials  
* **Search Engine -** This part of the software will handle search requests by the user.   
* **Upload Page -** This part of the software will handle data uploading requested by the user  
* **Post upload Display Page -** This part of the software will appear as a confirmation after a user has uploaded data using the *Upload Page*  
* **Create Account -** This part of the software will handle account creation by making their own username and password credentials  
* **Create username -** This part of the software will handle username creation  
* **Forgot Password -** This part of the software will handle account password reset  
* **Reset Password -** This part of the software will allow the user to replace the forgotten password with a new one  
* **Create new password -** This part of the software will allow the user to input a new password for their account credentials  
* **Help -** This part of the software will inform the user of any questions they may have about the software  
* **Google button**  - This part of the software grants account credentials to students that attend St. Mary’s College of Maryland by using their school email as their username and their email password.   
* **Data Explorer** - This part of the software will provide additional results when the user is searching for data in the database

# **3\. Architecture Design** 

## **3.1\. Program Structure** 

![][image2]

Diagram 2

![][image3]

# **4\. Interface Design** 

## **4.1\. Internal System Interfaces**

**Account Management Interfaces**

These interfaces all handle account level interactions with the user and allow said user to access the data as well as the about and help interfaces within the website.

* Login  
* Create Account  
* Password Management

**Help Interface**

This interface will primarily be used to aid the user in using and understanding the system and how it functions. The interface will also provide possible troubleshooting and/or fixes that the user may encounter while using the application.

**About Interface**

This interface will provide the user with general information about the Circular Dichroism Spectrometer system.

**Database Interface**

This is the primary interface that allows the user of the system to view, download, upload, and compare data within the database.

* Upload  
* Graph  
* Multigraph  
* Download

**Graph Interface**

This interface’s primary purpose is to display the data that is within the database. It will provide the user with visuals on what the data contains, including multiple types of constraints,  as well as different colors to represent data when using the multigraph feature.

## **4.2\. External System Interfaces**

* Graphical Interface: Plotly  
* Internet Connection 

## **4.3\. User Interfaces**

**Home Screen Display**  
*![][image4]*  
**Log-in Screen Display**

**![][image5]**  
**Google Sign-in Display**  
**![][image6]**

**Database Screen Display![][image7]**

**Administrator (Master) Screen Display**  
**![][image8]**  
**Upload File Display**  
**![][image9]**

**Personal Profile Display**  
**![][image10]**  
**Website Information Display**  
**![][image11]**

**Password Recovery Display**  
**![][image12]**

**Single Graph Screen**  
**![][image13]**

**Multi Graph Screen**

**![][image14]**

**Graph Color Wheel Display**  
*![][image15]*

# **5\. Procedural Design** 

*![][image16]*

# **6\. Miscellaneous** 

None.  
---

image1: data-flow-diagram.png
image2: program-structure-diagram1.png
image3: program-structure-diagram2.png
image4: home-screen-display.png
image5: log-in-screen-display.png
image6: google-sign-in-display.png
image7: database-screen-display.png
image8: admin-screen-display.png
image9: upload-file-display.png
image10: personal-profile-display.png
image11: website-information-display.png
image12: password-recovery-display.png
image13: single-graph-screen.png
imgae14: multi-graph-screen.png
image15: graph-color-wheel-picker.png
imgae16: procedural-design-diagram.png