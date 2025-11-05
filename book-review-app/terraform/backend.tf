terraform {
  backend "s3" {
    bucket       = "imshakil-bkt-tfstate"
    key          = "bkreview-terraform.tfstate"
    use_lockfile = true
    region       = "ap-southeast-1"
  }
}
