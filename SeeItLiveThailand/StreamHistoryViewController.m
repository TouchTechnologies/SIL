//
//  StreamHistoryViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/12/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "StreamHistoryViewController.h"

#import "defs.h"
#import "Streaming.h"
#import "DataManager.h"
#import "UserManager.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "StreamingCell.h"
#import "StreamingDetailViewController.h"
#import "VKVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <KKGridView/KKGridView.h>
//#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "UserProfileViewController.h"
#import "UserData.h"
#import "CommentViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LiveStreamingCell.h"
#import "LivestreamRealtimeViewController.h"
#import "SBScrollView.h"
#import "SVPullToRefresh.h"

@interface StreamHistoryViewController () <UIAlertViewDelegate,UIGestureRecognizerDelegate,UIApplicationDelegate,KKGridViewDataSource, KKGridViewDelegate,UIScrollViewDelegate>//UIScrollViewDelegate
{
    CGSize cellSize;
    CGSize paddingSize;
    
    CGFloat parentGrab;
    CGFloat rcBarH;
    CGFloat rcGrapY;
    CGFloat rcButtonW;
    CGFloat imgPHW01;
    CGFloat imgPHW02;
    NSUInteger UserTag;
    NSUInteger CellTag;
    CGFloat cellH ;
    CGRect parentFrame;
    CGRect scrollViewRect;
    
    StreamingCell *cell;
    Streaming *stream;
//    MBProgressHUD *hud ;
//    IBOutlet UIScrollView *scrollView;
    
    IBOutlet SBScrollView *scrollView;
    UIView *onAirView;
    CGRect onAirViewRect;
    
    UIScrollView *previewScrollView;
    CGRect previewScrollViewRect;
    
    UIImageView *imgOnAir;
    CGRect imgOnAirRect;
    CGRect gridViewRect;
    
    
}


@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic) NSString *loadingTitle;
@property (nonatomic, strong) UILabel *lblPlace;
@property (nonatomic, strong) UIView *recordBar;
@end

@implementation StreamHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0]];
    [self initialSize];
    [self initial];
    scrollView.delegate = self;
    _gridView.delegate = self;
    scrollView.delegate = self;
     __weak StreamHistoryViewController *weakSelf = self;
    
    [_gridView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    // setup infinite scrolling
    [_gridView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    NSLog(@"StreamHistoryViewController");
//    
//   [[NSNotificationCenter defaultCenter] addObserver:self
//                                            selector:@selector(refreshList:)
//                                               name:@"refresh"
//                                              object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(refreshList:)
//                                                 name:@"update"
//                                               object:nil];
    //[self initialTest];
}
- (void)viewDidAppear:(BOOL)animated {
    [_gridView triggerPullToRefresh];
}
#pragma mark - Actions

- (void)setupDataSource {
//    self.dataSource = [NSMutableArray array];
//    for(int i=0; i<15; i++)
//        [self.dataSource addObject:[NSDate dateWithTimeIntervalSinceNow:-(i*90)]];
}

- (void)insertRowAtTop {
    __weak StreamHistoryViewController *weakSelf = self;
    NSLog(@"insertRowAtTop");
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_gridView beginUpdates];
//        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
//        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [_gridView endUpdates];
        [_gridView reloadData];
        [_gridView.pullToRefreshView stopAnimating];
        
    });
}


- (void)insertRowAtBottom {
    __weak StreamHistoryViewController *weakSelf = self;
    NSLog(@"insertRowAtBottom");
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_gridView beginUpdates];
//        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
//        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [_gridView endUpdates];
        [_gridView reloadData];
        [_gridView.infiniteScrollingView stopAnimating];
    });
}

- (void)initialTest {
    
    
    
    CGFloat scWidth = (self.view.frame.size.width / 2) - 15;
    CGFloat scHeiht = 150;//(self.view.frame.size.height / 2) - 30;
    
    self.gridView.cellSize = CGSizeMake(scWidth, scHeiht);
    self.gridView.cellPadding = CGSizeMake(10.f, 10.f);
    self.gridView.allowsMultipleSelection = NO;
    self.gridView.scrollEnabled = FALSE;
    self.gridView.scrollsToTop = YES;
         self.gridView.backgroundColor = [UIColor clearColor];
   
    _fillerData = [[NSMutableArray alloc] init];
    
    //for (NSUInteger i = 0; i < 20; i++) {
        
        //[_fillerData addObject:[NSString stringWithFormat:@"no - %u", i]];
    //}
    
    [self.gridView reloadData];
}

- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    parentFrame = self.view.bounds;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        parentGrab = 120.0 * scy;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - (15 * scx), (230 * scy));
        paddingSize = CGSizeMake((10.0 * scx), (10.0 * scy));
        rcBarH = 90.0 * scy;
        rcGrapY = 200 * scy;
        rcButtonW = 80.0 * scx;
        imgPHW01 = 40.0 * scy;
        imgPHW02 = 25.0 * scy;
        onAirViewRect = CGRectMake(0*scx, 0*scy, self.view.frame.size.width, 240*scy);
        scrollViewRect = CGRectMake(0*scx, 0*scy, width, height- (80*scy));
        gridViewRect = CGRectMake(0*scx, 240*scy , width, height);
        
    } else {
        cellH = 300;
        parentGrab = 120.0;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - 15, 230);
        paddingSize = CGSizeMake(10.f, 10.f);
        rcBarH = 90.0;
        rcGrapY = 200.0;
        rcButtonW = 80.0;
        imgPHW01 = 40.0;
        imgPHW02 = 25.0;
        onAirViewRect = CGRectMake(0, 0, self.view.frame.size.width, 240);
        scrollViewRect = CGRectMake(0, 0, width, height - 80);
        gridViewRect = CGRectMake(0, 240 , width, height);
    }
}

- (void)initial {
   
    scrollView = [[SBScrollView alloc] init];
    [scrollView setFrame:scrollViewRect];
    [self.view addSubview: scrollView];

    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.pageName = @"StreamHistory";
    //NSLog(@"History Stream");
    // Show progress
    /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"Loading...";
    
    //[self.view bringSubviewToFront:hud];
    
    [hud show:YES];
    */
    
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
//    [tempWindow addSubview:hud];
//    [hud show:YES];
    
    [self.gridView removeFromSuperview];
    
    
    
//    onAirView = [[UIView alloc] initWithFrame:onAirViewRect];
//    onAirView.backgroundColor = [UIColor redColor];
//    [scrollView addSubview:onAirView];
    
    
 //   self.gridView = [[KKGridView alloc] initWithFrame:CGRectMake(parentFrame.origin.x, parentFrame.origin.y, parentFrame.size.width, (weakSelf.streamList.count*(cellH+10))+10)];
    
    self.gridView = [[KKGridView alloc] initWithFrame:gridViewRect];
    self.gridView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    self.gridView.cellSize = cellSize;
    self.gridView.cellPadding = paddingSize;
    self.gridView.allowsMultipleSelection = NO;
    self.gridView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:self.gridView];
    
    __weak StreamHistoryViewController *weakSelf = self;
    
    
    [[DataManager shareManager] getStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
        
        
//        [hud hide:YES];
        if (success) {
            weakSelf.streamList = streamRecords;
            NSLog(@"STREAMLIST COUNT :::: %ld", weakSelf.streamList.count);
            
            
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            /*
             CGFloat xLbl = (weakSelf.view.bounds.size.width / 2) - 100;
             UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(xLbl, 20, 200, 25)];
             lblTitle.text = NotConnect;
             lblTitle.textAlignment = NSTextAlignmentCenter;
             [weakSelf.view addSubview:lblTitle];
             */
            //NSLog(@"%@",error);
        }
        
       
        
        [weakSelf.gridView reloadData];
    }];


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    
    
   // NSLog(@"stream Count:::::: %ld");
    
    //self.gridVideo.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height);
    //self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    

}

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
    CGFloat imgWidth = cell.frame.size.width;
    CGFloat imgHeight = cell.frame.size.height - imgPHW01;
    CGRect setframe ;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
          cellH = 300 * scy ;
        gridView.cellSize = CGSizeMake(gridView.bounds.size.width - (20*scx) , cellH);
        setframe = CGRectMake(parentFrame.origin.x, parentFrame.origin.y, parentFrame.size.width, self.streamList.count*(cellH+(10*scy)) + (10*scy));
    }
    else{
          cellH = 300;
          gridView.cellSize = CGSizeMake(gridView.bounds.size.width - 20 , cellH);
         setframe = CGRectMake(parentFrame.origin.x, parentFrame.origin.y , parentFrame.size.width, self.streamList.count*(cellH+10) + 10);
    
    }
  
