# var.namespace の末尾は skuタイプ名 である
 #  プレフィックス'example-'を持つ場合もある

# var.windows-username のデフォルト値は clearcode である
run "assert_default_value_1" {
  command = plan
  # 必須のvariablesを与える。ここではwin11-23h2-entのものを使う
  variables {
    namespace           = "example-win11-ent-23H2"
    windows-password    = "ABCDEfghij0123456789"
    offer               = "Windows-11"
    publisher           = "MicrosoftWindowsDesktop"
    sku                 = "win11-23h2-ent"
  }
  assert {
    condition     = var.windows-username == "clearcode"
    error_message = "The default var.windows-username value must be 'clearcode'."
  }
}

# var.download-user のデフォルト値は browser-verify である
run "assert_default_value_2" {
  command = plan
  # 必須のvariablesを与える。ここではwin11-23h2-entのものを使う
  variables {
    namespace           = "example-win11-ent-23H2"
    windows-password    = "ABCDEfghij0123456789"
    offer               = "Windows-11"
    publisher           = "MicrosoftWindowsDesktop"
    sku                 = "win11-23h2-ent"
  }
  assert {
    condition     = var.download-user == "browser-verify"
    error_message = "The default var.download-user value must be 'browser-verify'."
  }
}