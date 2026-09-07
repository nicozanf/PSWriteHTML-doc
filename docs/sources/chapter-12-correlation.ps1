$Data = @(
    [PSCustomObject]@{ Name = 'Alpha'; Value = 12 }
    [PSCustomObject]@{ Name = 'Beta';  Value = 18 }
    [PSCustomObject]@{ Name = 'Gamma'; Value = 9 }
)

$TableID = 'ChartTable'

New-HTML -TitleText 'Chart and Table' -FilePath "$PWD\chart-table.html" -Online -Show {
    New-HTMLTable -DataTable $Data -DataTableID $TableID -DataStore HTML

    New-HTMLChart -Title 'Values by Name' {
        foreach ($Item in $Data) {
            New-ChartPie -Name $Item.Name -Value $Item.Value
        }

        New-ChartEvent -DataTableID $TableID -ColumnID 0
    }
}
