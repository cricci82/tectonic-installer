variable "source_url_list" {
  type        = "string"
  description = "s3 location for ignition"
}

variable "verification" {
  type        = "string"
  description = "sha512 hash of igntion contents"
}

variable "instance_count" {
  default = "1"
}

variable "bucket" {
  type = "string"
}

variable "keys" {
  type = "list"
}

variable "content" {
  type = "list"
}