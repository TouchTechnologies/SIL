//
//  UserLiveViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "UserLiveViewController.h"
#import "defs.h"
#import "Streaming.h"
#import "DataManager.h"
#import "Haneke.h"
#import "UIImage+HanekeDemo.h"
#import "StreamingCell.h"
#import "StreamingDetailViewController.h"
#import "VKVideoPlayerViewController.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <KKGridView/KKGridView.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "UserProfileViewController.h"
#import "UserManager.h"
#import "UserData.h"
#import "AppDelegate.h"
#import "MyStreamingCell.h"

@interface UserLiveViewController ()<UIAlertViewDelegate,UIGestureRecognizerDelegate>
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
}

@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic) NSString *loadingTitle;
@property (nonatomic, strong) UILabel *lblPlace;
@property (nonatomic, strong) UIView *recordBar;

@end

@implementation UserLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSize];
    [self initial];

    // Do any additional setup after loading the view.
}
- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        parentGrab = 120.0 * scx;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - (15 * scx), (230 * scy));
        paddingSize = CGSizeMake((10.0 * scx), (10.0 * scy));
        rcBarH = 90.0 * scy;
        rcGrapY = (180 * scy) + 20;
        rcButtonW = 80.0 * scx;
        imgPHW01 = 40.0 * scx;
        imgPHW02 = 25.0 * scx;
        
    } else {
        
        parentGrab = 120.0;
        cellSize = CGSizeMake((self.view.frame.size.width / 2) - 15, 230);
        paddingSize = CGSizeMake(10.f, 10.f);
        rcBarH = 90.0;
        rcGrapY = 200.0;
        rcButtonW = 80.0;
        imgPHW01 = 40.0;
        imgPHW02 = 25.0;
    }
}
- (void)initial {

 
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:tempWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [tempWindow addSubview:hud];
    [hud show:YES];
    
    [self.gridView removeFromSuperview];
    
    CGRect parentFrame = self.view.bounds;
    self.gridView = [[KKGridView alloc] initWithFrame:CGRectMake(parentFrame.origin.x, parentFrame.origin.y , parentFrame.size.width, parentFrame.size.height)];
    self.gridView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    [self.view addSubview:self.gridView];
    
    //CGFloat scWidth = (self.view.frame.size.width / 2) - 15;
    //CGFloat scHeiht = 230;//(self.view.frame.size.height / 2) - 30;
    self.gridView.cellSize = cellSize;
    self.gridView.cellPadding = paddingSize;
    self.gridView.allowsMultipleSelection = NO;
    //self.gridView.scrollsToTop = YES;
    self.gridView.backgroundColor = [UIColor clearColor];

    
    __weak UserLiveViewController *weakSelf = self;
    
    
    [[UserManager shareIntance] getStreamDataByID:nil userID:appDelegate.followData.userId Completion:^(NSError *error, NSArray *streamRecords,BOOL success) {
        
        NSLog(@"================================================");
        [hud hide:YES];
        if (success) {
            weakSelf.streamList = streamRecords;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [weakSelf.gridView reloadData];

        
    }];
//    [[DataManager shareManager] getStreamingWithCompletionBlock:^(BOOL success, NSArray *streamRecords, NSError *error) {
//        
//        
//        [hud hide:YES];
//        if (success) {
//            weakSelf.streamList = streamRecords;
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            /*
//             CGFloat xLbl = (weakSelf.view.bounds.size.width / 2) - 100;
//             UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(xLbl, 20, 200, 25)];
//             lblTitle.text = NotConnect;
//             lblTitle.textAlignment = NSTextAlignmentCenter;
//             [weakSelf.view addSubview:lblTitle];
//             */
//            //NSLog(@"%@",error);
//        }
//        
//        [weakSelf.gridView reloadData];
//    }];
    
}


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
    //return _fillerData.count;
}
- (void)gridView:(KKGridView *)gridView willDisplayCell:(KKGridViewCell *)cell atIndexPath:(KKIndexPath *)indexPath{
    //    CGFloat pedding ;
    //    pedding = gridView.cellPadding;
    //    gridView.cellSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2 - 50, 500);
    
    
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
    
   // Avatar = [NSString stringWithFormat:@"%@",stream.avatarUrl];
    
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
    cell.imgSnapshot.hnk_cacheFormat = format;
    
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
    cell.editLivestream.hidden = true;
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
- (void)cellViewClick:(UITapGestureRecognizer *)tapGR {
    
    MyStreamingCell *cell = (MyStreamingCell *)tapGR.view;
    NSLog(@"cellTag:%@",tapGR.view);
    //    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    //    appDelegate.pageName = @"mylivestream";
    StreamingDetailViewController *streamingDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"streamingdetail"];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    Streaming *stream = [self.streamList objectAtIndex:cell.cellTag];
    streamingDetail.objStreaming = stream;
    
    //    streamingDetail.streamingID =
    streamingDetail.streamingType = @"mylivestream";
    
   // [self.view.window.rootViewController presentViewController:streamingDetail animated:YES completion:nil];
    
    [self presentViewController:streamingDetail animated:YES completion:nil];

    
}

- (void)goProfile:(id)sender
{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    UserTag = [tapRecognizer.view tag];
    
   // StreamingCell *cell = (StreamingCell *)tapRecognizer.view;
    
//    UserProfileViewController *userprofile = [self.storyboard instantiateViewControllerWithIdentifier:@"userprofile"];
//    
//    [self.view.window.rootViewController presentViewController:userprofile animated:YES completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
