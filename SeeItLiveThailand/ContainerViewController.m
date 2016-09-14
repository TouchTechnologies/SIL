//
//  ContainerViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/26/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "ContainerViewController.h"
#import "SubContainerViewController.h"
#import "VideoListViewController.h"
#import "VideoPagingViewController.h"
#import "UnderConViewController.h"
#import "ContactViewController.h"
#import "StreamContrainerViewController.h"
#import "ADViewController.h"
//#import "NavButtonTabViewController.h"
#import "defs.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <AFNetworking.h>
#import <Google/Analytics.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "SeeItLiveThailand-Swift.h"
//#import "NearByProviderViewController.h"
#import "Hotline.h"
#import "Helpful.h"
//#import "Sock"
//#import <SocketIOClientSwift/SocketIOClientSwift-Swift.h>

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface ContainerViewController () {
    
    AppDelegate *appDelegate;
    CGFloat barHeight;
    CGFloat btSize;
    CGFloat btY;
    CGFloat btGrab;
    CGFloat detailY;
    SocketIOClient* socket;
    
    
}
@property UIViewController  *currentDetailViewController;
@property (nonatomic, strong) UIView *toolbarView;
@end

@implementation ContainerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    [self initialSize];
    [self initial];
    [self getMobileData];
    [self fetchSSIDInfo];
    [self getCategory];
//    [self initHelpful];
//    [self initSocket];
    

    
    // Do any additional setup after loading the view.
//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
//    
//    if ((int)appDelegate.isLogin == 1) {
//        [self activeMenu:5];
//        UnderConViewController *underConView = [self.storyboard instantiateViewControllerWithIdentifier:@"underconstruction"];
//        [self swapCurrentControllerWith:underConView];
//    }else if((int)appDelegate.isProfile == 1)
//    {
//        appDelegate.isProfile = false;
//        [self activeMenu:5];
//        UnderConViewController *underConView = [self.storyboard instantiateViewControllerWithIdentifier:@"underconstruction"];
//        [self swapCurrentControllerWith:underConView];
//    }
//    else{
//        NSLog(@"else");
//        SubContainerViewController *subContView = [self.storyboard instantiateViewControllerWithIdentifier:@"subcontrainer"];
//        [self presentDetailController:subContView];
//    }
    NSLog(@"ContainerView");
    ADViewController *streamContrainer =[ self.storyboard instantiateViewControllerWithIdentifier:@"adcontroller"];
    [self swapCurrentControllerWith:streamContrainer];

    
//    SubContainerViewController *subContView = [self.storyboard instantiateViewControllerWithIdentifier:@"subcontrainer"];
//    [self presentDetailController:subContView];
    
}
- (void)initSocket
{
    NSURL* url = [[NSURL alloc] initWithString:@"http://192.168.9.117:3008"];
    socket = [[SocketIOClient alloc] initWithSocketURL:url options:@{@"log": @YES, @"forcePolling": @YES}];
    [socket joinNamespace:@"/websocket"];
    [socket on:@"ack-connected" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected %@",data);
    }];
    [socket connect];
    
    
    [socket on:@"message:new" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"HandlingEvent : %@",data);

    }];
//    [socket connect];
//    NSArray *room = @[self.roomNameTxt.text];
    [socket emit:@"join" withItems:@[@"demo/room-1"]];
}
- (void)getMobileData
{

    NSDictionary *SSIDInfo = [self fetchSSIDInfo];
    NSLog(@"SSID Name : %@",SSIDInfo[@"SSID"]);
    appDelegate.SSIDName = SSIDInfo[@"SSID"];
    NSLog(@"OS version :%@",[UIDevice currentDevice].systemVersion);
    appDelegate.osVersion = [UIDevice currentDevice].systemVersion;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"d.M.yyyy";
    formatter.dateFormat = @"YYYY_MM_d";
    NSString *date = [formatter stringFromDate:[NSDate date]];
    appDelegate.date = date;
    NSLog(@"Date time : %@",date);

    
    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    NSLog(@"Carrier Name: %@", [carrier carrierName]);
    appDelegate.carrierName = [carrier carrierName];
    
    NSLog(@"Device Name %@",[[UIDevice currentDevice] model]);
    appDelegate.deviceType = [[UIDevice currentDevice] model];
    
    NSLog(@"Device ID : %@",[[[UIDevice currentDevice] identifierForVendor]UUIDString]);
    appDelegate.UUID = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
    
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"appVersion %@",version);
    appDelegate.appVersion = version;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:TRUE];

