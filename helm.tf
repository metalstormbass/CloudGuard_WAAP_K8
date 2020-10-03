#Provider for Helm
provider "helm" {
    kubernetes {
    host                   = azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.cluster_ca_certificate)
    load_config_file = false
  }
}


resource "helm_release" "cp_waap_helm" {
    name  = "cp_waap_helm"
    chart = "https://github.com/metalstormbass/cp_waap_helm/blob/main/CP_WAAP_Helm/CP_WAAP_Helm-0.1.0.tgz?raw=true"
    namespace = kubernetes_namespace.vulnk8_namespace.metadata.0.name
    version    = "3.3.0"
    set {
    name  = "token"
    value = var.token
  }
}
