//
//  UserProfileViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserData.h"
#import "UserManager.h"
#import "ADPageControl.h"
#import "DetailProfileViewController.h"
#import "UserLiveViewController.h"
#import "MBProgressHUD.h"

@interface UserProfileViewController ()<ADPageControlDelegate>

{
    ADPageControl *_pageControl;
    BOOL isLazy;
    UIImageView *imgProfile ;
    CGFloat imgW;
    CGFloat cgGrap;
    CGFloat font;
    CGRect headerViewRect;
    CGRect userNameRect;
    UIView *headerView;
    UILabel *userName;
    CGFloat statusbarH;
    
    UILabel *followersCount;
    UILabel *followingCount;
    UILabel *btnLbl;
    
    IBOutlet UIView *containerView;
    
    CGFloat ScreenW;
    CGFloat ScreenH;
    
    UIButton *FollowBtn;
    CGRect imgProfileRect ;
    CGRect followerLblRect;
    CGRect followingLblRect;
    CGRect followersCountRect;
    CGRect followingCountRect;
    CGRect FollowBtnRect;
    CGRect  containerViewRect;
    UserData *userData;
   // UIView *secondView;
    //IBOutlet UIView *secondView;
    CGFloat fontSize;
    CGFloat titleHeight;
    CGFloat titleWidth;
    CGFloat indicatorHeight;
    CGFloat indicatorWidth;
    
    CGRect pageControlRect;
}


@end

@implementation UserProfileViewController


- (void)viewDidLoad {
        [super viewDidLoad];
        [self initialSize];
        [self initial];
        [self setupPageControl];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(refreshList:)
                                                     name:@"refresh"
                                                   object:nil];
     // Do any additional setup after loading the view.
}
-(void)initialSize{
    CGFloat scx = (768.0/360.0);
    CGFloat scy = (1024.0/480.0);
    ScreenW = [UIScreen mainScreen].bounds.size.width;
    ScreenH = [UIScreen mainScreen].bounds.size.height;
    
       if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
           
           fontSize = 16.0 * scx;
           titleHeight = 45.0 * scy;
           titleWidth = [UIScreen mainScreen].bounds.size.width/2 * scx;
           indicatorHeight = 5.0 * scy;
        statusbarH = [UIApplication sharedApplication].statusBarFrame.size.height;
        imgW = 100*scx ;
        cgGrap = 10*scx ;
        font = 14*scy;
        
        
        headerViewRect = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+statusbarH,ScreenW, 160*scy);
        imgProfileRect = CGRectMake(ScreenW/4 - (imgW/2 + (10*scx)), headerViewRect.size.height/2 - imgW/2, imgW, imgW);
        userNameRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2 - imgW/2,ScreenW - (cgGrap*2)+imgW, 30*scy);
        
        
        
           
        followerLblRect = CGRectMake(ScreenW/2,  headerViewRect.size.height/2 - (30*scy) , ScreenW/2, 30*scy);
        followingLblRect = CGRectMake(ScreenW/2 + ScreenW/4,  headerViewRect.size.height/2 - (30*scy) ,100*scx, 30*scy);
        followersCountRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2, 70 *scx, 30*scy);
        followingCountRect = CGRectMake(ScreenW/2 + ScreenW/4, headerViewRect.size.height/2 , 70*scx , 30*scy);
        FollowBtnRect = CGRectMake(ScreenW/2 + followersCountRect.size.width/(4*scx), headerViewRect.size.height/2 + (40*scy), ScreenW/3 , 30*scy);
        containerViewRect =CGRectMake(0, (headerViewRect.origin.y + headerViewRect.size.height)*scy, self.view.bounds.size.width ,  self.view.bounds.size.height - (headerViewRect.origin.y + headerViewRect.size.height));
          
       pageControlRect = CGRectMake(0*scx, headerViewRect.origin.y + headerViewRect.size.height + (titleHeight-(45*scy)) , self.view.bounds.size.width, self.view.bounds.size.height-(headerViewRect.origin.y + headerViewRect.size.height));
    }
    else{
        
        fontSize = 16.0;
        titleHeight = 45.0;
        titleWidth = [UIScreen mainScreen].bounds.size.width/2;
        indicatorHeight = 5.0;

         statusbarH = [UIApplication sharedApplication].statusBarFrame.size.height;
        font = 14;
        imgW = 100;
        cgGrap = 10 ;
        headerViewRect = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+statusbarH, self.view.frame.size.width, 160);
        userNameRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2 - imgW/2,self.view.frame.size.width/2, 30);
      
        imgProfileRect = CGRectMake(ScreenW/4 - (imgW/2 + 10), headerViewRect.size.height/2 - imgW/2, imgW, imgW);
        followerLblRect = CGRectMake(ScreenW/2,  headerViewRect.size.height/2 - 30 , ScreenW/2, 30);
        followingLblRect = CGRectMake(ScreenW/2 + ScreenW/4,  headerViewRect.size.height/2 - 30 ,100, 30);
        followersCountRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2, 70 , 30);
        followingCountRect = CGRectMake(ScreenW/2 + ScreenW/4, headerViewRect.size.height/2 , 70 , 30);
        FollowBtnRect = CGRectMake(ScreenW/2 + followersCountRect.size.width/4, headerViewRect.size.height/2 + 40, ScreenW/3 , 30);
       containerViewRect =CGRectMake(0,  headerViewRect.origin.y + headerViewRect.size.height, self.view.bounds.size.width ,  self.view.bounds.size.height - (headerViewRect.origin.y + headerViewRect.size.height));

        pageControlRect = CGRectMake(0, headerViewRect.origin.y + headerViewRect.size.height + (titleHeight-45) , self.view.bounds.size.width, self.view.bounds.size.height-(headerViewRect.origin.y + headerViewRect.size.height) );
    
    }
    

}
-(void)initial{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    userData = _userData;
    NSLog(@"alldata %@",userData);
    NSLog(@"PassingData %@",_userData.userId);
    
    
    headerView = [[UIView alloc] initWithFrame:headerViewRect];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    imgProfile = [[UIImageView alloc] initWithFrame:imgProfileRect];
    
    imgProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userData.profile_picture]]];
    imgProfile.layer.cornerRadius = imgW/2;
    imgProfile.clipsToBounds = TRUE;
    [headerView addSubview:imgProfile];
    
    userName = [[UILabel alloc] initWithFrame:userNameRect];
    userName.text = [userData.first_name stringByAppendingString:[@" " stringByAppendingString:userData.last_name]];
    userName.font = [UIFont fontWithName:@"Helvetica" size:font+6];
