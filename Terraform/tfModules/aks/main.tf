resource "azurerm_kubernetes_cluster" "aks" {
  dns_prefix          = var.name
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  node_resource_group = join("-",[var.name,"workernodes"])
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                  = "default"
    node_count            = var.default_node_pool.node_count
    vm_size               = var.default_node_pool.vm_size
    availability_zones    = var.default_node_pool.zones
    node_labels           = var.default_node_pool.node_labels
    max_pods              = var.default_node_pool.max_pods
    vnet_subnet_id        = var.vnet_subnet_id
    os_disk_size_gb       = var.default_node_pool.os_disk_size_gb
    orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version    
    enable_auto_scaling   = var.default_node_pool.cluster_auto_scaling
    min_count             = var.default_node_pool.cluster_auto_scaling_min_count
    max_count             = var.default_node_pool.cluster_auto_scaling_max_count
    tags                  = var.tags   
    enable_node_public_ip = var.default_node_pool.enable_node_public_ip 
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled                    = var.addons.oms_agent
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
    azure_policy {
      enabled = var.addons.azure_policy
    }
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      #admin_group_object_ids = [azuread_group.aks_administrators.object_id]
      admin_group_object_ids = ["7d3f73f3-a9fd-4afc-a91e-6adbfa568522"]
    }
  }

  network_profile {
    load_balancer_sku  = "standard"
    outbound_type      = "loadBalancer"
    network_plugin     = "azure"
    network_policy     = "calico"
    dns_service_ip     = "10.1.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.1.0.0/16"
  }
}

resource "azurerm_role_assignment" "aks_ra_oms" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.aks.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_ra_subnet" {
  scope                = var.vnet_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

resource "azurerm_role_assignment" "aks_ra_acrpull" {
  scope                = var.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_anp" {
  lifecycle {
    ignore_changes = [
      node_count
    ]
  }

  for_each = var.additional_node_pools
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.value.node_os == "Windows" ? substr(each.key, 0, 6) : substr(each.key, 0, 12)
  mode                  = "User"
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size
  availability_zones    = each.value.zones
  max_pods              = each.value.max_pods
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_type               = each.value.node_os
  node_taints           = each.value.node_taints
  vnet_subnet_id        = var.vnet_subnet_id
  enable_auto_scaling   = each.value.cluster_auto_scaling
  min_count             = each.value.cluster_auto_scaling_min_count
  max_count             = each.value.cluster_auto_scaling_max_count
}