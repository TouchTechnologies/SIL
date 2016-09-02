//
//  StreamingDetailViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/26/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "StreamingDetailViewController.h"
#import "VKVideoPlayer.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreLocation/CoreLocation.h>
#import "Streaming.h"
#import "Haneke.h"
#import "CommentViewController.h"
#import "UserProfileViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"

#import "DataManager.h"
#import "SeeItLiveThailand-Swift.h"
#import "LiveAroundViewController.h"
#import "MBProgressHUD.h"

@interface StreamingDetailViewController ()<VKVideoPlayerDelegate , UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    
    CGFloat fontSize;
    CGFloat bottomHeight;
    
    CGRect topViewPortRect;
    CGRect topViewLandRect;
    
    CGRect propViewPortRect;
    CGRect propViewLandRect;
    
    CGRect vdoLabelPortRect;
    CGRect vdoLabelLandRect;
    
    CGRect imgPinPortRect;
    CGRect imgPinLandRect;
    
    CGRect imgLivePortRect;
    CGRect imgLiveLandRect;
    
    CGRect lblLocationDescRect;
    CGRect streamUserLandRect;
    
    CGRect lblViewCountPortRect;
    CGRect lblViewCountLandRect;
    
    //    CGRect lblViewPortRect;
    //
    
    CGRect imgViewIconPortRect;
    CGRect imgViewIconLandRect;
    
    CGRect btnLovePortRect;
    CGRect btnLoveLandRect;
    
    CGRect lblLoveCountPortRect;
    CGRect lblLoveCountLandRect;
    
    
    CGRect shareimgPortRect;
    CGRect shareimgLandRect;
    
    CGRect imgCommentPortRect;
    CGRect imgCommentLandRect;
    
    CGRect lblCommentCountPortRect;
    CGRect lblCommentCountLandRect;
    //  CGRect lblCommentRect;
    CGRect doneButtonPortRect;
    CGRect doneButtonLandRect;
    
    CGRect imgLoveIconPortRect;
    CGRect imgLoveIconLandRect;
    
    CGRect lblLocationLivePortRect;
    CGRect lblLocationLiveLandRect;
    
    CGRect profileViewRect;
    CGRect chatViewLandRect;
    
    CGRect mapImgRect;
    
    CGRect tableHeaderViewRect;
    CGRect iconCategoryImgRect;
    CGRect categoryTypeLblRect;
    CGRect categoryDescLblRect;
    
    
    
    CGRect liveIncategoryTblRect;
    CGRect liveSnapshortImgRect;
    
    
    CGRect chatboxTxtPortRect;
    CGRect chatboxTxtLandRect;
    
    CGRect sendchatBtnPortRect;
    CGRect sendchatBtnLandRect;
    
    CGRect heartimgPortRect;
    CGRect heartimgLandRect;
    
    CGRect chatButtonLandRect;
    
    CGRect shareBtnPortRect;
    CGRect shareBtnLandRect;
    
    CGFloat cellH;
    
    CGRect lblcategoryDescRect;
    CGRect lblcategoryTypeRect;
    
    CGRect AvatarRect;
    CGRect followerCountLblRect;
    CGRect usernameLblRect;
    CGRect followerLblRect;
    
    CGRect waterMarkRect;
    CGRect streamTitleCellLblRect;
    CGRect categoryTitleCellLblRect;
    CGRect categoryTypeCellLblRect;
    CGRect imgLoveCellRect;
    CGRect loveCountCellLblRect;
    CGRect userAvatarCellimgRect;
    
    CGRect moreBtnRect;
    CGRect liveAroundBtnRect;
    
    CGRect playerRect;
    CGRect playerLandRect;
    // object
    
    UIFont *font;
    UILabel *lblLocationLive;
    UILabel *streamingTitle;
    UILabel *liveStreamLocationLbl;
    UIImageView *imgPin;
    UIView *topView;
    UIView *propViewPort;
    UIImageView *imgPinLive;
    
    UILabel *lblcategoryDesc;
    UILabel *lblcategoryType;
    
    
    
    UIImageView *mapImg;
    UIButton *liveAroundBtn;
    
    UIView *profileView;
    UITableView *liveIncategoryTbl;
    UITextField *chatboxTxt;
    UIButton *sendchatBtn;
    
    UIImageView *avatarImg;
    UILabel *followerCountLbl;
    UILabel *usernameLbl;
    UILabel *followerLbl;
    
    UIView *tableHeaderView;
    UIImageView *iconCategoryImg;
    UILabel *categoryTypeLbl;
    UILabel *categoryDescLbl;
    
    //UITableViewCell *cell;
    
    UIImageView *imgCommentIcon;
    UILabel *lblCommentCount;
    UIImageView *imgViewIcon;
    UILabel *lblViewCount;
    UILabel *lblLocationDesc;
    UIImageView *imgLive;
    UIButton *btnLove;
    UILabel *lblLove;
    UITextField *loveCount;
    UIImageView *heartimg ;
    UIImageView *imgLoveIcon;
    
    UITableViewCell *cell;
    
    UIButton *chatBtn;
    UIButton *chaticonImg;
    
    UIButton *shareBtn;
    UIImageView *shareImg;
    
    UIImageView *liveSnapshortImg;
    UIImageView *waterMark;
    UILabel *streamTitleCellLbl;
    UILabel *categoryTitleCellLbl;
    UILabel *categoryTypeCellLbl;
    UIImageView *imgLoveCell;
    UILabel *loveCountCellLbl;
    UIImageView *userAvatarCellimg;
    
    UIButton *livearoungBtn;
    IBOutlet UIScrollView *scrollView;
    AppDelegate *appDelegate;
    SocketIOClient *socket;
    int *count;
}
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic, strong) VKVideoPlayer* player;


@end

