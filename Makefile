ROCQ ?= rocq
ROCQARGS := -w all -set 'Primitive Projections' -set 'Universe Polymorphism' -set 'Printing Universes'

PACKAGE := EnrichedPreorder
SRCS := $(shell find theories -name *.v)

.PHONY: all all-quick clean FORCE

all: RocqMakefile $(SRCS)
	$(MAKE) -f RocqMakefile

all-quick: RocqMakefile $(SRCS)
	$(MAKE) -f RocqMakefile vok

_RocqProject: Makefile $(SRCS)
	printf -- "-arg \"$(ROCQARGS)\"\n-Q theories $(PACKAGE)\n$(SRCS)\n" > _RocqProject

RocqMakefile: Makefile _RocqProject
	$(ROCQ) makefile -f _RocqProject -o RocqMakefile

%.vo: RocqMakefile FORCE
	$(MAKE) -f RocqMakefile $@

%.vok: RocqMakefile FORCE
	$(MAKE) -f RocqMakefile $@

%.vo: RocqMakefile FORCE
	$(MAKE) -f RocqMakefile $@

clean:
	rm -f _RocqProject
	rm -f RocqMakefile RocqMakefile.conf .RocqMakefile.d
	rm -f $(shell find theories -regextype awk -regex ".*\.(aux|glob|vo|vok|vos)")
