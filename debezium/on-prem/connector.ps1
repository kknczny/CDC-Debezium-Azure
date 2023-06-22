# Add Connector
cd debezium\on-prem
$JSON = Get-Content '..\connector_config_orders.json' | Out-String
$JSON = Get-Content '..\connector_config_stock.json' | Out-String


Invoke-RestMethod http://localhost:8083/connectors/ -Method POST -Body $JSON -ContentType "application/json"     

# List Connectors
Invoke-RestMethod http://localhost:8083/connectors

# Connector Status
Invoke-RestMethod http://localhost:8083/connectors/orders-00/status
Invoke-RestMethod http://localhost:8083/connectors/stock-00/status

# Delete Connectors
Invoke-RestMethod http://localhost:8083/connectors/orders-00 -Method DELETE
Invoke-RestMethod http://localhost:8083/connectors/stock-00 -Method DELETE