//
//  VideoPagingViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/29/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "VideoPagingViewController.h"
#import "TAPageControl.h"
#import "VideoListViewController.h"
#import "VideoDetailViewController.h"
#import "VideoPlace.h"
#import "ContainerViewController.h"

#import "defs.h"
#import "AFNetworking.h"
#import "ROI.h"
#import "CCTVS.h"

#import "Model_TopPage.h"
#import "DataManager.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "UIColor+Hex.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
//#import "UILabel+MFAutoresizeLabel.h"

#import <SMPageControl/SMPageControl.h>
#import "CustomIOSAlertView.h"
#import "customAlertPromotion.h"
#import "RegisterVC.h"
#import "AppDelegate.h"

#import "PromotionManager.h"
#import "LoginNavViewController.h"
#import "UserManager.h"
#import "ModelManager.h"
#import <Google/Analytics.h>
#import "SVWebViewController.h"
#import "AppDelegate.h"
//#import "SVPullToRefresh.h"

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface VideoPagingViewController ()<CustomIOSAlertViewDelegate,UIScrollViewDelegate,UIApplicationDelegate> {
    UIImageView *logoCCTV;
    UIImageView *ic_cctv;
    UIImageView *imageView ;
    IBOutlet UIScrollView *scrollView;
    NSInteger count;
    
    
    UIScrollView *previewScrollView;
    
    UIActivityIndicatorView *activityIndicator;
    UILabel *lblPoint;
    UIImageView *imgIconPoint;
    UIImageView *imgIconPlace;
    UILabel *lblPlace;
    UILabel *lblview;
    UIImageView *imgIconView;
    NSMutableArray *pointPosition;
    NSMutableArray *pointList;
    UITableViewCell *cell;
    
    CGFloat cellHeight;
    CGFloat scHeiht;
    CGFloat imgHeight;
    
    CGFloat fontSize;
    CGFloat fontPromotionSize;
    CGFloat grapFontW;
    CGFloat lblH;
    CGFloat lblPlaceY;
    CGFloat lblInitialY;
    CGFloat lblChangelY;
    CGFloat icoInitialY;
    CGFloat iconPointW;
    CGFloat iconPlaceW;
    CGFloat grapLblPointW;
    CGFloat grapIconPointW;
    CGFloat grapIconPointWL;
    CGFloat pagingSize;
    CGFloat dotSize;
    NSString *promotionName;
    BOOL PROMOTION;
    EAIntroView *_intro;
    EAIntroView *intro;
    UIView *headerView;
    
    CGFloat viewCountLblW;
    CGFloat viewCountLblH;
    CGFloat screenwidth ;
    CGFloat screenheigth ;
    NSString* webUrl;
    SVModalWebViewController *webViewController;
    CustomIOSAlertView *alertView;
    
    UIView *viewPlace;
    CGFloat vdoCount;
    NSMutableArray *newRoi;
    CGFloat scGrap;
}
@property (nonatomic, strong) TAPageControl *customPageControl;
@property (nonatomic, strong) NSMutableArray *pageControlList;
@property (nonatomic, assign) NSInteger rowCount;
@property (nonatomic) NSString *loadingTitle;

@end

@implementation VideoPagingViewController

-(void)viewWillAppear:(BOOL)animated
{
    //    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    //    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    //    // If you're copying this to an app just using Analytics, you'll
    //    // need to configure your tracking ID here.
    //    // [START screen_view_hit_objc]
    //    NSLog(@"analytics Menu");
    //    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //    NSString *name = [NSString stringWithFormat:@"Menu"];
    //    NSString *dimensionValue = @"iOS";
    //    NSString *metricValue = @"iOS_METRIC_VALUE";
    //    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    //    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    //    [tracker set:kGAIScreenName value:name];
    //    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    //    // [END screen_view_hit_objc]
    
    [self checkPromotion];
}
- (void)viewDidAppear:(BOOL)animated {
//    [_tblViewVideo triggerPullToRefresh];
}
#pragma mark - Actions

- (void)setupDataSource {
    //    self.dataSource = [NSMutableArray array];
    //    for(int i=0; i<15; i++)
    //        [self.dataSource addObject:[NSDate dateWithTimeIntervalSinceNow:-(i*90)]];
}

- (void)insertRowAtTop {
    __weak VideoPagingViewController *weakSelf = self;
    NSLog(@"insertRowAtTop");
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [_tblViewVideo beginUpdates];
        //        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
        //        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//        [_tblViewVideo endUpdates];
//        [_tblViewVideo reloadData];
//        [_tblViewVideo.pullToRefreshView stopAnimating];
        
    });
}


- (void)insertRowAtBottom {
    __weak VideoPagingViewController *weakSelf = self;
    NSLog(@"insertRowAtBottom");
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [_tblViewVideo beginUpdates];
        //        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
        //        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
//        [_tblViewVideo endUpdates];
//        [_tblViewVideo reloadData];
//        [_tblViewVideo.infiniteScrollingView stopAnimating];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger * cellcount;
    //    cellcount = UITableview.cell.cellcount;
    NSLog(@"VideoPage");
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    [self initialSize];
    [self initial];
    [self getTopPageView];
    
    
    scrollView.delegate = self;
    //    previewScrollView.delegate = self;
    _tblViewVideo.delegate = self;
    __weak VideoPagingViewController *weakSelf = self;
    
//    [_tblViewVideo addPullToRefreshWithActionHandler:^{
//        [weakSelf insertRowAtTop];
//    }];
    
    // setup infinite scrolling
//    [_tblViewVideo addInfiniteScrollingWithActionHandler:^{
//        [weakSelf insertRowAtBottom];
//    }];
    [_intro setDelegate:self];
    
    
    
}
+ (void)initialize {
    
    /*
     HNKCacheFormat *format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
     
     format.compressionQuality = 0.5;
     // UIImageView category default: 0.75, -[HNKCacheFormat initWithName:] default: 1.
     
     format.allowUpscaling = YES;
     // UIImageView category default: YES, -[HNKCacheFormat initWithName:] default: NO.
     
     format.diskCapacity = 10 * 1024 * 1024;
     // UIImageView category default: 10 * 1024 * 1024 (10MB), -[HNKCacheFormat initWithName:] default: 0 (no disk cache).
     
     format.preloadPolicy = HNKPreloadPolicyAll;
     // Default: HNKPreloadPolicyNone,HNKPreloadPolicyLastSession,HNKPreloadPolicyAll
     
     format.scaleMode = HNKScaleModeAspectFit;
     // UIImageView category default: -[UIImageView contentMode], -[HNKCacheFormat initWithName:] default: HNKScaleModeFill. HNKScaleModeAspectFill
     
     format.size = CGSizeMake(kImgWidth, kImgHeight);
     // UIImageView category default: -[UIImageView bounds].size, -[HNKCacheFormat initWithName:] default: CGSizeZero.
     
     format.preResizeBlock = ^UIImage* (NSString *key, UIImage *image) {
     
     CGSize newSize = CGSizeMake(kImgWidth, kImgHeight);
     UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
     [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
     
     UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return newImage;
     
     };
     
     format.postResizeBlock = ^UIImage* (NSString *key, UIImage *image) {
     
     CGSize newSize = CGSizeMake(kImgWidth, kImgHeight);
     UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
     [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
     
     
     UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return newImage;
     };
     
     
     [[HNKCache sharedCache] registerFormat:format];
     */
}
-(void)initialPromotiompopup{
    
    
    screenwidth = [UIScreen mainScreen].bounds.size.width;
    screenheigth = [UIScreen mainScreen].bounds.size.height;
    
    alertView = [[CustomIOSAlertView alloc] init];
    [alertView setContainerView:[self createPromotionView]];
    alertView.buttonTitles = nil;
    [alertView setDelegate:self];
    [alertView setUseMotionEffects:true];
    [alertView show];
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
}

