TARGETS=android-ui.html android-intro.html adapter-view.html activity-intent.html

all: $(TARGETS)

%.html : %.md boilerplate.html
	sed -e '/<textarea id="source">/r $<' boilerplate.html > $@

clean:
	rm $(TARGETS)
