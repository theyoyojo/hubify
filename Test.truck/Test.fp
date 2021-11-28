# FLOORPLAN 0.0.0

# FLOORPLAN := LINE | LINE FLOORPLAN
# LINE := ITEM\n
# ITEM := ROOM | PIPE | META
# META := TITLE
# TITLE := House <ascii>
# ROOM := NAME TYPE VADDR PADDR
# NAME := <ascii> (maps to local file or git repo of website)
# TYPE := info | blog | chat | repo
# VADDR \in \mathbb{R}^3 (subject to change)
# PADDR := PIPE
# PIPE := HOST/PATH => URL

House Test

# how should these links work?
# - local version
# - fix when pushing to server
# - dash may fix this

testx info (0,0,0) host/x
testy info (0,1,0) host/y
testz info (1,0,0) host/z
nuts info (-1,0,0) host/nuts
notes info (-2,0,0) host/notes
help info (1,1,0) host/help
p portal (1,1,0) host/p

host => example.com
