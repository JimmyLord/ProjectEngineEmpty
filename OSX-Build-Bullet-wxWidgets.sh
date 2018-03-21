pushd Engine/Libraries/Bullet3/build3
./premake4_osx xcode4
./premake4_osx --ios xcode4
popd

pushd Framework/Libraries/wxWidgets/
mkdir build-cocoa-debug
cd build-cocoa-debug
../configure --enable-debug --enable-universal_binary=i386,x86_64 --with-opengl
make
popd

pushd GameEmptyReplaceMe/Game/Data
ln -s ../../../Engine/DataEngine ./DataEngine
popd