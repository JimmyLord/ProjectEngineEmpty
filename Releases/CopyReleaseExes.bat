@IF [%1] == [] GOTO Error

copy ..\GameEmptyReplaceMe\Output\Win32\EmptyReplaceMe\Release\EmptyReplaceMe_Release.exe %1\MyEngine_Game.exe
copy ..\GameEmptyReplaceMe\Output\Win32\EmptyReplaceMe\WxRelease\EmptyReplaceMe_WxRelease.exe %1\MyEngine_Editor.exe

copy ..\GameEmptyReplaceMe\Output\x64\EmptyReplaceMe\Release\EmptyReplaceMe_Release.exe %1\MyEngine_Game_x64.exe
copy ..\GameEmptyReplaceMe\Output\x64\EmptyReplaceMe\WxRelease\EmptyReplaceMe_WxRelease.exe %1\MyEngine_Editor_x64.exe

copy ..\GameEmptyReplaceMe\Game\SourceNaCL\Web\EmptyReplaceMe_Release.pexe %1\Web\MyEngine.pexe

mkdir %1\Android\lib\armeabi
copy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\jniLibs\armeabi\libEmptyReplaceMe.so %1\Android\lib\armeabi\libEmptyReplaceMe.so
copy ..\GameEmptyReplaceMe\Output\AndroidClassesDex\classes.dex %1\Android\classes.dex

@GOTO End

:Error
@echo "Must supply a folder name (i.e. Drag and drop a folder onto this batch file)"

:End
@pause