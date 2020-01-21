# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# CSG Specific alias
alias servers='sh ~/bin/servers.sh'

# User specific aliases and functions
alias l='ls -ahl'
