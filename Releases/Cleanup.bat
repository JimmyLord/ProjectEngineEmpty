@IF [%1] == [] GOTO Error

rmdir /Q /S %1\Android\assets
rmdir /Q /S %1\Android\Output

rmdir /Q /S %1\Emscripten

rmdir /Q /S %1\Web\Data

@GOTO End

:Error
@echo "Must supply a folder name (i.e. Drag and drop a folder onto this batch file)"
@pause

:End
