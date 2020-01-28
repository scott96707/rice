#!/bin/bash
# Output the list of servers from the servers.list file
while read -r line; do echo "$line"; done < ~/bin/servers.list