//    userName.font = [UIFont fo]
    userName.textColor = [UIColor blackColor];
    //(__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    [headerView addSubview:userName];
    
    UILabel *followerLbl = [[UILabel alloc] initWithFrame:followerLblRect];
    followerLbl.text = @"Followers";
    followerLbl.textColor = [UIColor grayColor];
    followerLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    [headerView addSubview:followerLbl];
    
    UILabel *followingLbl = [[UILabel alloc] initWithFrame:followingLblRect];
    followingLbl.text = @"Following";
    followingLbl.textColor = [UIColor grayColor];
    followingLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    [headerView addSubview:followingLbl];
    
    followersCount = [[UILabel alloc] initWithFrame:followersCountRect];
    followersCount.backgroundColor = [UIColor whiteColor];
    followersCount.text = userData.count_follower;
    followersCount.font =[UIFont fontWithName:@"Helvetica" size:font];
    followersCount.textAlignment = NSTextAlignmentCenter ;
    followersCount.textColor = [UIColor redColor];
//    (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    followersCount.layer.borderWidth = 1;
    followersCount.layer.borderColor = [UIColor grayColor].CGColor;
  
    followersCount.layer.cornerRadius = 5;
    followersCount.clipsToBounds = YES;
    [headerView addSubview:followersCount];
    
    followingCount = [[UILabel alloc] initWithFrame:followingCountRect];
    followingCount.backgroundColor = [UIColor whiteColor];
    followingCount.text = userData.count_following;
    followingCount.font =[UIFont fontWithName:@"Helvetica" size:font];
    followingCount.textAlignment = NSTextAlignmentCenter ;
    followingCount.textColor = [UIColor redColor];
    //(__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    followingCount.layer.borderWidth = 1;
    followingCount.layer.borderColor =   [UIColor grayColor].CGColor;
    followingCount.layer.cornerRadius = 5;
    followingCount.clipsToBounds = YES;
    [headerView addSubview:followingCount];

    FollowBtn = [[UIButton alloc] initWithFrame:FollowBtnRect];
    btnLbl = [[UILabel alloc] initWithFrame:FollowBtn.bounds];
    btnLbl.text = @"Follow";
    btnLbl.font =[UIFont fontWithName:@"Helvetica" size:font];
    btnLbl.textColor =  (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    btnLbl.textAlignment = NSTextAlignmentCenter;
    
    [FollowBtn addSubview:btnLbl];
    FollowBtn.backgroundColor = [UIColor whiteColor];
    FollowBtn.layer.borderWidth = 1;
    FollowBtn.layer.borderColor =  [UIColor grayColor].CGColor;    
    
    FollowBtn.layer.cornerRadius = 5;
    FollowBtn.clipsToBounds = YES;
    if(appDelegate.isLogin && userData.is_followed && ![appDelegate.user_ID isEqualToString:userData.userId])
    {
        btnLbl.textColor = [UIColor whiteColor];
        [btnLbl setText:@"Following"];
        FollowBtn.backgroundColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.15 alpha:1];
        //[UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1];
    }else
    {
        btnLbl.textColor = [UIColor blackColor];
        //[UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1];
        FollowBtn.backgroundColor = [UIColor whiteColor];
        
    }
    FollowBtn.tag = 7;
    [FollowBtn addTarget:self action:@selector(setFollow:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:FollowBtn];
    
    
    //  containerView = [[UIView alloc] init];
    // [containerView setFrame:containerViewRect];

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
    _pageControl.iTitleViewWidth = [UIScreen mainScreen].bounds.size.width;
    _pageControl.bEnablePagesEndBounceEffect = NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
    _pageControl.colorTabText = [UIColor blackColor]; //orangeColor
    _pageControl.colorTitleBarBackground = [UIColor whiteColor];
    _pageControl.colorPageIndicator = [UIColor redColor];
    //[UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]; //[UIColor orangeColor]; //blueColor
    _pageControl.colorPageOverscrollBackground = [UIColor whiteColor];
    
    _pageControl.bShowMoreTabAvailableIndicator = NO;
    // _pageControl.iTitleViewWidth = indicatorWidth;
    
    
    /**** 3. Add as subview ****/
    
    _pageControl.view.frame = pageControlRect;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"showmylocation"]) {
        NSLog(@"SHOW");
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)backBarbtn:(id)sender {
//   AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refresh"
     object:nil];
