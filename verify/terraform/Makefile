# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

.PHONY: update-vm-lists

SHELL=/bin/bash

all: update-vm-lists

update-vm-lists:
	az vm image list --publisher MicrosoftWindowsDesktop --all > ./vm-list-windows-desktop.json
	az vm image list --publisher MicrosoftWindowsServer --all > ./vm-list-windows-server.json
