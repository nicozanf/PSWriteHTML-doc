========================================================================
Chapter 9: Automated Reporting and Email Integration
========================================================================

.. contents:: Table of Contents
   :local:
   :depth: 2

Automation Overview
===================

Beyond producing interactive browser-based dashboards saved as local `.html` files, **PSWriteHTML** includes specialized functionality for
automated email reporting. Sending rich HTML emails via PowerShell often presents challenges because major mail clients (especially desktop
Microsoft Outlook) use restrictive rendering engines that strips external stylesheets, CSS grids, and JavaScript.

PSWriteHTML solves this by providing dedicated email layout cmdlets (``Email``, ``EmailBody``, ``EmailLayoutRow``, ``EmailLayoutColumn``)
that automatically inline CSS styles into raw table-based HTML compatible with legacy email clients.



HTML Email Architecture vs. Web Dashboards
==========================================

When building content for email delivery, standard web layouts (like ``New-HTML``, JavaScript-based DataTables, and ApexCharts) should not be used
directly because email clients block external scripts and dynamic DOM manipulation for security reasons.

Key Email Constraints & Differences
-----------------------------------

+------------------------+----------------------------------+----------------------------------------------------+
| Feature                | Web Dashboard (``New-HTML``)     | Email Report (``Email``)                           |
+========================+==================================+====================================================+
| **Primary Container**  | ``New-HTML``                     | ``Email`` / ``EmailBody``                          |
+------------------------+----------------------------------+----------------------------------------------------+
| **Layout Model**       | Responsive CSS Flex/Grid Panels  | Inlined Table-based Rows & Columns                 |
+------------------------+----------------------------------+----------------------------------------------------+
| **JavaScript Support** | Full (DataTables, ApexCharts)    | None (Blocked by mail clients)                     |
+------------------------+----------------------------------+----------------------------------------------------+
| **CSS Handling**       | Linked / Embedded Head Styles    | Direct Inline CSS (``style="..."``)                |
+------------------------+----------------------------------+----------------------------------------------------+
| **Image Delivery**     | Web URLs or local relative paths | Inline images or CID (Content-ID) MIME attachments |
+------------------------+----------------------------------+----------------------------------------------------+


Building HTML Emails (``Email`` / ``EmailBody``)
=========================================================

To construct and send an email, use the `Email <https://github.com/EvotecIT/PSWriteHTML/blob/master/Docs/Email.md>`_
cmdlet with an ``-Email`` script block. Use `EmailBody <https://github.com/EvotecIT/PSWriteHTML/blob/master/Docs/EmailBody.md>`_
together with ``EmailLayout``, ``EmailLayoutRow``, and ``EmailLayoutColumn`` to build the table-based body. These commands apply
email-safe layout and styling directly to the generated HTML.

Basic Email Template Structure
------------------------------

.. code-block:: powershell

   # Generate and send an email with an inlined HTML body
   Email -To 'infrastructure@example.com' -From 'reports@example.com' `
       -Subject 'Morning backup status' -Server 'smtp.example.com' -Port 587 -SSL -Email {
       EmailBody {
           EmailLayout {
               EmailLayoutRow {
           EmailLayoutRow {
               EmailLayoutColumn {
                       New-HTMLText -Text "Below is the automated morning backup status summary."
                   }
               }
           EmailLayoutRow {
               EmailLayoutColumn {
                       New-HTMLTable -DataTable $BackupResults -DisablePaging
                   }
               }
           EmailLayoutRow {
               EmailLayoutColumn {
   }

.. note::
    `EmailLayoutRow <https://github.com/EvotecIT/PSWriteHTML/blob/master/Docs/EmailLayoutRow.md>`_ and
    `EmailLayoutColumn <https://github.com/EvotecIT/PSWriteHTML/blob/master/Docs/EmailLayoutColumn.md>`_ replace dashboard sections and panels
    for this purpose. They ensure email clients render the multi-column layout using native HTML ``<table>`` rows and cells.


Embedding Images in Email Reports (``New-HTMLImage``)
=====================================================

External image links (e.g., ``<img src="https://...">``) may be blocked by default in Microsoft Outlook and Apple Mail until the recipient
clicks "Download Images". To ensure logos and status icons display immediately, embed images directly using
`New-HTMLImage <https://github.com/EvotecIT/PSWriteHTML/blob/master/Docs/New-HTMLImage.md>`_ .
For a self-contained HTML body, use ``New-HTMLImage -Inline``. This embeds the image data in the generated markup and avoids relying on
external image URLs. CID inline images are delivery-library-specific. The mail client library must add the image as an inline MIME
attachment, assign it a unique Content-ID such as ``CompanyLogo``, and include that same identifier in the HTML as
``src="cid:CompanyLogo"``. A ``cid:`` reference by itself is only a pointer; without the matching MIME attachment and Content-ID, the
recipient's mail client cannot load the image.

