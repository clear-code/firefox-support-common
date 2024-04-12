# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

.PHONY: all terraform.tfvars apply apply-playbook destroy clean

SHELL=/bin/bash

all: clean apply

terraform.tfvars:
	cd $(DIR_PATH) && \
	cat ../../modules/terraform.tfvars.template | \
        sed -e "/^windows-password = \"%PASSWORD%\"/c windows-password = \"$$(pwgen -s --remove-chars=\'\"$$%{} -y 20 1)\"" > $(DIR_PATH)/terraform.tfvars

apply: terraform.tfvars
	cd $(DIR_PATH) && terraform init
	cd $(DIR_PATH) && terraform plan
	time (cd $(DIR_PATH) && terraform apply -auto-approve && ansible-playbook -i ansible/hosts ansible/playbook.yml)

apply-playbook:
	cd $(DIR_PATH) && ansible-playbook -i ansible/hosts ansible/playbook.yml

destroy:
	cd $(DIR_PATH) && terraform destroy -auto-approve

clean:
	cd $(DIR_PATH) && \
	rm -rf .terraform .terraform.lock.hcl password.txt terraform.tfstate terraform.tfstate.backup terraform.tfvars \
		rdp/add_password.bat rdp/*.rdp
