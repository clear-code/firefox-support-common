variable "namespace" {
    description = "Prefix example- and the sku type to use as a part of environment name"
    type        = string
    default     = "example-win11-ent-23H2"
}
variable "windows-password" {
    description = "Windows login password, whose value is in terraform.tfvars"
    type        = string
}
