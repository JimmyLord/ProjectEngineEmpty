@echo This batch file will link a data folder from Engine to GameEmptyReplaceMe/Game
@echo --

cd GameEmptyReplaceMe/Game
mklink /J "DataEngine" "../../Engine/DataEngine"

pause