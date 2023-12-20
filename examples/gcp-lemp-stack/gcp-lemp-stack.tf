# gcp provider with a backend stored in GCS
terraform {
  backend "gcs" {
    bucket = "blackrainbow-zero-terraform-state"
    prefix = "gcp-lemp-stack"
  }
}

#  Set the GCP project
provider "google" {
  project = "blackrainbow-zero"
  region  = "us-central1"
  zone    = "us-central1-a"
}