//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"Data Store  username : %@",[defaults objectForKey:@"username"]);
    NSLog(@"Data Store  password : %@",[defaults objectForKey:@"password"]);
    
    if([defaults objectForKey:@"isLogin"])
    {
        //appDelegate.access_token = (result[@"data"][@"access_token"] != (id)[NSNull null])?result[@"data"][@"access_token"] :@"-";
        appDelegate.access_token = [defaults objectForKey:@"access_token"];
        appDelegate.username = [defaults objectForKey:@"username"];
        appDelegate.email = [defaults objectForKey:@"email"];
        appDelegate.password = [defaults objectForKey:@"password"];
        appDelegate.birth_date = [defaults objectForKey:@"birth_date"];
        appDelegate.first_name = [defaults objectForKey:@"first_name"];
        appDelegate.last_name = [defaults objectForKey:@"last_name"];
        appDelegate.profile_picture = [defaults objectForKey:@"profile_picture"];
        appDelegate.user_ID = [defaults objectForKey:@"user_ID"];
        appDelegate.isLogin = YES;
        NSLog(@"isLogin True");
        
    }else{
        NSLog(@"isLogin false");
    }
    
    if([appDelegate.pageName  isEqual: @"MyStream"])
    {
         NSLog(@"Page Name %@",appDelegate.pageName);
        
        [self addViewFirst:self];
    }
  
    
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    NSLog(@"Google Main_Page");
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Main_Page"];
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    
}
- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        barHeight = 45.0 * SCALING_Y;
        btY = 7.5 * SCALING_Y;
        btSize = 30.0 * SCALING_X;
        btGrab = 10.0 * SCALING_X;
        
    } else {
        
        barHeight = 45.0;
        btY = 7.5;
        btSize = 30.0;
        btGrab = 10.0;
        //detailY = 45.0;
        
    }
}

