//
//  termViewVC.m
//  TouchCCTV
//
//  Created by weerapons suwanchatree on 12/17/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//

#import "termViewVC.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
@implementation termViewVC{
    
    IBOutlet UIWebView *termsWV;
}
-(void)viewDidLoad{
    NSString *urlAdress=@"http://seeitlivethailand.com/termsofservice";
    
    NSURL *url = [NSURL URLWithString:urlAdress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [termsWV loadRequest:requestObj];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.socketScreenName = @"termViewVC";
}
-(void)viewWillAppear:(BOOL)animated{
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_CreateAccount_ViewTerm"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
}
@end
