@echo off
Set "SExe="
Set "SPth="
For /F "Tokens=1,2*" %%A In ('Reg Query HKCU\SOFTWARE\Valve\Steam') Do (
    If "%%A" Equ "SteamExe" Set "SExe=%%C"
    If "%%A" Equ "SteamPath" Set "SPth=%%C")
If Not Defined SExe Exit/B
Rem Your commands go under here for example
Echo=The full path to the Steam executable is "%SExe%"
If Defined SPth set "steam-dir=%SPth%"
set "tf2-path=%steam-dir%\steamapps\common\Team Fortress 2"
Echo=The full path to the TF2 Folder is "%tf2-path%"

echo.
echo Select what you'd like to do to play TF2.
echo.
echo 1. Start Normally
echo 2. Update Configs
echo 3. Set Casual Mods
echo 4. Set Competitive Mods
echo.

:getOptions
set "choices="
set /p "choices=Type your choices without spacing (e.g. 1,2,3): "

if not defined choices ( 
    echo Please enter a valid option
    goto getOptions
    )

for %%a in (%choices%) do if %%a EQU 6 set choices=1,2,3,4,5
for %%i in (%choices%) do call :option-%%i

echo.
echo Done!
exit

:option-1
cd "%tf2-path%\tf\custom"
cls
IF NOT EXIST "..\..\tf_win64.exe" (goto :WAIT)
goto :DOIT

:WAIT
color c
echo Error Code : E01 (not in custom folder)
goto :ASK

:ASK
set /P c=This program might not be in the CUSTOM folder, continue? [continue or cancel]
if /I %c% EQU continue goto :DOIT
if /I %c% EQU cancel goto :EXIT2

:DOIT
echo Removing cache files.
del /F /S *.cache
goto EXIT

:EXIT2
exit

:EXIT
"Team Fortress 2.url"
exit

:option-2
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
start "" "%~f0"
exit

:option-3
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "cfg\"
start "" "%~f0"
exit

:option-4
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "cfg\"
start "" "%~f0"
exit