.. code-block:: powershell

   Email -Email {
       EmailBody {
           EmailLayout {
               EmailLayoutRow {
                   EmailLayoutColumn {
                       New-HTMLImage -Source 'C:\Reports\CompanyLogo.png' -Inline -AlternativeText 'Company logo' -Width 150
                       New-HTMLText -Text '<h2>Daily Audit Summary</h2>'
                   }
               }
           }
       }
   }


Sending the Email Report via SMTP or Microsoft Graph
====================================================

The ``Email`` cmdlet can deliver the generated body directly. If another delivery library is required, use its HTML-body option and pass
the output from ``Email -OutputHTML`` to that library.

Method 1: Native ``Send-MailMessage`` (Legacy SMTP)
---------------------------------------------------

.. code-block:: powershell

   # The built-in PowerShell cmdlet Send-MailMessage is obsolete.
   # Keep this only for existing legacy SMTP scripts.
   Send-MailMessage -To 'admin@company.com' -From 'reports@company.com' `
       -Subject "Daily System Health Check - $(Get-Date -Format 'yyyy-MM-dd')" `
       -Body $EmailBody -BodyAsHtml -SmtpServer 'smtp.company.com' -Port 25


Method 2: Microsoft Graph API (Modern Cloud Delivery)
------------------------------------------------------

For Office 365 environments where basic SMTP authentication is disabled, send the generated HTML email via Microsoft
Graph PowerShell SDK:

.. code-block:: powershell

   # Requires Microsoft.Graph.Mail module
   Import-Module Microsoft.Graph.Mail

   $Message = @{
       Subject = "Automated Storage Alert"
       Body = @{
           ContentType = "Html"
           Content     = $EmailBody
       }
       ToRecipients = @(
           @{ EmailAddress = @{ Address = "admin@company.com" } }
       )
   }

   Send-MgUserMail -UserId "reports@company.com" -Message $Message


Automating Generation via Windows Scheduled Tasks
=================================================

To run reports automatically on a daily or weekly schedule, wrap your PowerShell data gathering and PSWriteHTML script
into an automated Scheduled Task.

Creating the Scheduled Task via PowerShell
------------------------------------------

The following administrative script registers a daily task that executes an automated PSWriteHTML report at
06:00 AM every morning:

.. code-block:: powershell

   # Define Script Path
   $ScriptPath = "C:\Automation\Scripts\Generate-DailyReport.ps1"

   # Create Action: Execute PowerShell 7 / Windows PowerShell silently
   $Action = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-ExecutionPolicy Bypass -NoProfile -File `"$ScriptPath`""

   # Create Trigger: Daily at 06:00 AM
   $Trigger = New-ScheduledTaskTrigger -Daily -At "06:00 AM"

   # Register Task under SYSTEM or Dedicated Service Account
   Register-ScheduledTask -TaskName "PSWriteHTML_DailyReport" `
                          -Action $Action `
                          -Trigger $Trigger `
                          -User "NT AUTHORITY\SYSTEM" `
                          -RunLevel Highest


Complete End-to-End Operational Example
=======================================

The following complete script collects disk space usage, builds a highlighted inline HTML table, generates an email body, and dispatches
an automated alert email if any drive drops below critical thresholds:

.. literalinclude:: sources/chapter-09-operational.ps1
   :language: powershell


Email Automation Best Practices
===============================

1. **Use ``Email`` for Emails, ``New-HTML`` for Web Pages:** Never use standard ``New-HTML`` directly inside an email
   body. Desktop mail clients like Outlook will strip non-inlined CSS and script blocks.
2. **Disable DataTables Interactivity in Emails:** Always set ``-Paging $false`` and ``-Filtering $false`` on
   ``New-HTMLTable`` inside email blocks, as email clients cannot run the JavaScript engine required for search and
   paging.
3. **Specify Explicit Widths:** Use explicit table and column percentage widths (e.g., ``width="100%"``) to prevent
   email templates from rendering distorted on mobile email clients.

----

**Next Chapter:** :doc:`Chapter 10: Advanced Features, Tips, and Troubleshooting <chapter-10>`
