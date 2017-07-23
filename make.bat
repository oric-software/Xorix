@echo off

SET PATH=%PATH%;%CC65%

SET ORICUTRON="..\..\..\oricutron\"
set PATH_VID="usr\share\presto"
SET ORIGIN_PATH=%CD%
SET BINARY=xorix
set VERSION="0.0.1"

%OSDK%\bin\xa.exe -v -R -cc src\%BINARY%.asm -o build\%BINARY%.o65
co65  build\%BINARY%.o65 


cl65 -ttelestrat src/%BINARY%.c build/%BINARY%.s  ..\oric-common\lib\ca65\telestrat\hires.s -o release\orix\bin\%BINARY%

IF "%1"=="NORUN" GOTO End

copy  release\orix\bin\%BINARY% %ORICUTRON%\usbdrive\bin\%BINARY%


cd %ORICUTRON%
OricutronV4 -mt
cd %ORIGIN_PATH%
:End


