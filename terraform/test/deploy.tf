resource "kubernetes_deployment" "deploymentnginx-1" {
  metadata {
    name = "deploymentnginx-1"
    labels = {
      App = "nginx"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "nginx"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx-container"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}
