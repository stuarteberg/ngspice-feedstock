@echo on

echo %cd%
echo %LIBRARY_BIN%

if "%ARCH%"=="32" (
set PLATFORM=x86
) else (
set PLATFORM=x64
)

REM The windows build expects flex-bison to be in a special location
mkdir ..\flex-bison
copy %LIBRARY_BIN%\win_bison.exe ..\flex-bison\
copy %LIBRARY_BIN%\win_flex.exe ..\flex-bison\

dir ../flex-bison

msbuild.exe ^
  /p:Platform=%PLATFORM% ^
  /p:PlatformToolset=v141 ^
  /p:WindowsTargetPlatformVersion=10.0.17763.0 ^
  /p:Configuration=console_release_omp ^
  /p:PostBuildEvent="" ^
  visualc\vngspice.sln ^
  || goto :error

make-install-vngspice.bat visualc\Release\ngspice_con.exe 64


REM msbuild.exe ^
REM   /p:Platform=%PLATFORM% ^
REM   /p:PlatformToolset=v141 ^
REM   /p:WindowsTargetPlatformVersion=10.0.17763.0 ^
REM   /p:Configuration=ReleaseOMP ^
REM   /p:PostBuildEvent="" ^
REM   visualc\vngspice.sln ^
REM   || goto :error

REM make-install-vngspice.bat visualc\Release\ngspice.exe 64