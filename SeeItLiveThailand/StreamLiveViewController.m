//
//  StreamLiveViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/12/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "StreamLiveViewController.h"

#import "defs.h"
#import "Streaming.h"
#import "StreamingCell.h"
#import "DataManager.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "Streaming.h"
#import "LiveStreamingCell.h"
#import "StreamingDetailViewController.h"
#import "VKVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <KKGridView/KKGridView.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "UserManager.h"
#import "UserProfileViewController.h"
#import "NotVDOview.h"
#import "LivestreamRealtimeViewController.h"

@interface StreamLiveViewController ()
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic, strong) UILabel *lblNoStream;
@property (nonatomic, strong) UIView *recordBar;
@property (nonatomic, strong) UIImageView *imgLiveStatus;


@end

@implementation StreamLiveViewController {
    CGSize cellSize;
    CGSize paddingSize;
    
    CGFloat parentGrab;
    CGFloat rcBarH;
    CGFloat rcGrapY;
    CGFloat rcButtonW;
    CGFloat imgPHW01;
    CGFloat imgPHW02;
    
    CGRect imgLiveRect;
    CGRect imgLive;
    CGRect lblNoStreamRect;
    CGFloat fontSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initialSize];
//    [self initial];
    
    //[self initialTest];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
//    NSLog(@"Out ==========================>");
}
-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)initNib{
    }
- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        NSLog(@"if");
        parentGrab = 120.0 * scx;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - (15 * scx), (230 * scy));
        paddingSize = CGSizeMake((10.0 * scx), (10.0 * scy));
        rcBarH = 90.0 * scy;
        rcGrapY = (180 * scy) + 20;
        rcButtonW = 80.0 * scx;
        imgPHW01 = 40.0 * scx;
        imgPHW02 = 25.0 * scx;
        
        
        
        imgLiveRect = CGRectMake((5 * scx), (5 * scy), (60 * scx), (20 * scy));
       // lblNoStreamRect = CGRectMake((self.view.bounds.size.width/2) - (150 * scx), ( 200.0f * scy), (300.0f * scx), (30.0f * scy));
        imgLive = CGRectMake((self.view.bounds.size.width/2) - 25.0f, 130.0f, 50.0f, 50.0f);
        lblNoStreamRect = CGRectMake((self.view.bounds.size.width/2) - 150.0f, 200.0f, 300.0f, 50.0f);
        fontSize = 18.0 * scx;
        
    } else {
        NSLog(@"else");
        parentGrab = 120.0;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - 15, 230);
        paddingSize = CGSizeMake(10.f, 10.f);
        rcBarH = 90.0;
        rcGrapY = 200.0;
        rcButtonW = 80.0;
        imgPHW01 = 40.0;
        imgPHW02 = 25.0;
        
        imgLiveRect = CGRectMake(5, 5, 60, 20);
        
        
        imgLive = CGRectMake((self.view.bounds.size.width/2) - 25.0f, 130.0f, 50.0f, 50.0f);
        lblNoStreamRect = CGRectMake((self.view.bounds.size.width/2) - 150.0f, 200.0f, 300.0f, 30.0f);

        fontSize = 18.0;
    }
}

