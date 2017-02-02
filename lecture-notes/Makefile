TARGETS=android-ui.html android-intro.html adapter-view.html activity-intent.html fragment.html actionbar-navigation.html data-storage.html location.html animation-graphics.html multimedia.html material-design.html mobile-backend.html

all: $(TARGETS)

%.html : %.md boilerplate.html
	sed -e '/<textarea id="source">/r $<' boilerplate.html > $@

clean:
	rm $(TARGETS)
