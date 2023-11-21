data "azurerm_image" "azure-image" {
  name                = "${var.packer_image_name}-${var.packer_image_version}"
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine_scale_set" "azure-vmss" {
  name                = "vmss-${local.naming_convention}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "${var.sku}_B1s"
  instances           = var.instances
  admin_username      = var.admin_username
  upgrade_mode        = var.upgrade_mode
  source_image_id     = data.azurerm_image.azure-image.id

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  # source_image_reference {
  #   publisher = var.image_publisher
  #   offer     = var.image_offer
  #   sku       = var.image_sku
  #   version   = var.image_version
  # }

  os_disk {
    storage_account_type = var.storage_account_type
    caching              = var.caching
  }

  data_disk {
    storage_account_type = var.storage_account_type
    caching              = var.caching
    create_option        = "Empty"
    lun                  = 10
    disk_size_gb         = 4
  }

  network_interface {
    name    = "vmss-network-interface-${local.naming_convention}"
    primary = true

    ip_configuration {
      name                                   = "vmss-internal-ip-${local.naming_convention}"
      primary                                = true
      subnet_id                              = azurerm_subnet.azure-subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.azure-backend-pool.id]
    }
  }

  lifecycle {
    ignore_changes = ["instances"]
  }
  
  custom_data = filebase64("custom_data.sh")

  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
  depends_on = [
    azurerm_virtual_network.azure-vnet
  ]
}

resource "azurerm_monitor_autoscale_setting" "azure-autoscaling" {
  name                = "autoscale-${local.naming_convention}"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.azure-vmss.id

  profile {
    name = "autoscale-profile-${local.naming_convention}"

    capacity {
      default = 10
      minimum = 2
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.azure-vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT1M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 80
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.azure-vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  # predictive {
  #   scale_mode      = "Enabled"
  #   look_ahead_time = "PT5M"
  # }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["classic.nct@gmail.com", "thanh.197pm31202@vanlanguni.vn"]
    }
  }

  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.azure-vmss
  ]
}

