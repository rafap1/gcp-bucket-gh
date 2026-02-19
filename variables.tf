variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "location" {
  description = "Location of the GCS bucket"
  type        = string
  default     = "EU"
}

variable "iam_members" {
  description = "List of IAM members with their roles"
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules"
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = object({
      age                = optional(number)
      num_newer_versions = optional(number)
      with_state         = optional(string)
    })
  }))
  default = []
}
