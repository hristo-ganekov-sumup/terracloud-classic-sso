#!/bin/sh
# Exit if any of the intermediate steps fail
set -e

eval "$(jq -r '@sh "OUID=\(.OUID)"')"

aws organizations list-children --parent-id $OUID --child-type ACCOUNT | jq --arg OUID "$OUID" 'reduce .Children[] as $i ({}; .[$i.Id] = $OUID)'
