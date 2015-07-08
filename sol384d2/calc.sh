printf "stopping_times = [%s]" "$(cat results/*.jx | sed -nEe 's/"length": ([^}]*).*/\1/p' | sort -n | tr -s '\n' ',')" > stopping_times.txt