//    NSLog(@"pagename ::: %@",appDelegate.pageName);
//   appDelegate.pageName = @"MyStream";
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"refresh"
//     object:nil];

}
- (void)setFollow:(id)sender
{
  
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
    [hud show:YES];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    if (appDelegate.isLogin) {
        NSLog(@"setFollow tag %ld",(long)FollowBtn.tag);
        if(!userData.is_followed && ![appDelegate.user_ID isEqualToString:userData.userId])
        {
            [[UserManager shareIntance]followAPI:@"follow" userID:appDelegate.user_ID followingUserID:userData.userId Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                NSLog(@"setFollow %@",result);
                [hud hide:YES];
                int  followersPlus = [userData.count_follower intValue]+1;
                userData.count_follower = [NSString stringWithFormat:@"%d",followersPlus];
                NSLog(@"followersPlus %d",followersPlus);
                followersCount.text = [NSString stringWithFormat:@"%d",followersPlus];
                userData.is_followed = true;
                
                
                btnLbl.textColor = [UIColor whiteColor];
                [btnLbl setText:@"Following"];
                FollowBtn.backgroundColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.15 alpha:1];

                [FollowBtn reloadInputViews];
                [headerView reloadInputViews];
                
            }];
            
            
            
        }else
        {
            [[UserManager shareIntance]followAPI:@"unfollow" userID:appDelegate.user_ID followingUserID:userData.userId Completion:^(NSError *error, NSDictionary *result, NSString *message){
                NSLog(@"setFollow %@",result);
                [hud hide:YES];
                int followersSub = [userData.count_follower intValue]-1;
                
                userData.count_follower = [NSString stringWithFormat:@"%d",followersSub];
                followersCount.text = [NSString stringWithFormat:@"%d",followersSub];
                userData.is_followed = false;
                
                btnLbl.textColor = [UIColor blackColor];
                [btnLbl setText:@"Follow"];
                FollowBtn.backgroundColor = [UIColor whiteColor];
                
                [FollowBtn reloadInputViews];
                [headerView reloadInputViews];
            }];

        }

    }
    else
    {
        [hud hide:YES];

        NSLog(@"is not login ");
        UIViewController *stream = [[UIViewController alloc] init];
        stream = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
        stream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:stream animated:YES completion:Nil];
    }
    
}
- (void) refreshList:(NSNotification *)refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"ADView Notiname:%@",[refreshName name]);

    if ([[refreshName name] isEqualToString:@"refresh"])
    {
        //[self viewDidLoad];
     //  [self dismissViewControllerAnimated:YES completion:nil];
        [_pageControl.view removeFromSuperview];
        [self viewDidLoad];
        NSLog (@"Reload successfully");
    }
    
}
@end
