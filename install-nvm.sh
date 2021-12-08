#!/bin/bash

# Install NVM and setup default conigurations.
/bin/bash -c "$(
  cat <<EOF
    set -e
    umask 0002
    # Do not update profile - we'll do this manually
    export PROFILE=/dev/null
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
    source ${NVM_DIR}/nvm.sh
    [[ $NODE_VERSION != '' ]] && nvm alias default ${NODE_VERSION}
    nvm install-latest-npm
    nvm clear-cache
EOF
)" 2>&1
