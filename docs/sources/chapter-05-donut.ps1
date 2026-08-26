# Prepare data categories, as an array of PSCustomObjects with two properties: Status and Count
$Data = @(
    [PSCustomObject]@{ Status = 'Active';   Count = 142 }
    [PSCustomObject]@{ Status = 'Disabled'; Count = 18 }
    [PSCustomObject]@{ Status = 'Locked';   Count = 5 }
)

New-HTML -Title "Account Status Overview" -FilePath "AccountChart.html" -Show {
    New-HTMLTab -Name "Identity Summary" {
        New-HTMLSection -HeaderText "User Account States" {
            New-HTMLPanel {
                New-HTMLChart -Title "Account Breakdown" {
                    $Data | ForEach-Object {
                        New-ChartDonut -Name $_.Status -Value $_.Count
                    }
                }
            }
        }
    }
}