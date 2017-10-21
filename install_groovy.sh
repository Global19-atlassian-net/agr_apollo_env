#!/usr/bin/env bash

curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install grails 2.5.5
sdk install groovy 2.4
sdk install gradle 3.5


