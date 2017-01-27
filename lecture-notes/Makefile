TARGETS=android-ui.html

all: $(TARGETS)

%.html : %.md
	sed -e '/<textarea id="source">/r $<' boilerplate.html > $@

clean:
	rm $(TARGETS)
