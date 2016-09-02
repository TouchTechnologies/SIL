//
//  ADViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 8/8/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "ADViewController.h"
#import "StreamLiveViewController.h"
#import "StreamHistoryViewController.h"
#import "MyLivestreamViewController.h"
#import "ADPageControl.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
#import "Streaming.h"
#import "DataManager.h"
#import "SBScrollView.h"

#import "defs.h"

#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "LiveStreamingCell.h"
#import "StreamingCell.h"
#import "VKVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <KKGridView/KKGridView.h>
#import "MBProgressHUD.h"
#import "UserManager.h"
#import "UserProfileViewController.h"
#import "LivestreamRealtimeViewController.h"
#import "OnAirCell.h"
#import "CategoryTypeViewController.h"

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);


@interface ADViewController ()<ADPageControlDelegate , UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
    ADPageControl *_pageControl;
    BOOL isLazy;
    
    UIView *recordBar;
    UIButton *recordButton;
    NSArray *streamList;
    
    CGFloat rcGrapY;
    CGFloat rcBarH;
    CGFloat rcButtonW;
    
    CGFloat fontSize;
    CGFloat titleHeight;
    CGFloat titleWidth;
    CGFloat indicatorHeight;
    CGFloat indicatorWidth;
    Streaming *stream;
    OnAirCell *collCell;
    
    
    SBScrollView *scrollView;
    CGFloat statusViewH;
    CGFloat onAirViewH;
    
    UIView *onAirView;
    CGRect onAirViewRect;
    UIView *liveStatusView;
    CGRect liveStatusViewRect;
   
    UIImageView *imgLiveicon;
    CGRect imgLiveiconRect;
    
    UILabel *lblLiveNow;
    CGRect lblLiveNowRect;
    
    UIImageView *imgOnairCount;
    CGRect imgOnairCountRect;
    
    UILabel *lblOnairCount;
    CGRect lblOnairCountRect;
    
    
    
    UIScrollView *previewScrollView;
    UIImageView *onairSnapshotImg;
    
    CGRect previewScrollViewRect;
    CGRect onairSnapshotImgRect;
   
    CGRect scrollViewRect;
    
    //มาจาก on air/////
    CGSize cellSize;
    CGSize paddingSize;
    CGFloat parentGrab;
    CGFloat imgPHW01;
    CGFloat imgPHW02;
    
    CGRect imgLiveRect;
    CGRect imgLive;
    CGRect lblNoStreamRect;
    
    UICollectionView *collectionView;
    CGRect collectionViewRect;
    UICollectionViewCell *item;
    
    UIImageView *imgSnapshot;
    UIImageView *imgWatermark;
    UIImageView *imgAvartar;
    UILabel *lblTitlelive;
    UIImageView *imgView;
    UILabel *lblViewCount;
    
    CGRect imgSnapshotRect;
    CGRect imgWatermarkRect;
    CGRect imgAvartarRect;
    CGRect lblTitleliveRect;
    CGRect imgViewRect;
    CGRect lblViewCountRect;
    CGRect pageControlRect;
    
    NSString *liveCount;

  }
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic, strong) UIImageView *imgLiveStatus;

@end

@implementation ADViewController{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSize];
    [self setupPageControl];
    [self initial];
    
    scrollView.delegate = self;
    collectionView.delegate = self;
    collectionView.dataSource = self;

//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                              selector:@selector(refreshList:)
//                                                 name:@"refresh"
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(refreshList:)
//                                                 name:@"update"
//                                               object:nil];
  }
