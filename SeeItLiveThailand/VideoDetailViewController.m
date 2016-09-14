//
//  VideoDetailViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/5/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//


#import "VideoDetailViewController.h"
#import "TAPageControl.h"
#import "ROI.h"
#import "CCTVS.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "DXAnnotation.h"
#import <DXAnnotationView.h>
#import <DXAnnotationSettings.h>
#import "HistoryListTableViewController.h"
#import "UserManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "CommentViewController.h"
#import <Google/Analytics.h>

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface VideoDetailViewController () {
    
    IBOutlet UIView *historyView;
    IBOutlet UIView *detailView;
    IBOutlet UIButton *viewHistory;
    IBOutlet UILabel *commentCountLbl;
    IBOutlet UIButton *getDirectionBtn;
    
    UILabel *lblPoint;
    UIImageView *imgIconPoint;
    UIScrollView *previewScrollView;
    UIImageView *ImgIconView;
    UIImageView *ImgIconCall;
    UIImageView *ImgIconWWW;
    UIImageView *ImgIconFB;
    
    CGFloat fontSize;
    CGFloat lblDescX;
    CGFloat lblDescY;
    CGFloat lblDescH;
    CGFloat lblDescGrap;
    CGFloat pagingGrap;
    CGFloat dotSize;
    
    CGFloat scHeiht;
    CGFloat imgHeight;
    CGRect imgLiveRect;
    CGRect lblPointRect;
    CGRect imgIconPointRect;
    CGRect imgIconDetailRect;
    
    UINavigationBar *navbar;
    UIView* fullView;
    
    CGRect historyViewRect;
    CGRect detailViewRect;
    
    CGRect lblDesRect;
    NSTimer * myTimer;
    
    
}
@property (nonatomic, strong) TAPageControl *customPageControl;

@end

