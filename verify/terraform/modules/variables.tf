variable "namespace" {
    type        = string
    default     = ""
    # var.namespace の末尾は skuタイプ名 である
    #  プレフィックス'example-'を持つ場合もある
    validation {
        condition     = strcontains(var.namespace, "win10") || strcontains(var.namespace, "win11") ||  strcontains(var.namespace, "windowsserver") || startswith(var.namespace, "example-")
        error_message = "The value of var.namespace must contain 'win10', 'win11', 'windowsserver' or begin with 'example-', but it is '${var.namespace}'."
    }
}

variable "windows-password" {
    type        = string
    default     = ""
    # var.windows-password は 半角英数記号20文字 である
    validation {
        condition     = length(var.windows-password) == 20
        error_message = "The length of var.windows-password must be 20, but it is ${length(var.windows-password)}."
    }
}

variable "offer" {
    type        = string
    default     = ""
    # var.offer は Windows-10, Windows-11, WindowsServer のいずれかである
    validation {
        condition     = contains(["Windows-10", "Windows-11", "WindowsServer"], var.offer)
        error_message = "The value of var.offer must be 'Windows-10', 'Windows-11', or 'WindowsServer', but it is '${var.offer}'."
    }
}

variable "publisher" {
    type        = string
    default     = ""
    # var.publisher は MicrosoftWindowsDesktop, MicrosoftWindowsServer のいずれかである
    validation {
        condition     = contains(["MicrosoftWindowsDesktop", "MicrosoftWindowsServer"], var.publisher)
        error_message = "The value of var.publisher must be 'MicrosoftWindowsDesktop' or 'MicrosoftWindowsServer', but it is '${var.publisher}'."
    }
}

variable "sku" {
    type        = string
    default     = ""
    # var.sku は win??-??h?-ent または ????-datacenter-g? の形式である
    # 古いものには -pro や -enterprise もある
    validation {
        condition     = endswith(var.sku, "-ent") || strcontains(var.sku, "-datacenter-") || endswith(var.sku, "-pro") || endswith(var.sku, "-enterprise") 
        error_message = "The value of var.sku must contain '-ent', or '-datacenter-', but it is '${var.sku}'."
    }
}

variable "windows-username" {
    type        = string
    default     = "clearcode"
}
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
