#!/bin/bash
#
# 1)  ssh_inst_for_srv_side_to_run_sh_in_bash.sh - diy: remove (#) the apt inst,
# once done
#
# Test with a remote session with the server:
# $ ssh bf@xx.xx.xxx.xx
#
# 2)  Key generation. Check your IP with hostname -I, on the server computer.
# * First to generate it on a client, second to copy it to your server.
# $ ssh-keygen
# $ ssh-copy-id -f bf@xx.xx.xxx.xx
#
# rsync.samba.org/
# Example rsync file transfer:
#
rsync --remove-source-files -av bf@10.39.234.94:/home/bf/Desktop/"shin <3 yuna.txt" ~/Desktop/
#
# unix.stackexchange.com/questions/371144/
# usage-of-remove-source-files-option-of-rsync
#
# superuser.com/questions/156664/
# what-are-the-differences-between-the-rsync-delete-options
#