- (void)viewWillAppear:(BOOL)animated{
  

}
- (void)viewDidAppear:(BOOL)animated{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSize {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        fontSize = 16.0 * scx;
        titleHeight = 45.0 * scy;
        titleWidth = width/1.4;
        indicatorHeight = 5.0 * scy;
        rcBarH = 70.0* scy;
        rcGrapY = 200.0* scy;
        rcButtonW = 50.0* scx;
       
        NSLog(@"else");
        parentGrab = 120.0*scx;
        cellSize = CGSizeMake((width/ 2) - (15*scx), 230*scy);
        paddingSize = CGSizeMake(10.f*scx, 10.f*scy);
        imgPHW01 = 40.0*scy;
        imgPHW02 = 25.0*scy;
        imgLiveRect = CGRectMake(5*scx, 5*scy, 60*scx, 20*scy);
        // indicatorWidth = self.view.bounds.size.width;
        onAirViewRect = CGRectMake(0*scx, 0*scy, width, 240*scy);
       scrollViewRect = CGRectMake(0*scx, 0, self.view.bounds.size.width, self.view.bounds.size.height + (titleHeight + indicatorHeight));
     //   scrollViewRect = CGRectMake(0*scx, imgPHW01, self.view.bounds.size.width, self.view.bounds.size.height + (titleHeight + indicatorHeight));
 
        liveStatusViewRect = CGRectMake(0*scx, 0*scy,width , 40*scy);
        collectionViewRect = CGRectMake(0*scx, 0*scy , width, onAirViewRect.size.height);
        
        previewScrollViewRect =  CGRectMake(0*scx, 0*scy,width , 200*scy);
        
        imgLiveiconRect = CGRectMake(10*scx , liveStatusViewRect.size.height/2 - (15*scy), 30*scx, 30*scy);
        lblLiveNowRect = CGRectMake(imgLiveiconRect.origin.x + imgLiveiconRect.size.width + (10*scx) , liveStatusViewRect.size.height/2 - (10*scy) , width/2 , 20*scy);
        
        imgOnairCountRect = CGRectMake(liveStatusViewRect.size.width - (60*scx), liveStatusViewRect.size.height/2 - (10*scy), 20*scx, 20*scy);
        
        lblOnairCountRect = CGRectMake(liveStatusViewRect.size.width - (45*scx), imgOnairCountRect.origin.y - (5*scy), 40*scx, 20*scy);
        pageControlRect = CGRectMake(0*scx,0*scy, self.view.bounds.size.width, self.view.bounds.size.height - (20*scy));
//        pageControlRect = CGRectMake(0*scx, (collectionViewRect.size.height), self.view.bounds.size.width, self.view.bounds.size.height - (20*scy));
    } else {
        
        fontSize = 16.0;
        titleHeight = 45.0;
        titleWidth = width/1.4 ;
        indicatorHeight = 5.0;
        rcBarH = 70.0;
        rcGrapY = 200.0;
        rcButtonW = 50.0;
        
        
        NSLog(@"else");
        parentGrab = 120.0;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - 15, 230);
        paddingSize = CGSizeMake(10.f, 10.f);
        imgPHW01 = 40.0;
        imgPHW02 = 25.0;
        imgLiveRect = CGRectMake(5, 5, 60, 20);
       // indicatorWidth = self.view.bounds.size.width;
        onAirViewRect = CGRectMake(0, 0, self.view.bounds.size.width, 240);
        
         scrollViewRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - indicatorHeight);
