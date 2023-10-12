@echo off

cls

cd assets

..\..\tilemizer_nopack.py -b4 -m=16d80 -o=pixies -t="pixies.png"

cd ..

cc6502 -O 2 --list-file build/main.lst --assembly-source build/main.s --core 45gs02 --target MEGA65 src/main.c
cc6502 -o build/main.o -O 2 --list-file build/main.lst --core 45gs02 --target MEGA65 src/main.c
cc6502 -O 2 --list-file build/setup.lst --assembly-source build/setup.s --core 45gs02 --target MEGA65 src/setup.c
cc6502 -o build/setup.o -O 2 --list-file build/setup.lst --core 45gs02 --target MEGA65 src/setup.c
cc6502 -O 2 --list-file build/dma.lst --assembly-source build/dma.s --core 45gs02 --target MEGA65 src/dma.c
cc6502 -o build/dma.o -O 2 --list-file build/dma.lst --core 45gs02 --target MEGA65 src/dma.c

as6502 -o build/irqload.o --list-file build/irqload.lst --core 45gs02 --target MEGA65 src/iffl/irqload.s
as6502 -o build/decruncher.o --list-file build/decruncher.lst --core 45gs02 --target MEGA65 src/iffl/decruncher.s
as6502 -o build/iffl.o --list-file build/iffl.lst --core 45gs02 --target MEGA65 src/iffl/iffl.s

ln6502 -o build/unicone.prg --list-file build/unicone.lst --verbose --output-format prg --core 45gs02 --target mega65 build/main.o build/setup.o build/dma.o build/irqload.o build/decruncher.o build/iffl.o build/interrupt.o ./mega65-unicone.scm

pause

C:\Users\death\Documents\C65\megatool\megatool -a assets/sentimental_thing.prg 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/pixies.chrs 00016d80

C:\Users\death\Documents\C65\megatool\megatool -c assets/sentimental_thing.prg.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/pixies.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -i assets/sentimental_thing.prg.addr.mc assets/pixies.chrs.addr.mc assets/+unicone

C:\Users\death\Documents\C64\GTK3VICE-3.6.1-win64\bin\c1541 -attach build/unicone.d81 -delete "unicone" -delete "+unicone" -write "build/unicone.prg" "unicone" -write "assets/+unicone" "+unicone" -list

call start /b "xemu" "C:\Users\death\Documents\C65\xemu-binaries-win64\xmega65" -8 build/unicone.d81