-(void)checkPromotion
{
    NSString * URL;
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    [[PromotionManager shareIntance] getPromotion:URL Completion:^(NSError *error, NSDictionary *result, NSString *message) {
//        NSLog(@"promotion all count %lu",(unsigned long)[result count]);
//        NSLog(@"promotion : %@",result);
        if ([result count] != 0) {
            appDelegate.hasPromotion = YES;
            if (!appDelegate.isPromotion) {
                [self initialPromotiompopup];
            }
        }else
        {
            appDelegate.hasPromotion = NO;
        }
    }];
}
- (UIView *)createPromotionView
{
    
    UIView *promotionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenwidth - 40 , screenheigth-40)];
    customAlertPromotion *presentPromotion = [[customAlertPromotion alloc] init];
    presentPromotion = [[NSBundle mainBundle]loadNibNamed:@"customAlertPromotion" owner:self options:nil][0];
    promotionView.backgroundColor = [UIColor clearColor];
    promotionView.layer.cornerRadius = 10;
    presentPromotion.frame = CGRectMake(0, 0, promotionView.frame.size.width, promotionView.frame.size.height);
    presentPromotion.layer.cornerRadius = 10;
    presentPromotion.backgroundColor = [UIColor clearColor];
    
    //   [presentPromotion.noThankBtn addTarget:self action:@selector(dissmissAlert:) forControlEvents:UIControlEventTouchUpInside];
    //   [presentPromotion.gotoPromotionBtn addTarget:self action:@selector(promotions:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    NSString *URL;
    webUrl = [[NSMutableArray alloc]init];
    
    [[PromotionManager shareIntance] getPromotion:URL Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        NSLog(@"promotion%@",result);
        
        [presentPromotion.imagePromotion addTarget:self action:@selector(promotionsAction:) forControlEvents:UIControlEventTouchUpInside];
        presentPromotion.imagePromotion.tag = [result[@"mobile_activity_properties"][0][@"action"] intValue];
        
        if(presentPromotion.imagePromotion.tag == 6)
        {
            webUrl = result[@"mobile_activity_properties"][0][@"content_url"];
            //            [webUrl addObject:result[@"mobile_activity_properties"][0][@"content_url"]];
            
            
        }
        [presentPromotion.noThankBtn addTarget:self action:@selector(promotionsAction:) forControlEvents:UIControlEventTouchUpInside];
        presentPromotion.noThankBtn.tag = [result[@"mobile_activity_properties"][1][@"action"] intValue];
        [presentPromotion.gotoPromotionBtn addTarget:self action:@selector(promotionsAction:) forControlEvents:UIControlEventTouchUpInside];
        presentPromotion.gotoPromotionBtn.tag = [result[@"mobile_activity_properties"][2][@"action"] intValue];
        
        promotionName = result[@"keyname"];
        //image promotion
        NSString *detailimage = result[@"mobile_activity_properties"][0][@"image_url"];
        NSURL *imageURL = [NSURL URLWithString:detailimage];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        //        promotionAction0 = [result[@"mobile_activity_properties"][0][@"action"] intValue];
        //        presentPromotion.imagePromotion.image = [UIImage imageWithData:imageData];
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:presentPromotion.imagePromotion.bounds];
        img0.image = [UIImage imageWithData:imageData];
        NSLog(@"%@",detailimage);
        
        // button cancel promotion
        //        promotionAction1 = [result[@"mobile_activity_properties"][1][@"action"] intValue];
        UILabel *btnPosition2 = [[UILabel alloc]init];
        if(result[@"mobile_activity_properties"][1][@"image_url"] != (id)[NSNull null])
        {
            btnPosition2 = [[UILabel alloc] initWithFrame:CGRectMake(0, presentPromotion.noThankBtn.frame.size.height/2 - 20, presentPromotion.noThankBtn.bounds.size.width, lblPlaceY)];
            //            btnPosition2.textColor =[UIColor colorWithRed:163 green:163 blue:163 alpha:1];
            btnPosition2.text = [NSString stringWithFormat:@"%@",result[@"mobile_activity_properties"][1][@"text"]];
            btnPosition2.textColor = [UIColor colorWithCSS:result[@"mobile_activity_properties"][1][@"text_color"]];
            NSString *cancelimage = result[@"mobile_activity_properties"][1][@"image_url"];
            NSLog(@"555555%@",result[@"mobile_activity_properties"][1][@"text"]);
            NSURL *cancelImageURL = [NSURL URLWithString:cancelimage];
            NSData *cancelimageData = [NSData dataWithContentsOfURL:cancelImageURL];
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:presentPromotion.noThankBtn.bounds];
            img2.image = [UIImage imageWithData:cancelimageData];
            [presentPromotion.noThankBtn addSubview:img2];
            
        }else
        {
            NSLog(@"image_url Null");
            btnPosition2 = [[UILabel alloc] initWithFrame:CGRectMake(0, presentPromotion.noThankBtn.frame.size.height/2 - 20, presentPromotion.noThankBtn.bounds.size.width, lblPlaceY)];
            btnPosition2.text = [NSString stringWithFormat:@"%@",result[@"mobile_activity_properties"][1][@"text"]];
            btnPosition2.textColor = [UIColor colorWithCSS:result[@"mobile_activity_properties"][1][@"text_color"]];
        }
        
        btnPosition2.textAlignment = NSTextAlignmentCenter;
        btnPosition2.font = [UIFont systemFontOfSize:fontPromotionSize];
        [presentPromotion.imagePromotion addSubview:img0];
        [presentPromotion.noThankBtn addSubview:btnPosition2];
        
        
        //button goto promotion page
        UILabel *btnPosition3 = [[UILabel alloc]init];
        if(result[@"mobile_activity_properties"][2][@"image_url"] != (id)[NSNull null])
        {
            NSString *promotionimage = result[@"mobile_activity_properties"][2][@"image_url"];
            NSLog(@"%@",result[@"mobile_activity_properties"][2][@"image_url"]);
            btnPosition3 = [[UILabel alloc] initWithFrame:CGRectMake(0, presentPromotion.gotoPromotionBtn.frame.size.height/2 - 20 , presentPromotion.gotoPromotionBtn.bounds.size.width, lblPlaceY)];
            btnPosition3.text = [NSString stringWithFormat:@"%@",result[@"mobile_activity_properties"][2][@"text"]];
            btnPosition3.textColor = [UIColor colorWithCSS:result[@"mobile_activity_properties"][2][@"text_color"]];
            
            NSURL *promotionImageURL = [NSURL URLWithString:promotionimage];
            NSData *promotionimageData = [NSData dataWithContentsOfURL:promotionImageURL];
            
            UIImageView *img3 = [[UIImageView alloc] initWithFrame:presentPromotion.gotoPromotionBtn.bounds];
            img3.image = [UIImage imageWithData:promotionimageData];
            
            
            promotionView.backgroundColor = [UIColor whiteColor];
            [presentPromotion.gotoPromotionBtn addSubview:img3];
        }else
        {
            NSLog(@"image_url Null");
            btnPosition3 = [[UILabel alloc] initWithFrame:CGRectMake(0, presentPromotion.gotoPromotionBtn.frame.size.height/2 - 20 , presentPromotion.gotoPromotionBtn.bounds.size.width, lblPlaceY)];
            btnPosition3.text = [NSString stringWithFormat:@"%@",result[@"mobile_activity_properties"][2][@"text"]];
            btnPosition3.textColor = [UIColor colorWithCSS:result[@"mobile_activity_properties"][2][@"text_color"]];
            promotionView.backgroundColor = [UIColor colorWithCSS:result[@"mobile_activity_properties"][2][@"background_color"]];
        }
        
        btnPosition3.textAlignment = NSTextAlignmentCenter;
        btnPosition3.font = [UIFont systemFontOfSize:fontPromotionSize];
        [presentPromotion.gotoPromotionBtn addSubview:btnPosition3];
        [promotionView addSubview:presentPromotion];
        
    }];
    
    return promotionView;
}

