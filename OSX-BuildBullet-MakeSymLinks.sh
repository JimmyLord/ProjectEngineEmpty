pushd Engine/Libraries/Bullet3/build3
./premake4_osx xcode4
./premake4_osx --ios xcode4
popd

pushd GameEmptyReplaceMe/Game/Data
ln -s ../../../Engine/DataEngine ./DataEngine
popd