- (void)initial {
    
    /*
    [self.btnViewFirst setBackgroundImage:[UIImage imageNamed:@"icon_A.png"] forState:UIControlStateNormal];
    [self.btnViewSecond setBackgroundImage:[UIImage imageNamed:@"icon_C.png"] forState:UIControlStateNormal];
    [self.btnViewThird setBackgroundImage:[UIImage imageNamed:@"icon_B.png"] forState:UIControlStateNormal];
    [self.btnViewForth setBackgroundImage:[UIImage imageNamed:@"icon_D.png"] forState:UIControlStateNormal];
    [self.btnViewFifth setBackgroundImage:[UIImage imageNamed:@"icon_E.png"] forState:UIControlStateNormal];
    */
    
    CGFloat boundWidth = self.view.bounds.size.width;
    CGFloat boundHeight = self.view.bounds.size.height;
    //CGRect topbarRect = CGRectMake(0, 0, self.view.bounds.size.width, 40.0f);
    CGRect topbarRect;
    
     if([[UIApplication sharedApplication] isStatusBarHidden]) {
     topbarRect = CGRectMake(0, 0, self.view.bounds.size.width, barHeight);
     } else {
     topbarRect = CGRectMake(0, 20, self.view.bounds.size.width, barHeight);
     }
    
    _toolbarView = [[UIView alloc] initWithFrame:topbarRect];
    _toolbarView.layer.backgroundColor = [UIColor blackColor].CGColor;
    //[UIColor colorWithRed:0.24 green:0.37 blue:0.58 alpha:1].CGColor; //[UIColor blueColor].CGColor;
    _toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolbarView];
    
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(0, topbarRect.origin.y + barHeight, boundWidth, boundHeight - (topbarRect.origin.y + barHeight))];
    self.detailView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.detailView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.detailView];
    
    //First Btn Menu
    UIButton *btnViewFirst = [[UIButton alloc] initWithFrame:CGRectMake(btGrab, btY, btSize, btSize)];
    btnViewFirst.tag = 1;
    [btnViewFirst setBackgroundImage:[UIImage imageNamed:@"icon_D.png"] forState:UIControlStateNormal];
    [btnViewFirst addTarget:self action:@selector(addViewFirst:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnViewFirst];
    
    
    //Second  Btn Menu
    UIButton *btnViewSecond = [[UIButton alloc] initWithFrame:CGRectMake((((boundWidth*25)/100)+btGrab) - (btSize/2), btY, btSize, btSize)];
    btnViewSecond.tag = 2;
    [btnViewSecond setBackgroundImage:[UIImage imageNamed:@"icon_A1.png"] forState:UIControlStateNormal];
    [btnViewSecond addTarget:self action:@selector(addViewSecond:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnViewSecond];
    
    
    //Third Btn Menu
    UIButton *btnViewThird = [[UIButton alloc] initWithFrame:CGRectMake((boundWidth/2) - (btSize/2), btY, btSize, btSize)];
    btnViewThird.tag = 3;
    [btnViewThird setBackgroundImage:[UIImage imageNamed:@"icon_C1.png"] forState:UIControlStateNormal];
    [btnViewThird addTarget:self action:@selector(addViewThird:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnViewThird];

    
    //Forth Btn Menu
    UIButton *btnViewForth = [[UIButton alloc] initWithFrame:CGRectMake((((boundWidth*75)/100)-btGrab) - (btSize/2), btY, btSize, btSize)];
    btnViewForth.tag = 4;
    [btnViewForth setBackgroundImage:[UIImage imageNamed:@"icon_B1.png"] forState:UIControlStateNormal];
    [btnViewForth addTarget:self action:@selector(addViewForth:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnViewForth];

    
    //Fifth  Btn Menu
    UIButton *btnViewFifth = [[UIButton alloc] initWithFrame:CGRectMake(boundWidth - (btSize + btGrab), btY, btSize, btSize)];
    btnViewFifth.tag = 5;
    [btnViewFifth setBackgroundImage:[UIImage imageNamed:@"ic_more1.png"] forState:UIControlStateNormal];
    [btnViewFifth addTarget:self action:@selector(addViewFifth:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnViewFifth];
    
 
}

- (void)activeMenu:(NSInteger)buttonNumber {
    for (UIView *view in [self.toolbarView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *menuButton = (UIButton *)view;
            NSMutableString *imgButtonName = [[NSMutableString alloc] init];
            switch (view.tag) {
                case 1:
                    [imgButtonName setString:@"icon_D"];
                    break;
                case 2:
                    [imgButtonName setString:@"icon_A"];
                    break;
                case 3:
                    [imgButtonName setString:@"icon_C"];
                    break;
                case 4:
                    [imgButtonName setString:@"icon_B"];
                    break;
                case 5:
                    [imgButtonName setString:@"ic_more"];
                    break;
                    
                default:
                    break;
            }
            
            if (buttonNumber != view.tag) {
                [imgButtonName appendString:@"1"];
            }
            
            [imgButtonName appendString:@".png"];
            
            [menuButton setBackgroundImage:[UIImage imageNamed:imgButtonName] forState:UIControlStateNormal];
            
        }
        //NSLog(@"%ld",view.tag);
    }
}

- (void)presentDetailController:(UIViewController*)detailVC{
    
    //0. Remove the current Detail View Controller showed
    if(self.currentDetailViewController){
        [self removeCurrentDetailViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:detailVC];
    
    //2. Define the detail controller's view size
    //detailVC.view.frame = [self frameForDetailController];
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    [self.detailView addSubview:detailVC.view];
    self.currentDetailViewController = detailVC;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [detailVC didMoveToParentViewController:self];
    
}

- (void)removeCurrentDetailViewController{
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.currentDetailViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
    [self.currentDetailViewController removeFromParentViewController];
}

- (void)swapCurrentControllerWith:(UIViewController*)viewController{
    
    //1. The current controller is going to be removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. The new controller is a new child of the container
    [self addChildViewController:viewController];
    
    //3. Setup the new controller's frame depending on the animation you want to obtain
    //viewController.view.frame = CGRectMake(0, 2000, viewController.view.frame.size.width, viewController.view.frame.size.height);
    
    //3b. Attach the new view to the views hierarchy
    [self.detailView addSubview:viewController.view];
    
    [self.currentDetailViewController.view removeFromSuperview];
    
    //Remove the old Detail controller from the hierarchy
    [self.currentDetailViewController removeFromParentViewController];
    
    //Set the new view controller as current
    self.currentDetailViewController = viewController;
    [self.currentDetailViewController didMoveToParentViewController:self];
    //Save the button position...we'll use it later
   
    
    /*
    [UIView animateWithDuration:1.3
     
     //4. Animate the views to create a transition effect
                     animations:^{
                         
                         //The new controller's view is going to take the position of the current controller's view
                         viewController.view.frame = self.currentDetailViewController.view.frame;
                         
                         //The current controller's view will be moved outside the window
                         self.currentDetailViewController.view.frame = CGRectMake(0,
                                                                                  -2000,
                                                                                  self.currentDetailViewController.view.frame.size.width,
                                                                                  self.currentDetailViewController.view.frame.size.width);
                         //...and the same is for the button
                   
                         
                     }
     
     
     //5. At the end of the animations we remove the previous view and update the hierarchy.
                     completion:^(BOOL finished) {
                         
                         //Remove the old Detail Controller view from superview
                         [self.currentDetailViewController.view removeFromSuperview];
                         
                         //Remove the old Detail controller from the hierarchy
                         [self.currentDetailViewController removeFromParentViewController];
                         
                         //Set the new view controller as current
                         self.currentDetailViewController = viewController;
                         [self.currentDetailViewController didMoveToParentViewController:self];
                         
                         //reset the button position
              
    }];
    */
    
}

- (CGRect)frameForDetailController{
    CGRect detailFrame = self.detailView.frame;
    
    return detailFrame;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)addViewFirst:(id)sender {
    NSLog(@"Second");
    NSLog(@"analytics LiveStream_OnAir");
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"LiveStream_OnAir"];
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
   
    
    [self activeMenu:1];
    ADViewController *streamContrainer =[ self.storyboard instantiateViewControllerWithIdentifier:@"adcontroller"];
    
    [self swapCurrentControllerWith:streamContrainer];

}

- (IBAction)addViewSecond:(id)sender {
        NSLog(@"first");
        NSLog(@"analytics Main_Page");
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"Main_Page"];
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
        [self activeMenu:2];
        SubContainerViewController *subContView = [self.storyboard instantiateViewControllerWithIdentifier:@"subcontrainer"];
        [self swapCurrentControllerWith:subContView];
}

- (IBAction)addViewThird:(id)sender {
    
    NSLog(@"Third");
    NSLog(@"analytics Coupon");
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Coupon"];
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Coupon_Action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"WebView"          // Event label
                                                           value:nil] build]];    // Event value
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    
    [self activeMenu:3];
    ContactViewController *contactView = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
    contactView.urlName = CouponURL;
    [self swapCurrentControllerWith:contactView];

}