@implementation VideoDetailViewController
@synthesize infoHistoryView;
- (void)viewDidLoad {
    [super viewDidLoad];

    
  //  [commentRtn addTarget:self action:(goCommant) forControlEvents:UIControlEventTouchUpInside];
    navbar = [self.navigationController navigationBar];
    navbar.barTintColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.7 alpha:1];
    self.navigationController.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"bg_livestream_back.png"];
        // Do any additional setup after loading the view.
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    

    [getDirectionBtn addTarget:self action:@selector(routeDirection) forControlEvents: UIControlEventTouchUpInside];
    
    self.title = self.roi.roiName;
    [self initialSize];
    [self setTitleBar];
    [self LoadScreenShots];
    [self LoadMap];
    [self infoHistory];
    [self LoadDesc];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    //= CGFloat();
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)infoHistory{
   
    historyView.frame =  historyViewRect;
    detailView.frame = detailViewRect;
    
    CCTVS *cctvsPoint = [self.roi.cctvs objectAtIndex:self.rowIndex];
    
    ImgIconView = [[UIImageView alloc] initWithFrame:imgIconDetailRect];
    ImgIconView.image = [UIImage imageNamed:@"ic_alertcomplant.png"];
    UILabel *totalviewLbl = [[UILabel alloc] initWithFrame:CGRectMake(imgIconDetailRect.origin.x*2 + imgIconDetailRect.size.width , imgIconDetailRect.origin.y , self.view.frame.size.width/2, 30)];
    totalviewLbl.text = (![cctvsPoint.totalView  isEqual: @""]) ? [self addComma:cctvsPoint.totalView] : @" - " ;
    totalviewLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    

    
    NSLog(@"CCTV ID : %@" ,cctvsPoint.cctvID);
    NSLog(@"CCTV Name : %@" ,cctvsPoint.cctvName);
    ImgIconCall = [[UIImageView alloc] initWithFrame:CGRectMake(imgIconDetailRect.origin.x , imgIconDetailRect.origin.y*2 + imgIconDetailRect.size.height, imgIconDetailRect.size.width, imgIconDetailRect.size.height)];
    ImgIconCall.image = [UIImage imageNamed:@"icon_call.png"];
    UILabel *CallLbl = [[UILabel alloc] initWithFrame:CGRectMake(imgIconDetailRect.origin.x*2 + imgIconDetailRect.size.width , imgIconDetailRect.origin.y*2 + imgIconDetailRect.size.height, self.view.frame.size.width/2, 30)];
    CallLbl.text = @" - ";
    CallLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    ImgIconWWW = [[UIImageView alloc] initWithFrame: CGRectMake(imgIconDetailRect.origin.x , imgIconDetailRect.origin.y*4 + imgIconDetailRect.size.height*2, imgIconDetailRect.size.width, imgIconDetailRect.size.height)];
    ImgIconWWW.image = [UIImage imageNamed:@"icon_www.png"];
    UILabel *WWWLbl = [[UILabel alloc] initWithFrame:CGRectMake(imgIconDetailRect.origin.x*2 + imgIconDetailRect.size.width , imgIconDetailRect.origin.y*4 + imgIconDetailRect.size.height*2, self.view.frame.size.width/2, 30)];
    WWWLbl.text = @" - ";
    WWWLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    
    ImgIconFB = [[UIImageView alloc] initWithFrame:CGRectMake(imgIconDetailRect.origin.x , imgIconDetailRect.origin.y*6 + imgIconDetailRect.size.height*3, imgIconDetailRect.size.width, imgIconDetailRect.size.height)];
    ImgIconFB.image = [UIImage imageNamed:@"icon_fb.png"];
    UILabel *FBLbl = [[UILabel alloc] initWithFrame:CGRectMake(imgIconDetailRect.origin.x*2 + imgIconDetailRect.size.width , imgIconDetailRect.origin.y*6 + imgIconDetailRect.size.height*3, self.view.frame.size.width/2, 30)];
    FBLbl.text = @" - ";
    FBLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    

    
    
    [infoHistoryView addSubview:ImgIconView];
    [infoHistoryView addSubview:totalviewLbl];
    [infoHistoryView addSubview:ImgIconCall];
    [infoHistoryView addSubview:CallLbl];
    [infoHistoryView addSubview:ImgIconWWW];
    [infoHistoryView addSubview:WWWLbl];
    [infoHistoryView addSubview:ImgIconFB];
    [infoHistoryView addSubview:FBLbl];
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"CCTV_"];
    name = [name stringByAppendingString:[self.roi.roiName stringByAppendingString:[@"_" stringByAppendingString:[cctvsPoint.cctvName stringByReplacingOccurrencesOfString:@" " withString:@""]]]];
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

- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        fontSize = 14.0 * SCALING_X;
        lblDescX = 9.0 * SCALING_X;
        lblDescY = 525.0 * SCALING_Y;
        lblDescH = 25.0 * SCALING_Y;
        lblDescGrap = 15.0 * SCALING_X;
        pagingGrap = 30.0 * SCALING_X;
        dotSize = 11.0 * SCALING_X;
        
        scHeiht = 240 * SCALING_Y;
        imgHeight = 180 * SCALING_Y;
        
        
        imgLiveRect = CGRectMake(5 * scx, 25 * scy, 60 * scx, 20 * scy);
        lblPointRect = CGRectMake(35 * scx, 194 * scy, 320 * scx, 25 * scy);
        imgIconPointRect = CGRectMake(5 * scx, 185 * scy, 25 * scx, 25 * scy
            );
        imgIconDetailRect = CGRectMake(2 * scx, 2 * scy, 20 * scx, 20 * scy
                                       );
        historyViewRect =  CGRectMake(10,scHeiht + (40*scy), [UIScreen mainScreen].bounds.size.width - 20, 40*scy);
        detailViewRect = CGRectMake(10, historyViewRect.origin.y + historyViewRect.size.height + (5*scy), [UIScreen mainScreen].bounds.size.width - 20, 355*scy);
        
        lblDesRect = CGRectMake(10,detailViewRect.origin.y + detailViewRect.size.height +(5*scy) ,[UIScreen mainScreen].bounds.size.width - 20 ,lblDescH*scy);
        
    } else {
        //CGRectMake(9, 525, strPointSize.width, 25);
        
        fontSize = 14.0;
        lblDescX = 9.0;
        lblDescY = detailViewRect.origin.y + detailViewRect.size.height +5;
        lblDescH = 25.0;
        lblDescGrap = 15.0;
        pagingGrap = 30.0;
        dotSize = 11.0;
        
        scHeiht = 240;
        imgHeight = 180;
        
        imgLiveRect = CGRectMake(5, 25, 60, 20);
        lblPointRect = CGRectMake(35, 194, 320, 25);
        imgIconPointRect = CGRectMake(5, 185, 25, 25);
        imgIconDetailRect = CGRectMake(2 , 2 , 20 , 20);
        
       
        historyViewRect =  CGRectMake(10,scHeiht + 40, [UIScreen mainScreen].bounds.size.width - 20, 40);
        detailViewRect = CGRectMake(10, historyViewRect.origin.y + historyViewRect.size.height + 5, [UIScreen mainScreen].bounds.size.width - 20, 355);
        
        lblDesRect = CGRectMake(10,detailViewRect.origin.y + detailViewRect.size.height +5 ,[UIScreen mainScreen].bounds.size.width - 20 ,lblDescH);
    }
}

