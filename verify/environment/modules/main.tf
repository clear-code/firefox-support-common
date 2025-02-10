terraform {
  required_version = ">= 1.1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.10"
    }

    local = {
      source  = "hashicorp/local"
      version = "~>1.4"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "firefoxverify" {
  name     = "FirefoxVerifyResourceGroup-${var.namespace}"
  location = "Japan East"
}

resource "azurerm_virtual_network" "firefoxverify" {
  name                = "firefoxverify-${var.namespace}-network"
  resource_group_name = azurerm_resource_group.firefoxverify.name
  location            = azurerm_resource_group.firefoxverify.location
  address_space       = ["10.5.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.firefoxverify.name
  virtual_network_name = azurerm_virtual_network.firefoxverify.name
  address_prefixes     = ["10.5.2.0/24"]
}

resource "azurerm_network_interface" "firefoxverify" {
  name                = "firefoxverify-${var.namespace}-instance-nic"
  location            = azurerm_resource_group.firefoxverify.location
  resource_group_name = azurerm_resource_group.firefoxverify.name

  ip_configuration {
    name                          = "firefoxverify-${var.namespace}-instance-nic"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.5.2.10"
    public_ip_address_id          = azurerm_public_ip.firefoxverify.id
  }
}

resource "azurerm_virtual_machine" "firefoxverify_vm" {
  name                             = "firefoxverify-${var.namespace}-vm"
  location                         = azurerm_resource_group.firefoxverify.location
  resource_group_name              = azurerm_resource_group.firefoxverify.name
  network_interface_ids            = [azurerm_network_interface.firefoxverify.id]
  vm_size                          = "Standard_B2S"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    # Vary with vm to create
    offer     = var.offer
    publisher = var.publisher
    sku       = var.sku
    version   = "latest"
  }

  storage_os_disk {
    name              = "firefoxverify-${var.namespace}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    os_type           = "Windows"
  }

  os_profile {
    computer_name  = "firefoxverify"
    admin_username = var.windows-username
    admin_password = var.windows-password
    custom_data    = file("${path.module}/config/settings.ps1")
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
    winrm {
      protocol = "http"
    }
    # Auto-Login's required to configure WinRM
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "AutoLogon"
      content      = "<AutoLogon><Password><Value>${var.windows-password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.windows-username}</Username></AutoLogon>"
    }
    # Unattend config is to enable basic auth in WinRM, required for the provisioner stage.
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "FirstLogonCommands"
      content      = file("${path.module}/config/FirstLogonCommands.xml")
    }
  }

  tags = {
    CreatedBy = "clearcode"
    Purpose   = "Describe Terraform instruction"
  }

  connection {
    host     = azurerm_public_ip.firefoxverify.ip_address
    type     = "winrm"
    port     = 5985
    https    = false
    timeout  = "2m"
    user     = var.windows-username
    password = var.windows-password
  }

#  provisioner "local-exec" {
#    command = "bash -c ansible-playbook -i ansible/hosts ansible/playbook.yml"
#  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "firefoxverify" {
  virtual_machine_id    = azurerm_virtual_machine.firefoxverify_vm.id
  location              = azurerm_resource_group.firefoxverify.location
  enabled               = true
  daily_recurrence_time = "2200"
  timezone              = "Tokyo Standard Time"
  notification_settings {
    enabled = false
  }
}

resource "azurerm_network_security_group" "firefoxverify" {
  name                = "FirefoxVerifySecurityGroup-${var.namespace}"
  location            = "Japan East"
  resource_group_name = azurerm_resource_group.firefoxverify.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "WinRM"
    priority                   = 998
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "WinRM-out"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Creating with Terraform"
  }
}

resource "azurerm_network_interface_security_group_association" "firefoxverify" {
  network_interface_id      = azurerm_network_interface.firefoxverify.id
  network_security_group_id = azurerm_network_security_group.firefoxverify.id
}

resource "azurerm_public_ip" "firefoxverify" {
  name                    = "firefoxverify-${var.namespace}-collector-pip"
  location                = azurerm_resource_group.firefoxverify.location
  resource_group_name     = azurerm_resource_group.firefoxverify.name
  sku                     = "Standard"
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "firefoxverify-${var.namespace}-pip"
  }
}

data "azurerm_public_ip" "firefoxverify" {
  name                = azurerm_public_ip.firefoxverify.name
  resource_group_name = azurerm_virtual_machine.firefoxverify_vm.resource_group_name
}

output "vm_public_ip_address" {
  value = data.azurerm_public_ip.firefoxverify.ip_address
}

