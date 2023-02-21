variable "secret_id" {type = string}
variable "name_suffix" {type = string}

resource "google_service_account" "sa" {
  account_id = "cloudrun-job-${var.name_suffix}"
  description = "Runtime account for Cloudrun Job"
}

resource "google_cloud_run_v2_job" "default" {
  name     = "cloudrun-job-${var.name_suffix}"
  location = "us-central1"
  launch_stage = "BETA"
  
  template {
    template {
      service_account = google_service_account.sa.email
      max_retries = 0
      volumes {
        name = "a-volume"
        secret {
          secret = var.secret_id
          default_mode = 292 # 0444
          items {
            version = "latest"
            path = "my-secret"
            mode = 256 # 0400
          }
        }
      }
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        volume_mounts {
          name = "a-volume"
          mount_path = "/secrets"
        }
      }
    }
  }
}

output "sa_email" {
  value = google_service_account.sa.email
}