# Create a new resource group
az group create --name demo2 --location "east us"

# Create a new API Management instance
az apim create --name integrationdemo99 --resource-group demo2 --publisher-name Contoso --publisher-email admin@contoso.com --no-wait

# sleep for at least 1 hour.

# Add an APIM App in AAD for the OIDC authentication - https://learn.microsoft.com/en-us/azure/healthcare-apis/register-application-cli-rest
az ad app create --display-name apimauth2 --identifier-uris "api://ourcompany.com/apiauth"

# Import a copy of the backend API.
# This file was created by manually exporting it via the portal.
az apim api import -g demo2 --service-name integrationdemo99 --path '/integrationhub' --specification-path .\apiDefinition.json --specification-format OpenApiJson

# Create SQL Server
az sql server create --name "myserver99" --resource-group "demo2" --location "east us" --admin-user "databaseadmin" --admin-password "XXXXXX123YYYY!!!"
az sql db create --resource-group "demo2" --server "myserver99" --name "integrationhub" --edition GeneralPurpose --family Gen5 --capacity 2 --zone-redundant true
az sql server firewall-rule create --resource-group "demo2" --server "myserver99" -n AllowYourIp --start-ip-address "0.0.0.0" --end-ip-address "255.255.255.255"

# Add schema to SQL database.
sqlcmd -S myserver99.database.windows.net -d integrationhub -i sqlcommand.txt -U databaseadmin -P XXXXXX123YYYY!!!

# There is no obvious way to create a Version 1 SQL Connection object via PowerShell/Azure CLI, instead create it using an ARM template.
# TODO: Find out if this is really true or if V2 connections can be created from the command line.
az deployment group create --resource-group "demo2" --template-file .\apiconnection.json

# A logic app can be created using Powershell/Azure CLI or ARM templates.
# Here we will use an ARM template as we can include the JSON definition of the workflow directly inside the ARM template.
az deployment group create --resource-group "demo2" --template-file .\logicapp.json

# Import the API policy into APIM.
# TODO: This will eventually be done automatically as part of the setup
# Manually copy the APIM Policies into place 
# 1. Open "apiPolicies - all operations.xml".
# 2. Replace the AAD Tenant GUID into lines 17 & 22.
# 3. 
# 4. Replace the backend URL in line 29.
# 5. Open the APIM resource and click on the "IntegrationPOC" API which was imported previously.
# 6. From the "Inbound processing" box, click the Polices </> button.
# 7. Replace the entire contents with the policy from apiPolicies.xml

# Import for getIntegration policy
# 8. Open "apiPolicies - getIntegration.xml".
# 9. Replace the values for the GUIDs as previous.
# 10. Update line 27 with the GUID of an AAD group that the user must be a member of to call this particular endpoint.
# 11. Update line 16 with the URL of the backend endpoint copies from the logic app HTTP trigger. Remember replace the several instances of & in the backend url with &amp; sequence.

# Manually disable the requirement for a subscription
# 1. In the "IntegrationPOC" API, click on the "Settings" tab.
# 2. Under "Subscription", un-check the "Subscription required" box.





