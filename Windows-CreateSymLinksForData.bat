@echo This batch file will link the game and engine data folders to the Android and NaCl build folders
@echo --

pushd GameEmptyReplaceMe\Game
mklink /J "DataEngine" "../../Engine/DataEngine"
popd

pushd GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main
mkdir assets
cd assets
mklink /J "Data" "../../../../../../Data"
mklink /J "DataEngine" "../../../../../../DataEngine"
popd

rem pushd GameEmptyReplaceMe\Game\SourceAndroid\AndroidApk
rem mkdir assets
rem cd assets
rem mklink /J "Data" "../../../Data"
rem mklink /J "DataEngine" "../../../DataEngine"
rem popd

pushd GameBlackJack\Game\SourceNaCL\Web
mklink /J "Data" "../../Data"
mklink /J "DataEngine" "../../DataEngine"
popd

pause