- (void)initial {
    
    //NSLog(@"Live Stream");
    
    // Show progress
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [tempWindow addSubview:hud];
    [hud show:YES];
    
    
    
    CGRect parentFrame = self.view.bounds;

//    
//    [self.recordBar removeFromSuperview];
//    
//    self.recordBar = [[UIView alloc] initWithFrame:CGRectMake(0, tempWindow.frame.size.height-rcGrapY, tempWindow.frame.size.width, rcBarH)];
//    self.recordBar.backgroundColor = [UIColor colorWithRed:0.184 green:0.184 blue:0.231 alpha:1];
//   // [self.view addSubview:self.recordBar];
//    
//    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake((self.recordBar.bounds.size.width/2) - (rcButtonW/2), (self.recordBar.bounds.size.height/2) - (rcButtonW/2), rcButtonW, rcButtonW)];
//    [recordButton setBackgroundImage:[UIImage imageNamed:@"ic_live1.png"] forState:UIControlStateNormal];
//    [recordButton addTarget:self action:@selector(liveStream) forControlEvents:UIControlEventTouchUpInside];
//    [recordButton addTarget:self action:@selector(gostreamming:)  forControlEvents:UIControlEventTouchUpInside];
//    [self.recordBar addSubview:recordButton];
    
    //add no streaming label
    //[_lblNoStream removeFromSuperview];
    

    
    //_lblNoStream.hidden = YES;
    
    //NSLog(@"initial");
    
    __weak StreamLiveViewController *weakSelf = self;
    
//    if (appDelegate.isLogin) {
    [[DataManager shareManager] getStreamingLiveWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
        

        [hud hide:YES];
        
        if (success)
        {
            
            
            if (streamRecords.count > 0) {
                
                NSLog(@"Has LiveStream");
                weakSelf.streamList = streamRecords;
                _lblNoStream.hidden = YES;
                _imgLiveStatus.hidden = YES;
                [_lblNoStream removeFromSuperview];
                [_imgLiveStatus removeFromSuperview];
                [self.gridView removeFromSuperview];
                
                self.gridView = [[KKGridView alloc] initWithFrame:CGRectMake(parentFrame.origin.x, parentFrame.origin.y , parentFrame.size.width, parentFrame.size.height)];
                self.gridView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
                self.gridView.dataSource = self;
                self.gridView.delegate = self;
                [self.view addSubview:self.gridView];
                
                //CGFloat scWidth = (self.view.frame.size.width / 2) - 15;
                //CGFloat scHeiht = 220;//(self.view.frame.size.height / 2) - 30;
                self.gridView.cellSize = cellSize;
                self.gridView.cellPadding = paddingSize;
                self.gridView.allowsMultipleSelection = NO;
                //self.gridView.scrollsToTop = YES;
                self.gridView.backgroundColor = [UIColor clearColor];
                
            } else {
                //_lblNoStream.hidden = NO;
                /*
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:NoLiveStream delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                 */
                NSLog(@"NoLiveStream");
                [self.gridView removeFromSuperview];
                
                [_lblNoStream removeFromSuperview];
                _lblNoStream = [[UILabel alloc] initWithFrame:lblNoStreamRect];
//                _lblNoStream.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
                _lblNoStream.text = NoLiveStream;
                _lblNoStream.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
                _lblNoStream.backgroundColor = [UIColor clearColor];
                _lblNoStream.textAlignment = NSTextAlignmentCenter;
                
                _imgLiveStatus = [[UIImageView alloc] initWithFrame:imgLive];
                _imgLiveStatus.contentMode = UIViewContentModeScaleToFill;
                _imgLiveStatus.image = [UIImage imageNamed:@"ic_livestream2.png"];
                [self.view  addSubview:_imgLiveStatus];
                [self.view addSubview:_lblNoStream];
            }
            
            
            //NSLog(@"",)
        } else
        {
            [hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:NotConnect delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    
//    }else{
//    
//        [hud hide:YES];
//        NSLog(@"Live Stream else");
//        
//        [_lblNoStream removeFromSuperview];
//        _lblNoStream = [[UILabel alloc] initWithFrame:lblNoStreamRect];
////        _lblNoStream.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//        _lblNoStream.text = NoLiveStream;
//        _lblNoStream.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
//        _lblNoStream.backgroundColor = [UIColor clearColor];
//        _lblNoStream.textAlignment = NSTextAlignmentCenter;
//        
//        UIImageView *imgLiveStatus = [[UIImageView alloc] initWithFrame:imgLive];
//        imgLiveStatus.contentMode = UIViewContentModeScaleToFill;
//        imgLiveStatus.image = [UIImage imageNamed:@"ic_livestream2.png"];
//        
//        [self.view  addSubview: imgLiveStatus];
//        [self.view addSubview:_lblNoStream];
//    }
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
- (void)initialTest {
    
    NSData *data = [self getSavedJsonData];
    
    NSError *jsonParsingError = nil;
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
    
    /*
    NSLog(@"%@",jsonResults);
    NSLog(@"%@",jsonResults[@"status"]);
    NSLog(@"%@",jsonResults[@"message"]);
    */
    
    if([jsonResults[@"status"] intValue] == 0) {
        NSLog(@"status is 0");
        NSArray *channelList = (NSArray *)jsonResults[@"data"][@"streamingChannels"];
        
        for (NSDictionary *channel in channelList) {
            //NSLog(@"%@",channel[@"channelID"]);
            //NSLog(@"%@",channel[@"streamings"]);
            
            for (NSDictionary *streaming in channel[@"streamings"]) {
                NSLog(@"%@",streaming[@"streamingID"]);
                NSLog(@"%@",streaming[@"snapshots"][@"320x240"]);
                NSLog(@"%@",streaming[@"urls"][@"http"]);
                NSLog(@"%@",streaming[@"geolocation"][@"latitude"]);
                NSLog(@"%@",streaming[@"geolocation"][@"longitude"]);
            }
        }
        
        //NSLog(@"%@",channel);
    }
    

    
 
    

}

-(NSData *)getSavedJsonData{
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/liveStreaming.json"];
    
    return [NSData dataWithContentsOfFile:jsonPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIImage *imgPH = [self resizeImage:[UIImage imageNamed:@"sil_big.jpg"] imageSize:CGSizeMake(imgWidth, imgHeight - imgPHW02)];
    
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
  
//    NSLog(@"isLove : %d",stream.isLoved);
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
        
            [self.gridView reloadData];
            
        }];
    }else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:stream.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);
            stream.isLoved = false;
            stream.lovesCount--;
            [self.gridView reloadData];
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
- (void)cellViewClick:(UITapGestureRecognizer *)tapGR {
    NSLog(@"streamingdetail");
    
    LiveStreamingCell *cell = (LiveStreamingCell *)tapGR.view;
    
    
    
    LivestreamRealtimeViewController *streamingRealtime = [self.storyboard instantiateViewControllerWithIdentifier:@"livestreaming"];
   
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:40 alpha:0.6f];
    
    Streaming *stream = [self.streamList objectAtIndex:cell.cellTag];
    streamingRealtime.objStreaming = stream;
    streamingRealtime.streamingType = @"live";
    [self.view.window.rootViewController presentViewController:streamingRealtime animated:YES completion:nil];
    
}
-(void)commentStream:(id)sender
{
    NSLog(@"COMMENTSTREAMING");
    
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

- (void)viewDidLayoutSubviews
{
    /*
    CGFloat puzzleGridXCoor = floorf(self.view.frame.size.width/2.0-self.puzzleGridView.frame.size.width/2.0);
    self.puzzleGridView.frame = CGRectMake(puzzleGridXCoor, 10, self.puzzleGridView.frame.size.width, self.puzzleGridView.frame.size.height);
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.puzzleGridView.frame.size.height + 130)];
    */
}



#pragma mark - WPPuzzleGridViewDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(void)liveStream{
//    LiveStreamVC Stream = new LiveStreamVC();
    NSLog(@"LiveStream");
    
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