-(void)dissmissAlert:(UIButton *)sender{
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [@"Promotion_" stringByAppendingString:[promotionName stringByAppendingString:@"_Cancel"]];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    NSNumber *value = [NSNumber numberWithInt:0];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:[name stringByAppendingString:@"_Action"]     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"Button"          // Event label
                                                           value:value] build]];    // Event value
    
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.isPromotion = YES;
    [alertView close];
}
-(void)promotions:(UIButton *)sender{
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [@"Promotion_" stringByAppendingString:promotionName];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    NSNumber *value = [NSNumber numberWithInt:1];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:[name stringByAppendingString:@"_Action"]   // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"Button"          // Event label
                                                           value:value] build]];    // Event value
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
    
    [alertView close];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.isPromotion = YES;
    // NSString * storyboardName = @"Main";
    // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *regis =[self.storyboard instantiateViewControllerWithIdentifier:@"regisnav"];
    regis.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:regis animated:YES completion:nil];
    
}

//action code
//0 = Cancel
//1 = Register
//2 = LiveStreaming
//3 = CCTV
//4= Coupon
//5 = Activity

-(void)promotionsAction:(UIButton*)sender{
    [alertView close];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    NSLog(@"action : %ld",(long)sender.tag);
    NSLog(@"webUrl : %@",webUrl);
    int action = sender.tag;
    appDelegate.isPromotion = YES;
    NSString * storyboardName = @"Main";
    NSString * promoNavName = @"";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    
    if(action == 6)
    {
        
        NSURL *URL = [NSURL URLWithString:webUrl];
        //        NSURL *URL = [NSURL URLWithString:@"http://www.seeitlivethailand.com/blogs"];
        webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
        
        webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:webViewController animated:YES completion:NULL];
        
    }else if (action == 0)
    {
        [alertView close];
    }else
    {
        switch (action) {
            case 0:
                NSLog(@"Close Promobutton");
                promoNavName = @"navvc";
                
                break;
            case 1:
                NSLog(@"Register Promobutton");
                promoNavName = @"regisnav";
                break;
            case 2:
                NSLog(@"LiveStreaming Promobutton");
                promoNavName = @"navvc";
                break;
            case 3:
                NSLog(@"CCTV Promobutton");
                promoNavName = @"navvc";
                break;
            case 4:
                NSLog(@"Coupon navvc");
                promoNavName = @"regisnav";
                break;
            case 5:
                NSLog(@"Activity Promobutton");
                promoNavName = @"navvc";
                break;
            case 6:
                NSLog(@"Activity webview");
                promoNavName = @"navvc";
                break;
            case 7:
                NSLog(@"Activity Login");
                //                appDelegate.pageName = @"MyProfile";
                //                if (appDelegate.isLogin == true) {
                //                    promoNavName = @"navvc";
                //                }else
                //                {
                //                    promoNavName = @"loginnav";
                //                }
                promoNavName = @"loginnav";
                break;
            default:
                NSLog(@"Main Promobutton");
                promoNavName = @"navvc";
                break;
        }
        
        
        
        //        ContainerViewController* test = [[ContainerViewController alloc]init];
        //        [test addViewForth:self];
        
        UIViewController *promoAction =[storyboard instantiateViewControllerWithIdentifier:promoNavName];
        promoAction.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:promoAction animated:YES completion:nil];
        
        //
        ////        MyViewController *myViewController = [[MyViewController alloc] initWithNibName:nil bundle:nil];
        //        UINavigationController *navigationController =
        //        [storyboard instantiateViewControllerWithIdentifier:promoNavName];
        //
        //        //now present this navigation controller modally
        //        [self presentViewController:navigationController
        //                           animated:YES
        //                         completion:^{
        //
        //                         }];
        //
        
    }
    
    
}

