#!/bin/sh

# Beginner tip:  if you're new to terminals, this is the best place to start usi
# ng them. If you create just a couple of files with some content in the names a
# nd a todo.txt with some content in it. If you are always pulling up your notes
# then you want to automate it with just the 2 konsole commands you see below.
#
# Highly highly cursed:
# My gf said she would like to try out black arts, but 1st she should understand
# the implications of spending so much time in highly active environments like K
# onsole. She's a big girl and she got in to the black arts, she likes The Hex.
#

# Startup applications:

# Print diretory, where i keep some temp files with the todo's as the file names
# - you can still back up this way by having them stored in git automatically li
# ke here:
#
# https://github.com/basedfigure/juju/blob/main/sh/git_auto_commit_desk.sh
#
konsole -e bash -c "cd /mnt/dump_dsk/CENTR/WRK/_lan/DESK/do/hat && ls; exec bash" &


# Open my todo list automatically upon startup. I call it with an alias, if it's
# closed. Terminal tabs are also good if you lack the screen space (laptops).
#
# The cd is for fuzzbox to list the files based on the DESK directory, it bugs o
# ut for me otherwise.
konsole -e bash -c "cd /mnt/dump_dsk/CENTR/WRK/_lan/DESK/ && vim todo.txt"

# DESK/ - Konsole pathing:
# do/
#  - hat/ now/ safe/ stat/
# * hat/  root/*, home/ side/ misc/
# * stat/ is for what my console looks for with:  todo
# fr_tpad/
# word/
#  - done/
#
# I have a super easy and powerful technique for creating todo files here (url):
# github.com/basedfigure/juju/blob/main/sh/todo.sh
# - Screenshot:
# codeberg.org/basedfigure/foot/media/branch/main/dojo/juju_todo_bash.png