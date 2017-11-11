@rem Command used to generate the debug keystore.
@rem keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 20000

mkdir assets
mkdir Output

call Setup.bat

SET ADDITIONAL_ARGUMENTS=--es "LaunchScene" "%1"
IF [%1] == [] SET ADDITIONAL_ARGUMENTS=

path=%path%;%ANDROID_PLATFORM_TOOLS%;%ANDROID_BUILD_TOOLS%;%JAVA_SDK_BIN%
mklink /J "assets/Data" "../Data"

@rem Create APK file (unsigned/unaligned).
aapt package -f -M AndroidManifest.xml -A assets -S res -I %ANDROID_API_FOLDER%\android.jar -F Output/MyEngine.apk.unaligned
aapt add Output/MyEngine.apk.unaligned classes.dex
aapt add Output/MyEngine.apk.unaligned lib/armeabi/libEmptyReplaceMe.so

@rem Sign APK and zipalign.
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore debug.keystore -storepass android Output/MyEngine.apk.unaligned androiddebugkey
zipalign -f 4 Output/MyEngine.apk.unaligned Output/MyEngine.apk

@rem Install and run game.
adb install -r Output/MyEngine.apk
adb shell am start -a android.intent.action.MAIN -n com.flathead.EmptyReplaceMePackage/.EmptyReplaceMeActivity %ADDITIONAL_ARGUMENTS%
