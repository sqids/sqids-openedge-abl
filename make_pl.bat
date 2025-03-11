@echo off
setlocal enabledelayedexpansion

if "%DLC%"=="" set DLC=C:\Progress\OpenEdge
if exist "%DLC%\promsgs" goto START
   echo DLC environment variable not set correctly - Please set DLC variable
   goto :eof

:START

type "%DLC%"\hello

set PL_FILE=Sqids.pl

cd rcode >nul 2>&1

if exist "%PL_FILE%" (
   del /q "%PL_FILE%" >nul 2>&1
)

call :len var "%CD%"  &:: "var"
set /a var+=1

"%DLC%\bin\prolib.exe" "%PL_FILE%" -create >nul 2>&1

@FOR /R %%a in (*.r) do (
	set str=%%a
	for /l %%i in (%var%,1,%var%) do (
		"%DLC%\bin\prolib.exe" "%PL_FILE%" -add !str:~%%i! >nul 2>&1
	)
)

"%DLC%\bin\prolib.exe" "%PL_FILE%" -compress >nul 2>&1
"%DLC%\bin\prolib.exe" "%PL_FILE%" -list 

pause
goto :eof

:len
 set len=%~2
 if not "%len%"=="" set /a %1+=1 & call :len %1 "%len:~1%"
goto :eof
