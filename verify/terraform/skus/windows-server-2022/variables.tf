variable "namespace" {
    description = "Prefix example- and the sku type to use as a part of environment name"
    type        = string
    default     = "example-windows-server-2022"
}
variable "windows-password" {
    description = "Windows login password, whose value is in terraform.tfvars"
    type        = string
}

variable "offer" {
    description = "value for storage_image_reference"
    type        = string
    default     = "WindowsServer"
}
variable "publisher" {
    description = "value for storage_image_reference"
    type        = string
    default     = "MicrosoftWindowsServer"
}
variable "sku" {
    description = "value for storage_image_reference"
    type        = string
    default     = "2022-Datacenter"
}
