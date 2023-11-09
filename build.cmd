@echo off

cls

echo %time%

cd assets

..\..\tilemizer_nopack.py -b4 -m=16e00 -o=pixies -t="pixies.png"
C:\Users\death\Documents\C65\JettMonsters\tools\tilemizer.py -b4 -m=1a640 -o=level_indicator -t="level_marker.png"
C:\Users\death\Documents\C65\JettMonsters\tools\tilemizer.py -b4 -m=1b900 -o=unicorn_background -t="unicorn_background.png"
C:\Users\death\Documents\C65\JettMonsters\tools\tilemizer.py -b4 -m=40000 -o=background -t="background.png"

copy /b pixies.chrs+level_indicator.chrs+unicorn_background.chrs tileset.chrs

C:\Users\death\Documents\C65\JettMonsters\tools\tilemizer.py -b8 -m=30000 -o=unicorn_title_plain -t="unicorn_title_plain.png"
C:\Users\death\Documents\C65\JettMonsters\tools\tilemizer.py -b8 -m=30000 -o=unicorn_title_credits -t="unicorn_title_credits.png"

split unicorn_title_plain.chrs 32768
split unicorn_title_credits.chrs 32768
split background.chrs 32768
split game_over_2.raw 32768

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
cc6502 -O 2 --list-file build/difficulty.lst --assembly-source build/difficulty.s --core 45gs02 --target MEGA65 src/difficulty.c
cc6502 -o build/difficulty.o -O 2 --list-file build/difficulty.lst --core 45gs02 --target MEGA65 src/difficulty.c
cc6502 --list-file build/audio.lst --assembly-source build/audio.s --core 45gs02 --target MEGA65 src/audio.c
cc6502 -o build/audio.o --list-file build/audio.lst --core 45gs02 --target MEGA65 src/audio.c
cc6502 --list-file build/titleloop.lst --assembly-source build/titleloop.s --core 45gs02 --target MEGA65 src/titleloop.c
cc6502 -o build/titleloop.o --list-file build/titleloop.lst --core 45gs02 --target MEGA65 src/titleloop.c
cc6502 --list-file build/gameoverloop.lst --assembly-source build/gameoverloop.s --core 45gs02 --target MEGA65 src/gameoverloop.c
cc6502 -o build/gameoverloop.o --list-file build/gameoverloop.lst --core 45gs02 --target MEGA65 src/gameoverloop.c

as6502 -o build/irqload.o --list-file build/irqload.lst --core 45gs02 --target MEGA65 src/iffl/irqload.s
as6502 -o build/decruncher.o --list-file build/decruncher.lst --core 45gs02 --target MEGA65 src/iffl/decruncher.s
as6502 -o build/iffl.o --list-file build/iffl.lst --core 45gs02 --target MEGA65 src/iffl/iffl.s
as6502 -o build/rng.o --list-file build/rng.lst --core 45gs02 --target MEGA65 src/rng.s

ln6502 -o build/unicone_full.prg --list-file build/unicone.lst --verbose --output-format prg --core 45gs02 --target mega65 build/main.o build/setup.o build/dma.o build/dma_jobs.o build/irqload.o build/decruncher.o build/iffl.o build/interrupt.o build/gameloop.o build/maps.o build/pixies.o build/input.o build/player.o build/unicorn.o build/rng.o build/icecream.o build/swing.o build/difficulty.o build/audio.o build/titleloop.o build/gameoverloop.o ./mega65-unicone.scm

echo %time%

pause

C:\Users\death\Documents\C65\exomizer-3.1.1\win32\exomizer sfx basic -t 65 -o build/unicone.prg build/unicone_full.prg

C:\Users\death\Documents\C65\acme\acme src\music_swap_stub.asm
C:\Users\death\Documents\C65\acme\acme src\tilemap.asm
C:\Users\death\Documents\C65\acme\acme src\attrmap.asm
C:\Users\death\Documents\C65\acme\acme src\flavors.asm

REM Loading Screen Data
C:\Users\death\Documents\C65\megatool\megatool -a assets/pixies.clut 00025000

C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain_0.chrs 00030000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain_1.chrs 00010000

C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain_2.chrs 00040000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain_3.chrs 00010000

C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain_4.chrs 00050000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain.map 00059200
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_plain.atr 0005b800

REM Title Screen Data
C:\Users\death\Documents\C65\megatool\megatool -a build/music_swap_stub.bin 0000c000

C:\Users\death\Documents\C65\megatool\megatool -a assets/megakitty_theme_1.prg 00010000

C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits_0.chrs 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits_1.chrs 00010000

C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits_2.chrs 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits_3.chrs 00010000

C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits_4.chrs 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits_5.chrs 00018000
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits.map 00019400
C:\Users\death\Documents\C65\megatool\megatool -a assets/unicorn_title_credits.atr 0001ba00

REM In Game Data
C:\Users\death\Documents\C65\megatool\megatool -a assets/sentimental_thing.prg 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/tileset.chrs 00016e00
C:\Users\death\Documents\C65\megatool\megatool -a build/tilemap.bin 0001c600
C:\Users\death\Documents\C65\megatool\megatool -a build/flavors.bin 0001f100

