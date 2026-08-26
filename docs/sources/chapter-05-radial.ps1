New-HTML -Title "SLA Dashboard" -FilePath "SLA-Chart.html" -Show {
   New-HTMLChart -Title "SLA Compliance" -Height 350 {
       New-ChartRadial -Name "SLA Compliance" -Value 92 -Color '#43A047'
   }
}
