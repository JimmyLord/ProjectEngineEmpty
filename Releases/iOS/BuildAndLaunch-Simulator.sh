
cd ..

echo ""
echo "$(tput setaf 5)==> Copying Data$(tput sgr0)"
rsync -avL Data MyEngine_Game_iOS_Simulator.app/

#echo ""
#echo "$(tput setaf 5)==> Launching Simulator$(tput sgr0)"
#echo "TODO: Launch simulator before running this script"

echo ""
echo "$(tput setaf 5)==> Installing package$(tput sgr0)"
xcrun simctl install booted MyEngine_Game_iOS_Simulator.app/

echo ""
echo "$(tput setaf 5)==> Launching game$(tput sgr0)"
xcrun simctl launch booted com.flatheadgames.EmptyReplaceMe
