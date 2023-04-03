provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "example-aks"

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7...+ZDw5/ chatgpt"
    }
  }

  agent_pool_profile {
    name            = "agentpool"
    count           = 3
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "SP_CLIENT_ID"
    client_secret = "SP_CLIENT_SECRET"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      client_app_id     = "AAD_CLIENT_APP_ID"
      server_app_id     = "AAD_SERVER_APP_ID"
      server_app_secret = "AAD_SERVER_APP_SECRET"
      tenant_id         = "AAD_TENANT_ID"
    }
  }
}
