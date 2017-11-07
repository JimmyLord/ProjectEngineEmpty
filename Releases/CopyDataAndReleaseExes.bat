@IF [%1] == [] GOTO Error

@rem Update all existing files with matching files from the Game folder. (Data, DataSource and Tools)
xcopy ..\GameEmptyReplaceMe\Game %1 /U /S /Y

@rem Update all existing files with matching files from the Android build folders.
xcopy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\AndroidManifest.xml %1\Android /Y
xcopy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\res %1\Android\res\ /S /Y

call CopyReleaseExes.bat %1

@GOTO End

:Error
@echo "Must supply a folder name (i.e. Drag and drop a folder onto this batch file)"

:End
@pause