-(void)pageView{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    
    
    
    UIView *totalName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    UILabel *totalName1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    totalName1.text = @"TOTAL VIEW" ;
    totalName1.textAlignment = NSTextAlignmentCenter ;
    totalName1.textColor = [UIColor whiteColor];
    totalName1.layer.borderWidth = 1 ;
    totalName1.layer.borderColor = [UIColor whiteColor].CGColor;
    totalName1.backgroundColor =[UIColor clearColor];
    totalName1.font =[UIFont systemFontOfSize:fontSize];
    [totalName addSubview:totalName1];
    
    UIView *top1View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    UILabel *totalName2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    totalName2.text = @"PHUKET" ;
    totalName2.textAlignment = NSTextAlignmentCenter ;
    totalName2.textColor = [UIColor whiteColor];
    totalName2.layer.borderWidth = 1 ;
    totalName2.layer.borderColor = [UIColor whiteColor].CGColor;
    totalName2.backgroundColor =[UIColor clearColor];
    totalName2.font =[UIFont systemFontOfSize:fontSize];
    [top1View addSubview:totalName2];
    
    UIView *top2View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    UILabel *totalName3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    totalName3.text = @"PATTAYA" ;
    totalName3.textAlignment = NSTextAlignmentCenter ;
    totalName3.textColor = [UIColor whiteColor];
    totalName3.layer.borderWidth = 1 ;
    totalName3.layer.borderColor = [UIColor whiteColor].CGColor;
    totalName3.backgroundColor =[UIColor clearColor];
    totalName3.font =[UIFont systemFontOfSize:fontSize];
    [top2View addSubview:totalName3];
    
    
    UIImageView *totalViewCount1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    UILabel *viewCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    viewCountLbl.font =[UIFont systemFontOfSize:fontSize];
    NSLog(@"Total show %@",appDelegate.topAll[@"totalView"]);
    viewCountLbl.text = (appDelegate.topAll[@"totalView"]!=nil)? [self addComma:appDelegate.topAll[@"totalView"]]:@"" ;
    //    viewCountLbl.text = @"1111111" ;
    viewCountLbl.textAlignment = NSTextAlignmentCenter ;
    viewCountLbl.textColor = [UIColor blackColor];
    viewCountLbl.backgroundColor =[UIColor whiteColor];
    [totalViewCount1 addSubview:viewCountLbl];
    
    UIImageView *totalViewCount2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    UILabel *viewCountLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    viewCountLbl2.font =[UIFont systemFontOfSize:fontSize];
    NSLog(@"Total show topPattaya %@",appDelegate.topPattaya[@"totalView"]);
    viewCountLbl2.text = (appDelegate.topPattaya[@"totalView"]!=nil)? [self addComma:appDelegate.topPattaya[@"totalView"]]:@"" ;
    //     viewCountLbl2.text = @"2222222" ;
    viewCountLbl2.textAlignment = NSTextAlignmentCenter ;
    viewCountLbl2.textColor = [UIColor blackColor];
    viewCountLbl2.backgroundColor =[UIColor whiteColor];
    [totalViewCount2 addSubview:viewCountLbl2];
    
    
    
    UIImageView *totalViewCount3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    UILabel *viewCountLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewCountLblW, viewCountLblH)];
    viewCountLbl3.text = (appDelegate.topPhuket[@"totalView"]!=nil)? [self addComma:appDelegate.topPhuket[@"totalView"]]:@"" ;
    viewCountLbl3.font =[UIFont systemFontOfSize:fontSize];
    viewCountLbl3.textAlignment = NSTextAlignmentCenter ;
    viewCountLbl3.textColor = [UIColor blackColor];
    viewCountLbl3.backgroundColor =[UIColor whiteColor];
    [totalViewCount3 addSubview:viewCountLbl3];
    
    //    headerView.frame = CGRectMake(0, 0, headerView.frame.size.width, cellHeight - 80);
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgColor = [UIColor whiteColor];
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgColor = [UIColor whiteColor];
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"PAGE VIEW";
    
    
    //set 2 UI
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        page1.bgImage = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.topAll[@"coverURL"]]]];
        page1.titleIconView = totalViewCount1;
        page1.titleIconPositionY = cellHeight/2;
        page1.title = @"PAGE VIEW";
        page1.titleFont = [UIFont systemFontOfSize:fontSize];
        page1.titlePositionY = cellHeight/2 ;
        
        
        page2.bgImage = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.topPattaya[@"coverURL"]]]];
        page2.titleIconView = totalViewCount2;
        page2.titleIconPositionY =  cellHeight/2;
        page2.title = @"PAGE VIEW";
        page2.titleFont = [UIFont systemFontOfSize:fontSize];
        page2.titlePositionY = cellHeight/2 ;
        
        
        page3.bgImage = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.topPhuket[@"coverURL"]]]];
        page3.titleIconView = totalViewCount3;
        page3.titleIconPositionY = cellHeight/2   ;
        page3.titleFont = [UIFont systemFontOfSize:fontSize];
        page3.titlePositionY = cellHeight/2  ;
        page3.bgColor = [UIColor whiteColor];
        
    }
    else{
        
        page1.bgImage = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.topAll[@"coverURL"]]]];
        page1.titleIconView = totalViewCount1;
        page1.titleIconPositionY = (cellHeight/4)+(viewCountLblH);
        page1.title = @"PAGE VIEW";
        page1.titleFont = [UIFont systemFontOfSize:fontSize];
        page1.titlePositionY = (cellHeight/3)+(viewCountLblH/4) ;
        
        
        page2.bgImage = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.topPattaya[@"coverURL"]]]];
        page2.titleIconView = totalViewCount2;
        page2.titleIconPositionY =cellHeight/4+(viewCountLblH) ;
        page2.title = @"PAGE VIEW";
        page2.titleFont = [UIFont systemFontOfSize:fontSize];
        page2.titlePositionY =   cellHeight/3+(viewCountLblH/4)  ;
        
        
        page3.bgImage = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.topPhuket[@"coverURL"]]]];
        page3.titleIconView = totalViewCount3;
        page3.titleIconPositionY = cellHeight/4+(viewCountLblH) ;
        page3.titleFont = [UIFont systemFontOfSize:fontSize];
        page3.titlePositionY = cellHeight/3+(viewCountLblH/4)  ;
        page3.bgColor = [UIColor whiteColor];
    }
    
    intro = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width,headerView.frame.size.height) andPages:@[page1,page2,page3]];
    [intro setDelegate:self];
    intro.skipButton.hidden = YES ;
    intro.swipeToExit = NO;
    intro.pageControlY = 20;
    NSLog(@"%f",intro.frame.size.height);
    NSLog(@"%f",headerView.frame.size.height);
    
    
    page1.onPageDidAppear= ^{
        intro.titleView = totalName;
        intro.titleViewY = headerView.frame.size.height/6;
        
        //intro.titleViewY = cellHeight/2 - 20 ;
        // intro.pages = pa;
        
        
    };
    page2.onPageDidAppear = ^{
        intro.titleView = top1View ;
        intro.titleViewY = headerView.frame.size.height/6;
    };
    page3.onPageDidAppear = ^{
        intro.titleView = top2View ;
        intro.titleViewY = (headerView.frame.size.height/6);
    };
    
    [intro showInView:headerView animateDuration:0.3];
    _intro = intro;
    
    
    
    ic_cctv = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.center.x - 90 , headerView.frame.size.height, 180 , 50)];
    
    ic_cctv.image = [[UIImage imageNamed:@"ic_headline.png"] init];
    ic_cctv.backgroundColor = [UIColor whiteColor];
    
    [scrollView addSubview:ic_cctv];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cellHeight = 260 * SCALING_Y;
        scHeiht = 240 * SCALING_Y;
        imgHeight = 180 * SCALING_Y;
        
        fontSize = 14.0 * SCALING_Y;
        fontPromotionSize = 25* SCALING_Y;
        grapFontW = 7 * SCALING_X;
        lblH = 25 * SCALING_Y;
        lblPlaceY = 32 * SCALING_Y;
        lblInitialY = 189 * SCALING_Y;
        lblChangelY = 194 * SCALING_Y;
        icoInitialY = 185 * SCALING_Y;
        iconPointW = 25 * SCALING_X;
        iconPlaceW = 25 * SCALING_X;
        grapLblPointW = 5 * SCALING_X;
        //grapLblPointW = 5;
        grapIconPointW = 5 * SCALING_X;
        grapIconPointWL = 2 * SCALING_X;
        pagingSize = 30 * SCALING_X;
        dotSize = 11.0 * SCALING_X;
        viewCountLblW = 100 *SCALING_X;
        viewCountLblH = 30 *SCALING_Y;
        scGrap = 20*SCALING_Y;
    } else {
        
        cellHeight = 260;
        scHeiht = 240;
        imgHeight = 180;
        viewCountLblW = 130;
        viewCountLblH = 30;
        fontSize = 14;
        fontPromotionSize = 25;
        grapFontW = 7;
        lblH = 25;
        lblPlaceY = 32;
        lblInitialY = 189;
        lblChangelY = 194;
        icoInitialY = 185;
        iconPointW = 25;
        iconPlaceW = 25;
        grapLblPointW = 5;
        grapIconPointW = 5;
        grapIconPointWL = 2;
        pagingSize = 30;
        dotSize = 11.0;
        scGrap = 80;
        
    }
}


