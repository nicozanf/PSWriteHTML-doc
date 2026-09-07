# 1. Define Corporate Dark Palette CSS
$DarkThemeCSS = @"
    body {
        background-color: #121212 !important;
        color: #e0e0e0 !important;
    }
    .card, .panel {
        background-color: #1e1e1e !important;
        border: 1px solid #333333 !important;
        color: #ffffff !important;
    }
    .table {
        color: #e0e0e0 !important;
        background-color: #1e1e1e !important;
    }
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #252525 !important;
    }
    .tabsWrapper > .tabsSlimmer > div[data-tabs="true"] > div:first-child::before {
        content: "";
        display: inline-block;
        width: 60px;
        height: 60px;
        margin-right: 8px;
        background-image: url("https://avatars.githubusercontent.com/u/15376314?s=60&v=4");
        background-size: cover;
        background-position: center;
        vertical-align: middle;
    }
"@

# 2. Collect System Sample Data
$Data = Get-Process | Select-Object -First 10 ID, ProcessName, CPU, WorkingSet

# 3. Generate Dark Mode Report
New-HTML -TitleText "Dark Mode Enterprise Report" `
        -FilePath "$env:USERPROFILE\Desktop\DarkReport.html" -Show {

    Add-HTMLStyle -Placement Header -Content $DarkThemeCSS

    New-HTMLTab -Name "SYSTEM METRICS" -IconSolid "chart-bar" {
        New-HTMLSection -HeaderText "Resource Monitoring" `
                        -HeaderBackGroundColor "#000000" `
                        -HeaderTextColor "#00E676" {
            New-HTMLPanel {
                New-HTMLText -Text "Top Processes"
                New-HTMLTable -DataTable $Data -Filtering
            }
        }
    }
}