@implementation StreamingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Fix Port
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    [self initialSize];
    [self initial];
    [self setVideoData];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"IS FULLSCREEN DIDLOAD ::: %@" , self.player.isFullScreen ? @"true":@"false");
    self.player.delegate = self;
    chatboxTxt.delegate = self;
    liveIncategoryTbl.delegate = self;
    liveIncategoryTbl.dataSource = self;
    scrollView.delegate = self;
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    [self getCategoryList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshList:)
                                                 name:@"refresh"
                                               object:nil];
    
    
}
- (void)orientationChanged:(NSNotification *)note
{
    
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            NSLog(@"IS FULL? ::: %@", self.player.isFullScreen ? @"true":@"false");
            NSLog(@"1!");
            if (!self.player.isFullScreen){
                ///////////////////// Port ///////////////////////////
                
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    [self.player.view addSubviewForControl:streamingTitle toView:topView];
//                    [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
//                    [self.player.view addSubviewForControl:lblcategoryType toView:topView];
//                    
//                }
//                else {
                    //[self.view setFrameHeight:self.view.bounds.size.height];
                
                    [self.player.view setFrame: playerRect];
                    [topView setFrame: topViewPortRect];
                    [btnLove setFrame:btnLovePortRect];
                
                    topView.hidden = FALSE;
                    self.player.view.topControlOverlay.hidden = FALSE;
                    self.player.view.doneButton.hidden = FALSE;
                    self.player.view.fullscreenButton.hidden = FALSE ;
                
                    [topView addSubview:btnLove];
                    self.player.isFullScreen = TRUE;
//}

            }
            else{
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    [topView setFrameWidth:[UIScreen mainScreen].bounds.size.height];
//                    [btnLove setFrame:CGRectMake(topView.bounds.size.width - 110, 10, 100, 100)];
//                    [topView addSubview:btnLove];
//                    topView.hidden = FALSE;
//                    
//                }
//                else {
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.doneButton.hidden = FALSE;
                self.player.view.fullscreenButton.hidden = FALSE ;
                topView.hidden = FALSE;
                
                [self.player.view setFrame: playerRect];
                [topView setFrame: topViewPortRect];
                [btnLove setFrame:btnLovePortRect];
                [topView addSubview:btnLove];
                self.player.isFullScreen = FALSE;

            }
            break;
            
        case UIDeviceOrientationFaceUp:
            NSLog(@"IS FULL???? 2 ::: %@", self.player.isFullScreen ? @"true":@"false");
            if (!self.player.isFullScreen){
                ///////////////////// Port ///////////////////////////
                //                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                //                    self.player.view.topControlOverlay.hidden = TRUE;
                //                    [self.player.view addSubviewForControl:streamingTitle toView:topView];
                //                    [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
                //                    [self.player.view addSubviewForControl:lblcategoryType toView:topView];
                //
                //                }
                //                else {
                //
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.doneButton.hidden = FALSE;
                self.player.view.fullscreenButton.hidden = FALSE ;
                topView.hidden = FALSE;
                
                [self.player.view setFrame: playerRect];
                [topView setFrame: topViewPortRect];
                [btnLove setFrame:btnLovePortRect];
                [topView addSubview:btnLove];
                self.player.isFullScreen = TRUE;
            }
            else{
                
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.doneButton.hidden = TRUE;
                self.player.view.videoQualityButton.hidden = TRUE;
                topView.hidden = TRUE;
                
                [btnLove setFrame:btnLoveLandRect];
                [ self.player.view.topControlOverlay addSubview:btnLove];
          
                self.player.isFullScreen = FALSE;

            }
//            if (self.player.isFullScreen == FALSE){
//                               
//            }
//            else{
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    [topView setFrameWidth:[UIScreen mainScreen].bounds.size.height];
//                    [btnLove setFrame:CGRectMake(topView.bounds.size.width - 110, 10, 100, 100)];
//                    [topView addSubview:btnLove];
//                    topView.hidden = FALSE;
//                    
//                }
//                else {
//                    self.player.view.topControlOverlay.hidden = FALSE;
//                    [self.view setFrameHeight:self.view.bounds.size.height];
//                    topView.hidden = FALSE;
//                    [ self.player.view.topControlOverlay addSubview:btnLove];
//                }
//                [self.player.view setFrame: playerRect];
//                [topView setFrame: topViewPortRect];
//                self.player.view.doneButton.hidden = FALSE;
//                self.player.view.fullscreenButton.hidden = FALSE ;
//                [btnLove setFrame:btnLovePortRect];
//                [topView addSubview:btnLove];
//                topView.hidden = FALSE;
//                self.player.isFullScreen = TRUE;
//            }
            NSLog(@"IS FULL? ::: %@", self.player.isFullScreen ? @"true":@"false");
            NSLog(@"2!");
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"IS FULL? ::: %@", self.player.isFullScreen ? @"true":@"false");
            NSLog(@"3!");
            if (!self.player.isFullScreen){
                ///////////////////// Port ///////////////////////////
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.videoQualityButton.hidden = TRUE;
                [btnLove setFrame:btnLoveLandRect];
                [ self.player.view.topControlOverlay addSubview:btnLove];
                topView.hidden = TRUE;

                self.player.view.doneButton.hidden = TRUE;
                self.player.view.videoQualityButton.hidden = TRUE;
                self.player.isFullScreen = TRUE;
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    [self.player.view addSubviewForControl:streamingTitle toView:topView];
//                    [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
//                    [self.player.view addSubviewForControl:lblcategoryType toView:topView];
//                    
//                }
//                else {
                
//                    self.player.view.topControlOverlay.hidden = FALSE;
//                    [self.view setFrameHeight:self.view.bounds.size.height];
//                    
//                //}
//                
//                [self.player.view setFrame: playerRect];
//                [topView setFrame: topViewPortRect];
//                self.player.view.doneButton.hidden = FALSE;
//                self.player.view.fullscreenButton.hidden = FALSE ;
//                [btnLove setFrame:btnLovePortRect];
//                [topView addSubview:btnLove];
//                topView.hidden = FALSE;
//                self.player.isFullScreen = TRUE;
                
//            }
//            else{
//                ///////////////////// Port ///////////////////////////
//                
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    [self.player.view addSubviewForControl:streamingTitle toView:topView];
//                    [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
//                    [self.player.view addSubviewForControl:lblcategoryType toView:topView];
//                    
              }
              else {
                
                  self.player.view.topControlOverlay.hidden = FALSE;
                  self.player.view.videoQualityButton.hidden = TRUE;
                  self.player.view.doneButton.hidden = TRUE;
                  
                  [btnLove setFrame:btnLoveLandRect];
                  [ self.player.view.topControlOverlay addSubview:btnLove];
                  topView.hidden = TRUE;
                  
                  self.player.isFullScreen = FALSE;
            }
    
    
            break;
        case UIDeviceOrientationLandscapeRight:
            // Land
            NSLog(@"IS FULL? ::: %@", self.player.isFullScreen ? @"true":@"false");
            NSLog(@"4!");
            if (!self.player.isFullScreen) {
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    self.player.view.videoQualityButton.hidden = TRUE;
//                    [topView setFrameWidth:[UIScreen mainScreen].bounds.size.height];
//                    [btnLove setFrame:CGRectMake(topView.bounds.size.width - 110, 10, 100, 100)];
//                    [topView addSubview:btnLove];
//                    topView.hidden = FALSE;
//                    
//                }
//                else {
                    self.player.view.topControlOverlay.hidden = FALSE;
                    self.player.view.videoQualityButton.hidden = TRUE;
                    self.player.view.doneButton.hidden = TRUE;
                
                    [btnLove setFrame:btnLoveLandRect];
                    [ self.player.view.topControlOverlay addSubview:btnLove];
                    topView.hidden = TRUE;
                    self.player.isFullScreen = TRUE;
            }
            else{
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.videoQualityButton.hidden = TRUE;
                self.player.view.doneButton.hidden = TRUE;
                
                [btnLove setFrame:btnLoveLandRect];
                [ self.player.view.topControlOverlay addSubview:btnLove];
                topView.hidden = TRUE;
       
                self.player.isFullScreen = FALSE;

//                self.player.view.topControlOverlay.hidden = FALSE;
//                [self.view setFrameHeight:self.view.bounds.size.height];
//                
//                // }
//                
//                [self.player.view setFrame: playerRect];
//                [topView setFrame: topViewPortRect];
//                self.player.view.doneButton.hidden = FALSE;
//                self.player.view.fullscreenButton.hidden = FALSE ;
//                [btnLove setFrame:btnLovePortRect];
//                [topView addSubview:btnLove];
//                topView.hidden = FALSE;
//                self.player.isFullScreen = FALSE;

            }

            break;
        case UIDeviceOrientationLandscapeLeft:
            // Land
            NSLog(@"IS FULL? ::: %@", self.player.isFullScreen ? @"true":@"false");
            NSLog(@"5!");
            if (!self.player.isFullScreen) {
             //   if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    self.player.view.topControlOverlay.hidden = TRUE;
//                    self.player.view.videoQualityButton.hidden = TRUE;
//                    [topView setFrameWidth:[UIScreen mainScreen].bounds.size.height];
//                    [btnLove setFrame:CGRectMake(topView.bounds.size.width - 110, 10, 100, 100)];
//                    [topView addSubview:btnLove];
//                    topView.hidden = FALSE;
                
//                }
//                else {
                    self.player.view.topControlOverlay.hidden = FALSE;
                    self.player.view.videoQualityButton.hidden = TRUE;
                    self.player.view.doneButton.hidden = TRUE;
                
                    [btnLove setFrame:btnLoveLandRect];
                    [ self.player.view.topControlOverlay addSubview:btnLove];
                    topView.hidden = TRUE;
       
                    self.player.isFullScreen = TRUE;
            }
            else{
                
                
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.videoQualityButton.hidden = TRUE;
                self.player.view.doneButton.hidden = TRUE;
                
                [btnLove setFrame:btnLoveLandRect];
                [ self.player.view.topControlOverlay addSubview:btnLove];
                topView.hidden = TRUE;

                self.player.isFullScreen = FALSE;
                
            }
                break;
        default:
            NSLog(@"IS FULL? ::: %@", self.player.isFullScreen ? @"true":@"false");
            NSLog(@"6!");

            if (!self.player.isFullScreen){
                ///////////////////// Port ///////////////////////////
                
                //                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                //                    self.player.view.topControlOverlay.hidden = TRUE;
                //                    [self.player.view addSubviewForControl:streamingTitle toView:topView];
                //                    [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
                //                    [self.player.view addSubviewForControl:lblcategoryType toView:topView];
                //
                //                }
                //                else {
                //
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.doneButton.hidden = FALSE;
                self.player.view.fullscreenButton.hidden = FALSE ;
                
                [self.view setFrameHeight:self.view.bounds.size.height];
                [self.player.view setFrame: playerRect];
                [topView setFrame: topViewPortRect];
                [btnLove setFrame:btnLovePortRect];
                [topView addSubview:btnLove];
                
                topView.hidden = FALSE;
                self.player.isFullScreen = TRUE;
       
            }
            else{
                //                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                //                    self.player.view.topControlOverlay.hidden = TRUE;
                //                    [topView setFrameWidth:[UIScreen mainScreen].bounds.size.height];
                //                    [btnLove setFrame:CGRectMake(topView.bounds.size.width - 110, 10, 100, 100)];
                //                    [topView addSubview:btnLove];
                //                    topView.hidden = FALSE;
                //
                //                }
                //                else {
                self.player.view.topControlOverlay.hidden = FALSE;
                self.player.view.doneButton.hidden = FALSE;
                self.player.view.fullscreenButton.hidden = FALSE ;
                
                [self.view setFrameHeight:self.view.bounds.size.height];
                [ self.player.view.topControlOverlay addSubview:btnLove];
                [self.player.view setFrame: playerRect];
                [topView setFrame: topViewPortRect];
                [btnLove setFrame:btnLovePortRect];
                [topView addSubview:btnLove];
                
                topView.hidden = FALSE;
                self.player.isFullScreen = FALSE;
            }
                break;
    };
}
- (void)getCategoryList
{
    __weak StreamingDetailViewController *weakSelf = self;
    weakSelf.streamList = [[NSArray alloc]init];
    
    NSString *filter = [@"?" stringByAppendingFormat:@"filters[stream_media][category_id][operator]==&filters[stream_media][category_id][value]=%d&filtersPage=1&filterLimit=30",self.objStreaming.categoryID];
    NSLog(@"FILTER1 ::: %@",filter);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[DataManager shareManager] getStreamingWithCompletionBlockWithFilterCat:^(BOOL success, NSArray *streamRecords, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success) {
            weakSelf.streamList = streamRecords;
            NSLog(@"STREAMLIST COUNT Cate :::: %ld", (unsigned long)weakSelf.streamList.count);
            [scrollView addSubview:liveIncategoryTbl];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        [liveIncategoryTbl reloadData];
        
    } Filter:filter];
    
    
}