- (void)initial {
    
    //  [self.view addSubview:headerView];
    
    
    //    [[UserManager shareIntance]getTopPageView];
    /*
     UIActivityIndicatorView *progressWheel = [[UIActivityIndicatorView alloc]
     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
     
     //makes activity indicator disappear when it is stopped
     progressWheel.hidesWhenStopped = YES;
     
     //used to locate position of activity indicator
     progressWheel.center = CGPointMake(self.view.bounds.size.width/2,
     ((self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height)-35)/2);
     */
    
    // header benner view
    headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cellHeight-100);
    [scrollView addSubview:headerView];
    
    
    //[progressWheel startAnimating];
    
    self.tblViewVideo.backgroundColor = [UIColor whiteColor]; //[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];
    self.tblViewVideo.backgroundView = nil;
    self.vdoList = [[NSArray alloc] init];
    self.pageControlList = [[NSMutableArray alloc] init];
    pointPosition = [[NSMutableArray alloc] init];
    //self.placeSection = [[NSArray alloc] init];
    
    
    __weak VideoPagingViewController *weakSelf = self;
    //    ModelManager *modelManager=[ModelManager getInstance];
    //    weakSelf.vdoList = [modelManager getAllData];
    //    NSLog(@"weakSelf.vdoList count  %lu",(unsigned long)weakSelf.vdoList.count);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        NSLog(@"backgroundPC");
        // Perform async operation
        // Call your method/function here
        // Example:
        // NSString *result = [anObject calculateSomething];
        // Show progress
        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        //        hud.mode = MBProgressHUDModeIndeterminate;
        //        hud.labelText = @"Loding...";
        //        [hud show:YES];
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Update UI
            // Example:
            // self.myLabel.text = result;
            [[DataManager shareManager] getCCTVwithCompletionBlockDatabase:^(BOOL success, NSArray *roiRecords, NSError *error) {
                //                [hud hide:YES];
                if (success) {
                    ModelManager *modelManager=[ModelManager getInstance];
                    NSArray *sortedArray  = [modelManager getAllDataSort];
                    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"roiSort" ascending:NO];
                    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
                    
                    weakSelf.vdoList = [sortedArray sortedArrayUsingDescriptors:sortDescriptors];
                    NSLog(@"before weakSelf.vdoList count  %lu",(unsigned long)weakSelf.vdoList.count);
                    
                    if (weakSelf.vdoList.count == 0) {
                        NSLog(@"getDataFromWebAPI");
//                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//                        hud.mode = MBProgressHUDModeIndeterminate;
//                        hud.labelText = @"Loading data...";
//                        [hud show:YES];
                        
                        [[DataManager shareManager] getCCTVwithCompletionBlock:^(BOOL success, NSArray *roiRecords, NSError *error) {
                            weakSelf.vdoList = roiRecords;
//                            [hud hide:YES];
                            [self initial];
                            [self pageView];
                            //                            [weakSelf.tblViewVideo reloadData];
                            
                        }];
                    }
                    NSLog(@"weakSelf.vdoList count  %lu",(unsigned long)weakSelf.vdoList.count);
                    
                    UIImage *dotInactive = [self resizeImage:[UIImage imageNamed:@"dotInactive.png"] imageSize:CGSizeMake(dotSize, dotSize)];
                    UIImage *dotActive = [self resizeImage:[UIImage imageNamed:@"dotActive.png"] imageSize:CGSizeMake(dotSize, dotSize)];
                    
                    
                    
                    for (int i=0; i<= weakSelf.vdoList.count; i++) {
                        TAPageControl *taPageControl = [[TAPageControl alloc] init];
                        taPageControl.dotImage = dotInactive;
                        taPageControl.currentDotImage = dotActive;
                        [weakSelf.pageControlList addObject:taPageControl];
                        [pointPosition addObject:[NSNumber numberWithInteger:0]];
                    }
                    
                    
                } else {
                    //[progressWheel stopAnimating];
                    //self.loadingTitle = NotConnect;
                    //            [hud hide:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                [weakSelf.tblViewVideo reloadData];
                
            }];
            
            //End background process
        });
    });
    
    //    [[DataManager shareManager] getAllData];
    //    ModelManager *modelManager=[ModelManager getInstance];
    //    weakSelf.vdoList = [modelManager getAllData];
    //
    //    NSLog(@"weakSelf.vdoList getAllData %@",[[DataManager shareManager] getAllData]);
    //
    //    UIImage *dotInactive = [self resizeImage:[UIImage imageNamed:@"dotInactive.png"] imageSize:CGSizeMake(dotSize, dotSize)];
    //    UIImage *dotActive = [self resizeImage:[UIImage imageNamed:@"dotActive.png"] imageSize:CGSizeMake(dotSize, dotSize)];
    //
    //
    //    for (int i=0; i<= weakSelf.vdoList.count; i++) {
    //        TAPageControl *taPageControl = [[TAPageControl alloc] init];
    //        taPageControl.dotImage = dotInactive;
    //        taPageControl.currentDotImage = dotActive;
    //        [weakSelf.pageControlList addObject:taPageControl];
    //        [pointPosition addObject:[NSNumber numberWithInteger:0]];
    //    }
    //    [weakSelf.tblViewVideo reloadData];
    
    
    
    
}

