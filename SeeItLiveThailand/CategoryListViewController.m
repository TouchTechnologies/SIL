//
//  CategoryListViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 5/3/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "CategoryListViewController.h"
#import "ADPageControl.h"
#import "AppDelegate.h"
#import "Streaming.h"
#import "DataManager.h"
#import "SBScrollView.h"
#import "defs.h"

#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "StreamingCell.h"
#import "VKVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <KKGridView/KKGridView.h>
#import "MBProgressHUD.h"
#import "UserManager.h"
#import "UserProfileViewController.h"
#import "SBScrollView.h"
#import "LoginViewController.h"
#import "StreamingDetailViewController.h"

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);
@interface CategoryListViewController ()<ADPageControlDelegate>
{
    ADPageControl *_pageControl;
    AppDelegate *appDelegate;
    BOOL isLazy;
    
    CGSize cellSize;
    CGSize paddingSize;
    CGFloat parentGrab;
    UIView *navView;
    UIButton *backBtn;
    
    CGRect navViewRect;
    CGRect backBtnRect;
    
    CGFloat rcGrapY;
    CGFloat rcBarH;
    CGFloat rcButtonW;
    
    CGFloat fontSize;
    CGFloat titleHeight;
    CGFloat titleWidth;
    CGFloat indicatorHeight;
    CGFloat indicatorWidth;
  
    CGFloat cellH;
    CGFloat imgPHW01;
    CGFloat imgPHW02;
    NSUInteger UserTag;
    NSUInteger CellTag;
    
    SBScrollView *scrollView;
    CGRect scrollViewRect;

    StreamingCell *cell;
    Streaming *stream;
    MBProgressHUD *hud ;
}
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic) NSString *loadingTitle;
@property (nonatomic, strong) UILabel *lblPlace;
@end