- (void)initial{
    
    self.player = [[VKVideoPlayer alloc] init];
    profileView.hidden = FALSE;
    
    CGFloat ss;
    ss = 100;
    self.player.view.doneButton.hidden = FALSE;
    // if (!self.player.isFullScreen) {
    self.player.view.frame = playerRect;
    NSLog(@"Player Height : %f", self.player.view.frame.size.height);
    NSLog(@"NOT FULLSCREEN");
    self.player.view.doneButton.frame = doneButtonPortRect;
    UIImage *back = [[UIImage alloc] init];
    back = [UIImage imageNamed:@"back.png"];
    [self.player.view.doneButton setImage:back forState:UIControlStateNormal];
    //self.player.isFullScreen = TRUE;
    //    }
    //    else{
    //
    //    }
    self.player.view.playerControlsAutoHideTime = @5;

    self.player.view.fullscreenButton.hidden = FALSE;
    self.player.view.nextButton.hidden = TRUE;
    self.player.view.rewindButton.hidden = TRUE;
    self.player.view.isControlsEnabled = FALSE;
    self.player.view.bottomControlOverlay.hidden = FALSE;
    self.player.view.topControlOverlay.hidden = FALSE;
    self.player.view.videoQualityButton.hidden = TRUE;
    
    [self.player.view.totalTimeLabel setFrameOriginX:CGRectGetWidth(self.player.view.bottomControlOverlay.frame) - self.player.view.totalTimeLabel.frame.size.width - self.player.view.fullscreenButton.frame.size.width - 5];
    
    
    
    
    
    propViewPort = [[UIView alloc] initWithFrame:propViewPortRect];
    propViewPort.backgroundColor = [UIColor blackColor];
    
    //[self.player.view addSubviewForControl:propViewPort toView:self.view];
    [self.view addSubview:propViewPort];
    [self.view addSubview:self.player.view];
    
    
    topView = [[UIView alloc] initWithFrame:topViewPortRect];
    topView.backgroundColor = [UIColor blackColor];
    [topView addSubview:self.player.view.doneButton];
    // [self.player.view addSubviewForControl:topView toView:self.view];
    [self.view addSubview:topView];
    
    font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    streamingTitle = [[UILabel alloc] initWithFrame:vdoLabelPortRect];
    streamingTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //steamingTitle.text = self.objStreaming.streamTitle;
    
    streamingTitle.textColor = [UIColor whiteColor];
    streamingTitle.backgroundColor = [UIColor clearColor];
    streamingTitle.textAlignment = NSTextAlignmentLeft;
    streamingTitle.font =  [UIFont fontWithName:@"Helvetica" size: fontSize];
    
    lblcategoryDesc = [[UILabel alloc] initWithFrame:lblcategoryDescRect];
    lblcategoryDesc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblcategoryDesc.text = @"Category : " ;
    lblcategoryDesc.textColor = [UIColor grayColor];
    lblcategoryDesc.backgroundColor = [UIColor clearColor];
    lblcategoryDesc.textAlignment = NSTextAlignmentLeft;
    lblcategoryDesc.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    
    lblcategoryType = [[UILabel alloc] initWithFrame:lblcategoryTypeRect];
    lblcategoryType.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //  lblcategoryType.text = self.objStreaming.categoryName;
    lblcategoryType.textColor = [UIColor redColor];
    lblcategoryType.backgroundColor = [UIColor clearColor];
    lblcategoryType.textAlignment = NSTextAlignmentLeft;
    lblcategoryType.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    
    //
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [self.player.view addSubviewForControl:streamingTitle toView:topView];
        [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
        [self.player.view addSubviewForControl:lblcategoryType toView:topView];
        self.player.view.topControlOverlay.hidden = TRUE;
            self.player.forceRotate = NO;
        self.player.view.fullscreenButton.hidden = TRUE;
        
    }
    else{
        self.player.view.topControlOverlay.hidden = FALSE;
        [self.player.view.topControlOverlay addSubview:streamingTitle];
        [self.player.view.topControlOverlay addSubview:lblcategoryDesc];
        [self.player.view.topControlOverlay addSubview:lblcategoryType];
            self.player.forceRotate = YES;
        
    }
    
    lblLocationDesc = [[UILabel alloc] initWithFrame:lblLocationDescRect];
    lblLocationDesc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblLocationDesc.text = @"Location : " ;
    lblLocationDesc.textColor = [UIColor grayColor];
    //colorWithRed:0.241 green:0.241 blue:0.241 alpha:1];
    lblLocationDesc.backgroundColor = [UIColor clearColor];
    lblLocationDesc.textAlignment = NSTextAlignmentLeft;
    lblLocationDesc.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    [propViewPort addSubview:lblLocationDesc];
    
    lblLocationLive = [[UILabel alloc] initWithFrame:lblLocationLivePortRect];
    lblLocationLive.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblLocationLive.text = @"live location";
    lblLocationLive.textColor = [UIColor redColor];
    lblLocationLive.backgroundColor = [UIColor clearColor];
    lblLocationLive.textAlignment = NSTextAlignmentLeft;
    lblLocationLive.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    [propViewPort addSubview:lblLocationLive];
    
    UITapGestureRecognizer* goProfile = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(goProfile:)];
    //[goProfile setNumberOfTouchesRequired:1];
    //goProfile.enabled = YES;
    [imgLive addGestureRecognizer:goProfile];
    [lblLocationDesc addGestureRecognizer:goProfile];
    
    btnLove = [[UIButton alloc] initWithFrame:btnLovePortRect];
    btnLove.userInteractionEnabled = YES;
    [btnLove setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
    
    [topView addSubview:btnLove];
    
    
    chatBtn = [[UIButton alloc] init];
    chatBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    chatBtn.contentMode = UIViewContentModeScaleAspectFit;
    [chatBtn setImage:[UIImage imageNamed:@"chat.png"] forState: UIControlStateNormal];
    //    UITapGestureRecognizer* TapChat = [[UITapGestureRecognizer alloc]
    //                                       initWithTarget:self action:@selector(tapchat:)];
    //    [TapChat setNumberOfTouchesRequired:1];
    //    [TapChat setDelegate:self];
    [chatBtn addTarget:self action:@selector(startChat:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    shareBtn = [[UIButton alloc] initWithFrame:shareBtnPortRect];
    shareImg = [[UIImageView alloc] initWithFrame:shareimgPortRect];
    shareImg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    shareImg.contentMode = UIViewContentModeScaleAspectFit;
    shareImg.image = [UIImage imageNamed:@"share_2.png"];
    [shareBtn addSubview:shareImg];
    [propViewPort addSubview:shareBtn];
    
    imgViewIcon = [[UIImageView alloc] initWithFrame:imgViewIconPortRect];
    imgViewIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    imgViewIcon.contentMode = UIViewContentModeScaleAspectFit;
    imgViewIcon.image = [UIImage imageNamed:@"view_2.png"];
    [propViewPort addSubview:imgViewIcon];
    
    lblViewCount = [[UILabel alloc] initWithFrame:lblViewCountPortRect];
    lblViewCount.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    lblViewCount.text = self.objStreaming.streamTotalView;
    lblViewCount.textColor = [UIColor whiteColor];
    lblViewCount.backgroundColor = [UIColor clearColor];
    lblViewCount.textAlignment = NSTextAlignmentLeft;
    lblViewCount.font = font;
    [propViewPort addSubview:lblViewCount];
    
    
    
    
    //  btnLove = [[UIButton alloc] initWithFrame:btnLoveRect];
    imgLoveIcon = [[UIImageView alloc] initWithFrame:imgLoveIconPortRect];
    imgLoveIcon.image = [UIImage imageNamed:@"love_noti.png"];
    imgLoveIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    imgLoveIcon.contentMode = UIViewContentModeScaleToFill;
    [propViewPort addSubview:imgLoveIcon];
    
    //[self.player.view addSubviewForControl:btnLove];
    //[propViewPort addSubview:btnLove];
    
    loveCount = [[UITextField alloc] initWithFrame:lblLoveCountPortRect];
    //    [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
    loveCount.textColor = [UIColor whiteColor];
    //  loveCount.backgroundColor = [UIColor whiteColor];
    loveCount.textAlignment = NSTextAlignmentLeft;
    loveCount.font = font;
    loveCount.enabled = NO;
    [propViewPort addSubview:loveCount];
    
    
    
    //    NSLog(@"isLove : %d",self.objStreaming.isLoved);
    //    if (self.objStreaming.isLoved)
    //    {
    //        [btnLove setImage:[UIImage imageNamed:@"ic_love2.png"] forState:UIControlStateNormal];
    //    }
    //    else
    //    {
    //       [btnLove setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
    //    }
    
    
    
    UITapGestureRecognizer* TapLove = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(loveSend:)];
    [TapLove setNumberOfTouchesRequired:1];
    [TapLove setDelegate:self];
    
    
    UITapGestureRecognizer* TapLogin = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(login:)];
    [TapLogin setNumberOfTouchesRequired:1];
    [TapLogin setDelegate:self];
    if (appDelegate.isLogin) {
        
        NSLog(@"not login");
        TapLove.enabled = NO;
        TapLogin.enabled = YES;
        [btnLove addGestureRecognizer:TapLogin];
        
    }
    else{
        NSLog(@"login");
        [btnLove addGestureRecognizer:TapLove];
        TapLove.enabled = YES;
        TapLogin.enabled = NO;
    }
    
    UITapGestureRecognizer* TapShare = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(shareStream:)];//Here should be actionViewTap:
    [TapShare setNumberOfTouchesRequired:1];
    [TapShare setDelegate:self];
    shareBtn.userInteractionEnabled = YES;
    [shareBtn addGestureRecognizer:TapShare];
    TapShare.enabled = YES;
    
 
    
    imgCommentIcon = [[UIImageView alloc] initWithFrame:imgCommentPortRect];
    imgCommentIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    imgCommentIcon.contentMode = UIViewContentModeScaleToFill;
    imgCommentIcon.image = [UIImage imageNamed:@"massege.png"];
    
    //  [btnComment addSubview:imgCommentIcon];
    [propViewPort addSubview:imgCommentIcon];
    
    lblCommentCount = [[UILabel alloc] initWithFrame:lblCommentCountPortRect];
    lblCommentCount.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    lblCommentCount.text = (self.objStreaming.count_comment != nil)?[NSString stringWithFormat:@"%@" ,self.objStreaming.count_comment]:@"0";
    lblCommentCount.textColor = [UIColor whiteColor];
    lblCommentCount.backgroundColor = [UIColor clearColor];
    lblCommentCount.textAlignment = NSTextAlignmentLeft;
    lblCommentCount.font = font;
    [propViewPort addSubview:lblCommentCount];
    
   
    
    //    NSLog(@"Map URL : %@",mapURL);
    mapImg = [[UIImageView alloc] initWithFrame:mapImgRect];
    //    mapImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mapURL]]];
    mapImg.backgroundColor = [UIColor greenColor];
    //    [scrollView addSubview:mapImg];
    
    
    profileView = [[UIView alloc] initWithFrame:profileViewRect];
    profileView.backgroundColor = [UIColor blackColor];
    
    avatarImg = [[UIImageView alloc] initWithFrame:AvatarRect];
    avatarImg.image = [UIImage imageNamed:@"anonymous.png"];
    avatarImg.layer.cornerRadius = AvatarRect.size.width/2;
    avatarImg.clipsToBounds = YES;
    [profileView addSubview:avatarImg];
    
    usernameLbl = [[UILabel alloc]initWithFrame:usernameLblRect];
    // usernameLbl.text = self.objStreaming.streamUserName;
    usernameLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    usernameLbl.textColor = [UIColor whiteColor];
    [profileView addSubview:usernameLbl];
    
    followerLbl = [[UILabel alloc]initWithFrame:followerLblRect];
    followerLbl.text = @"follower : ";
    followerLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    followerLbl.textColor = [UIColor grayColor];
    [profileView addSubview:followerLbl];
    
    followerCountLbl = [[UILabel alloc]initWithFrame:followerCountLblRect];
    //    followerCountLbl.text = self.objStreaming.streamUserFollowerCount;
    followerCountLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    followerCountLbl.textColor = [UIColor redColor];
    [profileView addSubview:followerCountLbl];
    
    [scrollView addSubview:profileView];
    
    tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderViewRect];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    iconCategoryImg = [[UIImageView alloc] initWithFrame:iconCategoryImgRect];
    iconCategoryImg.image = (self.objStreaming.categoryImage != nil)?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.categoryImage]]]:[UIImage imageNamed:@"blank.png"];
    iconCategoryImg.layer.cornerRadius = iconCategoryImgRect.size.width/2;
    iconCategoryImg.clipsToBounds = YES;
    [tableHeaderView addSubview:iconCategoryImg];
    
    categoryTypeLbl = [[UILabel alloc]initWithFrame:categoryTypeLblRect];
    categoryTypeLbl.text = self.objStreaming.categoryName;
    categoryTypeLbl.textAlignment = NSTextAlignmentCenter;
    categoryTypeLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    categoryTypeLbl.textColor = [UIColor redColor];
    [tableHeaderView addSubview:categoryTypeLbl];
    
    categoryDescLbl = [[UILabel alloc]initWithFrame:categoryDescLblRect];
    categoryDescLbl.text = @"Recommended video in category";
    categoryDescLbl.textAlignment = NSTextAlignmentCenter;
    categoryDescLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryDescLbl.textColor = [UIColor grayColor];
    [tableHeaderView addSubview:categoryDescLbl];
    
    [scrollView addSubview:tableHeaderView];
    
    
    
    liveIncategoryTbl = [[UITableView alloc] initWithFrame:liveIncategoryTblRect];
    liveIncategoryTbl.backgroundColor = [UIColor whiteColor];
    [liveIncategoryTbl registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
    
    
    livearoungBtn = [[UIButton alloc] initWithFrame: moreBtnRect];
    livearoungBtn.layer.borderWidth = 1;
    livearoungBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    livearoungBtn.backgroundColor = [UIColor redColor];
    livearoungBtn.layer.cornerRadius = moreBtnRect.size.height/2;
    livearoungBtn.clipsToBounds = YES;
    [livearoungBtn setTitle:@"Live Around" forState:UIControlStateNormal];
    [livearoungBtn addTarget:self action:@selector(clickmore:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:livearoungBtn];
    
    
}

- (void)setVideoData
{
    CLLocation* location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake([self.objStreaming.latitude floatValue], [self.objStreaming.longitude floatValue]) altitude:0 horizontalAccuracy:0 verticalAccuracy:0 course:0 speed:0 timestamp:nil];
    
    [self getAddressFromLocation:location];
    
    NSLog(@"streamID %@",self.objStreaming.ID);
    
    [self setSocket:[self.objStreaming.ID intValue]];
    
    streamingTitle.text = self.objStreaming.streamTitle;
    lblcategoryType.text = self.objStreaming.categoryName;
    lblViewCount.text = self.objStreaming.streamTotalView;
    [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
    if (self.objStreaming.isLoved)
    {
        [btnLove setImage:[UIImage imageNamed:@"ic_love2.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnLove setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
    }
    lblCommentCount.text = (self.objStreaming.count_comment != nil)?[NSString stringWithFormat:@"%@" ,self.objStreaming.count_comment]:@"0";
    
    NSString *mapURL = [@"https://maps.googleapis.com/maps/api/staticmap?center=" stringByAppendingString:[self.objStreaming.latitude stringByAppendingString:[@"," stringByAppendingString:[self.objStreaming.longitude stringByAppendingString:[@"&zoom=15&size=800x150&markers=color:red%7C" stringByAppendingString:[self.objStreaming.latitude stringByAppendingString:[@"," stringByAppendingString:[self.objStreaming.longitude stringByAppendingString:@"&key=AIzaSyAimot0aIsIsItn1F_BYXy6YVG-2Jc8MYs"]]]]]]]];
    mapImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mapURL]]];
    //    [scrollView removeFromSuperview];
    if(([self.objStreaming.latitude doubleValue] != 0.0 ) && ([self.objStreaming.longitude doubleValue] != 0.0))
    {
        [scrollView reloadInputViews];
        NSLog(@"set map lat : %f long : %f",[self.objStreaming.latitude doubleValue],[self.objStreaming.longitude doubleValue]);
        [scrollView addSubview:mapImg];
        [scrollView addSubview:livearoungBtn];
        
    }
    else{
        
        [scrollView reloadInputViews];
        [scrollView setFrame:CGRectMake(0, -mapImgRect.size.height, self.view.bounds.size.height,  self.view.bounds.size.height-(-mapImgRect.size.height))];
    }
    avatarImg.image = (self.objStreaming.streamUserImage != nil)?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.streamUserImage]]]:[UIImage imageNamed:@"anonymous.png"];
    
    usernameLbl.text = self.objStreaming.createBy;
    followerCountLbl.text = self.objStreaming.streamUserFollowerCount;
    
}
- (void)shareStream:(id)sender
{
    NSLog(@"ShareMyStream TAP");
    
    NSString * shareUrl = self.objStreaming.web_url;
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

- (void)clickmore :(id)sender{
    NSLog(@"GO LIVEAROUND");
 LiveAroundViewController *livearound = [self.storyboard instantiateViewControllerWithIdentifier:@"livearound"];
    
        livearound.objStreaming = self.objStreaming;
    
    
        NSString *filter = [@"/" stringByAppendingFormat:@"nearby?at=%@,%@&distance=%d&filterLimit=%d&filtersPage=%d",self.objStreaming.latitude,self.objStreaming.longitude,20,20,1];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[DataManager shareManager] getStreamingWithCompletionBlockWithFilter:^(BOOL success, NSArray *streamRecords, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (success) {
    
    
                       livearound.rowIndex = 0;
         livearound.liveAroundData = streamRecords;
                Streaming *a = [streamRecords objectAtIndex:1];
                NSLog(@"filter LiveAround Data : %@",a.streamUrl);
  NSLog(@"filter LiveAround Data Title: %@",a.streamTitle);
         [self presentViewController: livearound animated: YES completion:nil];
    
    
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
    
        } Filter:filter];
    
    
}

- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat topviewCtr = self.player.view.topControlOverlay.bounds.size.width;
    CGFloat imgHeight;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width ;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        bottomHeight = 100.0 * scy;
        NSLog(@"TOPVIEW ::: %.2f",topviewCtr);
        fontSize = 14.0*scy;
        cellH = 100*scy;
        imgHeight = 30.0*scy;
        
        
        
        
        playerRect = CGRectMake(0*scx, 50*scy, width, 150*scy);
        topViewPortRect = CGRectMake(0*scx, 0*scy, playerRect.size.width, 50*scy);
        
        imgPinPortRect = CGRectMake(10*scx,topViewPortRect.size.height/2 - (13*scy), 25*scx, 25*scy);
        
        doneButtonPortRect = CGRectMake(10*scx, topViewPortRect.size.height/2 - (10*scy) , 30*scx, 30*scy);
        
        vdoLabelPortRect = CGRectMake(doneButtonPortRect.size.width+(10*scx) ,topViewPortRect.size.height/2 - (10*scy) , 200*scx, 20*scy);
        
        lblcategoryDescRect = CGRectMake(doneButtonPortRect.size.width + (10*scx) , topViewPortRect.size.height/2 + (8*scy), 70*scx, 15*scy);
        
        lblcategoryTypeRect = CGRectMake(lblcategoryDescRect.origin.x + (70*scx) , topViewPortRect.size.height/2 + (8*scy), topViewPortRect.size.width/2, 15*scy);
        
        propViewPortRect = CGRectMake(0*scx,playerRect.origin.y + playerRect.size.height - 2, self.view.bounds.size.width, 50*scy);
        
        imgLivePortRect = CGRectMake(20*scx, 2*scy, 35*scx, 35*scy);
        
        lblLocationDescRect = CGRectMake(10*scx , propViewPortRect.size.height - (20*scy), 60*scx, 15*scy);
        
        lblLocationLivePortRect = CGRectMake(lblLocationDescRect.origin.x + (60*scx),  propViewPortRect.size.height - (20*scy), self.view.bounds.size.width - (lblLocationDescRect.origin.x + (50*scx)), 15*scy);
        
        shareBtnPortRect = CGRectMake(propViewPortRect.size.width - (35*scx) ,  10*scy , 25*scx , 25*scy);
        
        shareimgPortRect = CGRectMake(0*scx, 0*scy, shareBtnPortRect.size.width, shareBtnPortRect.size.height);
        
        btnLovePortRect = CGRectMake(topViewPortRect.size.width - (45*scx) ,topViewPortRect.size.height/2 - (18*scy) ,35*scx,35*scy);
        btnLoveLandRect = CGRectMake(playerRect.size.width - (45*scx) , playerRect.size.height/2 - (18*scy) , 35*scx, 35*scy);
        
        heartimgPortRect = CGRectMake(0*scx, 0*scy, btnLovePortRect.size.width , btnLovePortRect.size.height );
        
        imgViewIconPortRect = CGRectMake(10*scx, 10 *scy, 20*scx, 20*scy);
        
        lblViewCountPortRect = CGRectMake(imgViewIconPortRect.origin.x + (25*scx), 13*scy , 40*scx, 15*scy);
        
        imgCommentPortRect =  CGRectMake(lblViewCountPortRect.origin.x + (45*scx) , 10*scy,20*scx,20*scy);
        lblCommentCountPortRect = CGRectMake(imgCommentPortRect.origin.x + (25*scx), 13*scy , 40*scx, 15*scy);
        
        imgLoveIconPortRect = CGRectMake(lblCommentCountPortRect.origin.x + (45*scx),10*scy ,20*scx,20*scy);
        lblLoveCountPortRect = CGRectMake(imgLoveIconPortRect.origin.x + (25*scx) , 13*scy, 40*scx, 15*scy);
        
        mapImgRect = CGRectMake(0*scx,propViewPortRect.origin.y + propViewPortRect.size.height, self.view.bounds.size.width, 70*scy);
        liveAroundBtnRect = CGRectMake(mapImgRect.size.width/2 - (40*scx), mapImgRect.size.height/2 - (15*scy), 80*scx, 30*scy);
        
        profileViewRect = CGRectMake(0*scx,propViewPortRect.origin.y + propViewPortRect.size.height  + mapImgRect.size.height, self.view.bounds.size.width, 70*scy);
        
        tableHeaderViewRect = CGRectMake(0*scx, profileViewRect.origin.y + profileViewRect.size.height, self.view.bounds.size.width, 100*scy);
        iconCategoryImgRect = CGRectMake(tableHeaderViewRect.size.width/2 - (20*scx), tableHeaderViewRect.size.height/2 - (40*scy), 40*scx, 40*scy);
        categoryTypeLblRect = CGRectMake(0*scx, tableHeaderViewRect.size.height/2 + fontSize/2, self.view.bounds.size.width, fontSize);
        categoryDescLblRect = CGRectMake(0*scx, categoryTypeLblRect.origin.y + categoryTypeLblRect.size.height + fontSize/2, self.view.bounds.size.width, fontSize - 2);
        
        
        liveIncategoryTblRect = CGRectMake(0*scx, tableHeaderViewRect.origin.y + tableHeaderViewRect.size.height , self.view.bounds.size.width ,cellH*3);
        AvatarRect = CGRectMake(10*scx, profileViewRect.size.height/2 - (20*scy) , 40*scx , 40*scy);
        
        usernameLblRect = CGRectMake(60*scx, profileViewRect.size.height/2 - fontSize, 200*scx, fontSize+(1*scy));
        followerLblRect = CGRectMake(60*scx, profileViewRect.size.height/2 + (5*scy) , 60*scx , fontSize - 2);
        followerCountLblRect = CGRectMake(120*scx , profileViewRect.size.height/2 + (5*scy) , 50*scx , fontSize - 2);
        
        liveSnapshortImgRect = CGRectMake(10 *scx, 10*scy , self.view.bounds.size.width/2 - (40*scx) , cellH - (20*scy));
        
        waterMarkRect = CGRectMake((liveSnapshortImgRect.size.width) - (imgHeight+(5*scx)), (liveSnapshortImgRect.size.height)-(imgHeight+(5*scy)), imgHeight, imgHeight);
        
        streamTitleCellLblRect = CGRectMake(self.view.bounds.size.width/2 - (20*scx), cellH/4 - (fontSize), self.view.bounds.size.width/2, fontSize+(2*scy));
        categoryTitleCellLblRect =  CGRectMake(self.view.bounds.size.width/2 - (20*scx), cellH/2 - (fontSize), 60*scy, fontSize);
        categoryTypeCellLblRect = CGRectMake(self.view.bounds.size.width/2 + (40*scx), cellH/2 - (fontSize), 100*scx, fontSize);
        imgLoveCellRect = CGRectMake(self.view.bounds.size.width/2 - (20*scx), cellH - (30*scy), 20*scx, 20*scy);
        loveCountCellLblRect = CGRectMake(self.view.bounds.size.width/2 + (5*scx) , cellH - (25*scy), 50*scx, fontSize);
        userAvatarCellimgRect = CGRectMake(self.view.bounds.size.width - (50*scx), cellH - (50*scy) , 40*scx, 40*scy);
        
        moreBtnRect = CGRectMake(self.view.bounds.size.width/2 - (60*scx), mapImgRect.origin.y +mapImgRect.size.height/2, 120*scx, 30*scy);
        
    } else {
        
        NSLog(@"TOPVIEW ::: %.2f",topviewCtr);
        fontSize = 14.0;
        cellH = 100;
        imgHeight = 30.0;
        
        
        topViewLandRect = CGRectMake(0, 0 , self.view.bounds.size.width, 30);
        playerRect = CGRectMake(0, 50, width, 200);
        playerLandRect = CGRectMake(0, 100, width, height - 100);
        topViewPortRect = CGRectMake(0, 0,playerRect.size.width, 50);
        
        
        imgPinPortRect = CGRectMake(10,topViewPortRect.size.height/2 - 13, 25, 25);
        
        doneButtonPortRect = CGRectMake(10, topViewPortRect.size.height/2 - 10 , 30, 30);
        vdoLabelPortRect = CGRectMake(10 ,5 , 200, 20);
        lblcategoryDescRect = CGRectMake(10 , 25, 60, 15);
        lblcategoryTypeRect = CGRectMake(lblcategoryDescRect.origin.x + 60 ,25, topViewPortRect.size.width/2, 15);
        propViewPortRect = CGRectMake(0,250, self.view.bounds.size.width, 50);
        imgLivePortRect = CGRectMake(20, 2, 35, 35);
        
        lblLocationDescRect = CGRectMake(10 , propViewPortRect.size.height - 20, 60, 15);
        lblLocationLivePortRect = CGRectMake(lblLocationDescRect.origin.x + 60,  propViewPortRect.size.height - 20, self.view.bounds.size.width - (lblLocationDescRect.origin.x + 50), 15);
        
        shareBtnPortRect = CGRectMake(propViewPortRect.size.width - 35 ,  10 , 25 , 25);
        shareimgPortRect = CGRectMake(0, 0, shareBtnPortRect.size.width, shareBtnPortRect.size.height);
        btnLovePortRect = CGRectMake(topViewPortRect.size.width - 45 ,topViewPortRect.size.height/2 - 18 ,35,35);
        
        btnLoveLandRect = CGRectMake(height - 45 , 5 , 35, 35);
        
        heartimgPortRect = CGRectMake(0, 0, btnLovePortRect.size.width , btnLovePortRect.size.height );
        
        imgViewIconPortRect = CGRectMake(10, 10 , 20, 20);
        
        lblViewCountPortRect = CGRectMake(imgViewIconPortRect.origin.x + 25, 13 , 40, 15);
        
        
        imgCommentPortRect =  CGRectMake(lblViewCountPortRect.origin.x + 45 , 10 ,20,20);
        lblCommentCountPortRect = CGRectMake(imgCommentPortRect.origin.x + 25, 13 , 40, 15);
        
        imgLoveIconPortRect = CGRectMake(lblCommentCountPortRect.origin.x + 45,10 ,20,20);
        lblLoveCountPortRect = CGRectMake(imgLoveIconPortRect.origin.x + 25 , 13, 40, 15);
        
        bottomHeight = 100.0;
        
        mapImgRect = CGRectMake(0,propViewPortRect.origin.y + propViewPortRect.size.height, self.view.bounds.size.width, 70);
        liveAroundBtnRect = CGRectMake(mapImgRect.size.width/2 - 40, mapImgRect.size.height/2 - 15, 80, 30);
        
        profileViewRect = CGRectMake(0,propViewPortRect.origin.y + propViewPortRect.size.height  + mapImgRect.size.height, self.view.bounds.size.width, 70);
        
        tableHeaderViewRect = CGRectMake(0, profileViewRect.origin.y + profileViewRect.size.height, self.view.bounds.size.width, 100);
        iconCategoryImgRect = CGRectMake(tableHeaderViewRect.size.width/2 - 20, tableHeaderViewRect.size.height/2 - 40, 40, 40);
        categoryTypeLblRect = CGRectMake(0, tableHeaderViewRect.size.height/2 + fontSize/2, self.view.bounds.size.width, fontSize);
        categoryDescLblRect = CGRectMake(0, categoryTypeLblRect.origin.y + categoryTypeLblRect.size.height + fontSize/2, self.view.bounds.size.width, fontSize - 2);
        
        
        liveIncategoryTblRect = CGRectMake(0, tableHeaderViewRect.origin.y + tableHeaderViewRect.size.height , self.view.bounds.size.width ,cellH*3);
        AvatarRect = CGRectMake(10, profileViewRect.size.height/2 - 20 , 40 , 40);
        
        usernameLblRect = CGRectMake(60, profileViewRect.size.height/2 - fontSize, 200, fontSize+1);
        followerLblRect = CGRectMake(60, profileViewRect.size.height/2 + 5 , 50 , fontSize - 2);
        followerCountLblRect = CGRectMake(110 , profileViewRect.size.height/2 + 5 , 50 , fontSize - 2);
        
        liveSnapshortImgRect = CGRectMake(10 , 10 , self.view.bounds.size.width/2 - 40 , cellH - 20);
        
        waterMarkRect = CGRectMake((liveSnapshortImgRect.size.width) - (imgHeight+5), (liveSnapshortImgRect.size.height)-(imgHeight+5), imgHeight, imgHeight);
        
        streamTitleCellLblRect = CGRectMake(self.view.bounds.size.width/2 - 20, cellH/4 - (fontSize/2), self.view.bounds.size.width/2, fontSize+2);
        categoryTitleCellLblRect =  CGRectMake(self.view.bounds.size.width/2 - 20, cellH/2 - (fontSize), 60, fontSize);
        categoryTypeCellLblRect = CGRectMake(self.view.bounds.size.width/2 + 40, cellH/2 - (fontSize), 100, fontSize);
        imgLoveCellRect = CGRectMake(self.view.bounds.size.width/2 - 20, cellH - 30, 20, 20);
        loveCountCellLblRect = CGRectMake(self.view.bounds.size.width/2 + 5 , cellH - 25, 50, fontSize);
        userAvatarCellimgRect = CGRectMake(self.view.bounds.size.width - 50, cellH - 50 , 40, 40);
        
        
        
        moreBtnRect = CGRectMake(self.view.bounds.size.width/2 - 60,mapImgRect.origin.y +mapImgRect.size.height/2 , 120, 30);
        
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"disconnect socket");
    self.player.state = VKVideoPlayerStateContentPaused;
    [socket disconnect];
}
- (void)viewDidAppear:(BOOL)animated {
      NSLog(@"URL111:::: %@",self.objStreaming);
    [self playSampleClip1];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    appDelegate.isChat = TRUE;
    appDelegate.isMoreVedio = false ;
    
    
    //self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-bottomHeight);
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    //[self.navigationController setNavigationBarHidden:TRUE];
    //self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    /*
     if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
     NSLog(@"UIInterfaceOrientationIsPortrait");
     //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"portraitBG.png"]];
     } else {
     //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"landscapeBG.png"]];
     NSLog(@"UIInterfaceOrientationIsLandscape");
     }
     */
}

