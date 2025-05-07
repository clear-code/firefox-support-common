variable "namespace" {
    description = "Prefix example- and the sku type to use as a part of environment name"
    type        = string
    default     = "example-win10-ent-22H2"
}
variable "windows-password" {
    description = "Windows login password, whose value is in terraform.tfvars"
    type        = string
}

variable "offer" {
    description = "value for storage_image_reference"
    type        = string
    default     = "Windows-10"
}
variable "publisher" {
    description = "value for storage_image_reference"
    type        = string
    default     = "MicrosoftWindowsDesktop"
}
variable "sku" {
    description = "value for storage_image_reference"
    type        = string
    default     = "win10-22h2-ent"
}
