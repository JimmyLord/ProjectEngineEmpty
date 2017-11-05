@rem Command used to generate the debug keystore.
@rem keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 20000

mkdir assets
mkdir gen
mkdir bin

path=%path%;E:\Apps\Android\sdk\platform-tools\;E:\Apps\Android\sdk\build-tools\26.0.2\;C:\Program Files\Java\jdk1.8.0_131\bin
mklink /J "assets/Data" "../Data"

@rem Generate R.java, convert aidl files to java, compile java files and generate classes.dex file.
aapt package -f -m -J gen -M AndroidManifest.xml -S res -I E:\Apps\Android\sdk\platforms\android-24\android.jar
aidl -ogen -pE:\Apps\Android\sdk\platforms\android-24\framework.aidl aidl\com\android\vending\billing\IInAppBillingService.aidl
javac -d bin -classpath E:\Apps\Android\sdk\platforms\android-24\android.jar java/com/flathead/MYFWPackage/*.java java/com/flathead/EmptyReplaceMePackage/*.java gen/com/flathead/EmptyReplaceMePackage/R.java gen/com/android/vending/billing/IInAppBillingService.java
call dx --dex --output=classes.dex bin

@rem Create APK file (unsigned/unaligned).
aapt package -f -M AndroidManifest.xml -A assets -S res -I E:\Apps\Android\sdk\platforms\android-24\android.jar -F MyEngine.apk.unaligned
aapt add MyEngine.apk.unaligned classes.dex
aapt add MyEngine.apk.unaligned lib/armeabi/libEmptyReplaceMe.so

@rem Sign APK and zipalign.
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore debug.keystore -storepass android MyEngine.apk.unaligned androiddebugkey
zipalign -f 4 MyEngine.apk.unaligned MyEngine.apk

@rem Install and run game.
adb install -r MyEngine.apk
adb shell am start -a android.intent.action.MAIN -n com.flathead.EmptyReplaceMePackage/.EmptyReplaceMeActivity

pause
