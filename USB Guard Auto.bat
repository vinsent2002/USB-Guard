@echo off
set "d=Quarantine"
set "s=System Volume Information"

for /f %%a in ('"2>nul wmic path Win32_LogicalDisk where (drivetype="2" and mediatype=null) get name|find ":""') do set "fl=%%a"& if exist "%%a" call :# "%%a"
if not defined fl echo No USB flash drive 
echo.
pause& exit

:#
 echo Selected disk: %~1
 echo.
 pushd "%~1"
  attrib -h -r -s /d /s "*.*"
  if not exist "%d%" md "%d%"
  attrib +h -r "%d%"
  for %%a in ("exe" "scr" "vb" "vbs" "vbe" "inf" "dll") do move /y "*.%%~a" "%d%"
  del /f /s /q "*.lnk" "*.tmp"
  attrib +h +s /d /s "%s%" 
 popd
exit /b