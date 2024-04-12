# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

.PHONY: all apply apply-playbook destroy clean
COMMONDIRS = ../ 
CURRENT_DIR = $(shell pwd)

all terraform.tfvars apply apply-playbook destroy clean: $(COMMONDIRS)

$(COMMONDIRS): FORCE
	make -C $@ $(MAKECMDGOALS) DIR_PATH=$(CURRENT_DIR)

FORCE:
