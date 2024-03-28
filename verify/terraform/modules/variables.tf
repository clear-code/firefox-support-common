variable "namespace" {}
variable "windows-username" {
    type        = string
    default     = "clearcode"
}
variable "windows-password" {}
variable "windows-language-pack-url" {
    type        = string
    default     = ""
}
variable "firefox-policy-template-url" {
    type        = string
    default     = "https://github.com/mozilla/policy-templates/releases/download/v4.12/policy_templates_v4.12.zip"
}
variable "thunderbird-policy-template-url" {
    type        = string
    default     = "https://github.com/thundernest/policy-templates/archive/refs/heads/master.zip"
}
variable "flash-installer-url" {
    type        = string
    default     = ""
}
variable "hookdate-download-url" {
    type        = string
    default     = ""
}
variable "debugview-download-url" {
    type        = string
    default     = ""
}
variable "old-ie-download-url" {
    type        = string
    default     = ""
}
variable "download-user" {
    type        = string
    default     = "browser-verify"
}
variable "download-token" {
    type        = string
    default     = ""
}
