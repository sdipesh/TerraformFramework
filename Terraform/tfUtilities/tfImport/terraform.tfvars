#Azure source environment to import resource
subscription_id = "48aef7f2-5079-4f72-8444-06db693ee493"
client_id       = "6a3c653a-0039-45db-842b-e69efb21e20f"
client_secret   = ""
tenant_id       = "e5d03222-fcf5-4f73-802c-ad7125a5fb6b"

#terraform backend config vars
tfInitiative = "bim"
tfProject = "tf"
tfEnvironment = "tst"
tfbackendAzureRmContainerName = "tst"

#project specific vars
ptags = {
  "CreatedBy"   = "terraform",
  "environment" = "test",
  "application" = "Soleil"
}
pInitiative = "bim"
pProject = "soleil"
pEnvironment = "tst"
pRegion = "cac"