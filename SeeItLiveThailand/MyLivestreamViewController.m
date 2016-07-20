//
//  MyLivestreamViewController.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/12/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "MyLivestreamViewController.h"
#import <VCSimpleSession.h>


#import "defs.h"
#import "Streaming.h"
#import "DataManager.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "MyStreamingCell.h"
#import "StreamingDetailViewController.h"
#import "VKVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <KKGridView/KKGridView.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "EditMyStreamVC.h"
#import <Google/Analytics.h>
#import "UserData.h"
@interface MyLivestreamViewController () <UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    VCSimpleSession *session ;
    AppDelegate *appDelegate;
    UserData *userData;
    Streaming *userStream;
    UIView *recordBar;
    CGFloat rcGrapY;
    CGFloat rcBarH;
    CGFloat rcButtonW;
    CGFloat fontSize;
    
    CGSize cellSize;
    CGSize paddingSize;
    
    CGFloat parentGrab;
    CGFloat imgPHW01;
    CGFloat imgPHW02;
    CGRect imgLive;
    CGRect lblNoStreamRect;
    UIImageView *imgLiveStatus;
    CGFloat viewWidth;
    NSUInteger editTag;
    
    CGRect gridviewHeaderRect;
    CGRect viewHeaderRect;
    CGRect followerViewRect;
    CGRect AvatarRect;
    CGRect UserNameRect;
    CGRect followCountLblRect;
    CGRect lblfollowRect;
    CGRect lblMyLivestreamRect;
    CGRect lblVideoRect;
    CGRect lblVideoCountRect;
    CGRect gridViewRect;
    NSString *Avatar;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *NoLiveImg;
@property (strong, nonatomic) IBOutlet UILabel *NoLiveLb;
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic) NSString *loadingTitle;
@property (nonatomic, strong) UILabel *lblPlace;
@property (strong, nonatomic) IBOutlet UIView *gridviewHeader;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIView *followerView;
@property (strong, nonatomic) IBOutlet UIImageView *Avatar;
@property (strong, nonatomic) IBOutlet UILabel *UserName;
@property (strong, nonatomic) IBOutlet UILabel *followCountLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblFollow;
@property (strong, nonatomic) IBOutlet UILabel *lblMyLivestream;
@property (strong, nonatomic) IBOutlet UILabel *lblVideo;
@property (strong, nonatomic) IBOutlet UILabel *lblVideoCount;
@end

@implementation MyLivestreamViewController
@synthesize previewView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self initialSize];
    [self initial];

    
//
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshList:)
                                                 name:@"refresh"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshList:)
                                                 name:@"update"
                                               object:nil];
    
//    rcBarH = 90.0;
//    rcGrapY = 200.0;
//    rcButtonW = 80.0;
    
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    recordBar = [[UIView alloc] initWithFrame:CGRectMake(0, tempWindow.frame.size.height-rcGrapY, tempWindow.frame.size.width, rcBarH)];
//    recordBar.backgroundColor = [UIColor colorWithRed:0.184 green:0.184 blue:0.231 alpha:1];
//   // [self.view addSubview:recordBar];
    
   
    
    [_lblNoStream removeFromSuperview];
    _lblNoStream = [[UILabel alloc] initWithFrame:lblNoStreamRect];
//    _lblNoStream.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _lblNoStream.text = NoVideo;
    _lblNoStream.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    _lblNoStream.backgroundColor = [UIColor clearColor];
    _lblNoStream.textAlignment = NSTextAlignmentCenter;
    
    imgLiveStatus = [[UIImageView alloc] initWithFrame:imgLive];
    imgLiveStatus.contentMode = UIViewContentModeScaleToFill;
    imgLiveStatus.image = [UIImage imageNamed:@"ic_livestream2.png"];
    [self.view  addSubview:imgLiveStatus];
    [self.view addSubview:_lblNoStream];
    _lblNoStream.hidden = YES;
    imgLiveStatus.hidden = YES;
    
    
