@echo off

cc6502 -O 2 --list-file build/main.lst --assembly-source build/main.s --core 45gs02 --target MEGA65 src/main.c
cc6502 -o build/main.o -O 2 --list-file build/main.lst --core 45gs02 --target MEGA65 src/main.c
cc6502 -O 2 --list-file build/setup.lst --assembly-source build/setup.s --core 45gs02 --target MEGA65 src/setup.c
cc6502 -o build/setup.o -O 2 --list-file build/setup.lst --core 45gs02 --target MEGA65 src/setup.c
cc6502 -O 2 --list-file build/dma.lst --assembly-source build/dma.s --core 45gs02 --target MEGA65 src/dma.c
cc6502 -o build/dma.o -O 2 --list-file build/dma.lst --core 45gs02 --target MEGA65 src/dma.c

as6502 -o build/irqload.o --list-file build/irqload.lst --core 45gs02 --target MEGA65 src/iffl/irqload.s
as6502 -o build/decruncher.o --list-file build/decruncher.lst --core 45gs02 --target MEGA65 src/iffl/decruncher.s
as6502 -o build/iffl.o --list-file build/iffl.lst --core 45gs02 --target MEGA65 src/iffl/iffl.s

ln6502 -o build/unicone.prg --raw-multiple-memories --list-file build/unicone.lst --verbose --output-format prg --core 45gs02 --target mega65 build/main.o build/setup.o build/dma.o build/irqload.o build/decruncher.o build/iffl.o mega65-plain.scm