- (void)setTitleBar {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
      
        NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:fontSize],NSFontAttributeName, nil];
        self.navigationController.navigationBar.titleTextAttributes = size;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.7 alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
         [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
    } else {
        NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:fontSize],NSFontAttributeName, nil];
        self.navigationController.navigationBar.titleTextAttributes = size;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.7 alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
}

-(void)LoadScreenShots {
    CGFloat scWidth = self.ssView.frame.size.width;
    //CGFloat scHeiht = 240;
    //CGFloat imgHeight = 180;
    
    previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scWidth, scHeiht)];
    [previewScrollView setContentSize:CGSizeMake(scWidth * self.roi.cctvs.count, scHeiht)];
    previewScrollView.pagingEnabled = TRUE;
    previewScrollView.delegate = self;
    [self.ssView addSubview:previewScrollView];
    
    UIColor *color = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1];; // substitute your color here
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    [self.roi.cctvs enumerateObjectsUsingBlock:^(CCTVS *cctvs, NSUInteger idx, BOOL *stop) {
        
        UIView *viewPlace = [[UIView alloc] initWithFrame:CGRectMake(scWidth * idx, 0, scWidth, scHeiht)];
        viewPlace.backgroundColor = color;
        
        //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scWidth * idx, 0, scWidth, scHeiht)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scWidth, imgHeight)];
        imageView.tag = 1;
        
        UIImage *imgPH = [self resizeImage:[UIImage imageNamed:@"sil_big.jpg"] imageSize:CGSizeMake(scWidth, imgHeight)];
        
        HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
        if (!format)
        {
            format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
            format.size = CGSizeMake(scWidth, imgHeight);
            format.scaleMode = HNKScaleModeFill;
            format.compressionQuality = 100;
            format.diskCapacity = 0;//10 * 1024 * 1024; // 1MB
            format.preloadPolicy = HNKPreloadPolicyNone;
            //format.allowUpscaling = YES;
            
        }
        
        UITapGestureRecognizer* TapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self action:@selector(actionViewTap:)];//Here should be actionViewTap:
        
        TapGestureRecognizer.enabled = YES;
        [imageView setUserInteractionEnabled:YES];
        [imageView addGestureRecognizer:TapGestureRecognizer];
        
        imageView.hnk_cacheFormat = format;
        imageView.contentMode = UIViewContentModeScaleToFill;
        NSURL *url = [NSURL URLWithString:cctvs.imageUrl];
        [imageView hnk_setImageFromURL:url placeholder:imgPH];
        [imageView setNeedsDisplay];
        
        UIImageView *imgLive = [[UIImageView alloc] initWithFrame:imgLiveRect];
        imgLive.contentMode = UIViewContentModeScaleToFill;
        imgLive.image = [UIImage imageNamed:@"live_stream_icon.png"];
        
        [imageView addSubview:imgLive];
        
        [viewPlace addSubview:imageView];
        
        [previewScrollView addSubview:viewPlace];
        
        //NSLog(@"%@",cctvs.imageUrl);
        
        NSArray *imgObj = @[imageView,cctvs.imageUrl];
        
       myTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                         target:self
                                       selector:@selector(LoadNewImage:)
                                       userInfo:imgObj
                                        repeats:YES];
        
        
    }];
    
    //point layout
    CCTVS *cctvsPoint = [self.roi.cctvs objectAtIndex:self.rowIndex];
    
    lblPoint = [[UILabel alloc] initWithFrame:lblPointRect];
    
    NSLog(@"CCTV %@",cctvsPoint.totalView);
    lblPoint.text = cctvsPoint.cctvName;
    lblPoint.font = font;
    lblPoint.lineBreakMode = NSLineBreakByWordWrapping;
    lblPoint.numberOfLines = 0;
    lblPoint.textAlignment = NSTextAlignmentLeft;
    [lblPoint sizeToFit];
    //lblPoint.preferredMaxLayoutWidth = pointWidth;
    [self.ssView addSubview:lblPoint];
    
    imgIconPoint = [[UIImageView alloc] initWithFrame:imgIconPointRect];
    imgIconPoint.image = [UIImage imageNamed:@"icon_H.png"];
    [self.ssView addSubview:imgIconPoint];
    
    self.customPageControl = [[TAPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(previewScrollView.frame)- pagingGrap, CGRectGetWidth(previewScrollView.frame), pagingGrap)];
    self.customPageControl.numberOfPages = self.roi.cctvs.count;
    
    
    UIImage *dotInactive = [self resizeImage:[UIImage imageNamed:@"dotInactive.png"] imageSize:CGSizeMake(dotSize, dotSize)];
    UIImage *dotActive = [self resizeImage:[UIImage imageNamed:@"dotActive.png"] imageSize:CGSizeMake(dotSize, dotSize)];
    self.customPageControl.dotImage = dotInactive;
    self.customPageControl.currentDotImage = dotActive;
    /*
     self.customPageControl.dotImage = [UIImage imageNamed:@"dotInactive.png"];
     
     self.customPageControl.currentDotImage = [UIImage imageNamed:@"dotActive.png"];
     self.customPageControl.dotSize = CGSizeMake(30, 30);
     */
    
    //self.customPageControl.currentPage = self.rowIndex;
    /*
     TAPageControl *taPageControl = [[TAPageControl alloc] init];
     taPageControl.frame = CGRectMake(0, CGRectGetMaxY(previewScrollView.frame)-30, CGRectGetWidth(previewScrollView.frame), 30);
     taPageControl.numberOfPages = self.imageList.count;
     */
    
    [self.ssView addSubview:self.customPageControl];
    
    self.customPageControl.currentPage = self.rowIndex;
    
    CGRect scframe = previewScrollView.frame;
    scframe.origin.x = scframe.size.width * self.rowIndex;
    scframe.origin.y = 0;
    [previewScrollView scrollRectToVisible:scframe animated:YES];
}

