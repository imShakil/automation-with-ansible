terraform {
  backend "s3" {
    bucket       = "imshakil-bkt-tfstate"
    key          = "miniFinance-terraform.tfstate"
    use_lockfile = true
    region       = "ap-southeast-1"
  }
}
