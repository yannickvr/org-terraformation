module "org-terraformation" {
  source = "../"
  ous = {
    "management" = {}
    "apps"       = {}
    "dev" = {
      parent = "apps"
    }
    "shared" = {
      parent = "management"
      tags = {
        managedby = "org-terraformation"
      }
    }
  }
  accounts = {
    "management" = {
      email = "management@example.com"
      tags = {
        managedby = "org-terraformation"
      }
    }
    "dev" = {
      email  = "dev@example.com"
      parent = "dev"
    }
    "shared" = {
      email = "shared@example.com"
      parent = "shared"
    }
  }
}

