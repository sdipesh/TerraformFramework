resource "azuread_application" "azuread_app" {
    display_name                = var.display_name
    reply_urls                  = var.reply_urls
}