resource "local_file" "inventory" {
  filename = "ansible/hosts"
  content  = <<EOL
[windows]
${data.azurerm_public_ip.firefoxverify.ip_address}

[windows:vars]
ansible_user=${var.windows-username}
ansible_password=${var.windows-password}
ansible_port=5986
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
EOL
}

resource "local_file" "playbook" {
  filename = "ansible/playbook.yml"
  content  = <<EOL
- hosts: windows
  gather_facts: no
  become_method: runas
  vars:
    ansible_become_password: "${var.windows-password}"
  tasks:
    - name: Wait for reachable by polling after 'delay' until 'timeout'
      ansible.builtin.wait_for_connection:
          delay: 10
          timeout: 300
    - name: Gathering facts by setup module
      setup:
    - name: Allow copy and paste to the UAC dialog
      win_regedit:
        key: HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System
        value: PromptOnSecureDesktop
        data: 00000000
        datatype: dword
    - name: Set non-ASCII workgroup name
      microsoft.ad.membership:
        domain_admin_user: "${var.windows-username}"
        domain_admin_password: "${var.windows-password}"
        state: workgroup
        workgroup_name: ワークグループ
    - name: Prepare directory to download language pack
      win_file:
        path: C:\temp
        state: directory
    - name: Download language pack file
      when: not "${var.windows-language-pack-url}" == ""
      win_get_url:
        url: "${var.windows-language-pack-url}"
        dest: 'c:\temp\lp.cab'
        url_username: "${var.download-user}"
        url_password: "${var.download-token}"
    - name: Install language pack
      when: not "${var.windows-language-pack-url}" == ""
      win_shell: |
        $LpTemp = "c:\temp\lp.cab"
        Add-WindowsPackage -PackagePath $LpTemp -Online
        Set-WinUserLanguageList -LanguageList ja-JP,en-US -Force
        Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"
        Set-WinLanguageBarOption -UseLegacySwitchMode -UseLegacyLanguageBar
        Remove-Item $LpTemp -Force
    - win_reboot:
      when: not "${var.windows-language-pack-url}" == ""
    - name: Wait for the system to be ready after reboot for language pack
      ansible.builtin.wait_for_connection:
        delay: 10
        timeout: 300
      when: not "${var.windows-language-pack-url}" == ""
    - win_timezone:
        timezone: Tokyo Standard Time
    - name: Set location
      win_shell: Set-WinHomeLocation -GeoId 0x7A
    - name: Set UI language
      win_shell: Set-WinUILanguageOverride -Language ja-JP
    - name: Set system language
      win_shell: Set-WinSystemLocale -SystemLocale ja-JP
    - name: Set date/time format
      win_shell: Set-WinCultureFromLanguageListOptOut -OptOut $False
    - name: Set keyboard layout
      win_shell: Set-ItemProperty 'registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters' -Name 'LayerDriver JPN' -Value 'kbd106.dll'
    - win_reboot:
    - name: Wait for the system to be ready after reboot for locale settings
      ansible.builtin.wait_for_connection:
        delay: 10
        timeout: 300
    - name: Set region globally
      win_region:
        copy_settings: yes
        location: "122"
        format: ja-JP
        unicode_language: ja-JP
    - win_reboot:
    - name: Wait for the system to be ready after reboot for region settings
      ansible.builtin.wait_for_connection:
        delay: 10
        timeout: 300
    - name: Create administrator user
      win_user:
        name: "管理者"
        password: "${var.windows-password}"
        password_never_expires: true
        state: present
        groups:
          - Administrators
          - Users
          - Remote Desktop Users
    - name: Set display language for the administrator user
      become: yes
      become_user: "管理者"
      win_shell: |
        Set-WinUILanguageOverride -Language ja-JP
        Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"
    - name: Show hidden files for the administrator user
      become: yes
      become_user: "管理者"
      win_command: reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
    - name: Show file extensions for the administrator user
      become: yes
      become_user: "管理者"
      win_command: reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
    - name: Create regular user
      win_user:
        name: "ユーザー"
        password: "${var.windows-password}"
        password_never_expires: true
        state: present
        groups:
          - Users
          - Remote Desktop Users
    - name: Set display language for the regular user
      become: yes
      become_user: "ユーザー"
      win_shell: |
        Set-WinUILanguageOverride -Language ja-JP
        Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"
    - name: Show hidden files for the regular user
      become: yes
      become_user: "ユーザー"
      win_command: reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
    - name: Show file extensions for the regular user
      become: yes
      become_user: "ユーザー"
      win_command: reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
    - name: Download Microsoft .NET Framework 4.8 Offline Installer
      # See also: https://support.microsoft.com/en-us/topic/microsoft-net-framework-4-8-offline-installer-for-windows-9d23f658-3b97-68ab-d013-aa3c3e7495e0
      win_get_url:
        url: "https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe"
        dest: 'c:\Users\Public\dotnet48_installer.exe'
    - name: Install Microsoft .NET Framework 4.8 for chocolatey
      win_command: c:\Users\Public\dotnet48_installer.exe /Q
    - name: Install Active Directory Domain Service (AD DS) if this is Windows Server
      win_feature:
        name: AD-Domain-Services
        state: present
        include_management_tools: yes
      register: add_feature
      when: "'Server' in ansible_facts['distribution']"
    - name: Ensure AD DS was successfully installed
      debug:
        msg: "AD DS was successfully installed."
      when: add_feature.changed
    - name: Promote to a domain controller if this is Windows Server
      win_command: powershell.exe -command "Install-ADDSForest -DomainName example.local -SafeModeAdministratorPassword (ConvertTo-SecureString '${var.windows-password}' -AsPlainText -Force) -Force"
      register: promote_dc
      changed_when: "'The operation completed successfully' in promote_dc.stdout_lines | join(' ')"
      when: "'Server' in ansible_facts['distribution']"
    - name: Restart after promotion if this is Windows Server
      win_reboot:
      when: promote_dc.changed
    - name: Wait for the system to be ready after reboot for AD DC promotion
      ansible.builtin.wait_for_connection:
        delay: 10
        timeout: 300
      when: promote_dc.changed
    - name: Setup chocolatey
      win_chocolatey:
        name: chocolatey
        state: present
    - name: Install chocolatey-compatibility.extension to install legacy style package like SakuraEditor
      win_chocolatey:
        name: chocolatey-compatibility.extension
        state: present
        allow_empty_checksums: yes
        ignore_checksums: yes
    - name: Install SakuraEditor
      win_chocolatey:
        name: sakuraeditor
        state: present
        allow_empty_checksums: yes
        ignore_checksums: yes
    - name: Install vim
      win_chocolatey:
        name: vim
        state: present
        allow_empty_checksums: yes
        ignore_checksums: yes
    - name: Download firefox-support-common for testcases
      win_get_url:
        url: "https://github.com/clear-code/firefox-support-common/archive/master.zip"
        dest: 'c:\Users\Public\firefox-support-common.zip'
    - name: Extract contents
      win_unzip:
        src: 'c:\Users\Public\firefox-support-common.zip'
        dest: 'c:\Users\Public'
        delete_archive: yes
    - name: Extract only testcases
      win_copy:
        src: 'c:\Users\Public\firefox-support-common-master\testcases'
        dest: 'c:\Users\Public'
        remote_src: True
    - name: Delete needless files
      win_file:
        path: 'c:\Users\Public\firefox-support-common-master'
        state: absent
    - name: Add enterprise cert for verification
      win_regmerge:
        path: 'C:\Users\Public\testcases\add-badssl-com-enterprise-root.reg'
    - name: Download Flash installer
      when: not "${var.flash-installer-url}" == ""
      win_get_url:
        url: "${var.flash-installer-url}"
        dest: 'C:\Users\Public\flash_installer.exe'
        url_username: "${var.download-user}"
        url_password: "${var.download-token}"
    - name: Download HookDate to override system time for Firefox
      when: not "${var.hookdate-download-url}" == ""
      win_get_url:
        url: "${var.hookdate-download-url}"
        dest: 'C:\Users\Public\hookdate.zip'
        url_username: "${var.download-user}"
        url_password: "${var.download-token}"
    - name: Extract contents
      when: not "${var.hookdate-download-url}" == ""
      win_unzip:
        src: 'C:\Users\Public\hookdate.zip'
        dest: 'c:\Users\Public'
        delete_archive: yes
    - name: Download DebugView for BrowserSelector
      when: not "${var.debugview-download-url}" == ""
      win_get_url:
        url: "${var.debugview-download-url}"
        dest: 'C:\Users\Public\DebugView.zip'
        url_username: "${var.download-user}"
        url_password: "${var.download-token}"
    - name: Extract contents
      when: not "${var.old-ie-download-url}" == ""
      win_unzip:
        src: 'C:\Users\Public\DebugView.zip'
        dest: 'c:\Users\Public'
        delete_archive: yes
    - name: Prepare directory to put policy templates (en-US locale)
      win_file:
        path: C:\Windows\PolicyDefinitions\en-US
        state: directory
    - name: Prepare directory to put policy templates (ja-JP locale)
      win_file:
        path: C:\Windows\PolicyDefinitions\ja-JP
        state: directory
    - name: Download Firefox policy template
      when: not "${var.firefox-policy-template-url}" == ""
      win_get_url:
        url: "${var.firefox-policy-template-url}"
        dest: 'C:\Users\Public\firefox-policy-template.zip'
    - name: Prepare directory to extract Firefox policy template
      when: not "${var.firefox-policy-template-url}" == ""
      win_file:
        path: 'c:\Users\Public\firefox_policy_templates'
        state: directory
    - name: Extract Firefox policy template
      when: not "${var.firefox-policy-template-url}" == ""
      win_unzip:
        src: 'C:\Users\Public\firefox-policy-template.zip'
        dest: 'c:\Users\Public\firefox_policy_templates'
        delete_archive: yes
    - name: Install Firefox policy template (definitions)
      when: not "${var.firefox-policy-template-url}" == ""
      win_command: xcopy /y C:\Users\Public\firefox_policy_templates\windows\* C:\Windows\PolicyDefinitions\
    - name: Install Firefox policy template (en-US locale)
      when: not "${var.firefox-policy-template-url}" == ""
      win_command: xcopy /y C:\Users\Public\firefox_policy_templates\windows\en-US\* C:\Windows\PolicyDefinitions\en-US\
    - name: Download Thunderbird policy template
      when: not "${var.thunderbird-policy-template-url}" == ""
      win_get_url:
        url: "${var.thunderbird-policy-template-url}"
        dest: 'C:\Users\Public\thunderbird-policy-template.zip'
    - name: Prepare directory to extract Thunderbird policy template
      when: not "${var.thunderbird-policy-template-url}" == ""
      win_file:
        path: 'c:\Users\Public\thunderbird_policy_templates'
        state: directory
    - name: Extract Thunderbird policy template
      when: not "${var.thunderbird-policy-template-url}" == ""
      win_unzip:
        src: 'C:\Users\Public\thunderbird-policy-template.zip'
        dest: 'c:\Users\Public\thunderbird_policy_templates'
        delete_archive: yes
    - name: Install Thunderbird policy template (definitions)
      when: not "${var.thunderbird-policy-template-url}" == ""
      win_command: xcopy /y C:\Users\Public\thunderbird_policy_templates\policy-templates-master\templates\central\windows\* C:\Windows\PolicyDefinitions\
    - name: Install Thunderbird policy template (en-US locale)
      when: not "${var.thunderbird-policy-template-url}" == ""
      win_command: xcopy /y C:\Users\Public\thunderbird_policy_templates\policy-templates-master\templates\central\windows\en-US\* C:\Windows\PolicyDefinitions\en-US\
    - name: Create shortcut to Program Files
      win_shortcut:
        src: '%ProgramFiles%'
        dest: '%Public%\Desktop\Program Files.lnk'
    - name: Create shortcut to Program Files (x86)
      win_shortcut:
        src: '%ProgramFiles(x86)%'
        dest: '%Public%\Desktop\Program Files (x86).lnk'
    - name: Create shortcut to testcases
      win_shortcut:
        src: '%Public%\testcases'
        dest: '%Public%\Desktop\testcases.lnk'
    - name: Create shortcut to AppData
      win_shortcut:
        src: '%AppData%'
        dest: '%Public%\Desktop\AppData.lnk'
    - name: Create shortcut to LocalAppData
      win_shortcut:
        src: '%LocalAppData%'
        dest: '%Public%\Desktop\LocalAppData.lnk'
#    - name: Add popup blocker exception hosts for Security-4-5 and Security-4-6
#      win_hosts:
#        state: present
#        canonical_name: hostname.example.com
#        ip_address: '93.184.216.34'
EOL
}

resource "local_file" "admin_rdp_shortcut" {
  filename = "rdp/管理者.rdp"
  content  = <<EOL
full address:s:${data.azurerm_public_ip.firefoxverify.ip_address}:3389
prompt for credentials:i:0
administrative session:i:1
username:s:管理者
EOL
}

resource "local_file" "user_rdp_shortcut" {
  filename = "rdp/ユーザー.rdp"
  content  = <<EOL
full address:s:${data.azurerm_public_ip.firefoxverify.ip_address}:3389
prompt for credentials:i:0
administrative session:i:1
username:s:ユーザー
EOL
}

resource "local_file" "batch_to_add_password_lines_for_rdp_shortcuts" {
  filename = "rdp/add_password.bat"
  content  = <<EOL
@echo off
for /f "usebackq delims==" %%i IN (`dir *.rdp /b`) do powershell.exe -command "'password 51:b:' + (('${var.windows-password}' | ConvertTo-SecureString -AsPlainText -Force) | ConvertFrom-SecureString);" >> %%i
del add_password.bat
EOL
}

resource "local_file" "password_file" {
  filename = "password.txt"
  content  = var.windows-password
}
