call "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/vcvarsall.bat"
cd ../GameEmptyReplaceMe
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=Win32 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=WxRelease /property:Platform=Win32 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=Release /property:Platform=x64 /t:Rebuild
msbuild EmptyReplaceMe.sln /property:Configuration=WxRelease /property:Platform=x64 /t:Rebuild
pause