#!/bin/sh
#  Used:  from tde_inst.sh

sed -i '/^JUJU_SH=/d;$a JUJU_SH="/mnt/dump_dsk/CENTR/WRK/juju/sh"' ~/.bashrc

grep -q '^alias juju=' ~/.bashrc || printf "%s\n" \
"alias juju='ls -lh --time-style=+%Y-%m-%d --group-directories-first \"\$JUJU_SH\" | awk '\''{printf \"%-6s %-12s %s\\n\", \$5, \$6, \$7}'\'''" \
>> ~/.bashrc