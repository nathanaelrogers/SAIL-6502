CA65=/usr/bin/ca65
LD65=/usr/bin/ld65

basic.bin: min_mon.o
	$(LD65) -o basic.bin \
		-C basic.cfg \
		--mapfile basic.map \
		min_mon.o

min_mon.o: min_mon.s basic.s
	$(CA65) --cpu 6502 --debug-info --listing min_mon.lst --feature labels_without_colons min_mon.s

clean:
	rm -f min_mon.o basic.bin

