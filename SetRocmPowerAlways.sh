#!/bin/bash
#MAX_POWER is in Watts and should reflect a value that you as the user are 100% certain can handle!
MAX_POWER=80
while :
do
        echo "To quit press Ctrl-C"
        sleep 5
        read -r -d '' CURRENT_MAX_POWER < <(rocm-smi -M | grep -Eo "[0-9]+\.[0]")
        read -r -d '' MAX_POWER_DECIMAL < <(bc <<< "$MAX_POWER != $CURRENT_MAX_POWER")
        if [  "$MAX_POWER_DECIMAL" -eq 1 ]
        then
            yes | rocm-smi --setpoweroverdrive "$MAX_POWER"
        fi
done
exit 0
