# 必須の変数に値を指定しないとエラーとなる
run "assert_mandatory_valueables" {
  command = plan
  expect_failures = [
    var.namespace, var.windows-password, var.offer, var.publisher, var.sku
  ]
}

# 必須の変数に与える値が不正だとエラーとなる
run "fail_when_any_of_mandatory_valueables_is_incorrect" {
  command = plan
  # エラーとなる条件は下記のとおり。指定すべき「特定の文字列」は ../variables.tf 内コメントを参照
  # namespace: 特定の文字列を含んでいない
  # password: 20文字でない
  # offer, publisher, sku: 末尾が特定の文字列でない。または、特定の文字列を含んでいない
  variables {
    namespace           = "invalid-ent-23H2"
    windows-password    = "0123456789"
    offer               = "Invalid"
    publisher           = "NotExist"
    sku                 = "Invalidsku"
  }
  expect_failures = [
    var.namespace, var.windows-password, var.offer, var.publisher, var.sku
  ]
}

# var.windows-username のデフォルト値は clearcode である
run "assert_default_value_1" {
  command = plan
  # 必須のvariablesを与える。ここではwin11-23h2-entのものを使う。passwordは20字のダミー文字列でよい。
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
  # 必須のvariablesを与える。ここではwin11-23h2-entのものを使う。passwordは20字のダミー文字列でよい。
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