-(void)actionViewTap:(id)sender{
    
    
    
    NSLog(@"Clicked!");
    NSInteger pageIndex = previewScrollView.contentOffset.x / CGRectGetWidth(previewScrollView.frame);
    
    CCTVS *cctvs = [self.roi.cctvs objectAtIndex:pageIndex];
    NSLog(@"Image URL%@",cctvs.imageUrl);
    
    fullView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] applicationFrame].size.width,[[UIScreen mainScreen] applicationFrame].size.height+100)];
    //self.view = baseView;
    NSURL *url = [NSURL URLWithString:cctvs.imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    //specify the frame of the imageView in the superview , here it will fill the superview
    imageView.frame = fullView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    // add the imageview to the superview
    [fullView addSubview:imageView];
    
    //add the view to the main view
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self
                action:@selector(backBtn:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"ic_share21.png"] forState:UIControlStateNormal];
    shareBtn.contentMode = UIViewContentModeScaleAspectFit;
    [shareBtn addTarget:self
                 action:@selector(shareAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.layer.borderWidth=1.0f;
    backBtn.layer.cornerRadius = 5;
    backBtn.layer.borderColor=[[UIColor whiteColor] CGColor];
    [backBtn setTitle:@"Done" forState:UIControlStateNormal];
    NSLog(@"Nav size W: %f H: %f Origin X: %f Origin Y: %f",navbar.frame.size.width,navbar.frame.size.height,navbar.frame.origin.x,navbar.frame.origin.y);
    backBtn.frame = CGRectMake(fullView.frame.size.width-55, navbar.frame.size.height + 25, 50, 30);
    [fullView addSubview:backBtn];
    
    shareBtn.frame = CGRectMake(fullView.frame.size.width-105, navbar.frame.size.height + 20, 40, 40);
    [fullView addSubview:shareBtn];
    
    [self.view addSubview:fullView];
    [fullView setBackgroundColor:[UIColor blackColor]];
    fullView.userInteractionEnabled = YES;
    fullView.alpha = 1;
    
    
    
}
-(void)landFullScreen
{
    NSLog(@"Clicked!");
    
    NSInteger pageIndex = previewScrollView.contentOffset.x / CGRectGetWidth(previewScrollView.frame);
    
    CCTVS *cctvs = [self.roi.cctvs objectAtIndex:pageIndex];
    NSLog(@"Image URL%@",cctvs.imageUrl);
    
    fullView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] applicationFrame].size.height+100,[[UIScreen mainScreen] applicationFrame].size.width)];
    //self.view = baseView;
    NSURL *url = [NSURL URLWithString:cctvs.imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    //specify the frame of the imageView in the superview , here it will fill the superview
    imageView.frame = fullView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    // add the imageview to the superview
    [fullView addSubview:imageView];
    
    //add the view to the main view
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self
                action:@selector(backBtn:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"ic_share21.png"] forState:UIControlStateNormal];
    shareBtn.contentMode = UIViewContentModeScaleAspectFit;
    [shareBtn addTarget:self
                 action:@selector(shareAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.layer.borderWidth=1.0f;
    backBtn.layer.cornerRadius = 5;
    backBtn.layer.borderColor=[[UIColor whiteColor] CGColor];
    [backBtn setTitle:@"Done" forState:UIControlStateNormal];
    NSLog(@"Nav size W: %f H: %f Origin X: %f Origin Y: %f",navbar.frame.size.width,navbar.frame.size.height,navbar.frame.origin.x,navbar.frame.origin.y);
    backBtn.frame = CGRectMake(fullView.frame.size.width-55, navbar.frame.size.height + 25, 50, 30);
    [fullView addSubview:backBtn];
    
    shareBtn.frame = CGRectMake(fullView.frame.size.width-105, navbar.frame.size.height + 20, 40, 40);
    [fullView addSubview:shareBtn];
    
    [self.view addSubview:fullView];
    [fullView setBackgroundColor:[UIColor blackColor]];
    fullView.userInteractionEnabled = YES;
    fullView.alpha = 1;
}

-(void)backBtn:(id)sender
{
    NSLog(@"back out");
    [fullView removeFromSuperview];
    
}
-(void)shareBtn:(id)sender
{
    NSLog(@"Share It");
    [fullView removeFromSuperview];
    
}
- (void)LoadNewImage:(NSTimer*)theTimer {
    
//    NSLog(@"New Image");
    NSArray *imgObj = (NSArray *)[theTimer userInfo];
    NSString *imgUrl = [imgObj objectAtIndex:1];
    UIImageView *imageView1 = [imgObj objectAtIndex:0];
    
    int r = arc4random() % 10000;
    
    imgUrl = [imgUrl stringByAppendingFormat:@"&reloadtime=%d", r];
    
//    NSLog(@"image reload : %@",imgUrl);
    
    CGFloat scWidth = self.ssView.frame.size.width;
    //CGFloat imgHeight = 180;
    
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
    if (!format)
    {
        format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
        format.size = CGSizeMake(scWidth, imgHeight);
        format.scaleMode = HNKScaleModeFill;
        format.compressionQuality = 1;
        format.diskCapacity = 0;//10 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
        //format.allowUpscaling = YES;
        
    }
    
    imageView1.hnk_cacheFormat = format;
    imageView1.contentMode = UIViewContentModeScaleToFill;
    NSURL *url = [NSURL URLWithString:imgUrl];
    //[imageView hnk_setImageFromURL:url placeholder:imgPH];
    [imageView1 hnk_setImageFromURL:url];
    [imageView1 setNeedsDisplay];

    /*
     UILabel *lblUrl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width, 25)];
     lblUrl.text = imgUrl;
     
     [imageView1 addSubview:lblUrl];
     */
}

- (void)LoadMap {
    
    //CCTVS *cctvs = [self.roi.cctvs objectAtIndex:self.rowIndex];
    
    [self changeLocation:self.rowIndex];
    
}

- (void)backAction{
    NSLog(@"backAction");
    [myTimer invalidate];
    myTimer = nil;
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    [myTimer invalidate];
    myTimer = nil;
}
- (void)LoadDesc {
    CCTVS *cctvs = [self.roi.cctvs objectAtIndex:self.rowIndex];
    
    NSString *strPoint = cctvs.cctvDesc;
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    CGRect frame = [strPoint boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - lblDescGrap, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    
    CGSize strPointSize = CGSizeMake(frame.size.width, frame.size.height);
    self.lblDesc.frame = lblDesRect;
  //  self.lblDesc.frame = CGRectMake(lblDescX, lblDescY, strPointSize.width, lblDescH);
    self.lblDesc.text = strPoint;
    self.lblDesc.font = font;
    self.lblDesc.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblDesc.numberOfLines = 0;
    self.lblDesc.textAlignment = NSTextAlignmentJustified;
    [self.lblDesc sizeToFit];
    
}

- (void)changeLocation:(NSInteger)rowIndex {
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.roi.cctvs enumerateObjectsUsingBlock:^(CCTVS *cctvs, NSUInteger idx, BOOL *stop) {
        
        if (idx != rowIndex) {
            DXAnnotation *annotation1 = [DXAnnotation new];
            annotation1.tag = idx;
            annotation1.coordinate = CLLocationCoordinate2DMake([cctvs.latitude doubleValue],[cctvs.longitude doubleValue]);
            annotation1.pinName = @"mappin";
            [self.mapView addAnnotation:annotation1];
            [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation1.coordinate, 10000, 10000)];
        }
        
    }];
    
    CCTVS *cctvsActive = [self.roi.cctvs objectAtIndex:rowIndex];
    
    DXAnnotation *annoActive = [DXAnnotation new];
    annoActive.tag = rowIndex;
    annoActive.coordinate = CLLocationCoordinate2DMake([cctvsActive.latitude doubleValue],[cctvsActive.longitude doubleValue]);
    annoActive.pinName = @"pin";
    [self.mapView addAnnotation:annoActive];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annoActive.coordinate, 10000, 10000)];
    
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    [self changePoint:pageIndex];
    
    self.customPageControl.currentPage = pageIndex;
    
}

