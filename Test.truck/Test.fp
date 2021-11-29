# FLOORPLAN 0.0.0

# FLOORPLAN := LINE | LINE FLOORPLAN
# LINE := ITEM\n
# ITEM := ROOM | PIPE | ASSET | META
# META := TITLE
# TITLE := House <ascii>
# ROOM := NAME TYPE VADDR PADDR
# NAME := <ascii> (maps to local file or git repo of website)
# TYPE := info | blog | chat | repo
# VADDR \in \mathbb{R}^3 (subject to change)
# PADDR := PIPE/<path> (pipe stuff isn't used yet)
# PIPE := HOST/PATH => URL
# ASSET := @ <filename> PADDR

House Test

# how should these links work?
# - local version (done)
# - fix when pushing to server
# - dash may fix this

testx info (0,0,0) host/x
testy info (0,1,0) host/y
testz info (1,0,0) host/x/z
nuts info (-1,0,0) host/nuts
notes info (-2,0,0) host/notes
help info (1,2,0) alt/help
nutsportal portal (1,1,0) host/port
bill info (2,2,0) alt/bill

@ bill.jpg alt/bill

host => example.com
