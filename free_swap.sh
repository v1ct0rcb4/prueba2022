#!/bin/bash

free_mem="$(free | grep 'Mem:' | awk '{print $7}')"
used_swap="$(free | grep 'Swap:' | awk '{print $3}')"

echo -e "Free memory:\t$free_mem kB ($((free_mem / 1024)) MiB)\nUsed swap:\t$used_swap kB ($((used_swap / 1024)) MiB)"
if [[ $used_swap -eq 0 ]]; then
    echo "No hay consumo de swap"
elif [[ $used_swap -lt $free_mem ]]; then
    echo "Liberando swap..."
    sudo swapoff -a
    sudo swapon -a
else
    echo "No hay memoria libre"
    exit 1
fi
