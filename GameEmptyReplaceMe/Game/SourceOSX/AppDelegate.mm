//
// Copyright (c) 2015 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"
#import "AppDelegate.h"

#define wide  0
#define ar169 0
#define ar43  0
#define ar32  1

#if ar32
#define SCREEN_WIDTH    400
#define SCREEN_HEIGHT   600
#elif ar43 && wide // 4:3
#define SCREEN_WIDTH    600
#define SCREEN_HEIGHT   450
#elif ar43 && !wide // 4:3
#define SCREEN_WIDTH    450
#define SCREEN_HEIGHT   600
#elif ar169 && wide // 16:9
#define SCREEN_WIDTH    600
#define SCREEN_HEIGHT   360
#elif ar169 && !wide // 9:16
#define SCREEN_WIDTH    360
#define SCREEN_HEIGHT   600
#endif

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    SAFE_DELETE( g_pGameCore );
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    LOGInfo( LOGTag, "applicationWillResignActive\n" );
    g_pGameCore->OnPrepareToDie();
    LOGInfo( LOGTag, "called g_pGameCore->OnPrepareToDie\n" );
}

- (void)applicationDidEnterBackground:(NSNotification *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    LOGInfo( LOGTag, "applicationDidEnterBackground\n" );
	
	g_pGameCore->OnFocusLost();
}

- (void)applicationWillEnterForeground:(NSNotification *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    LOGInfo( LOGTag, "applicationWillEnterForeground\n" );
}

- (void)applicationDidBecomeActive:(NSNotification *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    LOGInfo( LOGTag, "applicationDidBecomeActive\n" );
    
    g_pGameCore->OnFocusGained();
    
//    UInt32 otherAudioIsPlaying = 0;
//    UInt32 propertySize = sizeof( otherAudioIsPlaying );
//    AudioSessionGetProperty( kAudioSessionProperty_OtherAudioIsPlaying, &propertySize, &otherAudioIsPlaying );
//    
//    if( otherAudioIsPlaying ) //== false )
//        [m_avAudioPlayer stop];
    
    //    g_pGameCore->m_pSoundPlayer->ActivateSoundContext();
}

- (void)applicationWillTerminate:(NSNotification *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    LOGInfo( LOGTag, "applicationWillTerminate\n" );
    g_pGameCore->OnPrepareToDie();
}

@end
