REM Deleting previous files
mkdir bin
cd bin
DEL *.gb
REM Compiling source files
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o main.o ..\main.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o gameobject.o ..\model\gameobject.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o explorationmode.o ..\modes\explorationmode.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o hudmode.o ..\modes\hudmode.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o sprite.o ..\sprite.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o enterprise.o ..\graphics\enterprise.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o space1.o ..\graphics\space1.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o bckground.o ..\graphics\bckground.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o terra.o ..\graphics\terra.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o saturn.o ..\graphics\saturn.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o photon.o ..\graphics\photon.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o sensor_screen.o ..\graphics\sensor_screen.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o sensor_tiles.o ..\graphics\sensor_tiles.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o sensor_sprites.o ..\graphics\sensor_sprites.c
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -c -o asteroid_tiles.o ..\graphics\asteroid_tiles.c

REM Compiling .gb files
C:\source\gameboy\gbdk-win64\gbdk\bin\lcc -Wm-yC -o startrek.gbc main.o gameobject.o explorationmode.o hudmode.o sprite.o space1.o enterprise.o bckground.o terra.o saturn.o photon.o sensor_screen.o sensor_tiles.o sensor_sprites.o asteroid_tiles.o

REM Cleaning up
::DEL *.asm
::DEL *.lst
::DEL *.ihx
:: *.sym
:: *.o

cd ..