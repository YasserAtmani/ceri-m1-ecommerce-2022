terraform {
  cloud {
    organization = "pinkzebra"

    workspaces {
      name = "ecommerce1"
    }
  }
}

data "google_secret_manager_secret" "address" {
  secret_id = "mysql/address"
}

provider "google" {
  project = "ceri-m1-ecommerce-2022"
  region  = "europe-west1"
}

resource "google_cloud_run_service" "back" {
  name     = "cloud-run-backend"
  location = "europe-west1"

  template {
    spec {
      service_account_name = "terraform-pinkzebra@ceri-m1-ecommerce-2022.iam.gserviceaccount.com"
      containers {
        image = "europe-west1-docker.pkg.dev/ceri-m1-ecommerce-2022/pinkzebra/backend:latest"
        env {
          name = "DATABASE_ADDRESS"
          value_from {
            secret_key_ref {
              name = "mysql-address" # data.google_secret_manager_secret.address.secret_id
              key  = "latest"
            }
          }
        }
      }
    }
  }
}

resource "google_cloud_run_service" "front" {
  name     = "cloud-run-frontend"
  location = "europe-west1"


  template {
    spec {
      service_account_name = "terraform-pinkzebra@ceri-m1-ecommerce-2022.iam.gserviceaccount.com"
      containers {
        image = "europe-west1-docker.pkg.dev/ceri-m1-ecommerce-2022/pinkzebra/frontend:latest"
      }
    }
  }
}

output "url" {
  value = google_cloud_run_service.front.status[0].url
}
