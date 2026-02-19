module "bucket" {
  source      = "../.."
  bucket_name = "${local.name_prefix}-bucket-${random_id.suffix.hex}"
  location    = "EU"

  versioning_enabled = true

  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      }
      condition = {
        age = 30
      }
    },
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
      condition = {
        age = 7
      }
    }
  ]

  iam_members = [
    {
      role   = "roles/storage.objectViewer"
      member = "allUsers"
    }
  ]
}

resource "random_id" "suffix" {
  byte_length = 4
}
