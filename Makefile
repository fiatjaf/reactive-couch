SHELL=/usr/bin/fish

all:
	rsync -rtvu components/ _attachments/components
	rsync -rtvu lib/ _attachments/lib
	coffee --bare -c .
	erica push h http://localhost:5984/reactive_db
