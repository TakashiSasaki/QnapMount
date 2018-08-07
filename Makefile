.PHONY: help

vpath %.out ./out
OUT=$(shell pwd)/out

help:
	@echo digging into storage structure

define now 
$(shell date +%s)
endef
NOW=$(call now)

now:
	@echo $(NOW)

all: now.mount_l

now.mount_l:
	mount >$(OUT)/$@
	ln -s $(OUT)/$@ now.mount_l

now.du:
	du >$(OUT)/$@
	ln -s $(OUT)/$@ now.du

now.locate:
	locate / >$(OUT)/$@
	ln -s $(OUT)/$@ now.locate

now.pvs:
	pvs >$@
	ln -s $(OUT)/$@ now.pvs

now.lvs:
	lvs >$@
	ln -s $(OUT)/$@ now.lvs

now.vgs:
	vgs >$@
	ln -s $(OUT)/$@ now.vgs

now.dmsetup_ls:
	dmsetup ls >$(OUT)/$@
	ln -s $(OUT)/$@ now.dmsetup_ls

now.dmsetup_status:
	dmsetup status >$(OUT)/$@
	ln -s $(OUT)/$@ now.dmsetup_status

bind.txt: now.mount_l
	cat $< | sed -n -r 's/ type none \(.+bind\)$$//p' >$@

md.txt: now.mount_l
	cat $< | sed -n -r '/md[0-9]+/p' >$@

