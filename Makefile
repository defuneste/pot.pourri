SHELL := bash
.ONESHELL:
.SHELLFLAGS := -euo pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables

# FROM Yihui https://github.com/yihui/knitr/blob/master/Makefile
# he go on parent directory see cd ..;
PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGSRC  := $(shell basename `pwd`)

all: build install clean

## build		: build tarbal
build:
	cd ..;\
	R CMD build --no-manual $(PKGSRC)

## check 		: run devtools::check
check:
	R -e 'devtools::check()'

## install		: load the pkg
install:
	cd ..;\
	R CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz\

## clean		: delete pkg tar and Rcheck/
clean:
	cd ..;\
	$(RM) -r $(PKGNAME).Rcheck/;\
	$(RM) -r $(PKGNAME)_$(PKGVERS).tar.gz\
	
## help		: Quick help/reminder
help : Makefile
	@sed -n 's/^##//p' $<