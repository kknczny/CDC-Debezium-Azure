# Add Connector
cd debezium\on-prem
$JSON = Get-Content '..\register-sqlserver-eh.json' | Out-String
Invoke-RestMethod http://localhost:8083/connectors/ -Method POST -Body $JSON -ContentType "application/json"     

# List Connectors
Invoke-RestMethod http://localhost:8083/connectors

# Connector Status
Invoke-RestMethod http://localhost:8083/connectors/wwi-00/status

# Delete Connectors
Invoke-RestMethod http://localhost:8083/connectors/wwi-00 -Method DELETE