//scrollViewRect = CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height - indicatorHeight);
        
        liveStatusViewRect = CGRectMake(0, 0,self.view.bounds.size.width , 40);
        collectionViewRect = CGRectMake(0, 0 , self.view.bounds.size.width, onAirViewRect.size.height);

        previewScrollViewRect =  CGRectMake(0, 0,self.view.bounds.size.width , 200);
        
        imgLiveiconRect = CGRectMake(10 , liveStatusViewRect.size.height/2 - 15, 30, 30);
        lblLiveNowRect = CGRectMake(imgLiveiconRect.origin.x + imgLiveiconRect.size.width + 10 , liveStatusViewRect.size.height/2 - 10 , self.view.bounds.size.width/2 , 20);
        
        imgOnairCountRect = CGRectMake(liveStatusViewRect.size.width - 60, liveStatusViewRect.size.height/2 - 10, 20, 20);
        
        lblOnairCountRect = CGRectMake(liveStatusViewRect.size.width - 45, imgOnairCountRect.origin.y - 5, 40, 20);
          pageControlRect =   CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 20);
     //   pageControlRect =   CGRectMake(0,collectionViewRect.size.height, self.view.bounds.size.width, self.view.bounds.size.height - 20);
        
       

    }
}
-(void)initial{
   
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionView = [[UICollectionView alloc] initWithFrame:collectionViewRect collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    //collectionView.hidden = YES;
    [collectionView setShowsHorizontalScrollIndicator:NO];
    [layout setMinimumLineSpacing :0];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    [scrollView addSubview:collectionView];
    
    
    
    liveStatusView = [[UIView alloc] initWithFrame:liveStatusViewRect];
    liveStatusView.backgroundColor = [UIColor redColor];
   
    
    imgLiveicon = [[UIImageView alloc] initWithFrame:imgLiveiconRect];
    
    [imgLiveicon setImage:[UIImage animatedImageNamed:@"live" duration:1.0]];
    //imgLiveicon.image = [UIImage imageNamed:@"live1.png"];
    // imgLiveicon.layer.cornerRadius = imgLiveiconRect.size.width/2;
    // imgLiveicon.clipsToBounds = YES;
    // [imgLiveicon setImage:[UIImage animatedImageNamed:@"live" duration:1.0] forState:UIControlStateNormal];
    [liveStatusView addSubview:imgLiveicon];
    
    lblLiveNow = [[UILabel alloc] initWithFrame:lblLiveNowRect];
    lblLiveNow.text = @"Live Now";
    lblLiveNow.textAlignment = NSTextAlignmentLeft;
    lblLiveNow.textColor = [UIColor whiteColor];
    lblLiveNow.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [liveStatusView addSubview:lblLiveNow];
    
    imgOnairCount = [[UIImageView alloc] initWithFrame:imgOnairCountRect];
    imgOnairCount.image = [UIImage imageNamed:@"live_wh.png"];
    imgOnairCount.contentMode = UIViewContentModeScaleAspectFit;
    [liveStatusView addSubview:imgOnairCount];
    
    CGRect parentFrame = onAirViewRect;
   // __weak StreamLiveViewController *weakSelf = self;
    NSString *filter = [@"?" stringByAppendingFormat:@"filterLimit=%d&filtersPage=%d",3,1];
 
    ///////////////////////////////////////////////// OnAir ///////////////////////////////////////////////
    liveStatusView.hidden = YES;
 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 [[DataManager shareManager] getStreamingLiveWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
   
     [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success)
        {
            
            
            if (streamRecords.count > 0) {
                
                NSLog(@"Has LiveStream");
        
                self.streamList = streamRecords;
                liveCount = [NSString stringWithFormat:@"%ld",streamRecords.count];
                lblOnairCount = [[UILabel alloc] initWithFrame:lblOnairCountRect];
                lblOnairCount.text = liveCount;
                lblOnairCount.textColor = [UIColor whiteColor];
                lblOnairCount.font =[UIFont fontWithName:@"Helvetica-Bold" size:fontSize-2];
                lblOnairCount.textAlignment = NSTextAlignmentCenter;
                lblOnairCount.backgroundColor = [UIColor redColor];
                lblOnairCount.layer.borderWidth = 1;
                lblOnairCount.layer.borderColor = [UIColor whiteColor].CGColor;
                lblOnairCount.layer.cornerRadius = lblOnairCountRect.size.height/2;
                lblOnairCount.clipsToBounds = YES;
                [liveStatusView addSubview:lblOnairCount];
                CGFloat scy = (1024.0/480.0);
                CGFloat scx = (768.0/360.0);
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    NSLog(@"set iPad");
                    
                     [scrollView setFrame:CGRectMake(0, 40*scy, self.view.bounds.size.width, self.view.bounds.size.height)];
                    _pageControl.view.frame = CGRectMake(0*scx, collectionView.bounds.size.height , self.view.bounds.size.width, self.view.bounds.size.height - (20*scy));
                }
                else
                {
            
                    [scrollView setFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
                    _pageControl.view.frame = CGRectMake(0, collectionView.bounds.size.height , self.view.bounds.size.width, self.view.bounds.size.height - 20);
                    
                }

                liveStatusView.hidden = NO;
                _imgLiveStatus.hidden = YES;
                [_imgLiveStatus removeFromSuperview];
                [collectionView removeFromSuperview];
                
                
                [scrollView addSubview:collectionView];
                [self.view addSubview:liveStatusView];

// 
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    NSLog(@"set iPad");
//                    [scrollView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//                    
//                    _pageControl.view.frame = CGRectMake(0,240 , self.view.bounds.size.width, self.view.bounds.size.height - 240);
//                }
//                else
//                {
//                    [scrollView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//                    
//                    _pageControl.view.frame = CGRectMake(0, 240 , self.view.bounds.size.width, self.view.bounds.size.height - 240);
//                    
//                }
//                

                
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"NoLiveStream");
              
                [liveStatusView setHidden:TRUE];
                [collectionView setHidden: TRUE];
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    NSLog(@"set iPad");
                   [scrollView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                
                  _pageControl.view.frame = CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height - 20);
                    }
                else
                {
                    [scrollView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                    
                    _pageControl.view.frame = CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height - 20);
                
                }
                
                
                }

        } else
        {
           
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:NotConnect delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
        
      [collectionView reloadData];
    }];

}

-(void)setupPageControl
{

    
   
    
    
    
    scrollView = [[SBScrollView alloc] initWithFrame:scrollViewRect];
    scrollView.bounces = NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    //    onAirView = [[UIView alloc] initWithFrame:onAirViewRect];
    //    onAirView.backgroundColor = [UIColor yellowColor];
    //    [scrollView addSubview:onAirView];
    
    //previewScrollView.delegate = self;
    //previewScrollView = [[UIScrollView alloc] initWithFrame:previewScrollViewRect];
//    previewScrollView.backgroundColor = [UIColor grayColor];
//    [previewScrollView setPagingEnabled:TRUE];
//    [previewScrollView  setContentSize:CGSizeMake(self.view.bounds.size.width*7, 200)];
    [scrollView addSubview:self.gridView];
    
    
    
    
    /**** 1. Setup pages using model class "ADPageModel" ****/
    
    
    ADPageModel *historyModel = [[ADPageModel alloc] init];
    historyModel.strPageTitle = @"History Live";
    historyModel.iPageNumber = 0;
    //historyModel.viewController = streamHistory;
    historyModel.bShouldLazyLoad = YES;

    
    //Live
    ADPageModel *liveModel = [[ADPageModel alloc] init];
    liveModel.strPageTitle = @"Category";
    liveModel.iPageNumber = 1;
    liveModel.bShouldLazyLoad = YES;
    
    
    
    ADPageModel *myLive = [[ADPageModel alloc] init];
    myLive.strPageTitle = @"My Video";
    myLive.iPageNumber = 2;
    //historyModel.viewController = streamHistory;
    myLive.bShouldLazyLoad = YES;
    
    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:historyModel,liveModel,myLive, nil];
    _pageControl.iFirstVisiblePageNumber = 0;
    _pageControl.iTitleViewWidth = titleWidth;
    _pageControl.iTitleViewHeight = titleHeight;
    _pageControl.iPageIndicatorHeight = indicatorHeight;
    _pageControl.fontTitleTabText = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    _pageControl.bEnablePagesEndBounceEffect = NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
    _pageControl.colorTabText = [UIColor blackColor]; //orangeColor
    _pageControl.colorTitleBarBackground = [UIColor whiteColor];
    _pageControl.colorPageIndicator = [UIColor redColor];
    //[UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]; //[UIColor orangeColor]; //blueColor
    _pageControl.colorPageOverscrollBackground = [UIColor lightGrayColor];
    
    _pageControl.bShowMoreTabAvailableIndicator = NO;

    /**** 3. Add as subview ****/

    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        _pageControl.view.frame = CGRectMake(0*scx, 240*scy, self.view.bounds.size.width, self.view.bounds.size.height - (20*scy));