- (void)LoadNewImage {
    
    
    __weak VideoPagingViewController *weakSelf = self;
    //
    //    [[DataManager shareManager] getCCTVwithCompletionBlock:^(BOOL success, NSArray *roiRecords, NSError *error) {
    //
    //        [weakSelf.tblViewVideo beginUpdates];
    //
    //        if (success) {
    //            weakSelf.vdoList = roiRecords;
    //
    //        } else {
    //
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //            [alert show];
    //        }
    //
    //        [weakSelf.tblViewVideo endUpdates];
    //        //        [weakSelf.tblViewVideo reloadData];
    //
    //
    //    }];
    
    
    
    /*
     dispatch_queue_t concurrentQueue = dispatch_queue_create("reloadimage", NULL);
     dispatch_async(concurrentQueue, ^{
     
     dispatch_queue_t mainThreadQueue = dispatch_get_main_queue();
     dispatch_async(mainThreadQueue, ^{
     
     });
     
     });
     */
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSInteger count = self.vdoList.count ? 1 : 0;
    //NSInteger count = self.rowCount ? self.rowCount : 1;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSInteger count = self.vdoList.count ? self.vdoList.count : 1;
    //NSInteger count = self.rowCount ? self.rowCount : 1;
    
    NSLog(@"tableViewvdoList %lu",(unsigned long)self.vdoList.count);
    return self.vdoList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat rowHeight = self.vdoList.count ? 260 : 100;
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"gooooooo1");
    static NSString *simpleTableIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.tag = indexPath.row;
    
    ROI *roi = [[ROI alloc]init];
    
    
    if (indexPath.row == 0) {
        roi = [self.vdoList objectAtIndex:[indexPath row]];
        
    }else
    {
        roi = [self.vdoList objectAtIndex:[indexPath row]];
    }
    
    CGFloat scWidth = self.view.frame.size.width;
    
    UIColor *color = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1]; // substitute your color here
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:)];
    tapGestureRec.numberOfTapsRequired = 1;
    
    previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scWidth, scHeiht)];
    [previewScrollView setContentSize:CGSizeMake(scWidth * roi.cctvs.count, scHeiht)];
    previewScrollView.backgroundColor = color;
    previewScrollView.pagingEnabled = TRUE;
    previewScrollView.delegate = self;
    previewScrollView.tag = indexPath.row + 1;
    //previewScrollView.canCancelContentTouches = YES;
    
    [previewScrollView addGestureRecognizer:tapGestureRec];
    
    [[cell contentView] addSubview:previewScrollView];
    
    [roi.cctvs enumerateObjectsUsingBlock:^(CCTVS *cctvs, NSUInteger idx, BOOL *stop) {
        
        viewPlace = [[UIView alloc] initWithFrame:CGRectMake(scWidth * idx, 0, scWidth, imgHeight)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scWidth, imgHeight)];
        
        
        UIImage *imgPH = [self resizeImage:[UIImage imageNamed:@"sil_big.jpg"] imageSize:CGSizeMake(scWidth, imgHeight)];
        
        HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
        if (!format)
        {
            format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
            format.size = CGSizeMake(scWidth, imgHeight);
            format.scaleMode = HNKScaleModeFill;
            format.compressionQuality = 1;
            format.diskCapacity = 0;//10 * 1024 * 1024; // 1MB
            format.preloadPolicy = HNKPreloadPolicyNone;
            //format.allowUpscaling = YES;
            
        }
        
        imageView.hnk_cacheFormat = format;
        
        //imageView.hnk_cacheFormat = [HNKCache sharedCache].formats[@"thumbnail"];
        NSURL *url = [NSURL URLWithString:cctvs.imageUrl];
        [imageView hnk_setImageFromURL:url placeholder:imgPH];
        imageView.contentMode = UIViewContentModeScaleToFill;
        //imageView.userInteractionEnabled = YES;
        imageView.tag = indexPath.row ;
        //imageView.image = imgPH;
        [viewPlace addSubview:imageView];
        
        
        [previewScrollView addSubview:viewPlace];
        
    }];
    
    NSInteger pointIndex = [[pointPosition objectAtIndex:indexPath.row] intValue];
    
    [previewScrollView setContentOffset:CGPointMake(previewScrollView.frame.size.width * pointIndex, 0.0f)];
    
    CCTVS *cctvsPoint = [roi.cctvs objectAtIndex:pointIndex];
    NSString *strPoint = cctvsPoint.cctvName;
    
    CGFloat pointWidth = 0.0f;
    
    CGFloat lblPointW = (scWidth/2)-(iconPointW+grapIconPointW+grapFontW);
    
    lblPoint = [[UILabel alloc] initWithFrame:CGRectMake(lblPlaceY, lblInitialY + iconPointW, lblPointW, lblH)];
    lblPoint.text = strPoint;
    lblPoint.font = font;
    //lblPoint.lineBreakMode = NSLineBreakByCharWrapping;
    //lblPoint.numberOfLines = 1;
    lblPoint.textAlignment = NSTextAlignmentLeft;
    lblPoint.tag = (indexPath.row + 1);
    //[lblPoint sizeToFit];
    //lblPoint.preferredMaxLayoutWidth = pointWidth;
    [[cell contentView] addSubview:lblPoint];
    
    pointWidth = lblPointW + iconPointW + grapLblPointW + grapIconPointW + grapIconPointWL;
    
    imgIconPoint = [[UIImageView alloc] initWithFrame:CGRectMake(2 , icoInitialY + iconPointW , iconPointW, iconPointW)];
    //imgIconPoint = [[UIImageView alloc] initWithFrame:CGRectMake(scWidth - pointWidth, icoInitialY, iconPointW, iconPointW)];
    imgIconPoint.image = [UIImage imageNamed:@"icon_H1.png"];
    imgIconPoint.tag = (indexPath.row + 1);
    [[cell contentView] addSubview:imgIconPoint];
    
    //    NSLog(@"totalViewLb: %@",cctvsPoint.totalView);
    
    
    lblview = [[UILabel alloc] initWithFrame:CGRectMake((scWidth/1.5)+(iconPointW+grapIconPointW), lblInitialY, lblPointW, lblH)];
    lblview.text = [self addComma:cctvsPoint.totalView];
    lblview.font = font;
    lblview.textAlignment = NSTextAlignmentLeft;
    lblview.tag = (indexPath.row + 500);
    [[cell contentView] addSubview:lblview];
    
    imgIconView = [[UIImageView alloc] initWithFrame:CGRectMake(scWidth/1.5, icoInitialY + 4  , iconPointW, iconPointW)];
    //imgIconPoint = [[UIImageView alloc] initWithFrame:CGRectMake(scWidth - pointWidth, icoInitialY, iconPointW, iconPointW)];
    imgIconView.image = [UIImage imageNamed:@"ic_alertcomplant.png"];
    imgIconView.tag = (indexPath.row + 500);
    [[cell contentView] addSubview:imgIconView];
    
    
    
    imgIconPlace = [[UIImageView alloc] initWithFrame:CGRectMake(2, icoInitialY, iconPlaceW, iconPlaceW)];
    imgIconPlace.tag = (indexPath.row + 3000);
    imgIconPlace.image = [UIImage imageNamed:@"icon_F.png"];
    [[cell contentView] addSubview:imgIconPlace];
    
    
    CGFloat placeWidth = scWidth - (pointWidth + iconPlaceW);
    lblPlace = [[UILabel alloc] initWithFrame:CGRectMake(lblPlaceY, lblInitialY, placeWidth - 5 , lblH)];
    lblPlace.tag = (indexPath.row + 3000);
    
    lblPlace.text = roi.roiName;
    lblPlace.font = font;
    //lblPlace.tag = 99999;
    [[cell contentView] addSubview:lblPlace];
    
    
    TAPageControl *taPageControl = (TAPageControl *)[self.pageControlList objectAtIndex:indexPath.row];
    taPageControl.frame = CGRectMake((scWidth/2)/2, CGRectGetMaxY(previewScrollView.frame)-pagingSize, CGRectGetWidth(previewScrollView.frame), pagingSize);
    taPageControl.numberOfPages = roi.cctvs.count;
    
    
    //taPageControl.dotSize = CGSizeMake(30, 30);
    
    taPageControl.currentPage = pointIndex;
    [[cell contentView] addSubview:taPageControl];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"gooooooo2");
    VideoDetailViewController *vdoDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"videodetail"];
    TAPageControl *taPageControl = (TAPageControl *)[self.pageControlList objectAtIndex:indexPath.row];
    
    
    ROI *roi = [self.vdoList objectAtIndex:[indexPath row]];
    vdoDetail.roi = roi;
    vdoDetail.rowIndex = taPageControl.currentPage;
    [self.navigationController pushViewController:vdoDetail animated:TRUE];
    
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        count = self.vdoList.count;
        NSLog(@"cellcount::: %d",count);
        [self.tblViewVideo setFrame:CGRectMake(0, cellHeight-50, [UIScreen mainScreen].bounds.size.width,(cellHeight*count)+scGrap)];
        
    }
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    
    if (scrollView.tag > 0) {
        NSLog(@"%ld", (long)scrollView.tag);
        
        NSInteger realIndex = scrollView.tag - 1;
        
        NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        
        [pointPosition replaceObjectAtIndex:realIndex withObject:[NSNumber numberWithInteger:pageIndex]];
        
        [self changePoint:realIndex andPageIndex:pageIndex];
        
        TAPageControl *taPageControl = (TAPageControl *)[self.pageControlList objectAtIndex:realIndex];
        taPageControl.currentPage = pageIndex;
        
        
        
    }
    
    
    
    //[pointPosition replaceObjectAtIndex:scrollView.tag withObject:[NSNumber numberWithInteger:pageIndex]];
    
}

