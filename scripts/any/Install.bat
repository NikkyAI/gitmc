@echo off
cd %~dp0

SET directory=%1
ECHO "%directory%"

if not defined directory set directory=%ProgramFiles%\GitMC

ECHO "%directory%"

CALL :NORMALIZEPATH "%directory%"
SET directory=%RETVAL%

ECHO "%directory%"

:: # test dotnet
where dotnet > NUL 2> NUL
if errorlevel 1 goto :noDotnet
goto :copyTask

:noDotnet
:: #TODO: prompt install dotnet
echo "press enter to get .Net Core 1.1.1 (Runtime)"
pause > NUL 2> NUL
start "" https://www.microsoft.com/net/download/core#/runtime


:copyTask

echo "setting %%GITMC_CLI%% to %~dp0\%directory%"
set GITMC_CLI="%directory%"
echo "%%GITMC_CLI%% = %GITMC_CLI%"
setx GITMC_CLI %GITMC_CLI%

:: copy bin into target location (program files)
:: copy scripts next to bin
REM robocopy %~dp0\scripts "%directory%" *.* /MIR
robocopy %~dp0\bin "%directory%" *.* /MIR

:: copy all wrapper scripts

:: test if gitmc is executeable
where gitmc > NUL 2> NUL 
if errorlevel 1 goto :notInPath
goto :END

:notInPath
echo "not in path"
echo "trying to add '%%GITMC_CLI%%' to path"
:: DOS is horrible for forcing us to do THIS

for /F "tokens=2* delims= " %%f IN ('reg query "HKCU\Environment" /v Path ^| findstr /i path') do set OLD_USER_PATH=%%g
if defined OLD_USER_PATH setx PATH "%OLD_USER_PATH%;%%GITMC_CLI%%"


REM for /F "tokens=2* delims= " %%f IN ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path ^| findstr /i path') do set OLD_SYSTEM_PATH=%%g
REM if defined OLD_SYSTEM_PATH setx PATH "%OLD_SYSTEM_PATH%;%%GITMC_CLI%%;" -m
REM setx GITMC_CLI "%GITMC_CLI%" -m


:END
pause

:: ========== FUNCTIONS ==========
EXIT /B
:NORMALIZEPATH
  SET RETVAL=%~dpfn1
  EXIT /B