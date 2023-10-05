@echo off

cc6502 -O 2 --list-file build/main.lst --assembly-source build/main.s --core 45gs02 --target MEGA65 src/main.c
cc6502 -o build/main.o -O 2 --list-file build/main.lst --core 45gs02 --target MEGA65 src/main.c
cc6502 -O 2 --list-file build/setup.lst --assembly-source build/setup.s --core 45gs02 --target MEGA65 src/setup.c
cc6502 -o build/setup.o -O 2 --list-file build/setup.lst --core 45gs02 --target MEGA65 src/setup.c
cc6502 -O 2 --list-file build/irqload.lst --assembly-source build/irqload.s --core 45gs02 --target MEGA65 src/iffl/irqload.c
cc6502 -o build/irqload.o -O 2 --list-file build/irqload.lst --core 45gs02 --target MEGA65 src/iffl/irqload.c
cc6502 -O 2 --list-file build/dma.lst --assembly-source build/dma.s --core 45gs02 --target MEGA65 src/dma.c
cc6502 -o build/dma.o -O 2 --list-file build/dma.lst --core 45gs02 --target MEGA65 src/dma.c

ln6502 -o build/unicone.prg --raw-multiple-memories --list-file --verbose -l --output-format prg --core 45gs02 --target mega65 build/main.o build/setup.o build/irqload.o build/dma.o mega65-plain.scm
