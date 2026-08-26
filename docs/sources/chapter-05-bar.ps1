$DiskData = @(
    [PSCustomObject]@{ Drive = 'C:'; UsedGB = 120; FreeGB = 30 }
    [PSCustomObject]@{ Drive = 'D:'; UsedGB = 450; FreeGB = 50 }
    [PSCustomObject]@{ Drive = 'E:'; UsedGB = 200; FreeGB = 300 }
)

New-HTML -Title "Disk Capacity Dashboard" -FilePath "DiskChart.html" -Show {
    New-HTMLTab -Name "Storage" {
        New-HTMLSection -HeaderText "Drive Capacity Distribution (GB)" {
            New-HTMLPanel {
                New-HTMLChart -Title "Used vs Free Space" -Height 350 {
                    New-ChartBarOptions -Vertical
                    New-ChartLegend -Name 'Used Space (GB)', 'Free Space (GB)' `
                                    -Color '#E53935', '#43A047'

                    foreach ($Disk in $DiskData) {
                        New-ChartBar -Name $Disk.Drive `
                                    -Value $Disk.UsedGB, $Disk.FreeGB
                    }
                }
            }
        }
    }
}