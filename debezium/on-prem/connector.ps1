# Add Connector
cd debezium\on-prem
$JSON = Get-Content '..\register-sqlserver-eh.json' | Out-String
Invoke-RestMethod http://localhost:8083/connectors/ -Method POST -Body $JSON -ContentType "application/json"     

# List Connectors
Invoke-RestMethod http://localhost:8083/connectors

# Connector Status
Invoke-RestMethod http://localhost:8083/connectors/wwi/status
Invoke-RestMethod http://localhost:8083/connectors/wwi2/status

# Delete Connectors
Invoke-RestMethod http://localhost:8083/connectors/wwi -Method DELETE
Invoke-RestMethod http://localhost:8083/connectors/wwi2 -Method DELETE