@echo off 

if "%DLC%"==""       set DLC=C:\Progress\OpenEdge
set WRKDIR=%CD%

if exist "%DLC%"\promsgs goto BIN
   echo DLC environment variable not set correctly - Please set DLC variable
   goto END

:BIN
if not "%PROEXE%"=="" goto START
   set PROEXE=%DLC%\bin\_progres

if "%ICU_DATA%"==""    set ICU_DATA="%DLC%\bin\icu\data\\"

:START
if "%DISPBANNER%"=="no" goto NOBANNER
   type "%DLC%"\hello

:NOBANNER
   type "%DLC%"\version
   "%PROEXE%" -p ABLUnitCore.p -param CFG=ablunit.json -basekey "INI" -ininame propath.ini

set DISPBANNER=
set PROWINEXE=
:END