//    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake((recordBar.bounds.size.width/2) - (rcButtonW/2), (recordBar.bounds.size.height/2) - (rcButtonW/2), rcButtonW, rcButtonW)];
//    [recordButton setBackgroundImage:[UIImage imageNamed:@"ic_live1.png"] forState:UIControlStateNormal];
//    [recordBar addSubview:recordButton];
//    
//   [recordButton addTarget:self action:@selector(gostreamming:)  forControlEvents:UIControlEventTouchUpInside];

}
- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        parentGrab = 120.0 * scx;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - (15 * scx), (230 * scy));
        paddingSize = CGSizeMake((10.0 * scx), (10.0 * scy));
        rcBarH = 90.0 * scy;
        rcGrapY = 200 * scy;
        rcButtonW = 80.0 * scx;
        imgPHW01 = 40.0 * scx;
        imgPHW02 = 25.0 * scx;
        fontSize = 18.0 * scy;
        
        imgLive = CGRectMake((self.view.bounds.size.width/2) - (25*scx), 200*scy, 50*scx, 50*scy);
        lblNoStreamRect = CGRectMake(0*scx, 250*scy, self.view.bounds.size.width, 30*scy);
        
        gridviewHeaderRect = CGRectMake(0* scx, 122*scy, self.view.bounds.size.width, 48*scy);
        viewHeaderRect = CGRectMake(0* scx, 0*scy, self.view.bounds.size.width, 120*scy);
        followerViewRect = CGRectMake(0* scx, viewHeaderRect.size.height-(50*scy), self.view.bounds.size.width,50*scy);
        AvatarRect = CGRectMake(20* scx, 35*scy , (70* scx),70*scy);
        UserNameRect = CGRectMake(AvatarRect.size.width + (40* scx) , followerViewRect.origin.y - (35*scy), self.view.bounds.size.width/2 , 30*scy);
        followCountLblRect = CGRectMake(AvatarRect.size.width + (40* scx), followerViewRect.size.height/2 - (fontSize - 2), (50* scx), (fontSize - 2));
        lblfollowRect = CGRectMake(AvatarRect.size.width + (40* scx), followerViewRect.size.height/2, (70* scx), (fontSize - 4));
        lblMyLivestreamRect = CGRectMake(0* scx , gridviewHeaderRect.size.height/2 - fontSize, self.view.bounds.size.width, fontSize) ;
        lblVideoRect= CGRectMake(0* scx , gridviewHeaderRect.size.height/2 + (5*scy) , self.view.bounds.size.width/2 , fontSize - 4) ;
        lblVideoCountRect = CGRectMake(self.view.bounds.size.width/2 , gridviewHeaderRect.size.height/2 + (5*scy) , self.view.bounds.size.width/2, fontSize - 4) ;
                gridViewRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + (170*scy) , self.view.bounds.size.width, self.view.bounds.size.height - (220*scy));
        
    } else {
        
        parentGrab = 120.0;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - 15, 230);
        paddingSize = CGSizeMake(10.f, 10.f);
        rcBarH = 90.0;
        rcGrapY = 200.0;
        rcButtonW = 80.0;
        imgPHW01 = 40.0;
        imgPHW02 = 25.0;
        fontSize = 18.0;
        
        imgLive = CGRectMake((self.view.bounds.size.width/2) - 25.0f, 200, 50.0f, 50.0f);
        lblNoStreamRect = CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 30);
        
        gridviewHeaderRect = CGRectMake(0, 122, self.view.bounds.size.width, 48);
        viewHeaderRect = CGRectMake(0, 0, self.view.bounds.size.width, 120);
        followerViewRect = CGRectMake(0, viewHeaderRect.size.height-50, self.view.bounds.size.width,50);
        AvatarRect = CGRectMake(20, 35 , 70,70);
        UserNameRect = CGRectMake(AvatarRect.size.width + 40 , followerViewRect.origin.y - 35 , self.view.bounds.size.width/2 , 30);
        followCountLblRect = CGRectMake(AvatarRect.size.width + 40, followerViewRect.size.height/2 - (fontSize - 2), 50, (fontSize - 2));
        lblfollowRect = CGRectMake(AvatarRect.size.width + 40, followerViewRect.size.height/2, 50, (fontSize - 4));
        lblMyLivestreamRect = CGRectMake(0 , gridviewHeaderRect.size.height/2 - fontSize, self.view.bounds.size.width, fontSize) ;
        lblVideoRect = CGRectMake(0 , gridviewHeaderRect.size.height/2 + 5 , self.view.bounds.size.width/2 , fontSize - 4) ;
        lblVideoCountRect = CGRectMake(self.view.bounds.size.width/2 , gridviewHeaderRect.size.height/2 + 5 , self.view.bounds.size.width/2, fontSize - 4) ;
        gridViewRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 170 , self.view.bounds.size.width, self.view.bounds.size.height - (220));
    }
}
- (void)initial {
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
//    [tempWindow addSubview:hud];
//    [hud show:YES];

//    NSLog(@"Creata by ::::: %@",self.objStreaming.createBy);
//    NSLog(@"streamTotalViewEdit ::::: %@",self.objStreaming.streamTotalView);
//    NSLog(@"StreamImage ::::: %@",self.objStreaming.snapshot);
    
    //userStream = [self.streamList objectAtIndex:0];
    self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];

    self.viewHeader = [[UIView alloc] initWithFrame:viewHeaderRect];
     self.viewHeader.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewHeader];

     self.followerView = [[UIView alloc] initWithFrame:followerViewRect];
     self.followerView.backgroundColor = [UIColor whiteColor];
    
    self.followCountLbl = [[UILabel alloc] initWithFrame:followCountLblRect];
    self.followCountLbl.textColor = [UIColor redColor];
   
    
    
    self.followCountLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    self.followCountLbl.textAlignment = NSTextAlignmentCenter;
    [self.followerView addSubview:self.followCountLbl];
    
    self.lblFollow = [[UILabel alloc] initWithFrame:lblfollowRect];
    self.lblFollow.text = @"follower";
    self.lblFollow.textAlignment = NSTextAlignmentCenter;
    self.lblFollow.textColor = [UIColor grayColor];
    self.lblFollow.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 4];
    [self.followerView addSubview:self.lblFollow];
    [self.viewHeader addSubview:self.followerView];

    self.Avatar = [[UIImageView alloc] initWithFrame:AvatarRect];
    self.Avatar.backgroundColor = [UIColor lightGrayColor];
    self.Avatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:appDelegate.profile_picture]]];
    self.Avatar.layer.cornerRadius = AvatarRect.size.width/2;
    self.Avatar.clipsToBounds = YES;
    self.Avatar.contentMode = UIViewContentModeScaleToFill;
    [self.viewHeader addSubview:self.Avatar];
    
    self.UserName = [[UILabel alloc] initWithFrame:UserNameRect];
    self.UserName.text = (appDelegate.username != nil)?appDelegate.username:@"username";
    self.UserName.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    self.UserName.textColor = [UIColor whiteColor];
    [self.viewHeader addSubview:self.UserName];
    
    self.gridviewHeader = [[UIView alloc] initWithFrame:gridviewHeaderRect];
    self.gridviewHeader.backgroundColor = [UIColor whiteColor];
    
    self.lblMyLivestream = [[UILabel alloc] initWithFrame:lblMyLivestreamRect];
    self.lblMyLivestream.textAlignment = NSTextAlignmentCenter;
    self.lblMyLivestream.text = @"My Livestream";
    self.lblMyLivestream.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    [self.gridviewHeader addSubview:self.lblMyLivestream];
    
    self.lblVideo = [[UILabel alloc] initWithFrame:lblVideoRect];
    self.lblVideo.text = @"Video : ";
    self.lblVideo.textAlignment = NSTextAlignmentRight;
    self.lblVideo.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 4];
    self.lblVideo.textColor = [UIColor grayColor];
    [self.gridviewHeader addSubview:self.lblVideo];
    
    self.lblVideoCount = [[UILabel alloc] initWithFrame:lblVideoCountRect];
    self.lblVideoCount.text = @"";
    self.lblVideoCount.textAlignment = NSTextAlignmentLeft;
    self.lblVideoCount.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 4];
    self.lblVideoCount.textColor = [UIColor redColor];
    [self.gridviewHeader addSubview:self.lblVideoCount];

    [self.view addSubview:self.gridviewHeader];
    
    [self.gridView removeFromSuperview];
    
    CGRect parentFrame = self.view.bounds;
    
    self.gridView = [[KKGridView alloc] initWithFrame:gridViewRect];
    self.gridView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    [self.view addSubview:self.gridView];
    
    
    self.gridView.cellSize = cellSize;
    self.gridView.cellPadding = paddingSize;
    self.gridView.allowsMultipleSelection = NO;
    
    //self.gridView.scrollsToTop = YES;
    self.gridView.backgroundColor = [UIColor whiteColor];
    
     __weak MyLivestreamViewController *weakSelf = self;
    
    if(appDelegate.isLogin)
    {
        NSLog(@"is login ");
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[DataManager shareManager] getMyStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"streamRecords : %@",streamRecords);
       //     [hud hide:YES];
            self.followCountLbl.text = @"0";
            self.lblVideoCount.text = @"0";
            if (success) {
                if (streamRecords.count != 0) {
                    weakSelf.streamList = streamRecords;
                    userStream = [weakSelf.streamList objectAtIndex:0];
                    self.followCountLbl.text = [NSString stringWithFormat:@"%d" , (int)userStream.count_follower];
//                    NSLog(@"FOLLOWER ::: %ld",(long)userStream.count_follower);
                    self.lblVideoCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)streamRecords.count];
                    _lblNoStream.hidden = YES;
                    imgLiveStatus.hidden = YES;
                }else{
                    NSLog(@"streamRecords.count %lu",(unsigned long)streamRecords.count);

                }

                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }

            [weakSelf.gridView reloadData];
        }];
    }else{
   //     [hud hide:YES];
        NSLog(@"is not login ");
        [self.Avatar setImage:[UIImage imageNamed:@"anonymous.png"]];
        
        _lblNoStream.hidden = NO;
        imgLiveStatus.hidden = NO;

        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Login" message:@"go Login" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        //        [alert show];
        
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Go Login?"
//                                                        message:@"go go go?"
//                                                       delegate:self
//                                              cancelButtonTitle:@"Cancel"
//                                              otherButtonTitles:@"Ok", nil];
//        
//        [alert show];
        
        
    }
    
 

}
- (void)updateData
{
    NSLog(@"Update MyStream Data");
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
    __weak MyLivestreamViewController *weakSelf = self;
    [[DataManager shareManager] getMyStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
        
        
  //      [hud hide:YES];
        if (success) {
//            NSLog(@"streamRecords : %@",streamRecords);
            weakSelf.streamList = streamRecords;
            _lblNoStream.hidden = YES;
            imgLiveStatus.hidden = YES;
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [weakSelf.gridView reloadData];
    }];
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do your action
    }else{
        //reset clicked
        UIViewController *stream = [[UIViewController alloc] init];
        stream = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
        stream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController presentViewController:stream animated:YES completion:Nil];
    }
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
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    viewWidth = 1.0f;
       //self.gridVideo.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height);
    //self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - KKGridView

