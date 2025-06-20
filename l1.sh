#!/bin/bash

main() {
    git config core.filemode false
    git pull
    chmod +x ./_l1.sh
    ./_l1.sh "$@"
}

main "$@"