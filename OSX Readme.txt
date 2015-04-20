OSX Readme

Bullet
------
In this dir, create a dir called bullet
download bullet 2 sdk from google code: https://code.google.com/p/bullet/downloads/list: I tested bullet-2.82-r2704.zip
or grab latest from svn: svn checkout http://bullet.googlecode.com/svn/trunk/
unzip it into the bullet folder.

cd bullet/build
./premake4_osx xcode4
./ios_build.sh


wxWidgets
---------
cd wxWidgets
mkdir build-cocoa-debug
cd build-cocoa-debug
../configure --enable-debug --enable-universal_binary=i386,x86_64 --with-opengl
make
