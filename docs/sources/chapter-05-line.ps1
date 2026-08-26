   $CpuHistory = @(
       [PSCustomObject]@{ Day = 'Monday';    Usage = 42 }
       [PSCustomObject]@{ Day = 'Tuesday';   Usage = 58 }
       [PSCustomObject]@{ Day = 'Wednesday'; Usage = 47 }
   )

New-HTML -Title "CPU Usage Dashboard" -FilePath "CPUChart.html" -Show {
   New-HTMLChart -Title "CPU Usage History" -Height 350 {
       New-ChartAxisX -Names @($CpuHistory | ForEach-Object { $_.Day })
       New-ChartLine -Name "CPU Usage (%)" `
                     -Value @($CpuHistory | ForEach-Object { $_.Usage }) `
                     -Color '#1976D2' -Curve smooth
   }
}