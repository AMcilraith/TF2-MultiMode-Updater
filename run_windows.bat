@echo off

:: Always run from the folder where this script lives (so cfg, autoexec_*, etc. are found)
cd /d "%~dp0"
set "SCRIPT_DIR=%~dp0"

:: Set Directories - detect Steam path (registry first, then search alternate drives)
set "steam-dir="
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "steam-dir=%%b"
if not defined steam-dir for /f "tokens=3*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "steam-dir=%%a %%b"
:: Normalize path (registry may use forward slashes)
if defined steam-dir set "steam-dir=%steam-dir:/=\%"

:: If still not found, search common paths on all drive letters
if not exist "%steam-dir%\steam.exe" (
    set "steam-dir="
    for %%D in (C D E F G H) do (
        if not defined steam-dir if exist "%%D:\Steam\steam.exe" set "steam-dir=%%D:\Steam"
        if not defined steam-dir if exist "%%D:\Program Files (x86)\Steam\steam.exe" set "steam-dir=%%D:\Program Files (x86)\Steam"
        if not defined steam-dir if exist "%%D:\Program Files\Steam\steam.exe" set "steam-dir=%%D:\Program Files\Steam"
    )
)

if not exist "%steam-dir%\steam.exe" (
    echo Steam not found. Checked registry and drives C: through G: for:
    echo   \Steam   \Program Files ^(x86^)\Steam   \Program Files\Steam
    echo Edit run_windows.bat and set steam-dir to your Steam folder.
    pause
    exit /b 1
)

:: Locate TF2 directory (may be in main Steam or an alternate library e.g. E:\SteamLibrary)
set "tf2-path="
if exist "%steam-dir%\steamapps\common\Team Fortress 2\tf" set "tf2-path=%steam-dir%\steamapps\common\Team Fortress 2"
if not defined tf2-path (
    for %%D in (C D E F G H) do (
        if not defined tf2-path if exist "%%D:\SteamLibrary\steamapps\common\Team Fortress 2\tf" set "tf2-path=%%D:\SteamLibrary\steamapps\common\Team Fortress 2"
        if not defined tf2-path if exist "%%D:\Steam\steamapps\common\Team Fortress 2\tf" set "tf2-path=%%D:\Steam\steamapps\common\Team Fortress 2"
        if not defined tf2-path if exist "%%D:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2\tf" set "tf2-path=%%D:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2"
        if not defined tf2-path if exist "%%D:\Steam Games\steamapps\common\Team Fortress 2\tf" set "tf2-path=%%D:\Steam Games\steamapps\common\Team Fortress 2"
    )
)
if not defined tf2-path set "tf2-path=%steam-dir%\steamapps\common\Team Fortress 2"
if not exist "%tf2-path%\tf" (
    echo Team Fortress 2 not found. Checked steamapps\common\Team Fortress 2\tf in:
    echo   main Steam dir, and on C-H: \SteamLibrary \Steam \Program Files ^(x86^)\Steam \Steam Games
    echo Edit run_windows.bat and set tf2-path to your TF2 folder.
    pause
    exit /b 1
)

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
xcopy /e /k /h /i /y "%SCRIPT_DIR%cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 3 - Delete Mod Cache Only
:option-3
cls
del /F /Q /S "%tf2-path%\tf\custom\*.vpk.sound.cache"
call :startOptions

:: Option 4 - Set Casual Configuration Only (Cueki Preloader: does not touch tf\custom)
:option-4
cls
xcopy /e /k /h /i /y "%SCRIPT_DIR%autoexec_casual\autoexec.cfg" "%tf2-path%\tf\cfg\"
robocopy "%SCRIPT_DIR%cfg" "%tf2-path%\tf\cfg" /E /IS /IT /XD w /NFL /NDL /NJH /NJS
robocopy "%SCRIPT_DIR%cfg" "%tf2-path%\tf\cfg\overrides" /E /IS /IT /XD w /NFL /NDL /NJH /NJS
call :startOptions

:: Option 5 - Set Competitive Configuration Only
:option-5
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
xcopy /e /k /h /i /y "%SCRIPT_DIR%custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%autoexec_comp\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%cfg\*" "%tf2-path%\tf\cfg\overrides\"
call :startOptions

:: Option 6 - Set No Mods Configuration Only
:option-6
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
echo Mods have been removed.
pause
call :startOptions

:: Option 7 - Start in Casual Configuration (Cueki Preloader: does not touch tf\custom)
:option-7
cls
xcopy /e /k /h /i /y "%SCRIPT_DIR%autoexec_casual\autoexec.cfg" "%tf2-path%\tf\cfg\"
robocopy "%SCRIPT_DIR%cfg" "%tf2-path%\tf\cfg" /E /IS /IT /XD w /NFL /NDL /NJH /NJS
robocopy "%SCRIPT_DIR%cfg" "%tf2-path%\tf\cfg\overrides" /E /IS /IT /XD w /NFL /NDL /NJH /NJS
"%steam-dir%\steam.exe" steam://rungameid/440
exit

:: Option 8 - Start in Competitive Configuration
:option-8
cls
del /F /Q /S "%tf2-path%\tf\custom\*"
xcopy /e /k /h /i /y "%SCRIPT_DIR%custom_comp\*" "%tf2-path%\tf\custom\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%autoexec_comp\autoexec.cfg" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%cfg\*" "%tf2-path%\tf\cfg\"
xcopy /e /k /h /i /y "%SCRIPT_DIR%cfg\*" "%tf2-path%\tf\cfg\overrides\"
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
dir /b "%SCRIPT_DIR%custom_hud"
set /p "hud_choice=Type the name of the HUD you want to use: "
del /F /Q /S "%tf2-path%\tf\custom\hud"
xcopy /e /k /h /i /y "%SCRIPT_DIR%custom_hud\%hud_choice%\*" "%tf2-path%\tf\custom\hud"
call :startOptions