- (void)playSampleClip1 {
    //[self playStream:[NSURL URLWithString:@"http://203.151.133.7:1935/live/ch3_1/playlist.m3u8"]];
    NSLog(@"playSampleClip1");
    
     NSLog(@"URL :::: %@",self.objStreaming.streamUrl);
    [self playStream:[NSURL URLWithString:self.objStreaming.streamUrl]];
    
}

- (void)playStream:(NSURL*)url {
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    track.hasNext = YES;
    //[self.player.view.totalTimeLabel setFrameOriginX: self.player.view.frame.size.width - 100];
    
    
    NSLog(@"playStream");
    
    [self.player loadVideoWithTrack:track];
    
    //    self.player.state = VKVideoPlayerStateContentPaused;
    
}

- (void)login:(id)sender
{
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Please Login" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [Alert show];
    
    //     UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    //    NSLog(@"is not login ");
    //    UIViewController *stream = [[UIViewController alloc] init];
    //    stream = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
    //    stream.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:stream animated:YES completion:Nil];
}
- (void)startChat:(UIButton *)sender
{
    //   UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"buttonPressed" object:nil];
    if(!appDelegate.isChat)
    {
        profileView.hidden = TRUE;
        appDelegate.isChat = true;
    }
    else
    {
        profileView.hidden = FALSE;
        appDelegate.isChat = false;
    }
    
}
- (void)loveSend:(id)sender
{
    NSLog(@"Love Love");
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog (@"Tag %ld",[tapRecognizer.view tag]);
    NSInteger loveTag = [tapRecognizer.view tag];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonPressed" object:nil];
    // Streaming *stream = [self.streamList objectAtIndex:loveTag];
    //    NSLog(@"streamID :%@ ",stream.streamID);
    //    NSLog(@"islove? :%d ",stream.isLoved);
    NSLog (@"Tag !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    if(!self.objStreaming.isLoved)
    {
        [[UserManager shareIntance] loveAPI:@"love" streamID:self.objStreaming.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"loveSendresult : %@",result);
            if ([result[@"message"] isEqualToString:@"Success"]) {
                self.objStreaming.lovesCount = [result[@"data"][@"count"] integerValue];
                [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
                [btnLove setImage:[UIImage imageNamed:@"ic_love2.png"] forState:UIControlStateNormal];
                self.objStreaming.isLoved = true;
                
            }
            // [self viewDidLoad];
            
        }];
    }else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:self.objStreaming.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);
            if ([result[@"message"] isEqualToString:@"Success"]) {
                self.objStreaming.lovesCount = [result[@"data"][@"count"] integerValue];
                [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
                [btnLove setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
                //[self viewDidLoad];
                self.objStreaming.isLoved = false;
            }
        }];
    }
    
    
}

