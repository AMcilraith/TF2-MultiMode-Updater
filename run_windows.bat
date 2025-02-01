@echo off

:: Set Directories
set "steam-dir=%HOMEDRIVE%\Program Files (x86)\steam"
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
echo.
goto getOptions

:: Get User Options
:getOptions
set "choices=1,2,3,4,5,6,7,8,9,10"
set /p "choices=Type your choice without spacing (e.g. 1,2,3): "

if not defined choices (
    echo Please enter a valid option
    goto getOptions
) else (
    for %%i in (%choices%) do call :option-%%i
)

echo.
echo Done!
exit

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
del /F /S "%tf2-path%\tf\custom\*.vpk.sound.cache" >nul 2>&1
call :startOptions

:: Option 4 - Set Casual Configuration Only
:option-4
cls
del /F /S "%tf2-path%\tf\custom\*" >nul 2>&1
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 5 - Set Competitive Configuration Only
:option-5
cls
del /F /S "%tf2-path%\tf\custom\*" >nul 2>&1
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 6 - Set No Mods Configuration Only
:option-6
cls
del /F /S "%tf2-path%\tf\custom\*" >nul 2>&1
echo Mods have been removed.
pause
call :startOptions

:: Option 7 - Start in Casual Configuration
:option-7
cls
del /F /S "%tf2-path%\tf\custom\*" >nul 2>&1
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 8 - Start in Competitive Configuration
:option-8
cls
del /F /S "%tf2-path%\tf\custom\*" >nul 2>&1
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 9 - Start in No Mods Configuration
:option-9
cls
del /F /S "%tf2-path%\tf\custom\*" >nul 2>&1
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 10 - Start in Current Configuration
:option-10
cls
del /F /S "%tf2-path%\tf\custom\*.vpk.sound.cache" >nul 2>&1
"%steam-dir%\steam.exe" steam://rungameid/440
exit

