@IF [%1] == [] GOTO Error
xcopy ..\GameEmptyReplaceMe\Game %1 /U /S /Y
call CopyReleaseExes.bat %1
@GOTO End

:Error
@echo "Must supply a folder name (i.e. Drag and drop a folder onto this batch file)"

:End
@pause