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
echo 2. Update Configs Only
echo 2. Delete Mod Cache Only
echo 4. Set Casual Configuration Only
echo 5. Set Competitive Configuration Only
echo 6. Start in Casual Configuration
echo 7. Start in Competitive Configuration
echo 8. Start in Currrent Configuration
echo.

:getOptions
set "choices="
set /p "choices=Type your choices without spacing (e.g. 1,2,3): "

if not defined choices ( 
    echo Please enter a valid option
    goto getOptions
    )

for %%a in (%choices%) do if %%a EQU 6 set choices=1,2,3,4,5,6,7,8
for %%i in (%choices%) do call :option-%%i

echo.
echo Done!
exit

:option-1
"Team Fortress 2.url"
exit

:option-2
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\*"
start "" "%~f0"
exit

:option-3
del "%tf2-path%\tf\custom\*" /s/q
exit

:option-4
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "cfg\"
start "" "%~f0"
exit

:option-5
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "cfg\"
start "" "%~f0"
exit

:option-6
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\*"
del /F /S %tf2-path%\tf\custom\*.cache
"Team Fortress 2.url"

:option-7
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\*"
del /F /S %tf2-path%\tf\custom\*.cache
"Team Fortress 2.url"
exit

:option-8
del /F /S %tf2-path%\tf\custom\*.cache
"Team Fortress 2.url"
exit