- (void)changePoint:(NSInteger)index {
    //change label
    CCTVS *cctvs = [self.roi.cctvs objectAtIndex:index];
    lblPoint.frame = lblPointRect; //CGRectMake(35, 194, 400, 25);
    lblPoint.text = cctvs.cctvName;
    lblPoint.lineBreakMode = NSLineBreakByWordWrapping;
    lblPoint.numberOfLines = 0;
    lblPoint.textAlignment = NSTextAlignmentLeft;
    [lblPoint sizeToFit];
    
    //change location
    [self changeLocation:index];
    
    //change description
    
    self.lblDesc.text = cctvs.cctvDesc;
    self.lblDesc.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblDesc.numberOfLines = 0;
    self.lblDesc.textAlignment = NSTextAlignmentJustified;
    [self.lblDesc sizeToFit];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[DXAnnotation class]]) {
        
        DXAnnotation *annotation1 = (DXAnnotation *)annotation;
        //UIView *calloutView = [[[NSBundle mainBundle] loadNibNamed:@"myView" owner:self options:nil] firstObject];
        
        DXAnnotationView *annotationView = (DXAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
        /*
         NSString *pinName = @"";
         
         if (annotation1.tag == 1) {
         pinName = @"pin";
         } else {
         pinName = @"mappin";
         }
         */
        
        UIView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:annotation1.pinName]];
        
        
        //if (!annotationView) {
        
        annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:NSStringFromClass([DXAnnotationView class])
                                                              pinView:pinView
                                                          calloutView:nil
                                                             settings:[DXAnnotationSettings defaultSettings]];
        /*
         } else {
         [pinView removeFromSuperview];
         [annotationView addSubview:pinView];
         }
         */
        
        /*
         annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([DXAnnotationView class])];
         [annotationView addSubview:pinView];
         */
        
        //annotationView.image = [UIImage imageNamed:annotation1.pinName];
        
        
        annotationView.tag = annotation1.tag;
        
        return annotationView;
    }
    
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[DXAnnotationView class]]) {
        
        DXAnnotationView *dxView = (DXAnnotationView *)view;
        
        NSInteger indexObj = dxView.tag;
        
        NSLog(@"test annotation %ld",(long)indexObj);
        
        [previewScrollView setContentOffset:CGPointMake(previewScrollView.frame.size.width * indexObj, 0.0f)];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    //NSLog(@"deselect test annotation");
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:FALSE];
    //self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
