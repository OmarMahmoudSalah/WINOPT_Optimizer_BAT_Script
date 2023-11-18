@echo off
CLS
ECHO =============================
ECHO Windows Optimization Script APLHA -22/9/2018
ECHO =============================
ECHO This Project automates cleaning your system from unused files and helps to
ECHO improve your performance with ordered commands using your preinstalled tools
ECHO and may include also other GUI Tools to make it easier for
ECHO you to clean and choose what is best for you,Project based on .bat script
ECHO for a lightweight efficient tool 
ECHO =============================
ECHO **Created By OmarKwedar**
ECHO =============================

pause 

ECHO =============================
ECHO Windows Optimization Script APLHA -22/9/2018
ECHO =============================
ECHO **************************************
ECHO 1st: Disk Cleanup
ECHO **************************************
echo Using DEL command for cleaning temp files first
del /s /f /q %userprofile%\Recent\*.*
del /s /f /q %windir%\Prefetch\*.* 
del /s /f /q %windir%\Temp\*.*
del /s /f /q %windir%\system32\dllcache\*.*    
rd /s /q %windir%\system32\dllcache    
md %windir%\system32\dllcache
del /s /f /q "%USERPROFILE%\Cookies"\*.*    
rd /s /q "%USERPROFILE%\Cookies"    
md "%USERPROFILE%\Cookies"
echo Using DiskCleanup Utiltty
echo The Upcoming command will clean-up what you choose in all your drives
echo If Operation lag,just move the cursor to DiskCleanup dialog..
ECHO =============================
pause
ECHO Performing Command Please Wait ...
cleanmgr /sageset:65535 
cleanmgr /sagerun:65535
pause
cls
echo Cleaning browsers operation 
:choice
set /P c=Do you want to clean Google Chrome(if found)[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice


:yes
ECHO **** Clearing Chrome cache 
echo Please beaware that this operation needs to kill google chrome 
echo and deletes all chrome data as its new 

:choice
set /P c=Do You Want To Proceed ?[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice


:yes
taskkill /F /IM "chrome.exe">nul 2>&1
@rem Clear Google Chrome cache
erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i"  
ECHO **** Clearing Chrome DONE
:no


:no




:choice
set /P c=Do you want to clean Firefox(if found)[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice


:yes
ECHO **** Clearing Firefox Cahce
echo Please beaware that this operation needs to kill firefox
echo and deletes all Firefox data as its new 

:choice
set /P c=Do You Want To Proceed ?[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice


:yes
taskkill /F /IM "firefox.exe">nul 2>&1
@rem Clear Firefox cache
erase "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do RD /S /Q "%%i"
set DataDir=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles
del /q /s /f "%DataDir%"
rd /s /q "%DataDir%"
for /d %%x in (C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\*) do del /q /s /f %%x\*sqlite
ECHO **** Clearing Firefox DONE
:no


:no

cd %b2eincfilepath%
cls 



:choice
set /P c=Do you want to chkdsk using chkdsk utiltty [Y/N]?
if /I "%c%" EQU "Y" goto :Y
if /I "%c%" EQU "N" goto :N
goto :choice


:Y
cd Tools\chkdsk
start /w chkdsk-gui.exe

:N
cls
:choice
set /P c=Do you want to check for malwares Via AdwCleaner [Y/N]?
if /I "%c%" EQU "Y" goto :Y
if /I "%c%" EQU "N" goto :N
goto :choice


:Y
cd .. 
cd %b2eincfilepath%\Tools\adw
start /w adwcleaner_7.2.2.exe

:N
pause
cls
ECHO **************************************
ECHO 2nd Disk Defragmentation
ECHO **************************************
pause
defrag /C /H /V /U
cls
pause 
ECHO **************************************
ECHO 3rd:DISM
ECHO **************************************

:choice
echo if no script will use standard DISM 
echo ------------------------------------
set /P c=Do you want to use Dism ++ utility [Y/N]?

if /I "%c%" EQU "Y" goto :Y
if /I "%c%" EQU "N" goto :N
goto :choice

:Y

FOR /f "tokens=2 delims==" %%f IN ('wmic os get osarchitecture /value ^| find "="') DO SET "OS_ARCH=%%f"
IF "%OS_ARCH%"=="32-bit" GOTO :32bit
IF "%OS_ARCH%"=="64-bit" GOTO :64bit

:32bit
cd .. 
cd %b2eincfilepath%\Tools\dism++
start /w Dism++x86
GOTO :SUCCESS

:64bit
cd .. 
cd %b2eincfilepath%\Tools\dism++
start /w Dism++x64
GOTO :SUCCESS

:N
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
GOTO :SUCCESS

:SUCCESS
cls 
pause 
ECHO **************************************
ECHO 4th:System file checker -SFC
ECHO **************************************
sfc /scannow