//    }
//    else{
//        _pageControl.view.frame = CGRectMake(0, (liveStatusView.bounds.size.height*6), self.view.bounds.size.width, self.view.bounds.size.height - 20);
//    }
    _pageControl.view.frame = pageControlRect;
    [scrollView addSubview:_pageControl.view];
    
    
    
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    recordBar = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width- (rcBarH + 10),self.view.bounds.size.height - (titleHeight+ rcBarH + 30) , rcBarH , rcBarH)];
    recordBar.backgroundColor = [UIColor clearColor];
    recordBar.layer.cornerRadius = rcBarH/2;

    recordBar.clipsToBounds = YES;
    //[UIColor colorWithRed:0.184 green:0.184 blue:0.231 alpha:1];
    [self.view addSubview:recordBar];
    
//    UIImageView *imgBg = [[UIImageView alloc] initWithFrame:recordBar.bounds];
//    imgBg.image = [UIImage imageNamed:@"live.png"];
//    [recordBar addSubview:imgBg];
    
    recordButton = [[UIButton alloc] initWithFrame:recordBar.bounds];
    [recordButton setBackgroundImage:[UIImage imageNamed:@"live.png"] forState:UIControlStateNormal];
    [recordBar addSubview:recordButton];
    //[recordButton addTarget:self action:@selector(gostreamming:)  forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer* TapStream = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(gostreamming:)];//Here should be actionViewTap:
    [TapStream setNumberOfTouchesRequired:1];
    [TapStream setDelegate:self];
    [recordButton addGestureRecognizer:TapStream];
    TapStream.enabled = YES;
  
    

    //flag lazy load
    isLazy = FALSE;
}
-(void)gostreamming:(UIButton *)sender{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSLog(@"Go Stream");
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"LiveStream_Record"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"LiveStream_Record_Action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"Record"          // Event label
                                                           value:nil] build]];    // Event value
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
    
    if(appDelegate.isLogin)
    {
        NSLog(@"is login ");
        UIViewController *stream = [[UIViewController alloc] init];
        stream = [self.storyboard instantiateViewControllerWithIdentifier:@"livestream"];
        [self.view.window.rootViewController presentViewController:stream animated:YES completion:Nil];
    }else{
        NSLog(@"is not login ");
        UIViewController *stream = [[UIViewController alloc] init];
        stream = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
        stream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController presentViewController:stream animated:YES completion:Nil];
    }
    
}
#pragma mark - ADPageControlDelegate

//LAZY LOADING

-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
   
    NSLog(@"ADPageControl :: Lazy load asking for page %d",pageModel.iPageNumber);
    
    if(pageModel.iPageNumber == 0)
    {/////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"LiveStream_History"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        StreamHistoryViewController *streamHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"StreamHistory"];
//        isLazy = TRUE;
        isLazy = FALSE;
        return streamHistory;

    }
    else if(pageModel.iPageNumber == 1)
    {
        /////////////////////////////////////////////////////////////////

//        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//        NSString *name = [NSString stringWithFormat:@"LiveStream_Category"];
//        NSLog(@"analytics %@",name);
//        NSString *dimensionValue = @"iOS";
//        NSString *metricValue = @"iOS_METRIC_VALUE";
//        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
//        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
//        [tracker set:kGAIScreenName value:name];
//        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        CategoryTypeViewController *categoryType = [self.storyboard instantiateViewControllerWithIdentifier:@"categorytype"];
//        isLazy = TRUE;
        isLazy = FALSE;
        return categoryType;
    }
    else if(pageModel.iPageNumber == 2)
    {
        
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"LiveStream_MyLive"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        MyLivestreamViewController *myStream = [self.storyboard instantiateViewControllerWithIdentifier:@"livestream1"];
        isLazy = FALSE;
        return myStream;
    }
    return nil;
}