//    [hud show:YES];
    
    
    
    CCTVS *cctvsPoint = [self.roi.cctvs objectAtIndex:self.rowIndex];
    
    NSString *apiLink = [@"cctv/" stringByAppendingString:cctvsPoint.cctvID];
    //    HistoryListTableViewController *historyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"historylist"];
    appDelegate.timeArr = [[NSMutableArray alloc]init];
    appDelegate.imgArr = [[NSMutableArray alloc]init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        
        [[UserManager shareIntance]getAPIData:apiLink Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            NSLog(@"Hud Off");
            //NSLog(@"all Data %@",result[@"cctv_highlights"]);
            
            int index;
            for (index = 0; index < [result[@"cctv_highlights"] count]; index++) {
                
                //            NSLog(@"by index  %@",result[@"cctv_highlights"][index]);
                [appDelegate.imgArr insertObject:result[@"cctv_highlights"][index][@"highlight_url"] atIndex:index];
                
                NSMutableString *time = [NSMutableString stringWithString:result[@"cctv_highlights"][index][@"highlight_time"]];
                [time insertString:@":" atIndex:2];
                [appDelegate.timeArr insertObject:time atIndex:index];
            }
            //        NSLog(@"image URL %lu",(unsigned long)[historyVC.timeArr count]);
            
            
            appDelegate.CCTV_ID = cctvsPoint.cctvID;
            
            [[UserManager shareIntance] commentAPI:@"getcommentAll" cctvID:appDelegate.CCTV_ID data:nil Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                NSLog(@"commentcount %lu",(unsigned long)result.count);
                commentCountLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)result.count];
                [commentCountLbl reloadInputViews];
                
            }];
            //        [self.navigationController pushViewController:appDelegate animated:TRUE];
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    
     
}