// gridView.contentSize = CGSizeMake(gridView.bounds.size.width/2 - 20 ,500);
   stream = [self.streamList objectAtIndex:[indexPath index]];
    if(stream.avatarUrl != nil) {
        NSLog(@"%@",stream.avatarUrl);
    }

    cell = [StreamingCell cellForGridView:gridView];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.selected = FALSE;
    
    UIImage *imgPH = [self resizeImage:[UIImage imageNamed:@"sil_big.jpg"] imageSize:CGSizeMake(imgWidth, imgHeight - imgPHW02)];
    
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnailHis"];
    if (!format)
    {
        format = [[HNKCacheFormat alloc] initWithName:@"thumbnailHis"];
        format.size = CGSizeMake(imgWidth, imgHeight - imgPHW02);
        format.scaleMode = HNKScaleModeFill;
        format.compressionQuality = 1;
        format.diskCapacity = 10 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
        //format.allowUpscaling = YES;
        
    }
    
    NSURL *urlAvatar = [NSURL URLWithString:stream.avatarUrl];
    [cell.imgAvatar hnk_setImageFromURL:urlAvatar];

    cell.imgSnapshot.hnk_cacheFormat = format;
    
    NSURL *url = [NSURL URLWithString:stream.snapshot];
    [cell.imgSnapshot hnk_setImageFromURL:url placeholder:imgPH];
    
    [cell generateWarterMark];
    
    //cell.imgSnapshot.image = imgPH;
    //cell.lblPlace.text = [_fillerData objectAtIndex:[indexPath index]];
    cell.lblPlace.text = stream.streamTitle;
    //cell.lblCreateBy.text = stream.createBy;
    cell.lblCreateBy.text = stream.createBy;
    cell.lblViewCount.text = stream.streamTotalView;
    cell.lblLoveCount.text = [NSString stringWithFormat:@"%ld",(long)stream.lovesCount];
    
    
    NSLog(@"isLove : %d",stream.isLoved);
    if (stream.isLoved && appDelegate.isLogin) {
//        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
//        img.image = [UIImage imageNamed:@"ic_love2.png"];
//        [cell.btnLoveicon addSubview:img];
       
         [cell.btnLoveicon setImage:[UIImage imageNamed:@"ic_love2.png"] forState:UIControlStateNormal] ;
          cell.imgLoveicon.image = [UIImage imageNamed:@"ic_love2.png"];
          cell.lblLoveCount.textColor = [UIColor redColor];
        
//        [cell.contentView addSubview:cell.btnLoveicon];
    }
    else
    {
         [cell.btnLoveicon setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal] ;
          cell.imgLoveicon.image = [UIImage imageNamed:@"ic_love.png"];
         cell.lblLoveCount.textColor = [UIColor blackColor];
      //    [cell.btnLoveicon setImage:[UIImage animatedImageNamed:@"ic_love.png" duration:1.0] forState:UIControlStateHighlighted];//        [cell.contentView addSubview:cell.btnLoveicon];
        
    }

    UITapGestureRecognizer* playStream = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(play:)];
    [playStream setNumberOfTouchesRequired:1];
    [playStream setDelegate:self];
    cell.imgSnapshot.userInteractionEnabled = YES;
    cell.imgSnapshot.tag = [indexPath index];
    [cell.imgSnapshot addGestureRecognizer:playStream];
  //  [cell addGestureRecognizer:tapGestureRec];
    
    
    UITapGestureRecognizer* goProfile = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(goProfile:)];
    //Here should be actionViewTap:
    
    [goProfile setNumberOfTouchesRequired:1];
    [goProfile setDelegate:self];
    cell.lblCreateBy.userInteractionEnabled = YES;
    cell.lblCreateBy.tag = [indexPath index];
    [cell.lblCreateBy addGestureRecognizer:goProfile];
    goProfile.enabled = YES;
    
    UITapGestureRecognizer* TapShare = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(shareMyStream:)];//Here should be actionViewTap:
    [TapShare setNumberOfTouchesRequired:1];
    [TapShare setDelegate:self];
    cell.shareLivestream.userInteractionEnabled = YES;
    cell.shareLivestream.tag = [indexPath index];
    [cell.shareLivestream addGestureRecognizer:TapShare];
    TapShare.enabled = YES;
    
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
    
    CGRect parentFrame = self.view.bounds;
    [self.gridView setFrame:setframe];
       return cell;
}

