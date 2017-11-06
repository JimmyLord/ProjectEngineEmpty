@IF [%1] == [] GOTO Error

@rem Update all existing files with matching files from the Game folder. (Data, DataSource and Tools)
xcopy ..\GameEmptyReplaceMe\Game %1 /U /S /Y

@rem Update all existing files with matching files from the Android build folders.
xcopy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\AndroidManifest.xml %1\Android\AndroidManifest.xml /U /Y
xcopy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\aidl %1\Android\aidl /U /S /Y
xcopy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\java %1\Android\java /U /S /Y
xcopy ..\GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main\res %1\Android\res /U /S /Y
xcopy ..\Framework\MyFramework\SourceAndroid\MYFWsrc %1\Android\java /U /S /Y

call CopyReleaseExes.bat %1

@GOTO End

:Error
@echo "Must supply a folder name (i.e. Drag and drop a folder onto this batch file)"

:End
@pause