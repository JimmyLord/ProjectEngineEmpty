@echo This batch file will link the game and engine data folders to the Android and NaCl build folders
@echo --

pushd GameEmptyReplaceMe\Game\Data
rmdir "DataEngine"
mklink /J "DataEngine" "../../../Engine/DataEngine"
popd

pushd GameEmptyReplaceMe\Game\DataSource
rmdir "DataEngineSource"
mklink /J "DataEngineSource" "../../../Engine/DataEngineSource"
popd

pushd GameEmptyReplaceMe\Game\SourceAndroid\AndroidStudio\app\src\main
mkdir assets
cd assets
rmdir "Data"
mklink /J "Data" "../../../../../../Data"
popd

pushd GameEmptyReplaceMe\Game\SourceNaCL\Web
rmdir "Data"
mklink /J "Data" "../../Data"
popd

rem TODO: Don't hardcode the path to mono installation.
copy "C:\Program Files (x86)\Mono\bin\mono-2.0-sgen.dll" "GameEmptyReplaceMe/Game/mono-2.0-sgen.dll"
mkdir GameEmptyReplaceMe\Game\mono\lib\mono\4.5
copy "C:\Program Files (x86)\Mono\lib\mono\4.5\mscorlib.dll" "GameEmptyReplaceMe/Game/mono/lib/mono/4.5/mscorlib.dll"

pause