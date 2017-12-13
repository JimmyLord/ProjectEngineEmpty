cd ../GameEmptyReplaceMe

echo ""
echo "$(tput setaf 5)==> Building Release Package: Game$(tput sgr0)"
xcodebuild -scheme EmptyReplaceMe-OSX -config Release build

echo ""
echo "$(tput setaf 5)==> Building Release Package: Editor$(tput sgr0)"
xcodebuild -scheme EmptyReplaceMe-wx -config Release build