-(void)shareAction:(id)sender
{
    
    NSInteger pageIndex = previewScrollView.contentOffset.x / CGRectGetWidth(previewScrollView.frame);
    
    CCTVS *cctvs = [self.roi.cctvs objectAtIndex:pageIndex];
    
    NSLog(@"shareActionshareUrl : %@",cctvs.shareUrl);
    NSString * shareUrl = cctvs.shareUrl;
    
    NSArray *shareItems = @[shareUrl];
    

    NSString *text = @"";
    NSURL *url = [NSURL URLWithString:shareUrl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cctvs.imageUrl]]];
    UIActivityViewController *avc =[[UIActivityViewController alloc] initWithActivityItems:@[text, url, image]
applicationActivities:nil];
    
//    [self presentViewController:controller animated:YES completion:nil];
//    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:avc animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:avc];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width-35, 60, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
    
    //avc.popoverPresentationController.sourceView =
    
    
    //[self presentViewController:avc animated:YES completion:nil];
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

/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 [self.navigationController setNavigationBarHidden:TRUE];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)viewHistoryBtn:(id)sender {
    
    CCTVS *cctvsPoint = [self.roi.cctvs objectAtIndex:self.rowIndex];
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"CCTV_"];
    name = [name stringByAppendingString:[self.roi.roiName stringByAppendingString:[@"_" stringByAppendingString:[[cctvsPoint.cctvName stringByReplacingOccurrencesOfString:@" " withString:@""] stringByAppendingString:@"_History"]]]];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
    [self performSegueWithIdentifier:@"showHistory" sender:self];
    
}
//-(IBAction)goComment:(id)sender {
//
//    CommentViewController *commentVC = self.navigationController.topViewController;
//    commentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"commentVC"];
//    [self presentViewController:commentVC animated:YES completion:nil];
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showHistory"])
    {
        // Get reference to the destination view controller
        //  UINavigationController *nav = [segue destinationViewController];
        HistoryListTableViewController *vc = self.navigationController.topViewController;
        //        vc.CCTV_ID = @"55555";
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
      
    }
    
}
-(NSString*)addComma:(NSString *)number
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
    
    
    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[number integerValue]]];
    return formatted;
}

