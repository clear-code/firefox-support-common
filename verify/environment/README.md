# How to prepare verification environments

1. Prepare your Azure account.
2. Install the [terraform client](https://www.terraform.io/downloads.html).
3. Install the [`az` azure command line frontend](https://docs.microsoft.com/ja-jp/cli/azure/install-azure-cli?view=azure-cli-latest).
4. Prepare your authentication information for Azure.
   1. Run `az login`.
   2. Run `az account list` to get the available subscription ID (the `"id"` field of the active account).
      Assume it is `00000000-0000-0000-0000-000000000000`.
   3. Set the application id to the environment variable `SUBSCRIPTION_ID`, for example: `export SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"`.
   4. Run `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"` to get the authentication token.
   5. Set authentication information to environment variables, like:
      ```
      export ARM_SUBSCRIPTION_ID="(the subscription ID got at the step 2)"
      export ARM_CLIENT_ID="(the "appId" field of the got result at the step 4)"
      export ARM_CLIENT_SECRET="(the "password" field of the got result at the step 4)"
      export ARM_TENANT_ID="(the "tenant" field of the got result at the step 4)"
      ```
      (They should be added to your configuration file of the shell, ex. `~/.bashrc`)
5. `cd` to the directory under this directory.
6. Run `make` to prepare the verification environment.
   If it fails, while running Ansible, run Ansible again with `make apply-playbook`.
7. Run the batch file generated under the `rdp` directory.
8. Log in to the verification environment with the generated `.rdp` files.
9. Verify your change with the environment.
10. Run `make destroy` to destroy the environment.

See also https://www.clear-code.com/blog/2020/5/25.html to know how to prepare your environment initially.

