#!/bin/bash

	#strips all html and counts words in all White House briefings

	cat data-hold/* | ~/bin_compciv/pup 'div#content' | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | sed "s/&#39;/'/g" | grep -oE '[[:alpha:]]{7,}' | sort | uniq -c | sort -nr | head  -10 > topten.txt



