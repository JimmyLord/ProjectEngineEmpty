cd Framework/Libraries/wxWidgets/build/msw
call "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/vcvarsall.bat"
nmake /f makefile.vc BUILD=debug
nmake /f makefile.vc BUILD=release
cd ../../lib
rename vc_lib vc100_lib
cd ../../../..

rem cd bullet3/build3
rem call vs2010
rem cd ../..

pause