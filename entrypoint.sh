#!/bin/sh
if [[ ! -z "$SWAP" ]]; then fallocate -l $(($(stat -f -c "(%a*%s/10)*3" .))) _swapfile && mkswap _swapfile && swapon _swapfile && ls -hla; fi; free -m

exec "$@"
