variable "front-end-s3-bucket-name" {
  description = "CM Front End"
}

variable "website_map" {
  description = "Map of static website hosting"
}

variable "force_destroy" {
  description = "Whether to forcefully destroy the bucket when it contains objects"
  type        = bool
  default     = true
}
