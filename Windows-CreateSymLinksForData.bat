@echo This batch file will link a data folder from Engine to GameEmptyReplaceMe/Game
@echo --

cd GameEmptyReplaceMe/Game
mklink /J "DataEngine" "../../Engine/DataEngine"

cd SourceAndroid/AndroidApk/assets
mklink /J "Data" "../../../Data"
mklink /J "DataEngine" "../../../DataEngine"

rem cd SourceAndroid/AndroidStudioProject/app/src/main/assets
rem mklink /J "Data" "../../../../../../Data"
rem mklink /J "DataEngine" "../../../../../../DataEngine"

cd ../../../SourceNaCL/Web
mklink /J "Data" "../../Data"
mklink /J "DataEngine" "../../DataEngine"

pause