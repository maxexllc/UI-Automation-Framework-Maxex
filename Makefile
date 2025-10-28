.PHONY: install install-node install-browsers test smoke parallel lint clean

VENV?=.venv
ACTIVATE?=source $(VENV)/bin/activate

install:
	python -m venv $(VENV)
	$(ACTIVATE); pip install -U pip; pip install -r requirements.txt
	$(ACTIVATE); rfbrowser install

test:
	$(ACTIVATE); robot -d results -v ENV:dev tests

smoke:
	$(ACTIVATE); robot -d results -i smoke -v ENV:dev tests

parallel:
	$(ACTIVATE); pabot --processes 4 -d results -v ENV:dev tests

lint:
	$(ACTIVATE); robocop tests resources

clean:
	rm -rf results
