@echo off
setlocal enabledelayedexpansion

rem Specify the subfolder name
set "subfolder=Secondary"

rem Get the absolute path of the current directory
for %%I in ("%CD%") do set "currentPath=%%~fI"

rem Combine the current path with the subfolder name
set "subfolderPath=!currentPath!\!subfolder!"

rem Copy contents to the parent folder, replacing existing files
for %%A in ("!subfolderPath!\*") do (
    copy /y "%%A" "!currentPath!"
)

echo Contents of %subfolder% copied to the parent folder, replacing existing files.

endlocal