//CURRENT PAGE INDEX

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
    
    if (isLazy == FALSE) {
        NSLog(@"LIVE:::");
         ADPageModel *pageModel = [_pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
        if (iCurrentVisiblePage == 0) {
            NSLog(@"HISTORYLIVE");
      
           
            StreamHistoryViewController *streamVC = (StreamHistoryViewController *)pageModel.viewController;
            [streamVC viewDidLoad];

        }
        else if (iCurrentVisiblePage == 1){
        
            NSLog(@"CATEGORY");
        
        }
        else if (iCurrentVisiblePage == 2){
            NSLog(@"MY LIVE");
        
        }

       
        
//        if ([pageModel.viewController isKindOfClass:[StreamLiveViewController class]]) {
//            NSLog(@"live live");
//            StreamLiveViewController *streamLive = (StreamLiveViewController *)pageModel.viewController;
//            
//            [streamLive viewDidLoad];
//            
//        } else if ([pageModel.viewController isKindOfClass:[StreamHistoryViewController class]]) {
////            NSLog(@"his tory");
//            StreamHistoryViewController *streamHistory = (StreamHistoryViewController *)pageModel.viewController;
//            [streamHistory viewDidLoad];
//        }
//        else if ([pageModel.viewController isKindOfClass:[MyLivestreamViewController class]]) {
////            NSLog(@"My Live");
//            MyLivestreamViewController *MyLivestream = (MyLivestreamViewController *)pageModel.viewController;
//            [MyLivestream viewDidLoad];
//        }
//
   }
//    
    isLazy = FALSE;
    
//
//    UIViewController *controller = [_pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
//    [controller viewDidLoad];
}
- (void) refreshList:(NSNotification *) refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"ADView Notiname: %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"update"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self viewDidLoad];
        NSLog (@"Update successfully");
    }else if ([[refreshName name] isEqualToString:@"refresh"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self viewDidLoad];
        NSLog (@"Reload successfully");
    }
    
}


