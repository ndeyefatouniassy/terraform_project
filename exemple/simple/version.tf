/*terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.79.0" # Version 5.x uniquement
    }
  }
}
