@echo off 

set DLC=C:\Progress\OpenEdge
set WRKDIR=%CD%

if exist "%DLC%"\promsgs goto ANT
   echo.
   echo DLC variable is not correct - Please check setting in (%0)
   echo.
   pause
   exit 

:ANT
if "%ANT_HOME%"==""       set ANT_HOME=C:\Progress\OpenEdge\ant

set ANT_EXE=%ANT_HOME%\bin\ant.bat

if exist "%ANT_HOME%"\bin\ant.bat goto START
   echo.
   echo ANT_HOME variable is not correct - Please check setting in (%0)
   echo.	
   pause
   exit 

:START
   "%ANT_EXE%" %1

