#!/usr/bin/make -f

.PHONY=build

CHANGELOG=usr/share/doc/dotfiles-root/changelog.Debian.gz

build: $(CHANGELOG)

$(CHANGELOG): changelog
	mkdir -vp $(dir $@)
	gzip changelog -c >$@

clean:
	rm -f $(CHANGELOG)
	-rmdir --parents $(dir $(CHANGELOG))