- (IBAction)addViewForth:(id)sender {
    
    NSLog(@"Forth");
    NSLog(@"analytics BlogTravel");
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"BlogTravel"];
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"BlogTravel_Action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"WebView"          // Event label
                                                           value:nil] build]];    // Event value
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
    [self activeMenu:4];
    ContactViewController *contactView = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
    contactView.urlName = BlogURL;
    [self swapCurrentControllerWith:contactView];
    
//    [self activeMenu:4];
//    NearByProviderViewController *nearby = [self.storyboard instantiateViewControllerWithIdentifier:@"nearbyview"];
//    [self swapCurrentControllerWith:nearby];
    

}


- (IBAction)addViewFifth:(id)sender {
    NSLog(@"Fifth");
    NSLog(@"analytics Menu");
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu"];
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
    [self activeMenu:5];
    
    UnderConViewController *underConView = [self.storyboard instantiateViewControllerWithIdentifier:@"underconstruction"];
    [self swapCurrentControllerWith:underConView];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"Before: %@",identifier);
    if ([self shouldPerformSegueWithIdentifier:identifier sender:sender]) {
        [super performSegueWithIdentifier:identifier sender:sender];
    }
    // otherwise do nothing
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{

    NSLog(@"Before %@",identifier);

    return false;
}



