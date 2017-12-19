pushd ../GameEmptyReplaceMe

echo ""
echo "$(tput setaf 5)==> Building Debug Package: iOS$(tput sgr0)"
xcodebuild -scheme EmptyReplaceMe-iOS -config Release build -sdk iphonesimulator CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
xcodebuild -scheme EmptyReplaceMe-iOS -config Release build -sdk iphoneos CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

echo ""
echo "$(tput setaf 5)==> Building Release Package: Game$(tput sgr0)"
xcodebuild -scheme EmptyReplaceMe-OSX -config Release build

echo ""
echo "$(tput setaf 5)==> Building Release Package: Editor$(tput sgr0)"
xcodebuild -scheme EmptyReplaceMe-wx -config Release build

popd