@implementation CategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    scrollView.delegate = self;
    [self initialSize];
    [self setupPageControl];
    [self initial];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initial{
    
    navView = [[UIView alloc] initWithFrame:navViewRect];
    navView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:navView];
    
    backBtn = [[UIButton alloc] initWithFrame:backBtnRect];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    scrollView = [[SBScrollView alloc] initWithFrame:scrollViewRect];
    scrollView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [_pageControl.view addSubview:scrollView];
    
    
    
    
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [tempWindow addSubview:hud];
    [hud show:YES];
    
    [self.gridView removeFromSuperview];
    
     CGRect parentFrame = scrollViewRect;
    
    //    onAirView = [[UIView alloc] initWithFrame:onAirViewRect];
    //    onAirView.backgroundColor = [UIColor redColor];
    //    [scrollView addSubview:onAirView];
    
    
    //   self.gridView = [[KKGridView alloc] initWithFrame:CGRectMake(parentFrame.origin.x, parentFrame.origin.y, parentFrame.size.width, (weakSelf.streamList.count*(cellH+10))+10)];
    self.gridView = [[KKGridView alloc] initWithFrame:CGRectMake(parentFrame.origin.x, parentFrame.origin.y - 240 , parentFrame.size.width,  parentFrame.size.height)];
    self.gridView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    self.gridView.cellSize = cellSize;
    self.gridView.cellPadding = paddingSize;
    self.gridView.allowsMultipleSelection = NO;
    self.gridView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:self.gridView];
    
    __weak CategoryListViewController *weakSelf = self;
    
    
    [[DataManager shareManager] getStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
        
        
        [hud hide:YES];
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
-(void)initialSize{
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
//        fontSize = 16.0 * SCALING_X;
//        titleHeight = 45.0 * SCALING_Y;
//        titleWidth = 320 * SCALING_X;
//        indicatorHeight = 5.0 * SCALING_Y;
//        rcBarH = 70.0* SCALING_Y;
//        rcGrapY = 200.0* SCALING_Y;
//        rcButtonW = 50.0* SCALING_X;
//        //indicatorWidth = self.view.bounds.size.width* SCALING_X;
    } else {
        parentGrab = 120.0;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - 15, 230);
        paddingSize = CGSizeMake(10.f, 10.f);
        fontSize = 16.0;
        titleHeight = 45.0;
        titleWidth = 100;
        indicatorHeight = 5.0;
        rcBarH = 70.0;
        rcGrapY = 200.0;
        rcButtonW = 50.0;
        imgPHW01 = 40.0;
        imgPHW02 = 25.0;
        navViewRect = CGRectMake(0, 20, width, 40);
        backBtnRect = CGRectMake(5, navViewRect.size.height/2 -15 , 30 , 30);
        scrollViewRect = CGRectMake(0, titleHeight, width, height - 85);
    }

}
-(void)setupPageControl{
    /**** 1. Setup pages using model class "ADPageModel" ****/
    
    
    ADPageModel *TravelModel = [[ADPageModel alloc] init];
    TravelModel.strPageTitle = appDelegate.categoryData[0][@"category_name_en"];
    TravelModel.iPageNumber = 0;
    //historyModel.viewController = streamHistory;
    TravelModel.bShouldLazyLoad = YES;
    
    
    //Live
    ADPageModel *CultureModel = [[ADPageModel alloc] init];
    CultureModel.strPageTitle = appDelegate.categoryData[1][@"category_name_en"];
    CultureModel.iPageNumber = 1;
    CultureModel.bShouldLazyLoad = YES;
    
    
    
    ADPageModel *EventModel = [[ADPageModel alloc] init];
    EventModel.strPageTitle = appDelegate.categoryData[2][@"category_name_en"];
    EventModel.iPageNumber = 2;
    //historyModel.viewController = streamHistory;
    EventModel.bShouldLazyLoad = YES;
    
    ADPageModel *NewsModel = [[ADPageModel alloc] init];
    NewsModel.strPageTitle = appDelegate.categoryData[3][@"category_name_en"];
    NewsModel.iPageNumber = 3;
    //historyModel.viewController = streamHistory;
    NewsModel.bShouldLazyLoad = YES;

    ADPageModel *LifestyleModel = [[ADPageModel alloc] init];
    LifestyleModel.strPageTitle = appDelegate.categoryData[4][@"category_name_en"];
    LifestyleModel.iPageNumber = 4;
    //historyModel.viewController = streamHistory;
    LifestyleModel.bShouldLazyLoad = YES;

    ADPageModel *OtherModel = [[ADPageModel alloc] init];
    OtherModel.strPageTitle = appDelegate.categoryData[5][@"category_name_en"];
    OtherModel.iPageNumber = 5;
    //historyModel.viewController = streamHistory;
    OtherModel.bShouldLazyLoad = YES;

    ADPageModel *MusicModel = [[ADPageModel alloc] init];
    MusicModel.strPageTitle = appDelegate.categoryData[6][@"category_name_en"];
    MusicModel.iPageNumber = 6;
    //historyModel.viewController = streamHistory;
    MusicModel.bShouldLazyLoad = YES;

    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    //   _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:liveModel,historyModel, nil];
    _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:TravelModel,CultureModel,EventModel,NewsModel,LifestyleModel,OtherModel,MusicModel , nil];
    _pageControl.iTitleViewWidth = titleWidth;
    
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    //    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    //    if([appDelegate.pageName isEqualToString:@"MyStream"])
    //    {
    //        _pageControl.iFirstVisiblePageNumber = 2;
    //    }
    //    else
    //    {
    //        _pageControl.iFirstVisiblePageNumber = 0;
    //    }
    
    
    _pageControl.iFirstVisiblePageNumber = 0;
    
    _pageControl.iTitleViewHeight = titleHeight;
    _pageControl.iPageIndicatorHeight = indicatorHeight;
    _pageControl.fontTitleTabText =  [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    _pageControl.bEnablePagesEndBounceEffect = NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
    _pageControl.colorTabText = [UIColor blackColor]; //orangeColor
    _pageControl.colorTitleBarBackground = [UIColor whiteColor];
    _pageControl.colorPageIndicator = [UIColor redColor];
    //[UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]; //[UIColor orangeColor]; //blueColor
    _pageControl.colorPageOverscrollBackground = [UIColor lightGrayColor];
    
    _pageControl.bShowMoreTabAvailableIndicator = NO;
    
    
    
    /**** 3. Add as subview ****/
    
    
    _pageControl.view.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 20);
    [self.view addSubview:_pageControl.view];
    
    
    //flag lazy load
    isLazy = FALSE;


}
- (void)back:(id)sender{

    [self dismissViewControllerAnimated:TRUE completion:nil];
}
#pragma mark - ADPageControlDelegate

