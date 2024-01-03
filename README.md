# Basic Integration Application on Azure
This is a guide to setting up Azure API Management (APIM) protected by Azure AD authentication (AAD Auth) with API requests being forwared to a Logic App backend. The data is then stored in a CosmosDB or SQL DB. Each API operation is configured with its own unique set of permissions, allowing clients to call only those API endpoints for which they have the rights.

## Purpose
The primary aim of this repository is to teach new developers how the various Azure resources can be connected together to build an integration application and to understand the solution "under the covers". 
 
## Current state of the guide.
Currently documented are the steps to setup the demonstration using a mixture of Azure CLI & ARM templates (plus a few manual bits here and there).

## Roadmap
Eventually there will be:
 * Fully documented manual steps for deploying the various Azure resources to build a simple end-to-end integration application.
 * Full scripted ARM/Bicep/AzureCLI deployment so that the whole application can be easily setup for teaching and demonstration purposes.
