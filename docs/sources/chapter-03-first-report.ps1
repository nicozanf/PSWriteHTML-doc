   New-HTML -Title "My First Report" -FilePath "C:\Temp\Dashboard.html" -Show {
      New-HTMLTab -Name "Overview" {
         New-HTMLSection -HeaderText "System Overview" {
               New-HTMLPanel {
                  New-HTMLText -Text "Welcome to the automated system dashboard."
               }
         }
      }
   }