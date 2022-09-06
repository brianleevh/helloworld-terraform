terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.77.7"
    }
  }
}

provider "tencentcloud" {
  # Configuration options
  region = "ap-singapore"
}