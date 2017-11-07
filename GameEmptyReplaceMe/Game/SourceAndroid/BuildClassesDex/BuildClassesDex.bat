@rem Command used to generate the debug keystore.
@rem keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 20000

call Setup.bat

SET APK_FOLDER=../AndroidStudio/app/src/main
SET FRAMEWORK_JAVA_FOLDER=../../../../Framework/MyFramework/SourceAndroid/MYFWsrc
SET OUTPUT_FOLDER=..\..\..\Output\AndroidClassesDex

mkdir %OUTPUT_FOLDER%
mkdir %OUTPUT_FOLDER%\gen
mkdir %OUTPUT_FOLDER%\bin

path=%path%;%ANDROID_PLATFORM_TOOLS%;%ANDROID_BUILD_TOOLS%;%JAVA_SDK_BIN%

@rem Generate R.java, convert aidl files to java, compile java files and generate classes.dex file.
aapt package -f -m -J %OUTPUT_FOLDER%/gen -M %APK_FOLDER%/AndroidManifest.xml -S %APK_FOLDER%/res -I %ANDROID_API_FOLDER%/android.jar
aidl -o%OUTPUT_FOLDER%/gen -p%ANDROID_API_FOLDER%/framework.aidl %APK_FOLDER%/aidl/com/android/vending/billing/IInAppBillingService.aidl
javac -d %OUTPUT_FOLDER%/bin -classpath %ANDROID_API_FOLDER%/android.jar %FRAMEWORK_JAVA_FOLDER%/com/flathead/MYFWPackage/*.java %APK_FOLDER%/java/com/flathead/EmptyReplaceMePackage/*.java %OUTPUT_FOLDER%/gen/com/flathead/EmptyReplaceMePackage/R.java %OUTPUT_FOLDER%/gen/com/android/vending/billing/IInAppBillingService.java
call dx --dex --output=%OUTPUT_FOLDER%/classes.dex %OUTPUT_FOLDER%/bin

pause