- (void)login:(id)sender
{
//    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Please Login" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [Alert show];
    
      UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
        NSLog(@"is not login ");

       // LoginViewController *stream = [[UIViewController alloc] init];
         LoginViewController *stream = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
        stream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController presentViewController:stream animated:YES completion:Nil];
}
- (void)loveSend:(id)sender
{
    NSLog(@"Love Love");
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %d",[tapRecognizer.view tag]);
    NSInteger loveTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:loveTag];
    NSLog(@"streamID :%@ ",stream.streamID);
    NSLog(@"islove? :%d ",stream.isLoved);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lovepress" object:nil];
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
//    hud.mode = MBProgressHUDModeIndeterminate;
//   // hud.labelText = @"Loading...";
//    [tempWindow addSubview:hud];
//    [hud show:YES];
    
    if(!stream.isLoved)
    {
        [[UserManager shareIntance] loveAPI:@"love" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"loveSendresult : %@",result);
             stream.isLoved = true;
             stream.lovesCount++;
        
             [self.gridView reloadData];
//        [hud hide:YES];
    }];
        
    }
    else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);

            stream.lovesCount--;
            stream.isLoved = false;

            [self.gridView reloadData];
//          [hud hide:YES];

        }];
        
    }
    
}
-(void)commentStream:(id)sender
{
     NSLog(@"COMMENTSTREAMING");
//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
//    appDelegate.comment_type = @"STREAM";
//    
//     //UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
//     UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"commentNav"];
//   // CommentViewController *comment = navigationController.viewControllers[0];
//   // Comment.userData = userData;
//    [self.view.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    NSInteger streamTag = [tapRecognizer.view tag];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.comment_type = @"STREAM";
    Streaming *stream = [self.streamList objectAtIndex:streamTag];
    appDelegate.CCTV_ID = stream.streamID;
    //UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"commentNav"];
    // CommentViewController *comment = navigationController.viewControllers[0];
    // Comment.userData = userData;
    [self.view.window.rootViewController presentViewController:navigationController animated:YES completion:nil];

}
- (void)shareMyStream:(id)sender
{
    NSLog(@"ShareMyStream TAP");
    
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %d",[tapRecognizer.view tag]);
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
-(void)play:(id)sender
{
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag Playyyyy %ld",[tapRecognizer.view tag]);
    //    UserTag = [tapRecognizer.view tag];
    NSInteger playTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:playTag];
      StreamingDetailViewController *streamingDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"streamingdetail"];
       streamingDetail.objStreaming = stream;
        streamingDetail.streamingType = @"history";
   
     [self.view.window.rootViewController presentViewController:streamingDetail animated:YES completion:nil];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)updateData
//{
//    NSLog(@"Update MyStream Data");
//    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
//    __weak MyLivestreamViewController *weakSelf = self;
//    [[DataManager shareManager] getMyStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
//        
//        
//        [hud hide:YES];
//        if (success) {
//            NSLog(@"streamRecords : %@",streamRecords);
//            weakSelf.streamList = streamRecords;
//            _lblNoStream.hidden = YES;
//            imgLiveStatus.hidden = YES;
//            
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        
//        [weakSelf.gridView reloadData];
//    }];
//}

- (void) refreshList:(NSNotification *) refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"Stream history Notiname : %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"refresh"])
    {
        [self viewDidLoad];
        [self.gridView reloadContentSize];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog (@"Reload successfully");
    }
    
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    NSLog(@"scrollViewDidScroll");
//    // Get new record from here
//}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
////    NSLog(@"scrollViewDidEndScrollingAnimation");
//    
//}
//-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
//{
////    NSLog(@"scrollViewDidScrollToTop");
//}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
////    NSLog(@"scrollViewWillBeginDragging");
//}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
