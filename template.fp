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
test => file:///home/jsavitz/hubify/foobar
testx info (0,0,0) test/x
testy info (0,2,0) test/y
testz info (1,0,0) test/z
