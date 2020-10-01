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

resource "helm_release" "nginx_ingress" {
    name      = "ingress-nginx"
    chart     = "ingress-nginx/ingress-nginx"
    repository      = "https://kubernetes-charts.storage.googleapis.com/"
    namespace = kubernetes_namespace.vulnk8_namespace.metadata.0.name
}
