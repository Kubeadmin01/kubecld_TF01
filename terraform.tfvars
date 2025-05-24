environment = "Kubedev_iac"
allowed_locations = ["West Europe", "North Europe", "East US"]
network_config = ["10.0.0.0/16", "10.0.1.0", "10.0.2.0", "10.0.3.0", "10.0.4.0","10.0.5.0","10.0.6.0",24]
azurerm_subnet_name = [ "websn","appsn","dbsn","aspsn","akssn","pesn" ]
storage_account_location = "West Europe"
random_prefix = "kube"