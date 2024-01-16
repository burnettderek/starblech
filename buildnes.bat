REM Deleting previous files
mkdir bin
cd bin
DEL *.gb
REM Compiling source files
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o main.o ..\main.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o sprite.o ..\sprite.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o hudmode.o ..\modes\hudmode.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o explorationmode.o ..\modes\explorationmode.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o enterprise.o ..\graphics\enterprise.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o space1.o ..\graphics\space1.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o bckground.o ..\graphics\bckground.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o terra.o ..\graphics\terra.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o saturn.o ..\graphics\saturn.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -c -o photon.o ..\graphics\photon.c

REM Compiling .gb files
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -mmos6502:nes -Wm-yoA -Wl-j -Wm-yS -o startrek.nes main.o explorationmode.o sprite.o space1.o enterprise.o bckground.o terra.o saturn.o photon.o hud.o

REM Cleaning up
::DEL *.asm
::DEL *.lst
::DEL *.ihx
:: *.sym
:: *.o

cd ..