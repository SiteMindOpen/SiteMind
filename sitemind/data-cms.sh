#!/bin/bash

cat sitemind_signals.csv | head -1 | tr ',' '\n' | sed 's/$/=/' > data-cms.temp1
head -2 sitemind_signals.csv | tail -1 | tr ',' '\n' > data-cms.temp2
paste data-cms.temp1 data-cms.temp2 | tr -d '\t' > data-cms.bash

cat domain.bash data-cms.bash | grep -v =$ > env.bash

## CLEAN UP
rm data-cms.temp* domain.bash data-cms.bash