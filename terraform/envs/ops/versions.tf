terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.29.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.29.0"
    }
  }
  cloud {
    organization = "astrafy"

    workspaces {
      name = "dbt"
    }
  }
}

provider "google" {
  # Configuration options
}

provider "google-beta" {
  # Configuration options
}
