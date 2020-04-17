#!/bin/bash
# Author: @unfo
# xargs ls --full-time output:
# -rw-rw---- 1 USER    GROUP  458654 2015-08-09 11:12:37.000000000 +0300 ./path/2015/08/09/file.ext
# awk fields:
# 1          2 3       4      5      6          7                  8     9

find . -type f -print0 \
| xargs -0 ls --full-time \
| awk '{ total[$6] += $5 } END { for (d in total) { printf("%s\t%6.2f MB\n",d,(total[d] / 1024 / 1024)) } }' \
| sort -k1

# Here's the oneliner for copypaste ease:
# find . -type f -exec ls --full-time {} \; | awk '{ total[$6] += $5 } END { for (d in total) { printf("%s\t%6.2f MB\n",d,(total[d] / 1024 / 1024)) } }' | sort -k1


# Used -print0 | xargs -0 because it is significantly faster 
# vs find -exec ls --full-time {} \; which forks for every file.
### Output:
#2015-03-30	 28.09 MB
#2015-03-31	  0.10 MB
#2015-04-01	  3.32 MB
#2015-04-02	 27.82 MB
#2015-04-03	  5.24 MB
#2015-04-05	  8.40 MB
#2015-04-06	  9.39 MB
#2015-04-07	  2.54 MB