C:\Users\death\Documents\C65\megatool\megatool -a assets/game_start.raw 00012b00
C:\Users\death\Documents\C65\megatool\megatool -a assets/trot.raw 00019100
C:\Users\death\Documents\C65\megatool\megatool -a assets/splat_1.raw 0001ac00

C:\Users\death\Documents\C65\megatool\megatool -a assets/falling.raw 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/splat_2.raw 0001b700

C:\Users\death\Documents\C65\megatool\megatool -a assets/background_0.chrs 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/background_1.chrs 00010000

C:\Users\death\Documents\C65\megatool\megatool -a assets/background_2.chrs 00010000
C:\Users\death\Documents\C65\megatool\megatool -a assets/splat_3.raw 00017c00

REM Game Over Data
C:\Users\death\Documents\C65\megatool\megatool -a assets/game_over_1.raw 00012b00
C:\Users\death\Documents\C65\megatool\megatool -a build/attrmap.bin 0001b200

C:\Users\death\Documents\C65\megatool\megatool -a assets/game_over_2.raw 00010000

REM Level Complete Data
C:\Users\death\Documents\C65\megatool\megatool -a assets/level_end.raw 00010000


REM Loading Screen Data
C:\Users\death\Documents\C65\megatool\megatool -c assets/pixies.clut.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain_0.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain_1.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain_2.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain_3.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain_4.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain.map.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_plain.atr.addr

REM Title Screen Data
C:\Users\death\Documents\C65\megatool\megatool -c build/music_swap_stub.bin.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/megakitty_theme_1.prg.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits_0.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits_1.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits_2.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits_3.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits_4.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits_5.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits.map.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/unicorn_title_credits.atr.addr

REM In Game Data
C:\Users\death\Documents\C65\megatool\megatool -c assets/sentimental_thing.prg.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/tileset.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c build/tilemap.bin.addr
C:\Users\death\Documents\C65\megatool\megatool -c build/flavors.bin.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/game_start.raw.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/trot.raw.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/splat_1.raw.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/falling.raw.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/splat_2.raw.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/background_0.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/background_1.chrs.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/background_2.chrs.addr
C:\Users\death\Documents\C65\megatool\megatool -c assets/splat_3.raw.addr

REM Game Over Data
C:\Users\death\Documents\C65\megatool\megatool -c assets/game_over_1.raw.addr
C:\Users\death\Documents\C65\megatool\megatool -c build/attrmap.bin.addr

C:\Users\death\Documents\C65\megatool\megatool -c assets/game_over_2.raw.addr

REM Level Complete Data
C:\Users\death\Documents\C65\megatool\megatool -c assets/level_end.raw.addr


C:\Users\death\Documents\C65\megatool\megatool -i assets/pixies.clut.addr.mc assets/unicorn_title_plain_0.chrs.addr.mc assets/unicorn_title_plain_1.chrs.addr.mc assets/unicorn_title_plain_2.chrs.addr.mc assets/unicorn_title_plain_3.chrs.addr.mc assets/unicorn_title_plain_4.chrs.addr.mc assets/unicorn_title_plain.map.addr.mc assets/unicorn_title_plain.atr.addr.mc build/music_swap_stub.bin.addr.mc assets/megakitty_theme_1.prg.addr.mc assets/unicorn_title_credits_0.chrs.addr.mc assets/unicorn_title_credits_1.chrs.addr.mc assets/unicorn_title_credits_2.chrs.addr.mc assets/unicorn_title_credits_3.chrs.addr.mc assets/unicorn_title_credits_4.chrs.addr.mc assets/unicorn_title_credits_5.chrs.addr.mc assets/unicorn_title_credits.map.addr.mc assets/unicorn_title_credits.atr.addr.mc assets/level_end.raw.addr.mc assets/unicone0

C:\Users\death\Documents\C65\megatool\megatool -i assets/sentimental_thing.prg.addr.mc assets/tileset.chrs.addr.mc build/tilemap.bin.addr.mc build/flavors.bin.addr.mc assets/game_start.raw.addr.mc assets/trot.raw.addr.mc assets/splat_1.raw.addr.mc assets/falling.raw.addr.mc assets/splat_2.raw.addr.mc assets/background_0.chrs.addr.mc assets/background_1.chrs.addr.mc assets/background_2.chrs.addr.mc assets/splat_3.raw.addr.mc assets/game_over_1.raw.addr.mc build/attrmap.bin.addr.mc assets/game_over_2.raw.addr.mc assets/unicone1


C:\Users\death\Documents\C64\GTK3VICE-3.6.1-win64\bin\c1541 -attach build/unicone.d81 -delete "unicone     /bas" -delete "+unicone0" -delete "+unicone1" -write "build/unicone.prg" "unicone     /bas" -write "assets/unicone0" "+unicone0" -write "assets/unicone1" "+unicone1" -list

pause

run