- (void)goComment:(id)sender{
    NSLog(@"GO COMMENT");
    //    UIViewController *commentVC = [[UIViewController alloc] init];
    //      CommentViewController *comment = [self.storyboard instantiateViewControllerWithIdentifier:@"commentNav"];
    //    [self presentViewController:comment animated:YES completion:nil];
    
}
- (void)goProfile:(id)sender{
    NSLog(@"GO PROFILE");
    UserProfileViewController *profile = [self.storyboard instantiateViewControllerWithIdentifier:@"userprofile"];
    [self presentViewController:profile animated:YES completion:nil];
}

- (void)addDemoControl {
    
    UIButton *playSample1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    playSample1Button.frame = CGRectMake(10,40,80,40);
    [playSample1Button setTitle:@"stream" forState:UIControlStateNormal];
    [playSample1Button addTarget:self action:@selector(playSampleClip1) forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubviewForControl:playSample1Button];
    
    
}

#pragma mark - VKVideoPlayerControllerDelegate
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didControlByEvent:(VKVideoPlayerControlEvent)event {
    
    //NSLog(@"%s event:%d", __FUNCTION__, event); //VKVideoPlayerControlEventTapFullScreen
    
    if (event == VKVideoPlayerControlEventTapDone) {
        NSLog(@"VKVideoPlayerControlEventTapDone End");
        if ([self.streamingType isEqualToString:@"mylivestream"]) { //history,live
            //[videoPlayer pauseContent:YES completionHandler:nil];
            
            NSLog(@"mylivestreamEnd");
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refresh"
             object:nil];
            [videoPlayer pauseContent:YES completionHandler:nil];
            /*
             UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake((self.player.view.bounds.size.width - 45), 15, 35, 35)];
             [shareButton setBackgroundImage:[UIImage imageNamed:@"share_blue.png"] forState:UIControlStateNormal];
             [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
             [self.player.view addSubviewForControl:shareButton];
             */
        }
        else {
            //            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refresh"
             object:nil];
            [videoPlayer pauseContent:YES completionHandler:nil];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if (event == VKVideoPlayerControlEventTapFullScreen) {
        if (self.player.isFullScreen) {
            NSLog(@"11");
            // Land
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                self.player.view.topControlOverlay.hidden = TRUE;
                [topView setFrameWidth:[UIScreen mainScreen].bounds.size.height];
                [btnLove setFrame:CGRectMake(topView.bounds.size.width - 110, 10, 100, 100)];
                [topView addSubview:btnLove];
                topView.hidden = FALSE;
                
            }
            else {
                self.player.view.topControlOverlay.hidden = FALSE;
                [btnLove setFrame:btnLoveLandRect];
                [ self.player.view.topControlOverlay addSubview:btnLove];
                topView.hidden = TRUE;
            }
            
            self.player.view.doneButton.hidden = TRUE;
            self.player.view.videoQualityButton.hidden = TRUE;
            self.player.isFullScreen = TRUE;
        }
        else{
            ///////////////////// Port ///////////////////////////
            NSLog(@"12");
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                self.player.view.topControlOverlay.hidden = TRUE;
//                [self.player.view addSubviewForControl:streamingTitle toView:topView];
//                [self.player.view addSubviewForControl:lblcategoryDesc toView:topView];
//                [self.player.view addSubviewForControl:lblcategoryType toView:topView];
//                
//            }
//            else {
            
                self.player.view.topControlOverlay.hidden = FALSE;
                [self.view setFrameHeight:self.view.bounds.size.height];
                
           // }
            
            [self.player.view setFrame: playerRect];
            [topView setFrame: topViewPortRect];
            self.player.view.doneButton.hidden = FALSE;
            self.player.view.fullscreenButton.hidden = FALSE ;
            [btnLove setFrame:btnLovePortRect];
            [topView addSubview:btnLove];
            topView.hidden = FALSE;
            self.player.isFullScreen = FALSE;
        }
        
        
    }
    
    
}


- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didPlayToEnd:(id<VKVideoPlayerTrackProtocol>)track{
    
    NSLog(@"This live stream has finished");
}

-(void)shareAction:(id)sender
{
    
    
    
    
    NSString * shareUrl = self.objStreaming.streamUrl;
    
    NSArray *shareItems = @[shareUrl];
    
    //UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
    //NSMutableArray * shareItems = [NSMutableArray new];
    //[shareItems addObject:imgShare];
    //[shareItems addObject:message];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
    
    //self.objStreaming.streamUrl
}
//
//#pragma mark - Orientation
//- (BOOL)shouldAutorotate {
//    return NO;
//}

//-(void)videoPlayer:(VKVideoPlayer *)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation {
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==
//        UIInterfaceOrientationLandscapeRight) {
//        NSLog(@"UIInterfaceOrientationIsPortrait 1");
//
//        //    [self setPortrait];
//
//
//        ///////////////////// Port ///////////////////////////
//        NSLog(@"กลับหลังจากเอียงซ้าย");
//        NSLog(@"กลับหลังจากเอียงขวา");
//        [topView setFrame: topViewPortRect];
//        self.player.view.doneButton.hidden = FALSE;
//        self.player.view.topControlOverlay.hidden = FALSE;
//        [self.view setFrameHeight:self.view.bounds.size.width];
//        [self.player.view setFrame: playerRect];
//        [btnLove setFrame:btnLovePortRect];
//        [topView addSubview:btnLove];
//        topView.hidden = FALSE;
//        self.player.isFullScreen = true;
//    }
//    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
//        NSLog(@"UIInterfaceOrientationIsPortrait 2");
//        //  [self setPortrait];
//        ///////////////////// Port ///////////////////////////
//        NSLog(@"12");
//        [topView setFrame: topViewPortRect];
//        self.player.view.doneButton.hidden = FALSE;
//        self.player.view.topControlOverlay.hidden = FALSE;
//        [self.view setFrameHeight:self.view.bounds.size.width];
//        [self.player.view setFrame: playerRect];
//        [btnLove setFrame:btnLovePortRect];
//        [topView addSubview:btnLove];
//        topView.hidden = FALSE;
//        self.player.isFullScreen = true;
//        // [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
//        //self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/2);
//
//    }
//    else if (orientation == UIInterfaceOrientationMaskPortrait){
//        NSLog(@"UIInterfaceOrientationMaskPortrait 22");
//        //   [self setLandscap];
//        /////////////////////// Land /////////////////////
//        self.player.view.doneButton.hidden = TRUE;
//        self.player.view.topControlOverlay.hidden = FALSE;
//        [ self.player.view.topControlOverlay addSubview:btnLove];
//        [btnLove setFrame:btnLoveLandRect];
//
//        topView.hidden = TRUE;
//        self.player.view.videoQualityButton.hidden = TRUE;
//        self.player.isFullScreen = false;
//
//
//    }
//
//    else {
//
//        if (self.player.isFullScreen) {
//            NSLog(@"เอียงซ้าย มาที่นี่");
//            NSLog(@"เอียงขวา มาที่นี่");
//            //     [self setLandscap];
//            /////////////////////// Land /////////////////////
//            self.player.view.doneButton.hidden = TRUE;
//            self.player.view.topControlOverlay.hidden = FALSE;
//            [ self.player.view.topControlOverlay addSubview:btnLove];
//            [btnLove setFrame:btnLoveLandRect];
//
//            topView.hidden = TRUE;
//            self.player.view.videoQualityButton.hidden = TRUE;
//            self.player.isFullScreen = false;
//
//
//        }
//        else{
//            NSLog(@"UIInterfaceOrientationIsLandscape");
//
//            //   [self setPortrait];
//            ///////////////////// Port ///////////////////////////
//            NSLog(@"Port didload");
////
////                        [topView setFrame: topViewPortRect];
////                        self.player.view.doneButton.hidden = FALSE;
////                        self.player.view.topControlOverlay.hidden = FALSE;
////                        [self.view setFrameHeight:self.view.bounds.size.width];
////                       [self.player.view setFrame: playerRect];
////                        [btnLove setFrame:btnLovePortRect];
////                        [topView addSubview:btnLove];
////                        topView.hidden = FALSE;
////                        self.player.isFullScreen = true;
//
//        }
//
//
//    }
//
//
//}
//
//
/*
 - (UIImage*)circularScaleNCrop:(UIImage*)image andRect:(CGRect)rect{
 // This function returns a newImage, based on image, that has been:
 // - scaled to fit in (CGRect) rect
 // - and cropped within a circle of radius: rectWidth/2
 
 //Create the bitmap graphics context
 UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width, rect.size.height), NO, 0.0);
 CGContextRef context = UIGraphicsGetCurrentContext();
 
 //Get the width and heights
 CGFloat imageWidth = image.size.width;
 CGFloat imageHeight = image.size.height;
 CGFloat rectWidth = rect.size.width;
 CGFloat rectHeight = rect.size.height;
 
 //Calculate the scale factor
 CGFloat scaleFactorX = rectWidth/imageWidth;
 CGFloat scaleFactorY = rectHeight/imageHeight;
 
 //Calculate the centre of the circle
 CGFloat imageCentreX = rectWidth/2;
 CGFloat imageCentreY = rectHeight/2;
 
 // Create and CLIP to a CIRCULAR Path
 // (This could be replaced with any closed path if you want a different shaped clip)
 CGFloat radius = rectWidth/2;
 CGContextBeginPath (context);
 CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
 CGContextClosePath (context);
 CGContextClip (context);
 
 //Set the SCALE factor for the graphics context
 //All future draw calls will be scaled by this factor
 CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
 
 // Draw the IMAGE
 CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
 [image drawInRect:myRect];
 
 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 return newImage;
 }
 */
