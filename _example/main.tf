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
      email  = "shared@example.com"
      parent = "shared"
    }
  }
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
  delegated_administrators = {
    "cloudtrail" = {
      account = "shared"
    }
    "inspector2" = {
      account = "shared"
    }
    "securityhub" = {
      account = "shared"
    }
  }
}