- (void)setLblPoint {
    
}

- (void)changePoint:(NSUInteger)row andPageIndex:(NSInteger)index {
    
    //NSLog(@"row = %ld , index = %ld",(long)row,(long)index);
    
    //point layout
    CGFloat scWidth = self.tblViewVideo.frame.size.width;
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    ROI *roi = [self.vdoList objectAtIndex:row];
    CCTVS *cctvs = [roi.cctvs objectAtIndex:index];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.tblViewVideo cellForRowAtIndexPath:indexPath];
    NSString *strPoint = cctvs.cctvName;
    CGRect frame = [strPoint boundingRectWithSize:CGSizeMake(scWidth-grapFontW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    
    CGSize strPointSize = CGSizeMake(frame.size.width, frame.size.height);
    CGFloat pointWidth = 0.0f;
    /*
     CGFloat iconPointW = 25;
     CGFloat iconPlaceW = 25;
     CGFloat grapLblPointW = 5;
     CGFloat grapIconPointW = 5;
     CGFloat grapIconPointWL = 2;
     */
    //NSLog(@"scWidth - %f",scWidth);
    //NSLog(@"strPointSize - %f",strPointSize.width);
    //NSLog(@"frame - %f",frame.size.width);
    
    for (id lblView in [cell.contentView subviews]) {
        if ([lblView isKindOfClass:[UILabel class]]) {
            lblPoint = lblView;
            if (lblPoint.tag == (row + 1)) {
                
                
                /*
                 CGFloat maxLblPointW = scWidth - (iconPointW + grapLblPointW + grapIconPointW + grapIconPointWL);
                 CGFloat curLblPointW = strPointSize.width;
                 CGFloat lblPointW = curLblPointW >= maxLblPointW ? maxLblPointW : curLblPointW;
                 */
                CGFloat lblPointW = (scWidth/2)-(iconPointW+grapIconPointW+grapFontW);
                
                //CGFloat yOrigin = lblPoint.bounds.origin.y + 194;
                
                lblPoint.text = @"";
                lblPoint.frame =  CGRectMake(lblPlaceY, lblInitialY +25, lblPointW, lblH);
                //lblPoint.frame =
                lblPoint.text = strPoint;
                //lblPoint.lineBreakMode = NSLineBreakByCharWrapping;
                
                //lblPoint.numberOfLines = 1;
                lblPoint.textAlignment = NSTextAlignmentLeft;
                lblPoint.font = font;
                
                //[lblPoint sizeToFit];
                
                //pointWidth = lblPoint.bounds.size.width + 25;
                pointWidth = lblPointW + iconPointW + grapLblPointW + grapIconPointW + grapIconPointWL;
                
                lblview.text = [self addComma:cctvs.totalView];
                
                NSLog(@"tableW - %f",scWidth);
                NSLog(@"lblPointW - %f",lblPointW);
                NSLog(@"pointWidth x - %f",lblPoint.frame.origin.x);
                NSLog(@"pointWidth - %f",pointWidth);
                
            }
            if (lblPoint.tag ==(row+500)) {
                lblview = lblPoint;
                CGFloat lblPointW = (scWidth/2)-(iconPointW+grapIconPointW+grapFontW);
                
                lblview.frame = CGRectMake((scWidth/1.5)+(iconPointW+grapIconPointW), lblInitialY, lblPointW ,lblH);
                
            }
            
            if (lblPoint.tag == (row + 3000)) {
                lblPlace = lblPoint;
                
                CGFloat placeWidth = scWidth - (pointWidth + iconPlaceW);
                lblPlace.text = @"";
                lblPlace.frame = CGRectMake(lblPlaceY, lblInitialY, placeWidth - 5 , lblH);
                lblPlace.tag = (indexPath.row + 3000);
                lblPlace.text = roi.roiName;
                
                /*
                 if ((scWidth - (pointWidth + iconPlaceW)) > 0) {
                 
                 CGFloat placeWidth = scWidth - (pointWidth + iconPlaceW);
                 lblPlace.text = @"";
                 lblPlace.frame = CGRectMake(lblPlaceY, lblInitialY, placeWidth - 5 , lblH);
                 lblPlace.tag = (indexPath.row + 3000);
                 lblPlace.text = roi.roiName;
                 
                 lblPlace.hidden = NO;
                 
                 //NSLog(@"placeWidth - %f",placeWidth);
                 
                 } else {
                 lblPlace.hidden = YES;
                 }
                 */
            }
        }
        
        if ([lblView isKindOfClass:[UIImageView class]]) {
            imgIconPoint = lblView;
            if (imgIconPoint.tag == (row +1)) {
                
                //CGFloat yOrigin = imgIconPoint.bounds.origin.y + 185;
                imgIconPoint.frame =  CGRectMake(2 , icoInitialY + 25 , iconPointW, iconPointW);
                
                
            }
            if (imgIconPoint.tag == (row + 500)) {
                imgIconView = imgIconPoint;
                imgIconView.frame = CGRectMake(scWidth/1.5, icoInitialY + 4  , iconPointW, iconPointW);
            }
            if (imgIconPoint.tag == (row + 3000)) {
                imgIconPlace = imgIconPoint;
                imgIconPlace = [[UIImageView alloc] initWithFrame:CGRectMake(2, icoInitialY, iconPlaceW, iconPlaceW)];
                imgIconPlace.tag = (indexPath.row + 3000);
                /*
                 imgIconPlace.hidden = NO;
                 
                 if ((scWidth - pointWidth) > iconPlaceW) {
                 imgIconPlace = [[UIImageView alloc] initWithFrame:CGRectMake(2, icoInitialY, iconPlaceW, iconPlaceW)];
                 imgIconPlace.tag = (indexPath.row + 3000);
                 
                 } else {
                 imgIconPlace.hidden = YES;
                 }
                 */
            }
        }
        
        
        
        
        /*
         CGFloat pointWidth = lblPoint.bounds.size.width + 25;
         
         if ((scWidth - pointWidth) > 25) {
         //Place layout
         imgIconPlace = [[UIImageView alloc] initWithFrame:CGRectMake(2, 185, 25, 25)];
         imgIconPlace.tag = (indexPath.row + 3000);
         imgIconPlace.image = [UIImage imageNamed:@"icon_F.png"];
         [[cell contentView] addSubview:imgIconPlace];
         
         CGFloat placeWidth = pointWidth + 25;
         
         lblPlace = [[UILabel alloc] initWithFrame:CGRectMake(32, 189, placeWidth , 25)];
         lblPlace.tag = (indexPath.row + 3000);
         lblPlace.text = roi.roiName;
         //lblPlace.tag = 99999;
         [[cell contentView] addSubview:lblPlace];
         }
         */
    }
    
}

- (void)scrollViewClick:(UITapGestureRecognizer *)tapGR {
    
    UIScrollView *previewScrollView1 = (UIScrollView *)tapGR.view;
    NSInteger tag = previewScrollView1.tag - 1;
    NSInteger pageIndex = previewScrollView1.contentOffset.x / CGRectGetWidth(previewScrollView1.frame);
    
    VideoDetailViewController *vdoDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"videodetail"];
    
    ROI *roi = [self.vdoList objectAtIndex:tag];
    vdoDetail.roi = roi;
    vdoDetail.rowIndex = pageIndex;
    
    [self.navigationController pushViewController:vdoDetail animated:TRUE];
    
}