- (IBAction)commentBtn:(id)sender {
    NSLog(@"Comment go go");
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
   appDelegate.comment_type = @"CCTV";
    CommentViewController *commentVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"commentNav"];
    [self presentViewController:commentVC animated:YES completion:nil];
}

- (void)routeDirection
{
    NSLog(@"routeDirection");
    CCTVS *cctvsPoint = [self.roi.cctvs objectAtIndex:self.rowIndex];
    NSLog(@"cctv Name %@",cctvsPoint.cctvName);

    NSLog(@"lat %@ long %@",cctvsPoint.latitude,cctvsPoint.longitude);
    //first create latitude longitude object
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([cctvsPoint.latitude doubleValue],[cctvsPoint.longitude doubleValue]);
    
    //create MKMapItem out of coordinates
    MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    [destination setName:cctvsPoint.cctvName];
    if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
    {
        //using iOS6 native maps app
        [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
    }
    else
    {
        //using iOS 5 which has the Google Maps application
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current+Location&daddr=%f,%f", [cctvsPoint.latitude doubleValue],[cctvsPoint.longitude doubleValue]];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}


//-(void)videoPlayer:(VKVideoPlayer *)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation {
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==
//        UIInterfaceOrientationLandscapeRight) {
//        
//        
//        NSLog(@"UIInterfaceOrientationIsPortrait");
//        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-bottomHeight);
//        
//    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
//        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
//    }
//    
//    else {
//        
//        //self.player.isFullScreen = YES;
//        //self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
//        NSLog(@"UIInterfaceOrientationIsLandscape");
//    }
//    
//    
//}

- (void) orientationChanged:(NSNotification *)note
{
    NSLog(@"orientationChanged");
    
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            NSLog(@"UIDeviceOrientationPortrait");
            [fullView removeFromSuperview];
            /* start special animation */
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
//            NSLog(@"UIDeviceOrientationPortraitUpsideDown");
            /* start special animation */
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"UIDeviceOrientationLandscapeRight");
//            [self landFullScreen];
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"UIDeviceOrientationLandscapeLeft");
//            [self landFullScreen];
            break;
            
        default:
            break;
    };
}
@end
