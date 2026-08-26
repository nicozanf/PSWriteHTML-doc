New-HTML -Title "World Map" -FilePath "WorldMap.html" -Online -Show {
    New-HTMLSection -HeaderText "World Countries" {
        New-HTMLPanel {
            New-HTMLMap -Map "World_Countries" -AnchorName "WorldMap" -AreaTitle "Selected Countries" -ShowAreaLegend -FillColor "#DCEAF7" -StrokeColor "#536878" -StrokeWidth 1 {
                New-MapArea -Area "US" -Value 1 -Tooltip { "United States" }
                New-MapArea -Area "CA" -Value 2 -Tooltip { "Canada" }
                New-MapArea -Area "AU" -Value 3 -Tooltip { "Australia" }
                New-MapArea -Area "IT" -Value 4 -Tooltip { "Italy" }

                New-MapLegendSlice -Type area -Label "USA" -MinimumValue 1 -MaximumValue 1 -FillColor "#E74C3C"
                New-MapLegendSlice -Type area -Label "Canada" -MinimumValue 2 -MaximumValue 2 -FillColor "#3498DB"
                New-MapLegendSlice -Type area -Label "Australia" -MinimumValue 3 -MaximumValue 3 -FillColor "#2ECC71"
                New-MapLegendSlice -Type area -Label "Italy" -MinimumValue 4 -MaximumValue 4 -FillColor "#F1C40F"
            }
        }
    }
}
