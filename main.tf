resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.location

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lifecycle_rule.value.action.storage_class
      }
      condition {
        age                = lifecycle_rule.value.condition.age
        num_newer_versions = lifecycle_rule.value.condition.num_newer_versions
        with_state         = lifecycle_rule.value.condition.with_state
      }
    }
  }
}
## cambio
resource "google_storage_bucket_iam_member" "members" {
  for_each = { for idx, m in var.iam_members : "${m.role}-${m.member}" => m }
  bucket   = google_storage_bucket.bucket.name
  role     = each.value.role
  member   = each.value.member
}
