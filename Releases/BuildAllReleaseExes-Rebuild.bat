call "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/vcvarsall.bat"

@rem Build all C++ configurations.
cd ../GameEmptyReplaceMe
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=Win32 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=EditorRelease /property:Platform=Win32 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=x64 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=EditorRelease /property:Platform=x64 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=PNaCl /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=Android /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=Emscripten /t:Rebuild

@rem Build Android Java files.
cd Game\SourceAndroid\BuildClassesDex
call BuildClassesDex.bat

pause
