module "rg-infra" {
  source                  = "./RG"
  var_resource_group_name = var.var_resource_group_name
  location                = var.location
}
module "rg-aks-infra" {
   source                  = "./RG"
   depends_on = [ module.rg-infra ]
  var_resource_group_name = var.var_aks_resource_group_name
  location                = var.location
}
module "acr-infra" {
  source           = "./ACR"
  depends_on = [ module.rg-infra ]
  var_acr_rg_name  = module.rg-infra.out_rg_name
  var_acr_location = module.rg-infra.out_rg_location
  var_acr_name     = var.var_acr_name
  var_sku          = var.var_sku

}
module "aks_infra" {
  depends_on = [ module.acr-infra ]
  source = "./AKS"
  var_dns_prefix     = var.var_dns_prefix
  var_aks_name_space = var.var_aks_name_space
  var_aks_name       = var.var_aks_name
  var_vm_size        = var.var_vm_size
  var_client_id      = var.var_client_id
  var_client_secret  = var.var_client_secret
  var_aks_resource_group_name = module.rg-aks-infra.out_rg_name
  location = module.rg-aks-infra.out_rg_location
}


resource "null_resource" "execute_dokerbuild_script_1" {
  depends_on = [module.acr-infra,module.aks_infra]
  provisioner "local-exec" {
    command = <<-EOT
      az login --service-principal -u ${var.var_client_id} --tenant ${var.var_tenant_id} -p ${var.var_client_secret}

      docker login -u ${module.acr-infra.admin_username} -p ${module.acr-infra.admin_password} ${module.acr-infra.login_server}
      cd //home//bharath//CGI-Demo
      mvn clean install
      docker build -f //home//bharath//CGI-Demo//Dockerfile -t cgi-demo:latest .
      docker tag cgi-demo:latest ${module.acr-infra.login_server}/cgi-demo:latest
      docker push ${module.acr-infra.login_server}/cgi-demo:latest
    EOT
  }
}


resource "null_resource" "execute_aks_script_1" {
  depends_on = [null_resource.execute_dokerbuild_script_1]
  provisioner "local-exec" {
    command = <<-EOT
      az aks get-credentials --resource-group ${var.var_resource_group_name} --name ${var.var_aks_name}
      kubectl create var_aks_name_space ${var.var_aks_name_space}
      kubectl get ns

      kubectl apply -f deployment.yml -n ${var.var_aks_name_space}
      kubectl apply -f service.yml -n ${var.var_aks_name_space}

      kubectl get service -n ${var.var_aks_name_space}
    EOT
  }
}