- (NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return 1;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return self.streamList.count;
    //return _fillerData.count;
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat cellH ;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cellH = 100*scy;
        gridView.cellSize = CGSizeMake(gridView.bounds.size.width/2 - (15*scx) , cellH);
    }
    else{
        cellH = 100;
        gridView.cellSize = CGSizeMake(gridView.bounds.size.width/2 - 15 , cellH);
        //self.view.bounds.size.height/2 ;
        
    }
    
    
    Streaming *stream = [self.streamList objectAtIndex:[indexPath index]];
    if(stream.avatarUrl != nil) {
        NSLog(@"%@",stream.avatarUrl);
    }
    
    Avatar = [NSString stringWithFormat:@"%@",stream.avatarUrl];
    
    UITapGestureRecognizer *tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellViewClick:)];
    tapGestureRec.numberOfTapsRequired = 1;
    
    MyStreamingCell *cell = [MyStreamingCell cellForGridView:gridView];
    cell.cellTag = [indexPath index];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    CGFloat imgWidth = cell.frame.size.width;
    CGFloat imgHeight = cell.frame.size.height - imgPHW01;
    
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
//       cell.imgSnapshot.hnk_cacheFormat = format;
    
    NSURL *url = [NSURL URLWithString:stream.snapshot];
    [cell.imgSnapshot hnk_setImageFromURL:url placeholder:imgPH];
    