/** Returns first non-empty SSID network info dictionary.
 *  @see CNCopyCurrentNetworkInfo */
- (NSDictionary *)fetchSSIDInfo
{
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        NSLog(@"SSIDInfo %s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}
- (void) initHelpful
{
    [[UserManager shareIntance] getAPIData:@"listhotline" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        NSLog(@"listhotline : %@",result);
        appDelegate.helpfulData = [[NSMutableArray alloc]init];
//        searchData = [[NSMutableArray alloc]init];
        for (NSDictionary* hotlineGroup in result) {
            NSLog(@"hotline_group_name %@",hotlineGroup[@"hotline_group_name"]);
            Helpful* helpful = [[Helpful alloc] init];
            NSMutableArray*hotlineObj = [[NSMutableArray alloc]init];
            helpful.hotline_group_name = hotlineGroup[@"hotline_group_name"];
            for (NSDictionary* hotlines in hotlineGroup[@"hotlines"]) {
                NSLog(@"hotlineshotline_call %@",hotlines[@"hotline_call"]);
                Hotline* hotline = [[Hotline alloc]init];
                hotline.hotline_call = hotlines[@"hotline_call"];
                hotline.hotline_image = hotlines[@"hotline_image"];
                hotline.hotline_name = hotlines[@"hotline_name"];
                hotline.hotline_id = hotlines[@"id"];
                
                [hotlineObj addObject:hotline];
            }
            helpful.hotline = hotlineObj;
            [appDelegate.helpfulData addObject:helpful];
            
        }
        NSLog(@"initHelpful %@",appDelegate.helpfulData);

        //        for (Helpful *test in helpfulData) {
        //            NSLog(@"testttttttt %@",test.hotline_group_name);
        //            NSLog(@"testttttttthotline %@",test.hotline[0]);
        //            for (Hotline* testH in test.hotline) {
        //                NSLog(@"showData : %@",testH.hotline_name);
        //            }
        //        }
        
    }];
}
- (void) getCategory
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do something...
        NSLog(@"Container:getCategory");
        
        [[UserManager shareIntance] getAPIData:@"categoryStream" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            //        NSLog(@"categoryStream : %@",result);
            appDelegate.categoryData = [[NSMutableArray alloc]init];
            NSArray *sortedArray  = result;
            NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
            
            for (NSDictionary *category in [sortedArray sortedArrayUsingDescriptors:sortDescriptors])
            {
                [appDelegate.categoryData addObject:category];
            }
            NSLog(@"AllCat %@",appDelegate.categoryData);
            
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

}

@end