#pragma mark - Collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  //  return 5 ;
    return self.streamList.count;;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGRect bottonViewItemRect;
      AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    item  = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor redColor];
    Streaming *stream = [self.streamList objectAtIndex:[indexPath item]];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imgSnapshotRect = CGRectMake(10*scx, 0*scy, item.contentView.bounds.size.width - (20 *scx), item.contentView.bounds.size.height - (40*scy) );
        imgWatermarkRect = CGRectMake(imgSnapshotRect.size.width/2 - (25*scx),imgSnapshotRect.size.height/2 - (25*scy), 50*scx, 50*scy);
        imgAvartarRect = CGRectMake(imgSnapshotRect.size.width - (55*scx), imgSnapshotRect.size.height - (55*scy), 50*scx, 50*scy);
        lblTitleliveRect = CGRectMake(10*scx , imgSnapshotRect.size.height - (25*scy), 200*scx, 20*scy);
        bottonViewItemRect = CGRectMake(0*scx, item.bounds.size.height - (40*scy), item.bounds.size.width, 40*scy);
        imgViewRect = CGRectMake(10*scx , bottonViewItemRect.size.height - (30*scy), 20*scx, 20*scy);
        lblViewCountRect = CGRectMake(40*scx , bottonViewItemRect.size.height - (30*scy), 50*scx, 20*scy);
        
    }
    else{
        imgSnapshotRect = CGRectMake(10, 0, item.contentView.bounds.size.width - 20 , item.contentView.bounds.size.height - 40 );
        imgWatermarkRect = CGRectMake(imgSnapshotRect.size.width/2 - 25,imgSnapshotRect.size.height/2 - 25, 50, 50);
        imgAvartarRect = CGRectMake(imgSnapshotRect.size.width - 55, imgSnapshotRect.size.height - 55, 50, 50);
        lblTitleliveRect = CGRectMake(10 , imgSnapshot.bounds.size.height - 25, 200, 20);
        bottonViewItemRect = CGRectMake(0, item.bounds.size.height - 40, item.bounds.size.width, 40);
        imgViewRect = CGRectMake(10 , bottonViewItemRect.size.height - 30, 20, 20);
        lblViewCountRect = CGRectMake(40 , bottonViewItemRect.size.height - 30, 50, 20);
    }
  

    item.tag = [indexPath item];
    item.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    CGFloat imgWidth = item.frame.size.width;
    CGFloat imgHeight = item.frame.size.height - imgPHW01;
    
    UIImage *imgPH ;
    imgPH = [UIImage imageNamed:@"sil_big.jpg"];
    //   [imgPH :CGSizeMake(imgWidth, imgHeight - imgPHW02)];
    
    //= [self resizeImage:[UIImage imageNamed:@"sil_big.jpg"] imageSize:CGSizeMake(imgWidth, imgHeight - imgPHW02)];
    
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnailLive"];
    if (!format)
    {
        format = [[HNKCacheFormat alloc] initWithName:@"thumbnailLive"];
        format.size = CGSizeMake(imgWidth, imgHeight - imgPHW02);
        format.scaleMode = HNKScaleModeFill;
        format.compressionQuality = 1;
        format.diskCapacity = 10 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
        //format.allowUpscaling = YES;
        
    }
    
    imgSnapshot = [[UIImageView alloc] initWithFrame:imgSnapshotRect];
    imgSnapshot.hnk_cacheFormat = format;
   // [imgSnapshot setContentMode:UIViewContentModeScaleAspectFit];
    imgSnapshot.layer.cornerRadius = 5 ;
    imgSnapshot.clipsToBounds = TRUE;
    imgSnapshot.backgroundColor = [UIColor grayColor];
    [item.contentView addSubview:imgSnapshot];
    

    
    imgWatermark = [[UIImageView alloc] initWithFrame:imgWatermarkRect];
    imgWatermark.contentMode = UIViewContentModeScaleAspectFit;
    imgWatermark.image = [UIImage imageNamed:@"play.png"];
    imgWatermark.tag = [indexPath item];
    
    UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo:)];
     tapPlay.numberOfTapsRequired = 1;
    [tapPlay setDelegate:self];
    [imgWatermark setUserInteractionEnabled:YES];
    [imgWatermark addGestureRecognizer:tapPlay];
    tapPlay.enabled = YES;
    [item.contentView addSubview:imgWatermark];
    
    
    NSURL *url = [NSURL URLWithString:stream.snapshot];
    [imgSnapshot hnk_setImageFromURL:url placeholder:imgPH];
    
    imgAvartar = [[UIImageView alloc] initWithFrame:imgAvartarRect];
    imgAvartar.layer.borderWidth = 2;
    imgAvartar.layer.borderColor = [UIColor whiteColor].CGColor;
    imgAvartar.layer.cornerRadius = imgAvartar.bounds.size.width/2 ;
    imgAvartar.clipsToBounds = TRUE;
    imgAvartar.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer* goProfile = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(goProfile:)];
    //    //Here should be actionViewTap:

        [goProfile setNumberOfTouchesRequired:1];
        [goProfile setDelegate:self];
        imgAvartar.userInteractionEnabled = YES;
       imgAvartar.tag = [indexPath item];
        [imgAvartar addGestureRecognizer:goProfile];
        goProfile.enabled = YES;
        

    [item.contentView addSubview:imgAvartar];
    
    NSURL *avatar = [NSURL URLWithString:stream.avatarUrl];
    [imgAvartar hnk_setImageFromURL:avatar placeholder:[UIImage imageNamed:@"anonymous.png"]];

    
    lblTitlelive = [[UILabel alloc] initWithFrame:lblTitleliveRect];
    lblTitlelive.text = stream.streamTitle;
    lblTitlelive.textColor = [UIColor whiteColor];
    lblTitlelive.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2 ];
    [imgSnapshot addSubview:lblTitlelive];
    
    UIView *bottonViewItem = [[UIView alloc] initWithFrame:bottonViewItemRect];
    bottonViewItem.backgroundColor = [UIColor redColor];
    [item.contentView addSubview:bottonViewItem];
    
    imgView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imgView.image = [UIImage imageNamed:@"view_2.png"];
    [bottonViewItem addSubview:imgView];
    
    lblViewCount = [[UILabel alloc] initWithFrame:lblViewCountRect];
    [lblViewCount setText:stream.streamTotalView];
    lblViewCount.textColor = [UIColor whiteColor];
    lblViewCount.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    [bottonViewItem addSubview:lblViewCount];

    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionViewRect.size.width , collectionViewRect.size.height);
}


- (void)playVideo:(UITapGestureRecognizer *)tapGR {
    NSLog(@"streamingdetail111");
    
//    //LiveStreamingCell *cell = (LiveStreamingCell *)tapGR.view;
//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
////    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
////    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
//    //    UserTag = [tapRecognizer.view tag];
    NSInteger watermarkTag = [tapGR.view tag];
//   // imgWatermark = (UIImageView *)tapGR.view;
//    
  LivestreamRealtimeViewController *streamingRealtime = [self.storyboard instantiateViewControllerWithIdentifier:@"livestreaming"];

   // item.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:40 alpha:0.6f];

    Streaming *stream = [self.streamList objectAtIndex:watermarkTag];

    streamingRealtime.objStreaming = stream;

    streamingRealtime.streamingType = @"live";

    [self.view.window.rootViewController presentViewController:streamingRealtime animated:YES completion:nil];
//    
}
- (void)goProfile:(id)sender
{
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    //    UserTag = [tapRecognizer.view tag];
    NSInteger profileTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:profileTag];
