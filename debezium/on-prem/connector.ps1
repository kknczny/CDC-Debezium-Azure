# Add Connector
$JSON = Get-Content '..\register-sqlserver-eh.json' | Out-String
Invoke-RestMethod http://localhost:8083/connectors/ -Method POST -Body $JSON -ContentType "application/json"     

# List Connectors
Invoke-RestMethod http://localhost:8083/connectors

# Delete Connectors
Invoke-RestMethod http://localhost:8083/connectors/wwi -Method DELETE