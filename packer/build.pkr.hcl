build {
  sources = ["source.azure-arm.vm"]

  provisioner "shell" {
    execute_command  = local.execute_command
    scripts          = ["scripts/install_nginx.sh"]
    inline_shebang   = "/bin/sh -x"
  }

  provisioner "file" {
    source = "nginx-html/nginx-html.tar"
    destination = "/tmp/nginx-html.tar"
  }

  provisioner "shell" {
    environment_vars = ["ACCOUNTNAME=${var.azure_tags.owner}"]
    scripts          = ["scripts/update_nginx_page.sh"]
    inline_shebang   = "/bin/sh -x"
  }
}