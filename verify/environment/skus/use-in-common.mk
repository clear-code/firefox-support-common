# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

.PHONY: all apply apply-playbook destroy clean

SHELL=/bin/bash

all: clean apply

terraform.tfvars:
	cat ../../modules/terraform.tfvars.template | \
        sed -e "/^windows-password = \"%PASSWORD%\"/c windows-password = \"$$(pwgen -s --remove-chars=\'\"\`$$%{}\\\<\>\& -y 20 1)\"" > terraform.tfvars

apply: terraform.tfvars
	tofu init
	tofu plan
	time (tofu apply -auto-approve && ansible-playbook -i ansible/hosts ansible/playbook.yml)

apply-playbook:
	ansible-playbook -i ansible/hosts ansible/playbook.yml

destroy:
	tofu destroy -auto-approve

clean:
	rm -rf .terraform .terraform.lock.hcl password.txt terraform.tfstate terraform.tfstate.backup terraform.tfvars \
		rdp/add_password.bat rdp/*.rdp
