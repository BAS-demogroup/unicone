@echo off

cls

cd assets

..\..\tilemizer_nopack.py -b4 -m=16d80 -o=pixies -t="pixies.png"
C:\Users\death\Documents\C65\JettMonsters\tools\tilemizer.py -b4 -m=23000 -o=level_indicator -t="level_marker.png"

cd ..

cc6502 -O 2 --list-file build/main.lst --assembly-source build/main.s --core 45gs02 --target MEGA65 src/main.c
cc6502 -o build/main.o -O 2 --list-file build/main.lst --core 45gs02 --target MEGA65 src/main.c
cc6502 -O 2 --list-file build/setup.lst --assembly-source build/setup.s --core 45gs02 --target MEGA65 src/setup.c
cc6502 -o build/setup.o -O 2 --list-file build/setup.lst --core 45gs02 --target MEGA65 src/setup.c
cc6502 -O 2 --list-file build/dma.lst --assembly-source build/dma.s --core 45gs02 --target MEGA65 src/dma.c
cc6502 -o build/dma.o -O 2 --list-file build/dma.lst --core 45gs02 --target MEGA65 src/dma.c
cc6502 -O 2 --list-file build/dma_jobs.lst --assembly-source build/dma_jobs.s --core 45gs02 --target MEGA65 src/dma_jobs.c
cc6502 -o build/dma_jobs.o -O 2 --list-file build/dma_jobs.lst --core 45gs02 --target MEGA65 src/dma_jobs.c
cc6502 -O 2 --list-file build/gameloop.lst --assembly-source build/gameloop.s --core 45gs02 --target MEGA65 src/gameloop.c
cc6502 -o build/gameloop.o -O 2 --list-file build/gameloop.lst --core 45gs02 --target MEGA65 src/gameloop.c
cc6502 -O 2 --list-file build/maps.lst --assembly-source build/maps.s --core 45gs02 --target MEGA65 src/maps.c
cc6502 -o build/maps.o -O 2 --list-file build/maps.lst --core 45gs02 --target MEGA65 src/maps.c
cc6502 -O 2 --list-file build/pixies.lst --assembly-source build/pixies.s --core 45gs02 --target MEGA65 src/pixies.c
cc6502 -o build/pixies.o -O 2 --list-file build/pixies.lst --core 45gs02 --target MEGA65 src/pixies.c
cc6502 -O 2 --list-file build/input.lst --assembly-source build/input.s --core 45gs02 --target MEGA65 src/input.c
cc6502 -o build/input.o -O 2 --list-file build/input.lst --core 45gs02 --target MEGA65 src/input.c
cc6502 -O 2 --list-file build/player.lst --assembly-source build/player.s --core 45gs02 --target MEGA65 src/player.c
cc6502 -o build/player.o -O 2 --list-file build/player.lst --core 45gs02 --target MEGA65 src/player.c
cc6502 -O 2 --list-file build/unicorn.lst --assembly-source build/unicorn.s --core 45gs02 --target MEGA65 src/unicorn.c
cc6502 -o build/unicorn.o -O 2 --list-file build/unicorn.lst --core 45gs02 --target MEGA65 src/unicorn.c
cc6502 -O 2 --list-file build/icecream.lst --assembly-source build/icecream.s --core 45gs02 --target MEGA65 src/icecream.c
cc6502 -o build/icecream.o -O 2 --list-file build/icecream.lst --core 45gs02 --target MEGA65 src/icecream.c
cc6502 -O 2 --list-file build/swing.lst --assembly-source build/swing.s --core 45gs02 --target MEGA65 src/swing.c
cc6502 -o build/swing.o -O 2 --list-file build/swing.lst --core 45gs02 --target MEGA65 src/swing.c

as6502 -o build/irqload.o --list-file build/irqload.lst --core 45gs02 --target MEGA65 src/iffl/irqload.s
as6502 -o build/decruncher.o --list-file build/decruncher.lst --core 45gs02 --target MEGA65 src/iffl/decruncher.s
as6502 -o build/iffl.o --list-file build/iffl.lst --core 45gs02 --target MEGA65 src/iffl/iffl.s
as6502 -o build/rng.o --list-file build/rng.lst --core 45gs02 --target MEGA65 src/rng.s

ln6502 -o build/unicone_full.prg --list-file build/unicone.lst --verbose --output-format prg --core 45gs02 --target mega65 build/main.o build/setup.o build/dma.o build/dma_jobs.o build/irqload.o build/decruncher.o build/iffl.o build/interrupt.o build/gameloop.o build/maps.o build/pixies.o build/input.o build/player.o build/unicorn.o build/rng.o build/icecream.o build/swing.o ./mega65-unicone.scm

pause

C:\Users\death\Documents\C65\exomizer-3.1.1\win32\exomizer sfx basic -t 65 -o build/unicone.prg build/unicone_full.prg

C:\Users\death\Documents\C65\acme\acme src\music_swap_stub.asm
C:\Users\death\Documents\C65\acme\acme src\tilemap.asm
C:\Users\death\Documents\C65\acme\acme src\attrmap.asm

C:\Users\death\Documents\C65\megatool\megatool -a build/music_swap_stub.bin 0000c000
C:\Users\death\Documents\C65\megatool\megatool -a assets/sentimental_thing.prg 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/pixies.chrs 00016d80
C:\Users\death\Documents\C65\megatool\megatool -a build/tilemap.bin 0001a5c0
C:\Users\death\Documents\C65\megatool\megatool -a build/attrmap.bin 0001ca78
C:\Users\death\Documents\C65\megatool\megatool -a assets/pixies.clut 0001ef30
C:\Users\death\Documents\C65\megatool\megatool -a assets/level_indicator.chrs 00023000

C:\Users\death\Documents\C65\megatool\megatool -c build/music_swap_stub.bin.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/sentimental_thing.prg.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/pixies.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c build/tilemap.bin.addr
C:\Users\death\Documents\C65\megatool\megatool -c build/attrmap.bin.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/pixies.clut.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/level_indicator.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -i build/music_swap_stub.bin.addr.mc assets/sentimental_thing.prg.addr.mc assets/pixies.chrs.addr.mc build/tilemap.bin.addr.mc build/attrmap.bin.addr.mc assets/pixies.clut.addr.mc assets/level_indicator.chrs.addr.mc assets/+unicone

C:\Users\death\Documents\C64\GTK3VICE-3.6.1-win64\bin\c1541 -attach build/unicone.d81 -delete "unicone" -delete "+unicone" -write "build/unicone.prg" "unicone" -write "assets/+unicone" "+unicone" -list

pause

run