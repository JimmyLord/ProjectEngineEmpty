if [ "$1" != "" ]; then

    pushd ../GameEmptyReplaceMe

    echo ""
    echo "$(tput setaf 5)==> Switching to Xcode 7.3.1$(tput sgr0)"
    sudo xcode-select -switch /Applications/Xcode731/Xcode.app

    echo ""
    echo "$(tput setaf 5)==> Building Release Package for iOS6: iOS$(tput sgr0)"
    xcodebuild -xcconfig ../Releases/XcodeConfig-iOS6.xcconfig -scheme EmptyReplaceMe-iOS -config Release build -sdk iphoneos CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

    echo ""
    echo "$(tput setaf 5)==> Switching back to latest Xcode$(tput sgr0)"
    sudo xcode-select -switch /Applications/Xcode92/Xcode.app

    popd

    echo ""
    echo "$(tput setaf 5)==> Copying iOS Unsigned Release Package$(tput sgr0)"
    rsync -avL ../GameEmptyReplaceMe/Output/EmptyReplaceMe/Build/Products/Release-iphoneos/EmptyReplaceMe-iOS.app/ $1/MyEngine_Game_iOS6_Device.app/

else

    echo "$(tput setaf 5)Must supply a folder name$(tput sgr0)"

fi