-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}
-(void)getTopPageView{
    __weak VideoPagingViewController *weakSelf = self;
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    ModelManager *modelManager=[ModelManager getInstance];
    NSMutableArray *topPageObjects = [NSMutableArray array];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        // Perform async operation
        // Call your method/function here
        // Example:
        // NSString *result = [anObject calculateSomething];
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Update UI
            // Example:
            // self.myLabel.text = result;
            NSMutableArray *topPageData = [NSMutableArray array];
            topPageData = [modelManager getTopPage];
            
            NSLog(@"toppagecount %lu",(unsigned long)topPageData.count);
            
            if (topPageData.count) {
                NSLog(@"ToppageData %@",topPageData);
                for (Model_TopPage *topPage in topPageData) {
                    NSLog(@"Topage Dic : %@",topPage.name);
                    
                    if([topPage.name isEqualToString:@"TOTAL VIEW"])
                    {
                        appDelegate.topAll     = @{@"name": topPage.name,
                                                   @"totalView": topPage.totalView,
                                                   @"coverURL": topPage.coverURL};
                    }else if([topPage.name isEqualToString:@"PHUKET"])
                    {
                        appDelegate.topPattaya = @{@"name": topPage.name,
                                                   @"totalView": topPage.totalView,
                                                   @"coverURL": topPage.coverURL};
                    }else if ([topPage.name isEqualToString:@"PATTAYA"])
                    {
                        appDelegate.topPhuket  = @{@"name": topPage.name,
                                                   @"totalView": topPage.totalView,
                                                   @"coverURL": topPage.coverURL};
                    }
                    
                }
                [self pageView];
                
            }
            NSString *apiName = @"properties";
            [[UserManager shareIntance]getAPIData:apiName Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                Model_TopPage *promotion = [[Model_TopPage alloc] init];
                NSLog(@"getTopPageView %@",result);
                NSArray * dicArray = result;
                appDelegate.topAll     = @{@"name":@"TOTAL VIEW",
                                           @"totalView":dicArray[2][@"content_en"],
                                           @"coverURL":dicArray[1][@"content_en"]};
                
                promotion.name = @"TOTAL VIEW";
                promotion.coverURL = dicArray[1][@"content_en"];
                promotion.totalView = dicArray[2][@"content_en"];
                
                [topPageObjects addObject:promotion];
                [modelManager insertTopPageData:topPageObjects];
            }];
            apiName = @"rois";
            [[UserManager shareIntance]getAPIData:apiName Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSArray * dicArray = result;
                
                NSLog(@"Result(Count) %lu",[result count]);
                NSLog(@"Result %@",result);
                int index;
                for (index = 0; index < [result count] - 1; index++) {
                    Model_TopPage *topPage = [[Model_TopPage alloc] init];
                    if ([dicArray[index][@"id_provider_information_tag_keyname"]  isEqual: @"1"]) {
                        NSLog(@"Pattaya total_view : %@",dicArray[index][@"total_view"]);
                        appDelegate.topPattaya = @{@"name":@"PATTAYA",
                                                   @"totalView":dicArray[index][@"total_view"],
                                                   @"coverURL":dicArray[index][@"cover_url"]};
                        
                        topPage.name = @"PATTAYA";
                        topPage.coverURL = dicArray[index][@"cover_url"];
                        topPage.totalView = dicArray[index][@"total_view"];
                        [topPageObjects addObject:topPage];
                        
                        
                    }else if ([dicArray[index][@"id_provider_information_tag_keyname"]  isEqual: @"6"])
                    {
                        appDelegate.topPhuket  = @{@"name":@"PHUKET",
                                                   @"totalView":dicArray[index][@"total_view"],
                                                   @"coverURL":dicArray[index][@"cover_url"]};
                        
                        topPage.name = @"PHUKET";
                        topPage.coverURL = dicArray[index][@"cover_url"];
                        topPage.totalView = dicArray[index][@"total_view"];
                        [topPageObjects addObject:topPage];
                        
                        
                    }
                    
                }
                //                    [self getTopPageView];
                NSLog(@"ALL view top three %@",appDelegate.topAll);
                NSLog(@"PATTAYA %@",appDelegate.topPattaya);
                NSLog(@"PHUKET %@",appDelegate.topPhuket);
                [modelManager insertTopPageData:topPageObjects];
            }];
            
            //End background process
            NSLog(@"background success");
            
        });
    });
    
}

-(NSString*)addComma:(NSString *)number
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
    
    
    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[number integerValue]]];
    return formatted;
}
//#pragma mark UIWebView delegate methods
//- (void)webViewDidStartLoad:(UIWebView *)webView {
////    [hud show:YES];
//    //[activityIndicator startAnimating];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
////    [hud hide:YES];
//    //[activityIndicator stopAnimating];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
////    [hud hide:YES];
//    //[activityIndicator stopAnimating];
//}
//- (BOOL) webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType) navigationType
//{
//    BOOL headerIsPresent = [[request allHTTPHeaderFields] objectForKey:@"x-tit-access-token"]!=nil;
//
//    if(headerIsPresent) return YES;
//
//    NSLog(@"Custom Webview");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSURL *url = [request URL];
//            NSLog(@"URL : %@",url);
//            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//            NSLog(@"Request : %@",request);
//            // set the new headers
//            for(NSString *key in [self.customHeader allKeys]){
//                [request addValue:[self.customHeader objectForKey:key] forHTTPHeaderField:key];
//            }
//            
//            // reload the request
//            [self.webView loadRequest:request];
//        });
//    });
//    return NO;
//}


@end
