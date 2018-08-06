.PHONY: help

help:
	@echo digging into storage structure

all: pvs.txt lvs.txt vgs.txt md.txt bind.txt mount.txt

mount.txt:
	mount | grep -v -e "^tmpfs" -e "type proc" -e "type tmpfs" -e "type sysfs" -e "type devpts" -e "type cgroup" >$@

bind.txt: mount.txt
	cat $< | sed -n -r 's/ type none \(.+bind\)$$//p' >$@

md.txt: mount.txt
	cat $< | sed -n -r '/md[0-9]+/p' >$@

pvs.txt:
	pvs > pvs.txt

lvs.txt:
	lvs > lvs.txt

vgs.txt:
	vgs > vgs.txt


