locals {
  name_suffix = "${random_pet.suffix.id}"
  secret_id_1 = "secret1"
  secret_id_2 = "secret2"
  
}

resource "random_pet" "suffix" {
  length = 2
}

provider "google" {
  region = "us-central1"
  zone   = "us-central1-c"
}


#################################################


module "job" {
  source = "./job_module"
  secret_id = local.secret_id_1  # replace this with local.secret_id_2 to reproduce the error
  name_suffix = local.name_suffix
}

resource "google_secret_manager_secret_iam_member" "secret_access" {
  secret_id = local.secret_id_1 # replace this with local.secret_id_2 to reproduce the error
  role      = "roles/secretmanager.secretAccessor"
  member    =  "serviceAccount:${module.job.sa_email}"
}

