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
echo 2. Delete Mod Cache Only
echo 4. Set Casual Configuration Only
echo 5. Set Competitive Configuration Only
echo 6. Start in Casual Configuration
echo 7. Start in Competitive Configuration
echo 8. Start in Currrent Configuration
echo.
goto getOptions

:: Get User Options
:getOptions
set "choices=1,2,3,4,5,6,7,8"
set /p "choices=Type your choice without spacing (e.g. 1,2,3): "

if not defined choices ( 
    echo Please enter a valid option
    goto getOptions
    )
else
for %%i in (%choices%) do call :option-%%i

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
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\*"
call :startOptions

:: Option 2 - Delete Mod Cache Only
:option-3
cls
del "%tf2-path%\tf\custom\*" /s/q
call :startOptions

:: Option 4 - Set Casual Configuration Only
:option-4
cls
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "cfg\"
call :startOptions

:: Option 5 - Set Competitive Configuration Only
:option-5
cls
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "cfg\"
call :startOptions


:option-6
cls
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_casual\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_casual\autoexec.cfg" "cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\*"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 7 - Start in Competitive Configuration
:option-7
cls
del "%tf2-path%\tf\custom\*" /s/q
xcopy /e /k /h /i /y "custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "autoexec_comp\autoexec.cfg" "cfg\"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\*"
xcopy /e /k /h /i /y "cfg\*" "%tf2-path%\tf\cfg\overrides\*"
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 8 - Start in Current Configuration
:option-8
cls
del /F /S %tf2-path%\tf\custom\*.cache
"%steam-dir%\steam.exe" steam://rungameid/440
exit