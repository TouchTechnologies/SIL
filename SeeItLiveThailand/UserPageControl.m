//
//  UserPageControl.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "UserPageControl.h"
#import "ADPageControl.h"
#import "DetailProfileViewController.h"
#import "UserLiveViewController.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
//#import "ADPageControl/ADPageModel.h"

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface UserPageControl ()<ADPageControlDelegate> {
    ADPageControl *_pageControl;
    BOOL isLazy;
    
    
    CGFloat rcGrapY;
    CGFloat rcBarH;
    CGFloat rcButtonW;
    
    CGFloat fontSize;
    CGFloat titleHeight;
    CGFloat titleWidth;
    CGFloat indicatorHeight;
    CGFloat indicatorWidth;
    
   }

@end

@implementation UserPageControl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSize];
    [self setupPageControl];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        fontSize = 16.0 * SCALING_X;
        titleHeight = 45.0 * SCALING_Y;
        titleWidth = [UIScreen mainScreen].bounds.size.width/2 * SCALING_X;
        indicatorHeight = 5.0 * SCALING_Y;
        rcBarH = 90.0* SCALING_Y;
        rcGrapY = 200.0* SCALING_Y;
        rcButtonW = 80.0* SCALING_X;
       //indicatorWidth = self.view.bounds.size.width/2* SCALING_X;
    } else {
        
        fontSize = 16.0;
        titleHeight = 45.0;
        titleWidth = [UIScreen mainScreen].bounds.size.width/2;
        indicatorHeight = 5.0;
        rcBarH = 90.0;
        rcGrapY = 200.0;
        rcButtonW = 80.0;
      //  indicatorWidth = self.view.bounds.size.width/2;
    }
}

-(void)setupPageControl
{
    
    /**** 1. Setup pages using model class "ADPageModel" ****/
    
    //Live
    ADPageModel *liveModel = [[ADPageModel alloc] init];
    liveModel.strPageTitle = @" Live History   ";
    liveModel.iPageNumber = 0;
    liveModel.bShouldLazyLoad = YES;
    
    //StreamHistoryViewController *streamHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"StreamHistory"];
    
    ADPageModel *profileModel = [[ADPageModel alloc] init];
    profileModel.strPageTitle = @"   Profile   ";
    profileModel.iPageNumber = 1;
    //historyModel.viewController = streamHistory;
    profileModel.bShouldLazyLoad = YES;
    
    
    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
     _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:liveModel,profileModel,nil];
   
      _pageControl.iFirstVisiblePageNumber = 0;
    
    _pageControl.iTitleViewHeight = titleHeight;
    _pageControl.iPageIndicatorHeight = indicatorHeight;
    _pageControl.fontTitleTabText =  [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    _pageControl.bEnablePagesEndBounceEffect = NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
    _pageControl.colorTabText = [UIColor blackColor]; //orangeColor
    _pageControl.colorTitleBarBackground = [UIColor whiteColor];
    _pageControl.colorPageIndicator = [UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]; //[UIColor orangeColor]; //blueColor
    _pageControl.colorPageOverscrollBackground = [UIColor lightGrayColor];
    
    _pageControl.bShowMoreTabAvailableIndicator = NO;
   // _pageControl.iTitleViewWidth = indicatorWidth;
    
    
    /**** 3. Add as subview ****/
    
    _pageControl.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 20);
    [self.view addSubview:_pageControl.view];
    
    
      //flag lazy load
    isLazy = FALSE;
}

#pragma mark - ADPageControlDelegate

//LAZY LOADING

-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
    NSLog(@"ADPageControl :: Lazy load asking for page %d",pageModel.iPageNumber);
    
    if(pageModel.iPageNumber == 0)
    {
        
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
//        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//        NSString *name = [NSString stringWithFormat:@"LiveStream_MyLive"];
//        NSLog(@"analytics %@",name);
//        NSString *dimensionValue = @"iOS";
//        NSString *metricValue = @"iOS_METRIC_VALUE";
//        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
//        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
//        [tracker set:kGAIScreenName value:name];
//        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        UserLiveViewController *userStream = [self.storyboard instantiateViewControllerWithIdentifier:@"userlive"];
        isLazy = TRUE;
        return userStream;
    }
    else if(pageModel.iPageNumber == 1)
    {
        
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
//        // [START screen_view_hit_objc]
//        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//        NSString *name = [NSString stringWithFormat:@"User_Profile"];
//        NSLog(@"analytics %@",name);
//        NSString *dimensionValue = @"iOS";
//        NSString *metricValue = @"iOS_METRIC_VALUE";
//        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
//        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
//        [tracker set:kGAIScreenName value:name];
//        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        DetailProfileViewController *useraccount = [self.storyboard instantiateViewControllerWithIdentifier:@"detailprofile"];
        isLazy = TRUE;
        return useraccount;
    }
    return nil;
}


//CURRENT PAGE INDEX

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
    
    if (isLazy == FALSE) {
        ADPageModel *pageModel = [_pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
        
        if ([pageModel.viewController isKindOfClass:[UserLiveViewController class]]) {
            //NSLog(@"live live");
            UserLiveViewController *streamLive = (UserLiveViewController *)pageModel.viewController;
            [streamLive viewDidLoad];
            
        }
        else if([pageModel.viewController isKindOfClass:[DetailProfileViewController class]])
        {
            //NSLog(@"his tory");
            DetailProfileViewController *useraccount = (DetailProfileViewController *)pageModel.viewController;
            [useraccount viewDidLoad];
        }
        
    }
    
    isLazy = FALSE;
    
    
    //UIViewController *controller = [_pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
    //[controller viewDidLoad];
}
- (void) refreshList:(NSNotification *) refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"Stream userPage Notiname : %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"refresh"])
    {
        [self viewDidLoad];
        // [self.gridView reloadContentSize];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog (@"Reload successfully");
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
