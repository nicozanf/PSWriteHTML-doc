========================================================================
Chapter 10: Publishing Live Dashboards on Windows
========================================================================

.. contents:: Table of Contents
   :local:
   :depth: 2

Publishing Overview
====================

As you scale **PSWriteHTML** across enterprise infrastructure, you will likely want to transition from generating static, on-demand `.html`
files to publishing live, continuously updated dashboards accessible across your organization.

Because PSWriteHTML generates standalone HTML files bundled with JavaScript and CSS, publishing a live interactive dashboard does not require
complex web application frameworks like ASP.NET or Node.js. 

The standard architectural pattern consists of a **scheduled PowerShell task** that periodically writes an updated `index.html` file to a
directory served by a web server.

Method 1: Hosting via Windows IIS (Internet Information Services)
==================================================================

Windows IIS provides a robust, built-in option for hosting live PSWriteHTML dashboards internally with Active Directory Windows Authentication support.

1. **Install IIS Web Server:**

   Run PowerShell as Administrator:

   .. code-block:: powershell

      Install-WindowsFeature -Name Web-Server -IncludeManagementTools

2. **Configure Web Root Directory:**

   Create a dedicated folder to host your live report (e.g., ``C:\inetpub\wwwroot\Dashboards``).

3. **Configure Scheduled Auto-Refresh Pipeline:**

   Configure your PowerShell generation script to output directly to the IIS web directory and set the document to auto-refresh in the browser
   using custom header tags:

   .. code-block:: powershell

      # Target IIS Web Root
      $OutputPath = "C:\inetpub\wwwroot\Dashboards\index.html"

      # Auto-Refresh Meta Header (Refreshes browser every 300 seconds / 5 minutes)
      $CustomHeader = '<meta http-equiv="refresh" content="300">'

      New-HTML -Title "Live Infrastructure Monitor" -FilePath $OutputPath -CustomJavaScript $CustomHeader {
          New-HTMLTab -Name "Live Metrics" -IconSolid "heartbeat" {
              New-HTMLSection -HeaderText "Last Updated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" {
                  New-HTMLPanel {
                      New-HTMLTable -DataTable (Get-Service | Select-Object Name, DisplayName, Status -First 15)
                  }
              }
          }
      }

4. **Automate Update Frequency:**

   Register a Windows Scheduled Task to execute this generation script every 5 to 15 minutes. Users browsing
   to ``http://your-server-name/Dashboards/`` will always view the latest live snapshot.


Method 2: Publishing to Cloud Static Web Hosting
================================================

For cloud-managed environments, you can automatically upload the generated HTML dashboard to a static web container
(such as Azure Static Web Apps or AWS S3) using native PowerShell cloud modules:

.. code-block:: powershell

   # Generate Report Locally
   $LocalReport = "$env:TEMP\index.html"
   New-HTML -Title "Cloud Infrastructure Health" -FilePath $LocalReport { ... }

   # Upload to Azure Storage Blob ($web Static Website Container)
   # Requires Az.Storage module
   Set-AzStorageBlobContent -Container '$web' -File $LocalReport -Blob "index.html" -Context $StorageContext -Force


Method 3: Lightweight Hosting with Pode Framework
=================================================

If you want to serve live dashboards on a Windows machine without enabling full IIS features, you can use the lightweight
open-source **Pode** PowerShell web framework (see https://badgerati.github.io/Pode/latest/) to serve your PSWriteHTML
reports on demand:

.. code-block:: powershell

   Import-Module Pode

   Start-PodeServer {
       Add-PodeEndpoint -Address localhost -Port 8080 -Protocol Http
       
       # Serve static PSWriteHTML directory
       Use-PodeStatic -Path "C:\Reports\LiveDashboard"
   }


Publishing Best Practices
=========================

1. **Grant Service Account File Permissions:** Ensure the service account running your scheduled generation script has 
   explicit Modify/Write permissions to ``C:\inetpub\wwwroot\``.
2. **Understand Offline Resource Embedding:** When publishing in air-gapped networks, always use ``New-HTML -Offline``. 
   PSWriteHTML embeds and base64-encodes all required JavaScript libraries, fonts, and CSS directly inside the single
   ``index.html`` file. No secondary assets or subfolders are needed on the web server.
3. **Include "Last Refreshed" Timestamps:** Always render the current timestamp (``Get-Date``) in a section header or
   badge so users can immediately verify data freshness.

----

**Next Chapter:** :doc:`Chapter 11: Advanced Features, Optimization, and Troubleshooting <chapter-11>`
