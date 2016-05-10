//
//  AppDelegate.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/17/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "AppDelegate.h"
#import "popupStreaming.h"
#import "UnderConViewController.h"
#import <Google/Analytics.h>
#import "SCFacebook.h"
#import "Harpy.h"
#import "Util.h"
#import "StreamLiveViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SeeItLiveThailand-Swift.h"
#import "termViewVC.h"

@interface AppDelegate ()<HarpyDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

//    [self initSocket];
    //[Util copyFile:@"studentdb.sqlite"];
    [Util copyFile:@"SIL_db.sqlite"];
    

    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
    [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
    
    self.isLiveVC = NO;
    self.isLogin = NO;
    self.isPromotion = NO;
    self.hasPromotion = NO;
    self.access_token = @"";
    self.isProfile = 0;
    self.latitute = 0.0;
    self.longitude = 0.0;
    self.topAll = @{@"name":@"",
                    @"totalView":@"",
                    @"coverURL":@"http://seeitlivethailand.com/assets/image/roi/cover_slide/slide_totalview_cover_s.jpg"};
    self.topPattaya = @{@"name":@"",
                        @"totalView":@"",
                        @"coverURL":@"http://www.seeitlivethailand.com/assets/image/roi/cover_slide/slide_pattaya_cover_s.jpg"};
    self.topPhuket = @{@"name":@"",
                       @"totalView":@"",
                       @"coverURL":@"http://www.seeitlivethailand.com/assets/image/roi/cover_slide/slide_phuket_cover_s.jpg"};
    
    
    
    // [START tracker_objc]
    //Google UA ID: UA-72941116-1
    // Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
    // [END tracker_objc]
    
    // Present Window before calling Harpy
    [self.window makeKeyAndVisible];
    
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:@"1068051825"]; // iTunes Connect Mobile App ID
    [[Harpy sharedInstance] setPresentingViewController:_window.rootViewController];
    [[Harpy sharedInstance] setDelegate:self];
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
    [[Harpy sharedInstance] checkVersion];
    
    
    //Init SCFacebook
    [SCFacebook initWithReadPermissions:@[@"user_about_me",
                                          @"user_birthday",
                                          @"email",
                                          @"user_photos",
                                          @"user_events",
                                          @"user_friends",
                                          @"user_videos",
                                          @"public_profile"]
                     publishPermissions:@[@"manage_pages",
                                          @"publish_actions",
                                          @"publish_pages"]
     ];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
//    return YES;
}

#pragma mark - SCFacebook Handle

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
    
    // Do the following if you use Mobile App Engagement Ads to get the deferred
    // app link after your app is installed.
    [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
        if (error) {
            NSLog(@"Received error while fetching deferred app link %@", error);
        }
        if (url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
   
    if (self.isLiveVC) {
         NSLog(@"UIInterfaceOrientationMaskLandscapeRight");
        return UIInterfaceOrientationMaskLandscapeRight;
    }else
    {
         NSLog(@"UIInterfaceOrientationMaskPortrait");
         return UIInterfaceOrientationMaskPortrait;
        
    }
//    return UIInterfaceOrientationMaskPortrait;

}
- (void)initSocket
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSURL* url = [[NSURL alloc] initWithString:@"http://192.168.9.117:3008"];
    //socket
    SocketIOClient* socket = [[SocketIOClient alloc] initWithSocketURL:url options:@{@"log": @YES, @"forcePolling": @YES}];
    [socket joinNamespace:@"/websocket"];
    
    [socket on:@"ack-connected" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected %@",data);
        [socket emit:@"join" withItems:@[@"demo/room-1"]];
    }];
    [socket connect];
    
    
    [socket on:@"message:new" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"HandlingEvent : %@",data);
        NSError *jsonError;
        NSData *objectData = [data[0] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&jsonError];

        if([json[@"message_type"]  isEqual: @"test"] && [appDelegate.socketScreenName isEqual: @"termViewVC"])
        {
                NSLog(@"message : %@",json[@"message"]);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Socket Data"
                                                                message:json[@"message"]
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
//            termViewVC * termVC = [[termViewVC alloc]init];
//            
//            termVC.termsWV
        }
        

        
    }];
    //    [socket connect];
    //    NSArray *room = @[self.roomNameTxt.text];
    
}



@end
