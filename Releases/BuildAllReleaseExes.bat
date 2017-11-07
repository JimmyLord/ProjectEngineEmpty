call "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/vcvarsall.bat"

@rem Build all C++ configurations.
cd ../GameEmptyReplaceMe
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=Win32
msbuild EmptyReplaceMe.sln /property:Configuration=WxRelease /property:Platform=Win32
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=x64
msbuild EmptyReplaceMe.sln /property:Configuration=WxRelease /property:Platform=x64
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=PNaCl
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=Android

@rem Build Android Java files.
cd Game\SourceAndroid\BuildClassesDex
call BuildClassesDex.bat

pause