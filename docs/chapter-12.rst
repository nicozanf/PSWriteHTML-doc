========================================================================
Chapter 12: The Evotec PowerShell Module Suite
========================================================================

.. contents:: Table of Contents
   :local:
   :depth: 2

Evotec products Overview
========================

**PSWriteHTML** is part of an extensive suite of over 80 open-source PowerShell modules created and maintained
by **Przemysław Kłys** (`Przemyslaw.Klys on PowerShell Gallery <https://www.powershellgallery.com/profiles/Przemyslaw.Klys>`_).

This chapter categorizes the complete ecosystem of modules into distinct administrative domains—ranging from messaging, office document
generation, and Active Directory auditing to security policies, image processing, and system customization.

.. figure:: https://raw.githubusercontent.com/EvotecIT/PSWriteHTML/master/Docs/Images/PSWriteHTML-Logo.png
   :alt: Evotec Open Source Ecosystem
   :align: center
   :width: 300px


Core Frameworks & Helper Libraries
===================================

* **PSSharedGoods:** The core foundation library containing hundreds of shared helper functions for string manipulation, file handling,
  logging, and object processing across all Evotec modules.
* **PSPublishModule:** A project build and publishing framework for preparing, testing, and uploading PowerShell modules to the PowerShell Gallery.
* **PSParseHTML:** An HTML/CSS/JavaScript parser designed to extract, inspect, and analyze web content programmatically.


Communication & Notification Modules
====================================

* **Mailozaurr:** An advanced email engine utilizing MailKit and MimeKit supporting SMTP, POP3, IMAP, Graph API, and OAuth2.
* **PSTeams:** Sends rich webhook notifications to Microsoft Teams (supports Adaptive Cards, Hero Cards, and List Cards).
* **PSDiscord:** A lightweight module for sending structured webhooks and notifications to Discord channels.
* **Connectimo:** A connectivity module for handling network checks and remote endpoint testing.
* **Emailimo:** Helper module for managing inline email body structures and templates.


Office & Document Generation
============================

* **PSWritePDF:** Programmatically creates, edits, merges, splits, and formats PDF documents.
* **PSWriteOffice:** Creates and reads Word (``.docx``), Excel (``.xlsx``), PowerPoint (``.pptx``), Markdown, and CSV files natively without
  Microsoft Office installed (powered by OfficeIMO).
* **PSWord / Documentimo:** Dedicated tools for building Microsoft Word documentation and structured reports.
* **PSExcel / Excelimo:** Modules for creating and formatting Excel workbooks without requiring local Office installations.
* **MarkdownPrince:** A utility for parsing, converting, and processing Markdown files.


Active Directory, Security & Auditing
======================================

* **Testimo:** An Active Directory health and security audit framework evaluating domains against hundreds of best-practice checks.
* **GPOZaurr:** Group Policy analysis and repair tool designed to audit, troubleshoot, and fix GPO inconsistencies.
* **PSWinReporting / PSWinReportingV2:** Event log viewing, collecting, and security reporting engine focused on Domain Controllers.
* **SecurityPolicy:** A module wrapping ``secedit`` for managing Windows User Rights Assignments and local security policies.
* **AuditPolicy:** Replaces ``auditpol.exe`` with a custom wrapper to view and adjust Windows Security Audit policies.
* **PSPasswordExpiryNotifications:** Automates password expiry warning emails to users and managers using customizable templates.
* **PSWinDocumentation (AD, DNS, Exchange, O365, AWS):** Datasets and extraction tools that document infrastructure components into Word,
  Excel, or SQL databases.
* **AccountTracker:** Tracks non-compliant account placement in Active Directory services and OUs.
* **PSBlackListChecker:** Verifies IP addresses against global DNS blacklists and sends automated alert reports.


File Transfer, Security & Cryptography
======================================

* **Transferetto:** A reusable module/library for FTP, FTPS, SFTP, SCP, FXP, SSH commands, shell access, and SSH tunneling.
* **PSPGP:** Encrypts and decrypts files, folders, and text strings using PGP keys natively.
* **VirusTotalAnalyzer:** Interacts with the VirusTotal API to scan files, hashes, and URLs for threat intelligence.
* **PowerShellManager:** Extracts and recovers deleted or execution-flagged PowerShell scripts straight from Windows Event Logs for malware analysis.


Graphics, UI & Desktop Customization
=====================================

* **ImagePlayground:** Image processing engine capable of generating QR codes, barcodes, charts, and applying image filters.
* **PowerBGInfo:** Modern BGInfo replacement that generates dynamic system information desktop background wallpapers.
* **DesktopManager:** Manages, positions, and switches wallpapers across multi-monitor setups.
* **ConsoleMonster:** Terminal UI engine for building rich interactive console applications using Spectre.Console.
* **Statusimo / Dashimo:** Legacy status page and dashboard builders (integrated into modern PSWriteHTML workflows).


Cloud, Service & Vendor Integrations
====================================

* **O365Essentials / GraphEssentials / Graphimo:** Helper modules for managing Microsoft 365, Azure AD, and Intune via Microsoft Graph API.
* **O365Synchronizer:** Cross-tenant synchronization utility for sync-ing personal contacts, users, and guest objects.
* **PowerInfoblox:** Helper module for managing Infoblox IPAM and DNS appliance configurations.
* **PSLansweeper:** Queries Lansweeper asset databases for reporting and inventory tracking.
* **IISParser:** High-performance IIS log parsing module for traffic and diagnostic audits.
* **UnifiStockTracker:** Utility for tracking product stock in the Ubiquiti Unifi online store.
* **PSWordPress:** Interacts with WordPress web instances via REST API endpoints.


Ecosystem Integration Pattern
=============================

Combining these specialized modules yields robust automation solutions. For example, auditing AD security, rendering an HTML report, converting to PDF,
and emailing a summary via Microsoft Graph:

.. code-block:: powershell

   Import-Module Testimo
   Import-Module PSWriteHTML
   Import-Module Mailozaurr

   # 1. Run Active Directory Health Audit
   $AuditData = Invoke-Testimo -RootDomain

   # 2. Build Interactive HTML Report
   $ReportPath = "$env:TEMP\ADHealthReport.html"
   New-HTML -Title "AD Security Audit" -FilePath $ReportPath {
       New-HTMLTab -Name "Audit Details" {
           New-HTMLSection -HeaderText "Testimo Results" {
               New-HTMLTable -DataTable $AuditData
           }
       }
   }

   # 3. Generate HTML Email Body
   $Body = New-EmailBody {
       New-EmailSection {
           New-EmailPanel {
               New-EmailText -Text "The Active Directory health audit completed successfully. Attached is the interactive report."
           }
       }
   }

   # 4. Send via Mailozaurr Graph API
   Send-MgEmail -To "admin@domain.com" `
                -Subject "Weekly AD Audit Report" `
                -Body $Body `
                -BodyType HTML `
                -Attachments $ReportPath




----

**Next Chapter:** :doc:`Chapter 13: Documentation and Resources <chapter-13>`