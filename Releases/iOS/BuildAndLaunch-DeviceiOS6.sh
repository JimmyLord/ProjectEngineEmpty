
source Setup.sh

cd ..

sudo xcode-select -switch /Applications/Xcode731/Xcode.app

echo ""
echo "$(tput setaf 5)==> Copying Data$(tput sgr0)"
rsync -avL Data MyEngine_Game_iOS6_Device.app/

echo ""
echo "$(tput setaf 5)==> Signing Code and Data$(tput sgr0)"
codesign -s "$IOSSigningIdentity" MyEngine_Game_iOS6_Device.app/

echo ""
echo "$(tput setaf 5)==> Launching app$(tput sgr0)"
ios-deploy --justlaunch --bundle MyEngine_Game_iOS6_Device.app/

sudo xcode-select -switch /Applications/Xcode92/Xcode.app