//    NSLog(@"Screen : %@",url);
    [cell generateWarterMark];
    
    //cell.imgSnapshot.image = imgPH;
    //cell.lblPlace.text = [_fillerData objectAtIndex:[indexPath index]];
    cell.lblPlace.text = stream.streamTitle;
    cell.lblCreateBy.text = stream.createBy;
    cell.lblViewCount.text = stream.streamTotalView;
    cell.lblLoveCount.text = [NSString stringWithFormat:@"%ld",(long)stream.lovesCount];
    
    
//    NSLog(@"isLove : %d",stream.isLoved);
    if (stream.isLoved) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
        img.image = [UIImage imageNamed:@"ic_love2.png"];
        [cell.btnLoveicon addSubview:img];
     //   [cell.contentView addSubview:cell.btnLoveicon];
    }else
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
        img.image = [UIImage imageNamed:@"ic_love.png"];
        [cell.btnLoveicon addSubview:img];
   //     [cell.contentView addSubview:cell.btnLoveicon];
        
    }
//    [cell.editLivestream addTarget:self action:@selector(editMyStream:) forControlEvents:UIControlEventTouchUpInside];
//    cell.editLivestream.tag = [indexPath index];
    [cell addGestureRecognizer:tapGestureRec];
    
    
    UITapGestureRecognizer* TapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(editMyStream:)];//Here should be actionViewTap:

    [TapGestureRecognizer setNumberOfTouchesRequired:1];
    [TapGestureRecognizer setDelegate:self];
    cell.editLivestream.userInteractionEnabled = YES;
    cell.editLivestream.tag = [indexPath index];
    [cell.editLivestream addGestureRecognizer:TapGestureRecognizer];
    
    
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
//
//    [cell.editLivestream  setUserInteractionEnabled:YES];
//    [cell.editLivestream  addGestureRecognizer:TapGestureRecognizer];
    
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
-(void)commentStream:(id)sender
{
    NSLog(@"COMMENTSTREAMING");
    //UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"commentNav"];
    // CommentViewController *comment = navigationController.viewControllers[0];
    // Comment.userData = userData;
    [self.view.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
}
- (void)editMyStream:(id)sender
{
    NSLog(@"TESTING TAP");
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    editTag = [tapRecognizer.view tag];
    
    EditMyStreamVC *myStream = [self.storyboard instantiateViewControllerWithIdentifier:@"editMyStream"];
    Streaming *stream = [self.streamList objectAtIndex:editTag];
    myStream.objStreaming = stream;
    myStream.streamingType = @"history";
    NSLog(@"streamTotalViewTag:%lu",(unsigned long)editTag);
    [self.view.window.rootViewController presentViewController:myStream animated:YES completion:nil];
    
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
    
    MyStreamingCell *cell = (MyStreamingCell *)tapGR.view;
    NSLog(@"cellTag:%@",tapGR.view);
//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    StreamingDetailViewController *streamingDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"streamingdetail"];
 
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:40 alpha:0.6f];
    
    Streaming *stream = [self.streamList objectAtIndex:cell.cellTag];
    streamingDetail.objStreaming = stream;
    appDelegate.pageName = @"MyStream";
    streamingDetail.streamingType = @"mylivestream";
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"editmystream"])
    {
        // Get reference to the destination view controller
//        UINavigationController *nav = [segue destinationViewController];
//        EditMyStreamVC *myStream = (EditMyStreamVC *)nav.topViewController;
        
        EditMyStreamVC *myStream = [self.storyboard instantiateViewControllerWithIdentifier:@"editMyStream"];
        myStream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
       
        Streaming *stream = [self.streamList objectAtIndex:editTag];
        myStream.objStreaming = stream;
        myStream.streamingType = @"history";
        NSLog(@"streamTotalViewTag:%lu",(unsigned long)editTag);
        [self.view.window.rootViewController presentViewController:myStream animated:YES completion:nil];
        
        }
    
    //    else if([[segue identifier] isEqualToString:@"under2login"])
    //    {
    //        // Get reference to the destination view controller
    //        UINavigationController *nav = [segue destinationViewController];
    //        LoginNavViewController *vc = (LoginNavViewController *)nav.topViewController;
    //        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //
    //    }
    
        // DEFINE HERE THE CALLBACK FUNCTION
        // 1. get the model view controller
//         EditMyStreamVC *mvc = [segue destinationViewController];
//        
//        // 2. Your code after the modal view dismisses
//        mvc.onDismiss = ^(UIViewController *sender, NSObject *objectFromModalViewController)
//        {
//        
//            NSLog(@"DismisViewController");
//            // Do your stuff after dismissing the modal view controller
//            NSLog(@"data back %@",objectFromModalViewController);
//            
//        };
}
- (void) refreshList:(NSNotification *) refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"MyLive Notiname : %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"update"])
    {
        [self updateData];
        NSLog (@"Update successfully");
    }else if ([[refreshName name] isEqualToString:@"refresh"] && [appDelegate.pageName isEqualToString:@"MyStream"])
    {
       // _lblNoStream.hidden = YES;
      //  imgLiveStatus.hidden = YES;
        [self viewDidLoad];
        
        NSLog (@"My Reload successfully");
    }
}
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
