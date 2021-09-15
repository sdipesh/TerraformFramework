#terraform backend config vars
tfRegion                      = "cac"
tfProject                     = "tf"
tfbackendAzureRmContainerName = "dev"

#project specific vars
ptags = {
  "CreatedBy"     = "terraform",
  "Environment"   = "dev",
  "Application"   = "ivr",
  "BusinessUnit"  = "Bank"
}
pInitiative   = "bank"
pProject      = "ivr"
pEnvironment  = "dev"
auth_client_id_dev = "b9b98ee7-b489-4bd5-a0cb-f92c6c21bcb7"
auth_client_id_qa = "b9b98ee7-b489-4bd5-a0cb-f92c6c21bcb7"
auth_client_id_uat = "b9b98ee7-b489-4bd5-a0cb-f92c6c21bcb7"
tenant_id = "a1a2578a-8fd3-4595-bb18-7d17df8944b0"
app_service_plan_tier = "PremiumV2"
app_service_plan_size = "P1v2"
#key_vault_id = "/subscriptions/098a0539-137d-4b66-b307-129fc333c1a2/resourceGroups/bank-rg-eastus2/providers/Microsoft.KeyVault/vaults/bank-kv-eastus2-dev"
secret_permissions = ["get","list"]