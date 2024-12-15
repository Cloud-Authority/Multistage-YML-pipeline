# Variables
$ResourceGroup = "rg-siddhesh"
$Location = "eastus2"
$AppServicePlan = "asp-siddhesh99898"
$WebAppName = "siddhesh-gh-classic989"
$Runtime = "dotnet:6"

# Check if Resource Group exists
if (-not (az group exists --name $ResourceGroup | ConvertFrom-Json)) {
    Write-Output "Resource group $ResourceGroup does not exist. Creating..."
    az group create --name $ResourceGroup --location $Location
} else {
    Write-Output "Resource group $ResourceGroup exists."
}

# Check if App Service Plan exists
if (-not (az appservice plan show --name $AppServicePlan --resource-group $ResourceGroup -ErrorAction SilentlyContinue)) {
    Write-Output "App Service Plan $AppServicePlan does not exist. Creating..."
    az appservice plan create --name $AppServicePlan --resource-group $ResourceGroup --sku B1 --location $Location
} else {
    Write-Output "App Service Plan $AppServicePlan exists."
}

# Check if Web App exists
if (-not (az webapp show --name $WebAppName --resource-group $ResourceGroup -ErrorAction SilentlyContinue)) {
    Write-Output "Web App $WebAppName does not exist. Creating..."
    az webapp create --name $WebAppName --resource-group $ResourceGroup --plan $AppServicePlan --runtime $Runtime
} else {
    Write-Output "Web App $WebAppName exists."
}
