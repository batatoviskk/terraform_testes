#!/bin/bash
set -eu
 AZENV=$1
 AZTEAM=$2
 
URL=$(az databricks workspace list --subscription  $AZENV-BI-Estruturante --resource-group rg-gib$AZENV-team-$AZTEAM --query "[].{workspaceUrl: workspaceUrl}"  -o tsv)

if [ -z "$URL" ]; then echo "Url workskpace incorreta";
else
  echo "Obtendo token para workskpace: https://$URL"
  token_response=$(az account get-access-token -o json --resource 2ff814a6-3304-4ab8-85cb-cd0e6f879c1d)
  echo "Gravando localmente token para workskpace: https://$URL"
  export DATABRICKS_AAD_TOKEN=$(jq .accessToken -r <<< "$token_response")
  $(databricks configure --host "https://$URL" --aad-token)
  echo "Gravado configuracao client para workskpace: https://$URL"
  databricks secrets list-scopes
fi
