@echo off

:: Set Directories
set "steam-dir=%HOMEDRIVE%\Program Files (x86)\Steam"
set "tf2-path=%steam-dir%\steamapps\common\Team Fortress 2"

:: Start Options Menu
:startOptions
cls
echo.
echo Select what you'd like to do to play TF2.
echo.
echo 1. Start Normally
echo 2. Update Configs Only
echo 3. Delete Mod Cache Only
echo 4. Set Casual Configuration Only
echo 5. Set Competitive Configuration Only
echo 6. Remove Mods Only, Keep Existing Configuration
echo 7. Start in Casual Configuration
echo 8. Start in Competitive Configuration
echo 9. Remove Mods and Start in Current Configuration
echo 10. Start in Current Configuration
echo 11. Switch HUD
echo.
goto getOptions

:: Get User Options
:getOptions
set /p "choice=Type your choice (1-11): "

if "%choice%"=="1" goto option-1
if "%choice%"=="2" goto option-2
if "%choice%"=="3" goto option-3
if "%choice%"=="4" goto option-4
if "%choice%"=="5" goto option-5
if "%choice%"=="6" goto option-6
if "%choice%"=="7" goto option-7
if "%choice%"=="8" goto option-8
if "%choice%"=="9" goto option-9
if "%choice%"=="10" goto option-10
if "%choice%"=="11" goto option-11

echo Please enter a valid option
goto getOptions

:: Option 1 - Start Normally
:option-1
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 2 - Update Configs Only
:option-2
cls
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 3 - Delete Mod Cache Only
:option-3
cls
del /F /Q /S "%tf2-path%\tf\custom\*.vpk.sound.cache"
call :startOptions

:: Option 4 - Set Casual Configuration Only
:option-4
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 5 - Set Competitive Configuration Only
:option-5
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 6 - Set No Mods Configuration Only
:option-6
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
echo Mods have been removed.
pause
call :startOptions

:: Option 7 - Start in Casual Configuration
:option-7
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 8 - Start in Competitive Configuration
:option-8
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 9 - Start in No Mods Configuration
:option-9
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 10 - Start in Current Configuration
:option-10
cls
del /F /Q /S "%tf2-path%\tf\custom\*.vpk.sound.cache"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 11 - Switch HUD
:option-11
cls
echo Available HUDs:
dir /b custom_hud
set /p "hud_choice=Type the name of the HUD you want to use: "
del /F /Q /S "%tf2-path%\tf\custom\hud"
xcopy /e /k /h /i /y "custom_hud\%hud_choice%\*" "%tf2-path%\tf\custom\hud"
call :startOptions
