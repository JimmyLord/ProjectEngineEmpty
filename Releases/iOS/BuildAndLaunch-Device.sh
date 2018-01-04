
source Setup.sh

cd ..

echo ""
echo "$(tput setaf 5)==> Copying Data$(tput sgr0)"
rsync -avL Data MyEngine_Game_iOS_Device.app/

echo ""
echo "$(tput setaf 5)==> Signing Code and Data$(tput sgr0)"
codesign -f -s "$IOSSigningIdentity" MyEngine_Game_iOS_Device.app/

echo ""
echo "$(tput setaf 5)==> Launching app$(tput sgr0)"
ios-deploy --justlaunch --bundle MyEngine_Game_iOS_Device.app/