/*
 - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
 if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
 //self.view = portraitView;
 //[self changeTheViewToPortrait:YES andDuration:duration];
 
 NSLog(@"UIInterfaceOrientationIsPortrait");
 
 }
 else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
 //self.view = landscapeView;
 //[self changeTheViewToPortrait:NO andDuration:duration];
 NSLog(@"UIInterfaceOrientationIsLandscape");
 }
 }
 
 - (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation duration:(NSTimeInterval)duration {
 if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation ==
 UIInterfaceOrientationPortraitUpsideDown) {
 //[brownBackground setImage:[UIImage imageNamed:@"Portrait_Background.png"]];
 NSLog(@"UIInterfaceOrientationIsPortrait");
 } else {
 //[brownBackground setImage:[UIImage imageNamed:@"Landscape_Background.png"]];
 NSLog(@"UIInterfaceOrientationIsLandscape");
 }
 }
 
 -(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
 if (size.width > size.height) {
 NSLog(@"UIInterfaceOrientationIsLandscape");
 } else {
 NSLog(@"UIInterfaceOrientationIsPortrait");
 }
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
//#init tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.streamList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak StreamingDetailViewController *weakSelf = self;
    Streaming *stream = [[Streaming alloc]init];
    stream = [weakSelf.streamList objectAtIndex:indexPath.row];
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    CGRect tblSetframe;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        tblSetframe = CGRectMake(0*scx, tableHeaderViewRect.origin.y + tableHeaderViewRect.size.height , self.view.bounds.size.width ,cellH*(weakSelf.streamList.count)) ;
    }
    else{
        tblSetframe = CGRectMake(0, tableHeaderViewRect.origin.y + tableHeaderViewRect.size.height , self.view.bounds.size.width ,cellH*(weakSelf.streamList.count)) ;
    }
    
    
    
    
    
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    liveSnapshortImg = [[UIImageView alloc] initWithFrame:liveSnapshortImgRect];
    //    liveSnapshortImg.backgroundColor = [UIColor greenColor];
    
    
    liveSnapshortImg.image = [UIImage imageNamed:@"sil_big.jpg"];
    
    //    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:stream.snapshot]];
    //    UIImage *image=[UIImage imageWithData:data];
    //    if (image==nil) {
    //        //yourImageURL is not valid
    //        NSLog(@"liveSnapshortImg Invalid");
    //        liveSnapshortImg.image = [UIImage imageNamed:@"sil_big.jpg"];
    //    }
    //    else{
    //        NSLog(@"liveSnapshortImg valid");//        liveSnapshortImg.image = image;
    //    }
    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
    if (!format)
    {
        format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
        format.size = CGSizeMake(320, 240);
        format.scaleMode = HNKScaleModeAspectFill;
        format.compressionQuality = 0.5;
        format.diskCapacity = 1 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
    }
    liveSnapshortImg.hnk_cacheFormat = format;
    [liveSnapshortImg hnk_setImageFromURL:[NSURL URLWithString:stream.snapshot]];
    liveSnapshortImg.contentMode = UIViewContentModeScaleToFill;
    
    waterMark = [[UIImageView alloc] initWithFrame:waterMarkRect];
    waterMark.image = [UIImage imageNamed:@"play.png"];
    [liveSnapshortImg addSubview:waterMark];
    
    [cell.contentView addSubview:liveSnapshortImg];
    
    streamTitleCellLbl = [[UILabel alloc] initWithFrame:streamTitleCellLblRect];
    streamTitleCellLbl.text = stream.streamTitle;
    
    streamTitleCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    [cell.contentView addSubview:streamTitleCellLbl];
    
    categoryTitleCellLbl = [[UILabel alloc] initWithFrame:categoryTitleCellLblRect];
    categoryTitleCellLbl.text = @"Category : ";
    categoryTitleCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryTitleCellLbl.textColor = [UIColor grayColor];
    [cell.contentView addSubview:categoryTitleCellLbl];
    
    categoryTypeCellLbl = [[UILabel alloc] initWithFrame:categoryTypeCellLblRect];
    NSLog(@"categoryName ::: %@",self.objStreaming.categoryName);
    categoryTypeCellLbl.text = stream.categoryName;
    categoryTypeCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryTypeCellLbl.textColor = [UIColor redColor];
    [cell.contentView addSubview:categoryTypeCellLbl];
    
    imgLoveCell = [[UIImageView alloc] initWithFrame:imgLoveCellRect];
    imgLoveCell.image = [UIImage imageNamed:@"ic_love2.png"];
    imgLoveCell.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imgLoveCell];
    
    loveCountCellLbl = [[UILabel alloc] initWithFrame:loveCountCellLblRect];
    loveCountCellLbl.textColor = [UIColor redColor];
    loveCountCellLbl.text = [NSString stringWithFormat:@"%ld",(long)stream.lovesCount];
    loveCountCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    [cell.contentView addSubview:loveCountCellLbl];
    
    
    
    
    userAvatarCellimg = [[UIImageView alloc] initWithFrame:userAvatarCellimgRect];
    userAvatarCellimg.image = [UIImage imageNamed:@"anonymous.png"];
    userAvatarCellimg.hnk_cacheFormat = format;
    [userAvatarCellimg hnk_setImageFromURL:[NSURL URLWithString:stream.streamUserImage]];
    
    userAvatarCellimg.layer.cornerRadius = userAvatarCellimgRect.size.width/2;
    userAvatarCellimg.clipsToBounds = YES;
    [cell addSubview:userAvatarCellimg];
    liveIncategoryTbl.scrollEnabled = NO;
    [liveIncategoryTbl setFrame:tblSetframe];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    if (scrollView.contentOffset.y == 0) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.player.view.topControlOverlay.hidden = TRUE;
            streamingTitle.hidden = FALSE;
            lblcategoryDesc.hidden = FALSE;
            lblcategoryType.hidden = FALSE;
        }
        else{
            self.player.view.topControlOverlay.hidden = FALSE;
            
        }
        self.player.view.bottomControlOverlay.hidden = FALSE;
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            streamingTitle.hidden = TRUE;
            lblcategoryDesc.hidden = TRUE;
            lblcategoryType.hidden = TRUE;
        }
        else{
            
            streamingTitle.hidden = FALSE;
            lblcategoryDesc.hidden = FALSE;
            lblcategoryType.hidden = FALSE;
        }
        self.player.view.topControlOverlay.hidden = TRUE;
        self.player.view.bottomControlOverlay.hidden = TRUE;
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //   UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)indexPath;
    //    NSLog (@"Tag Playyyyy %ld",[tapRecognizer.view tag]);
    //    UserTag = [tapRecognizer.view tag];
    NSInteger playTag = [indexPath row];
    
    
    self.objStreaming = [self.streamList objectAtIndex:playTag];
    [self.view reloadInputViews];
    
    
    NSLog(@"Select");
    [socket on:@"ack-connected" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"leave connected %@",data);
        NSString* roomName = [@"streaming/" stringByAppendingString:[NSString stringWithFormat:@"%d",[self.objStreaming.ID intValue]]];
        [socket emit:@"leave" withItems:@[roomName]];
    }];
    self.objStreaming = [_streamList objectAtIndex:indexPath.row];
    
    //    self.player.state = VKVideoPlayerStateContentPaused;
    //    [socket disconnect];
    [socket on:@"ack-connected" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected %@",data);
        NSString* roomName = [@"streaming/" stringByAppendingString:[NSString stringWithFormat:@"%d",[self.objStreaming.ID intValue]]];
        [socket emit:@"join" withItems:@[roomName]];
    }];
    
    [self playSampleClip1];
    [self setVideoData];
    //    [self initial];
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellH ;
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    CGFloat width ; //= [UIScreen mainScreen].bounds.size.width;
    CGFloat height ;// = [UIScreen mainScreen].bounds.size.height;
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        NSLog(@"22");
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        [self.view setFrame:CGRectMake(0, -keyboardFrameBeginRect.size.height ,width,height)];
    }
    else{
        
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        [self.player.view setFrame:CGRectMake(0, -keyboardFrameBeginRect.size.width ,height,width)];
        
    }
    //    else{
    //    NSLog(@"23");
    //    [self.view setFrame:CGRectMake(0,0,width,height)];
    //
    //    }
    //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    NSLog(@"KEYBOARD DIDHIDE");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,0,width,height)];
}
- (void)setSocket:(int)roomID
{
    NSLog(@"setSocket RoomID : %d",roomID);
    NSURL* url = [[NSURL alloc] initWithString:SocketURL];
    //    socket
    socket = [[SocketIOClient alloc] initWithSocketURL:url options:nil];
    
    [socket joinNamespace:@"/websocket"];
    
    [socket on:@"ack-connected" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected %@",data);
        NSString* roomName = [@"streaming/" stringByAppendingString:[NSString stringWithFormat:@"%d",roomID]];
        [socket emit:@"join" withItems:@[roomName]];
    }];
    [socket on:@"watchedcount:update" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"All watchedcount:update :%@",data);
        lblViewCount.text = data[0][@"data"][@"watchedCount"];
        
        
    }];
    [socket on:@"lovescount:update" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"All lovescount:update :%@",data);
        loveCount.text = data[0][@"data"][@"loves_count"];
        
        
    }];
    
    [socket on:@"message:new" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"HandlingEvent : %@",data);
        
    }];
    [socket connect];
    //    NSArray *room = @[self.roomNameTxt.text];
    
}
-(void)getAddressFromLocation:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!placemarks) {
             // handle error
             NSLog(@" handle error");
             
         }
         
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             NSString *address = [NSString stringWithFormat:@"%@ %@", [placemark administrativeArea],[placemark locality]];
             
             // you have the address.
             // do something with it.
             //             NSLog(@"Address : %@ placemark : %@",address,placemark);
             if(([placemark administrativeArea] != nil)&&([placemark locality] != nil))
             {
                 //                 NSLog(@"[placemark administrativeArea] : %@",[placemark administrativeArea]);
                 lblLocationLive.text = address;
             }
             
         }
     }];
}
-(void) refreshList:(NSNotification *)refreshName
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"ADView Notiname: %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"refresh"])
    {
        [self.view reloadInputViews];
    }
    
}



@end
