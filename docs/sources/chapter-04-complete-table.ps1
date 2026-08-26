   # 1. Prepare Data
   $Services = Get-Service | Select-Object Name, DisplayName, Status, StartType | Select-Object -First 20

   # 2. Build Document
   New-HTML -Title "Infrastructure Audit" -FilePath "$env:USERPROFILE\Desktop\AuditReport.html" -Show {
       New-HTMLTab -Name "System Audit" {
           New-HTMLSection -HeaderText "Active Services State" {
               New-HTMLPanel {
                   New-HTMLTable -DataTable $Services -Buttons 'excelHtml5', 'pdfHtml5', 'columnVisibility' -PagingLength 10 {
                       
                       # Center header and adjust title
                       New-TableContent -ColumnName 'Status' -Alignment center
                       
                       # Formatting Rules
                       New-TableCondition -Name 'Status' -ComparisonType string -Operator eq -Value 'Running' -BackgroundColor '#C8E6C9' -Color '#2E7D32'
                       New-TableCondition -Name 'Status' -ComparisonType string -Operator eq -Value 'Stopped' -BackgroundColor '#FFCDD2' -Color '#C62828'
                   }
               }
           }
       }
   }