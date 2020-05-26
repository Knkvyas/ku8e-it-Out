resource "kubernetes_deployment" "example" {
  metadata {
    name = "node-deployment"
    labels = {
      app = "node-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "node-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "node-app"
        }
      }

      spec {
        container {
          image = "image_name/myapp:latest"
          name  = "ku8e-container"
      }
    }
  }
}
}
resource "kubernetes_service" "example" {
  metadata {
    name = "node-service"
  }
  spec {
    selector = {
      app = "node-app"
    }
    port {
      port        = 8000
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}



output "lb_ip" {
  value = "${kubernetes_service.example.load_balancer_ingress.0.hostname}"
}
