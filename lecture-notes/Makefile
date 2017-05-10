VERSION=0.9-prerelease
RELEASE=android-lecture-pdf-$(VERSION).tgz

TARGETS=android-ui.html android-intro.html adapter-view.html activity-intent.html fragment.html actionbar-navigation.html data-storage.html sqlite.html location.html animation.html custom-view.html graphics.html multimedia.html material-design.html mobile-backend.html

PDF-TARGETS=android-ui.pdf android-intro.pdf adapter-view.pdf activity-intent.pdf fragment.pdf actionbar-navigation.pdf data-storage.pdf sqlite.pdf location.pdf animation.pdf custom-view.pdf graphics.pdf multimedia.pdf material-design.pdf mobile-backend.pdf

html: $(TARGETS)

all: html pdf

%.html : %.md boilerplate.html
	sed -e '/<textarea id="source">/r $<' boilerplate.html > $@

pdf: $(PDF-TARGETS) decktape
	tar zcvf $(RELEASE) *.pdf

%.pdf : %.html decktape
	decktape-1.0.0/phantomjs decktape-1.0.0/decktape.js $< $@

decktape: decktape-1.0.0/decktape.js
decktape-1.0.0/decktape.js:
	curl -L https://github.com/astefanutti/decktape/archive/v1.0.0.tar.gz | tar -xz --exclude phantomjs
	# cd decktape-1.0.0
	curl -L https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-linux-x86-64 -o decktape-1.0.0/phantomjs
	chmod +x decktape-1.0.0/phantomjs

clean:
	rm $(TARGETS) $(PDF-TARGETS)

