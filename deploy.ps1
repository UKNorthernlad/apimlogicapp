# Create a new resource group
az group create --name demo2 --location "east us"

# Create a new API Management instance
az apim create --name integrationdemo99 --resource-group demo2 --publisher-name Contoso --publisher-email admin@contoso.com --no-wait

# sleep for at least 1 hour.

# Create a new API
az apim api create --service-name integrationdemo99 -g demo2 --api-id integrationapp --path '/integrationhub' --display-name 'Integration App'


az sql server create --name "myserver99" --resource-group "demo2" --location "east us" --admin-user "databaseadmin" --admin-password "XXXXXX123YYYY!!!"
az sql server firewall-rule create --resource-group "demo2" --server "myserver99" -n AllowYourIp --start-ip-address "0.0.0.0" --end-ip-address "0.0.0.0"
az sql db create --resource-group "demo2" --server "myserver99" --name "integrationhub" --edition GeneralPurpose --family Gen5 --capacity 2 --zone-redundant true

# TODO: Added schema to SQL database.

# There is no obvious way to create a Version 1 SQL Connection object via PowerShell/Azure CLI, so instead its being created using an ARM template.
# TODO: find out if this is really true or wether V2 connections can be used instead.
az deployment group create --resource-group "demo2" --template-file .\apiconnection.json

# A logic app can be created using Powershell/Azure CLI or ARM templates.
# Here we will use ARM templates as we can include the JSON definition of the workflow directly inside the ARM template.
az deployment group create --resource-group "demo2" --template-file .\logicapp.json







