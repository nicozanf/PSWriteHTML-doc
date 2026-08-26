New-HTML -Title "Executive Security Summary" -Show {
    New-HTMLTab -Name "Overview" -IconSolid "user-shield" {
        
        # Section wrapping InfoCards with Comfortable spacing
        New-HTMLSection -HeaderText "Key Security Metrics" -Density Comfortable {
            
            New-HTMLInfoCard -Title "Identity Protection" `
                            -Number "Active" `
                            -Subtitle "0 Risky Users Flagged" `
                            -Icon "Shield"  `
                            -IconColor '#0078d4'

            New-HTMLInfoCard -Title "Failed Logins (24h)" `
                            -Number "142" `
                            -Subtitle "Within expected threshold" `
                            -Icon "Error" `
                            -IconColor '#d9534f'

            New-HTMLInfoCard -Title "MFA Enrollment" `
                            -Number "98.4%" `
                            -Subtitle "+1.2% from last week" `
                            -Icon "Report" `
                            -IconColor '#5cb85c'
        }
    }
}