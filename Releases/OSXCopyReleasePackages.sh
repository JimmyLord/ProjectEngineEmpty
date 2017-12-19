if [ "$1" != "" ]; then

    echo ""
    echo "$(tput setaf 5)==> Copying iOS Unsigned Release Package$(tput sgr0)"
    rsync -avL ../GameEmptyReplaceMe/Output/EmptyReplaceMe/Build/Products/Release-iphonesimulator/EmptyReplaceMe-iOS.app/ $1/MyEngine_Game_iOS_Simulator.app/
    rsync -avL ../GameEmptyReplaceMe/Output/EmptyReplaceMe/Build/Products/Release-iphoneos/EmptyReplaceMe-iOS.app/ $1/MyEngine_Game_iOS_Device.app/

    echo ""
    echo "$(tput setaf 5)==> Copying Release Package: Game$(tput sgr0)"
    rsync -avL ../GameEmptyReplaceMe/Output/EmptyReplaceMe/Build/Products/Release/EmptyReplaceMe-OSX.app/ $1/MyEngine_Game.app/

    echo ""
    echo "$(tput setaf 5)==> Copying Release Package: Editor$(tput sgr0)"
    rsync -avL ../GameEmptyReplaceMe/Output/EmptyReplaceMe/Build/Products/Release/EmptyReplaceMe-wx.app/ $1/MyEngine_Editor.app/

else

    echo "$(tput setaf 5)Must supply a folder name$(tput sgr0)"

fi