//LAZY LOADING

-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
    
    NSLog(@"ADPageControl :: Lazy load asking for page %d",pageModel.iPageNumber);
    
    if(pageModel.iPageNumber == 0)
    {
        
        [_gridView reloadData];
    }
    else if(pageModel.iPageNumber == 1)
    {
        [_gridView reloadData];
    }
    else if(pageModel.iPageNumber == 2)
    {
        [_gridView reloadData];
    }
    else if(pageModel.iPageNumber == 3)
    {
        [_gridView reloadData];
    }
    else if(pageModel.iPageNumber == 4)
    {
        [_gridView reloadData];
    }
    else if(pageModel.iPageNumber == 5)
    {
        [_gridView reloadData];
    }
    else if(pageModel.iPageNumber == 6)
    {
        [_gridView reloadData];
    }
    return nil;
}

//CURRENT PAGE INDEX

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
    
    if (isLazy == FALSE) {
        ADPageModel *pageModel = [_pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
        
//        if ([pageModel.viewController isKindOfClass:[StreamLiveViewController class]]) {
//            //            NSLog(@"live live");
//            StreamLiveViewController *streamLive = (StreamLiveViewController *)pageModel.viewController;
//            [streamLive viewDidLoad];
//            
//        }
//        else if ([pageModel.viewController isKindOfClass:[StreamHistoryViewController class]]) {
//            //            NSLog(@"his tory");
//            StreamHistoryViewController *streamHistory = (StreamHistoryViewController *)pageModel.viewController;
//            [streamHistory viewDidLoad];
//        }
//        else if ([pageModel.viewController isKindOfClass:[MyLivestreamViewController class]]) {
//            //            NSLog(@"My Live");
//            MyLivestreamViewController *MyLivestream = (MyLivestreamViewController *)pageModel.viewController;
//            [MyLivestream viewDidLoad];
//        }
        
    }
    
    isLazy = FALSE;
    
    
    //UIViewController *controller = [_pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
    //[controller viewDidLoad];
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
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat imgWidth = cell.frame.size.width;
    CGFloat imgHeight = cell.frame.size.height - imgPHW01;
    CGRect setframe ;
    CGRect parentFrame = scrollView.bounds;
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
     NSLog(@"CATEGORY :%@" , stream.category);
    
    if (stream.categoryID == 1) {
        NSLog(@"Category DDD >>> %@",stream.category);
    }
    
    if ([stream.category isEqualToString:@"Other"]) {
        NSLog(@"stream cat count :::::: %@",stream.categoryCountStream);
    }
    
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
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    NSInteger loveTag = [tapRecognizer.view tag];
    
    Streaming *stream = [self.streamList objectAtIndex:loveTag];
    NSLog(@"streamID :%@ ",stream.streamID);
    NSLog(@"islove? :%d ",stream.isLoved);
   
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lovepress" object:nil];
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    // hud.labelText = @"Loading...";
    [tempWindow addSubview:hud];
    [hud show:YES];
    
    if(!stream.isLoved)
    {
        [[UserManager shareIntance] loveAPI:@"love" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"loveSendresult : %@",result);
            stream.isLoved = true;
            stream.lovesCount++;
            
            [self.gridView reloadData];
            [hud hide:YES];
        }];
        
    }
    else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);
            
            stream.lovesCount--;
            stream.isLoved = false;
            
            [self.gridView reloadData];
            [hud hide:YES];
            
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


- (void) refreshList:(NSNotification *) refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"ADView Notiname: %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"update"])
    {
        NSLog (@"Update successfully");
    }else if ([[refreshName name] isEqualToString:@"refresh"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        //        [self viewDidLoad];
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
