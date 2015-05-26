printf "sol224:    %6u    %6u\n" $(ag -l "pE: 1" sol224 | wc -l | tr -d ' \n') $(ag -l "p2: 1" sol224 | wc -l | tr -d ' \n')
printf "sol256:    %6u    %6u\n" $(ag -l "\[1, [01]\]" sol256 | wc -l | tr -d ' \n') $(ag -l "\[1, 1\]" sol256 | wc -l | tr -d ' \n')
printf "sol384:    %6u    %6u\n" $(ag -l "pE: 1" sol384 | wc -l | tr -d ' \n') $(ag -l "p2: 1" sol384 | wc -l | tr -d ' \n')
