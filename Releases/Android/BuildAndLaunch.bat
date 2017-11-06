@rem Command used to generate the debug keystore.
@rem keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 20000

mkdir assets
mkdir Output
mkdir Output\gen
mkdir Output\bin

call Setup.bat

path=%path%;%ANDROID_PLATFORM_TOOLS%;%ANDROID_BUILD_TOOLS%;%JAVA_SDK_BIN%
mklink /J "assets/Data" "../Data"

@rem Generate R.java, convert aidl files to java, compile java files and generate classes.dex file.
aapt package -f -m -J Output/gen -M AndroidManifest.xml -S res -I %ANDROID_API_FOLDER%\android.jar
aidl -oOutput/gen -p%ANDROID_API_FOLDER%\framework.aidl aidl\com\android\vending\billing\IInAppBillingService.aidl
javac -d Output/bin -classpath %ANDROID_API_FOLDER%\android.jar java/com/flathead/MYFWPackage/*.java java/com/flathead/EmptyReplaceMePackage/*.java Output/gen/com/flathead/EmptyReplaceMePackage/R.java Output/gen/com/android/vending/billing/IInAppBillingService.java
call dx --dex --output=Output/classes.dex Output/bin

@rem Create APK file (unsigned/unaligned).
aapt package -f -M AndroidManifest.xml -A assets -S res -I %ANDROID_API_FOLDER%\android.jar -F Output/MyEngine.apk.unaligned
pushd Output
aapt add MyEngine.apk.unaligned classes.dex
popd
aapt add Output/MyEngine.apk.unaligned lib/armeabi/libEmptyReplaceMe.so

@rem Sign APK and zipalign.
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore debug.keystore -storepass android Output/MyEngine.apk.unaligned androiddebugkey
zipalign -f 4 Output/MyEngine.apk.unaligned Output/MyEngine.apk

@rem Install and run game.
adb install -r Output/MyEngine.apk
adb shell am start -a android.intent.action.MAIN -n com.flathead.EmptyReplaceMePackage/.EmptyReplaceMeActivity

pause
