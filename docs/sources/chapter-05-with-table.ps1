
# 1. Collect Local Service Data
$Services = Get-Service
$GroupedServices = $Services | Group-Object Status | Select-Object @{N='Status';E={$_.Name}}, Count

# 2. Build Integrated Report
New-HTML -Title "Services Status & Breakdown" -FilePath "$env:USERPROFILE\Desktop\ServicesReport.html" -Show {
    New-HTMLTab -Name "Service Metrics" {

        # Top Row: Chart Summary
        New-HTMLSection -HeaderText "Status Summary Chart" {
            New-HTMLPanel {
                New-HTMLChart -Title "Running vs Stopped Services" -Height 300 {
                    $GroupedServices | ForEach-Object {
                        $Color = if ($_.Status -eq 'Running') { '#4CAF50' } else { '#F44336' }
                        New-ChartPie -Name $_.Status -Value $_.Count -Color $Color
                    }
                }
            }
        }

        # Bottom Row: Granular Data Grid
        New-HTMLSection -HeaderText "Detailed Service Records" {
            New-HTMLPanel {
                New-HTMLTable -DataTable ($Services | Select-Object Name, DisplayName, Status, StartType -First 25) {
                    New-TableCondition -Name 'Status' -ComparisonType string -Operator eq -Value 'Running' -BackgroundColor '#E8F5E9' -Color '#2E7D32'
                    New-TableCondition -Name 'Status' -ComparisonType string -Operator eq -Value 'Stopped' -BackgroundColor '#FFEBEE' -Color '#C62828'
                }
            }
        }
    }
}