//    NSLog(@"userID : %@",stream.userID);
    [[UserManager shareIntance]followAPI:@"getfollow" userID:stream.userID followingUserID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        NSLog(@"followAPIData %@ ",result);
        UserData *userData = [[UserData alloc] init];
        userData.userId = result[@"id"];
        userData.count_follower = result[@"count_follower"];
        userData.count_following = result[@"count_following"];
        userData.email = result[@"email"];
        userData.first_name = result[@"first_name"];
        userData.last_name = result[@"last_name"];
        userData.is_followed = [result[@"is_followed"] integerValue];
        userData.profile_picture = result[@"profile_picture"];
        userData.undislikes = result[@"undislikes"];
        userData.unlikes = result[@"unlikes"];
        userData.first_name = result[@"first_name"];
        appDelegate.followData = userData;
        
        UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"userprofile"];
        UserProfileViewController *userprofile = navigationController.viewControllers[0];
        userprofile.userData = userData;
        [self.view.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
        
        
    }];
    
    
}


@end



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/







/*
#pragma mark - KKGridView

- (NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return 1;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return self.streamList.count;
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat cellH ;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cellH = 300*scy ;
        gridView.cellSize = CGSizeMake(gridView.bounds.size.width - (20*scx) , cellH);
    }
    else{
        cellH = 300;
        gridView.cellSize = CGSizeMake(gridView.bounds.size.width - 20 , cellH);
        //self.view.bounds.size.height/2 ;
        
    }
    Streaming *stream = [self.streamList objectAtIndex:[indexPath index]];
    
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellViewClick:)];
    tapGestureRec.numberOfTapsRequired = 1;
    
    StreamingCell *cell = [StreamingCell cellForGridView:gridView];
    cell.cellTag = [indexPath index];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    CGFloat imgWidth = cell.frame.size.width;
    CGFloat imgHeight = cell.frame.size.height - imgPHW01;
    
    UIImage *imgPH ;
    imgPH = [UIImage imageNamed:@"sil_big.jpg"];
//   [imgPH :CGSizeMake(imgWidth, imgHeight - imgPHW02)];
    
    //= [self resizeImage:[UIImage imageNamed:@"sil_big.jpg"] imageSize:CGSizeMake(imgWidth, imgHeight - imgPHW02)];
    
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnailLive"];
    if (!format)
    {
        format = [[HNKCacheFormat alloc] initWithName:@"thumbnailLive"];
        format.size = CGSizeMake(imgWidth, imgHeight - imgPHW02);
        format.scaleMode = HNKScaleModeFill;
        format.compressionQuality = 1;
        format.diskCapacity = 10 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
        //format.allowUpscaling = YES;
        
    }
    
    cell.imgSnapshot.hnk_cacheFormat = format;
    
    NSURL *url = [NSURL URLWithString:stream.snapshot];
    [cell.imgSnapshot hnk_setImageFromURL:url placeholder:imgPH];
    
    [cell generateWarterMark];
    
    UIImageView *imgLive = [[UIImageView alloc] initWithFrame:imgLiveRect];
    imgLive.contentMode = UIViewContentModeScaleToFill;
    imgLive.image = [UIImage imageNamed:@"live_stream_icon.png"];
    
    [cell.imgSnapshot addSubview:imgLive];
    
    cell.lblPlace.text = stream.streamTitle;
    cell.lblCreateBy.text = stream.createBy;
    cell.lblViewCount.text = stream.streamTotalView;
    cell.lblLoveCount.text = [NSString stringWithFormat:@"%ld",(long)stream.lovesCount];
    
    [cell addGestureRecognizer:tapGestureRec];
    
    UITapGestureRecognizer* TapShare = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(shareStream:)];//Here should be actionViewTap:
    [TapShare setNumberOfTouchesRequired:1];
    [TapShare setDelegate:self];
    cell.shareLivestream.userInteractionEnabled = YES;
    cell.shareLivestream.tag = [indexPath index];
    [cell.shareLivestream addGestureRecognizer:TapShare];
    TapShare.enabled = YES;
    
    NSLog(@"isLove : %d",stream.isLoved);
    if (stream.isLoved) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
        img.image = [UIImage imageNamed:@"ic_love2.png"];
        [cell.btnLoveicon addSubview:img];
        [cell.contentView addSubview:cell.btnLoveicon];
    }else
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
        img.image = [UIImage imageNamed:@"ic_love.png"];
        [cell.btnLoveicon addSubview:img];
        [cell.contentView addSubview:cell.btnLoveicon];
        
    }
    
    UITapGestureRecognizer* goProfile = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(goProfile:)];
    //Here should be actionViewTap:
    
    [goProfile setNumberOfTouchesRequired:1];
    [goProfile setDelegate:self];
    cell.lblCreateBy.userInteractionEnabled = YES;
    cell.lblCreateBy.tag = [indexPath index];
    [cell.lblCreateBy addGestureRecognizer:goProfile];
    goProfile.enabled = YES;
    
    
    UITapGestureRecognizer* TapLove = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(loveSend:)];//Here should be actionViewTap:
    [TapLove setNumberOfTouchesRequired:1];
    [TapLove setDelegate:self];
    cell.btnLoveicon.userInteractionEnabled = YES;
    cell.btnLoveicon.tag = [indexPath index];
    //    [cell.btnLoveicon addGestureRecognizer:TapLove];
    TapLove.enabled = YES;
    UITapGestureRecognizer* TapLogin = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(login:)];
    [TapLogin setNumberOfTouchesRequired:1];
    [TapLogin setDelegate:self];
    if (appDelegate.isLogin) {
        [ cell.btnLoveicon addGestureRecognizer:TapLove];
        TapLove.enabled = YES;
        TapLogin.enabled = NO;
    }
    else{
        TapLove.enabled = NO;
        TapLogin.enabled = YES;
        [cell.btnLoveicon addGestureRecognizer:TapLogin];
        
    }
    
    
    
    
    UITapGestureRecognizer* TapComment = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(commentStream:)];//Here should be actionViewTap:
    [TapComment setNumberOfTouchesRequired:1];
    [TapComment setDelegate:self];
    cell.commentLivebtn.userInteractionEnabled = YES;
    cell.commentLivebtn.tag = [indexPath index];
    [cell.commentLivebtn addGestureRecognizer:TapComment];
    TapComment.enabled = YES;
    
    return cell;
}
- (void)login:(id)sender
{
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Please Login" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [Alert show];
    
    //  UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    //    NSLog(@"is not login ");
    //    UIViewController *stream = [[UIViewController alloc] init];
    //    stream = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
    //    stream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:stream animated:YES completion:Nil];
}
- (void)goProfile:(id)sender
{
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    //    UserTag = [tapRecognizer.view tag];
    NSInteger profileTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:profileTag];
    NSLog(@"userID : %@",stream.userID);
    //    Streaming *stream = [self.streamList objectAtIndex:UserTag];
    //    userprofile
    //    userprofile.streamingType = @"history";
    //    NSLog(@"streamTotalViewTag:%lu",(unsigned long)editTag);
    
    //    UserProfileViewController *userprofile = [self.storyboard instantiateViewControllerWithIdentifier:@"userprofile"];
    //    userprofile.streamData = stream;
    //    userprofile.userID = stream.userID;
    //    [self.view.window.rootViewController presentViewController:userprofile animated:YES completion:nil];
    
    [[UserManager shareIntance]followAPI:@"getfollow" userID:stream.userID Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        NSLog(@"followAPIData %@ ",result);
        UserData *userData = [[UserData alloc] init];
        userData.userId = result[@"id"];
        userData.count_follower = result[@"count_follower"];
        userData.count_following = result[@"count_following"];
        userData.email = result[@"email"];
        userData.first_name = result[@"first_name"];
        userData.last_name = result[@"last_name"];
        userData.is_followed = [result[@"is_followed"] integerValue];
        userData.profile_picture = result[@"profile_picture"];
        userData.undislikes = result[@"undislikes"];
        userData.unlikes = result[@"unlikes"];
        userData.first_name = result[@"first_name"];
        appDelegate.followData = userData;
        
        UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"userprofile"];
        UserProfileViewController *userprofile = navigationController.viewControllers[0];
        userprofile.userData = userData;
        [self.view.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
        
        
    }];
    
    
}

- (void)loveSend:(id)sender
{
    NSLog(@"Love Love");
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    NSInteger loveTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:loveTag];
    NSLog(@"streamID :%@ ",stream.streamID);
    NSLog(@"islove? :%d ",stream.isLoved);
    
    if(!stream.isLoved)
    {
        [[UserManager shareIntance] loveAPI:@"love" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"loveSendresult : %@",result);
            stream.isLoved = true;
            stream.lovesCount++;
            [self viewDidLoad];
            
        }];
    }else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);
            stream.isLoved = false;
            stream.lovesCount--;
            [self viewDidLoad];
        }];
    }
    
    
}

- (void)shareStream:(id)sender
{
    NSLog(@"ShareMyStream TAP");
    
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    NSInteger shareTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:shareTag];
    
    NSLog(@"Stream Data %@",stream.web_url);
    
    NSString * shareUrl = stream.web_url;
    NSLog(@"Share Image %@",shareUrl);
    
    NSArray *shareItems = @[shareUrl];
    
    
    //UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
    //NSMutableArray * shareItems = [NSMutableArray new];
    //[shareItems addObject:imgShare];
    //[shareItems addObject:message];
    
    //    NSString *text = @"";
    //    NSURL *url = [NSURL URLWithString:shareUrl];
    //    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:stream.snapshot]]];
    //    UIActivityViewController *avc =[[UIActivityViewController alloc] initWithActivityItems:@[text, url, image] applicationActivities:nil];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
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
    
    
}


-(void)commentStream:(id)sender
{
    NSLog(@"COMMENTSTREAMING");
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    NSInteger streamTag = [tapRecognizer.view tag];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.comment_type = @"stream";
    Streaming *stream = [self.streamList objectAtIndex:streamTag];
    appDelegate.CCTV_ID = stream.streamID;
    //UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"commentNav"];
    // CommentViewController *comment = navigationController.viewControllers[0];
    // Comment.userData = userData;
    [self.view.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
}
*/


