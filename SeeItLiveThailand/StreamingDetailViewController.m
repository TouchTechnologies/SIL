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
#import "Streaming.h"
#import "CommentViewController.h"
#import "UserProfileViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"

#import "SeeItLiveThailand-Swift.h"
#import "LiveAroundViewController.h"

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
    // object
    
    UIFont *font;
    UILabel *lblLocationLive;
    UILabel *steamingTitle;
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

    UIButton *moreBtn;
    IBOutlet UIScrollView *scrollView;
    AppDelegate *appDelegate;
    

    
}

@property (nonatomic, strong) VKVideoPlayer* player;


@end

@implementation StreamingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSocket];
    [self initialSize];
    [self initial];
    [self addLabel];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"IS FULLSCREEN ::: %@" , self.player.isFullScreen ? @"true":@"false");
    self.player.delegate = self;
    chatboxTxt.delegate = self;
    liveIncategoryTbl.delegate = self;
    liveIncategoryTbl.dataSource = self;
    scrollView.delegate = self;
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(refreshList:)
//                                                     name:@"refresh"
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(refreshList:)
//                                                     name:@"update"
//                                                   object:nil];
    //[[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar+5];
    
    /*
    self.vdoPlayer = [[KSVideoPlayerView alloc] initWithFrame:CGRectMake(0, 20, 320, 180) contentURL:[NSURL URLWithString:@"http://203.151.133.7:1935/live/ch3_1/playlist.m3u8"]];
    [self.view addSubview:self.vdoPlayer];
    self.vdoPlayer.tintColor = [UIColor redColor];
    
    [self.vdoPlayer pause];
    [self.vdoPlayer play];
     */
    
    // Do any additional setup after loading the view.
    /*
    UILabel *lblStringID = [[UILabel alloc] initWithFrame:CGRectMake(30,100 , 100, 20)];
    lblStringID.text = self.streamingID;
    
    [self.view addSubview:lblStringID];
    */
    /*
    NSString *videoURLString = @"http://203.151.133.7:1935/live/ch3_1/playlist.m3u8";
    NSURL *videoURL = [NSURL URLWithString:videoURLString];
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    moviePlayer.view.frame = self.view.bounds;
    [moviePlayer prepareToPlay];
    [moviePlayer play];
    [self.view addSubview:moviePlayer.view];
    */

    //[self addDemoControl];
    
}
- (void)initial{
    
    self.player = [[VKVideoPlayer alloc] init];
    profileView.hidden = FALSE;
    
    CGFloat ss;
    ss = 100;
    
    if (self.player.isFullScreen) {
        
        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height); //self.view.bounds;
        NSLog(@"NOT FULLSCREEN");
        self.player.view.doneButton.frame = doneButtonPortRect;
        
    }
    else{
        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/3); //self.view.bounds;
        NSLog(@"NOT FULLSCREEN");
        self.player.view.doneButton.frame = doneButtonPortRect;

    }
    self.player.view.playerControlsAutoHideTime = @1000;
    self.player.forceRotate = NO;
    self.player.view.fullscreenButton.hidden = TRUE;
    self.player.view.nextButton.hidden = TRUE;
    self.player.view.rewindButton.hidden = TRUE;
    self.player.view.topControlOverlay.hidden = TRUE;
    self.player.view.bottomControlOverlay.hidden = FALSE;
    
    
    
    propViewPort = [[UIView alloc] initWithFrame:propViewPortRect];
    propViewPort.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:propViewPort];
    [scrollView addSubview:self.player.view];
    
    
    topView = [[UIView alloc] initWithFrame:topViewPortRect];
    topView.backgroundColor = [UIColor blackColor];
    [topView addSubview:self.player.view.doneButton];
    [self.player.view addSubview:topView];
    
    font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    steamingTitle = [[UILabel alloc] initWithFrame:vdoLabelPortRect];
    steamingTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    steamingTitle.text = self.objStreaming.streamTitle;
    steamingTitle.textColor = [UIColor whiteColor];
    steamingTitle.backgroundColor = [UIColor clearColor];
    steamingTitle.textAlignment = NSTextAlignmentLeft;
    steamingTitle.font =  [UIFont fontWithName:@"Helvetica" size: fontSize];
    [topView addSubview:steamingTitle];
    
    lblcategoryDesc = [[UILabel alloc] initWithFrame:lblcategoryDescRect];
    lblcategoryDesc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblcategoryDesc.text = @"Category : " ;
    lblcategoryDesc.textColor = [UIColor grayColor];
    lblcategoryDesc.backgroundColor = [UIColor clearColor];
    lblcategoryDesc.textAlignment = NSTextAlignmentLeft;
    lblcategoryDesc.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    [topView addSubview:lblcategoryDesc];
    
    lblcategoryType = [[UILabel alloc] initWithFrame:lblcategoryTypeRect];
    lblcategoryType.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblcategoryType.text = @"Travel";
    lblcategoryType.textColor = [UIColor redColor];
    lblcategoryType.backgroundColor = [UIColor clearColor];
    lblcategoryType.textAlignment = NSTextAlignmentLeft;
    lblcategoryType.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    [topView addSubview:lblcategoryType];

    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    
    lblLocationDesc = [[UILabel alloc] initWithFrame:lblLocationDescRect];
    lblLocationDesc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblLocationDesc.text = @"Location : " ;
    lblLocationDesc.textColor = [UIColor grayColor];
                                 //colorWithRed:0.241 green:0.241 blue:0.241 alpha:1];
    lblLocationDesc.backgroundColor = [UIColor clearColor];
    lblLocationDesc.textAlignment = NSTextAlignmentLeft;
    lblLocationDesc.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    //font;
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
    //    [goProfile setNumberOfTouchesRequired:1];
    //     goProfile.enabled = YES;
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
    lblViewCount.text = self.objStreaming.streamTotalView;
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
    [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
    loveCount.textColor = [UIColor whiteColor];
    //  loveCount.backgroundColor = [UIColor whiteColor];
    loveCount.textAlignment = NSTextAlignmentLeft;
    loveCount.font = font;
    loveCount.enabled = NO;
    [propViewPort addSubview:loveCount];
    
    
    
    NSLog(@"isLove : %d",self.objStreaming.isLoved);
    if (self.objStreaming.isLoved)
    {
        [btnLove setImage:[UIImage imageNamed:@"ic_love2.png"] forState:UIControlStateNormal];
    }
    else
    {
       [btnLove setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
    }
    
    
    
    UITapGestureRecognizer* TapLove = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(loveSend:)];
    [TapLove setNumberOfTouchesRequired:1];
    [TapLove setDelegate:self];

    
    UITapGestureRecognizer* TapLogin = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(login:)];
    [TapLogin setNumberOfTouchesRequired:1];
    [TapLogin setDelegate:self];
    if (appDelegate.isLogin) {
        [btnLove addGestureRecognizer:TapLove];
        TapLove.enabled = YES;
        TapLogin.enabled = NO;
    }
    else{
        TapLove.enabled = NO;
        TapLogin.enabled = YES;
        [btnLove addGestureRecognizer:TapLogin];
        
        
    }
    
    
    //   [self.player.view addSubviewForControl:lblLove];
    
    
    
    // UIButton *btnComment = [[UIButton alloc] initWithFrame:btnCommentRect];
    // [btnComment addTarget:self action:@selector(goComment:) forControlEvents:UIControlEventTouchUpInside];
    
    imgCommentIcon = [[UIImageView alloc] initWithFrame:imgCommentPortRect];
    imgCommentIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    imgCommentIcon.contentMode = UIViewContentModeScaleToFill;
    imgCommentIcon.image = [UIImage imageNamed:@"massege.png"];
    
    //  [btnComment addSubview:imgCommentIcon];
    [propViewPort addSubview:imgCommentIcon];
    
    lblCommentCount = [[UILabel alloc] initWithFrame:lblCommentCountPortRect];
    lblCommentCount.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblCommentCount.text = @"0";
    lblCommentCount.textColor = [UIColor whiteColor];
    lblCommentCount.backgroundColor = [UIColor clearColor];
    lblCommentCount.textAlignment = NSTextAlignmentLeft;
    lblCommentCount.font = font;
    [propViewPort addSubview:lblCommentCount];
    
    mapImg = [[UIImageView alloc] initWithFrame:mapImgRect];
    mapImg.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:mapImg];
    
    
    profileView = [[UIView alloc] initWithFrame:profileViewRect];
    profileView.backgroundColor = [UIColor blackColor];
    
    avatarImg = [[UIImageView alloc] initWithFrame:AvatarRect];
    avatarImg.image = [UIImage imageNamed:@"blank.png"];
    avatarImg.layer.cornerRadius = AvatarRect.size.width/2;
    avatarImg.clipsToBounds = YES;
    [profileView addSubview:avatarImg];
    
    usernameLbl = [[UILabel alloc]initWithFrame:usernameLblRect];
    usernameLbl.text = @"Test User";
    usernameLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    usernameLbl.textColor = [UIColor whiteColor];
    [profileView addSubview:usernameLbl];
    
    followerLbl = [[UILabel alloc]initWithFrame:followerLblRect];
    followerLbl.text = @"follower : ";
    followerLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    followerLbl.textColor = [UIColor grayColor];
    [profileView addSubview:followerLbl];

    followerCountLbl = [[UILabel alloc]initWithFrame:followerCountLblRect];
    followerCountLbl.text = @"12K";
    followerCountLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    followerCountLbl.textColor = [UIColor redColor];
    [profileView addSubview:followerCountLbl];

    [scrollView addSubview:profileView];
    
    tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderViewRect];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    iconCategoryImg = [[UIImageView alloc] initWithFrame:iconCategoryImgRect];
    iconCategoryImg.image = [UIImage imageNamed:@"blank.png"];
    iconCategoryImg.layer.cornerRadius = iconCategoryImgRect.size.width/2;
    iconCategoryImg.clipsToBounds = YES;
    [tableHeaderView addSubview:iconCategoryImg];
    
    categoryTypeLbl = [[UILabel alloc]initWithFrame:categoryTypeLblRect];
    categoryTypeLbl.text = @"Travel";
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
    liveIncategoryTbl.backgroundColor = [UIColor grayColor];
    liveIncategoryTbl.separatorStyle = UITableViewCellStyleDefault;
    [liveIncategoryTbl registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
    [scrollView addSubview:liveIncategoryTbl];
    
    moreBtn = [[UIButton alloc] initWithFrame: moreBtnRect];
    moreBtn.layer.borderWidth = 1;
    moreBtn.layer.borderColor = [UIColor grayColor].CGColor;
    moreBtn.backgroundColor = [UIColor whiteColor];
    moreBtn.layer.cornerRadius = moreBtnRect.size.height/2;
    moreBtn.clipsToBounds = YES;
    UILabel *titlemoreLbl = [[UILabel alloc] initWithFrame:moreBtn.bounds];
    titlemoreLbl.text = @"more";
    titlemoreLbl.textAlignment = NSTextAlignmentCenter;
    titlemoreLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    titlemoreLbl.textColor = [UIColor grayColor];
    [moreBtn addSubview:titlemoreLbl];
    [moreBtn addTarget:self action:@selector(clickmore:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:moreBtn];
    
    //    chatboxTxt = [[UITextField alloc] initWithFrame:chatboxTxtPortRect];
//    chatboxTxt.borderStyle = UITextBorderStyleNone;
//    chatboxTxt.textColor = [UIColor whiteColor];
//    chatboxTxt.layer.cornerRadius = 5;
//    chatboxTxt.clipsToBounds = TRUE;
//    chatboxTxt.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent: 0.7];
//    chatboxTxt.placeholder = @"Say Something";
//    // chatboxTxt.placeholder = [UIColor whiteColor];
//    chatboxTxt.enabled = TRUE;
//    [chatView addSubview:chatboxTxt];
//    
//    sendchatBtn = [[UIButton alloc] initWithFrame:sendchatBtnPortRect];
//    sendchatBtn.titleLabel.text = @"send";
//    sendchatBtn.backgroundColor = [UIColor greenColor];
//    sendchatBtn.layer.cornerRadius = 5;
//    sendchatBtn.clipsToBounds = TRUE;
//    [chatView addSubview:sendchatBtn];
//    
//    //obj for tableview chat
//    [chatTbl registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
//    //  chatplaceView = [[UIView alloc] initWithFrame:CGRectMake(42, 2 ,chatTblRect.size.width - 44, cellH - 4)];

}

- (void)clickmore :(id)sender{
//    CGRect liveIncategoryTblsetRect = CGRectMake(0, liveIncategoryTblRect.origin.y, liveIncategoryTblRect.size.width , 500);
//    
//    if (!appDelegate.isMoreVedio) {
//        [liveIncategoryTbl setFrame:liveIncategoryTblsetRect];
//  
//        [moreBtn setFrame:CGRectMake(self.view.bounds.size.width/2 - 40, liveIncategoryTblsetRect.origin.y + liveIncategoryTblsetRect.size.height + 10 , 80, 30)];
//        [moreBtn reloadInputViews];
//        appDelegate.isMoreVedio = true;
//    }
//    else{
//        [liveIncategoryTbl setFrame: liveIncategoryTblRect];
//        [moreBtn setFrame:moreBtnRect];
//        [moreBtn reloadInputViews];
//        appDelegate.isMoreVedio = false;
//    }
    NSLog(@"GO LIVEAROUND");
       LiveAroundViewController *livearound = [self.storyboard instantiateViewControllerWithIdentifier:@"livearound"];
 
       [self presentViewController: livearound animated: YES completion:nil];
    
    

}

- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
   
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         bottomHeight = 100.0 * scy;
//        vdoLabelRect = CGRectMake((self.player.view.bounds.size.width/2)-(100 * scx), (10 * scy), (200 * scx), (25 * scy));
//        imgLiveRect = CGRectMake((self.player.view.bounds.size.width - (100 * scx)),(10 * scy), (60 * scx), (20 * scy));
//        fontSize = 14.0 * scx;
//        avatarRect = CGRectMake(20 * scx, self.view.bounds.size.height - 75 * scy, 50 * scx, 50 * scy);
//        streamUserRect = CGRectMake(80 * scx, self.view.bounds.size.height - 60 * scy, self.view.bounds.size.width - 100 * scx, 20 * scy);
//        
//        imgViewIconRect = CGRectMake(self.view.bounds.size.width - (125*scx), self.view.bounds.size.height- (93*scy) , 25*scx,25*scy);
//        lblViewCountRect = CGRectMake(self.view.bounds.size.width - (95*scx),self.view.bounds.size.height- (90*scy), 40*scx, 20*scy);
//        lblViewRect = CGRectMake(self.view.bounds.size.width - (55*scx),self.view.bounds.size.height- (90*scy), 55*scx, 20*scy);
//        btnLoveRect = CGRectMake(self.view.bounds.size.width - (125*scx), self.view.bounds.size.height- (65*scy) , 25*scx, 25*scy);
//        lblLoveCountRect = CGRectMake(self.view.bounds.size.width - (95*scx), self.view.bounds.size.height- (62*scx) , 40*scx, 20*scy);
//        lblLoveRect = CGRectMake(self.view.bounds.size.width - (55*scx), self.view.bounds.size.height- (62*scy) , 40*scx, 20*scy);
//        
//        btnCommentRect = CGRectMake(self.view.bounds.size.width - (125*scx), self.view.bounds.size.height- (35*scy) , 25*scx, 25*scy);
//        lblCommentCountRect = CGRectMake(self.view.bounds.size.width - (95*scx), self.view.bounds.size.height- (32*scy) , 40*scx, 20*scy);
//        lblCommentRect = CGRectMake(self.view.bounds.size.width - (55*scx), self.view.bounds.size.height- (32*scy) , 40*scx, 20*scy);
        
    } else {
        CGFloat topviewCtr = self.player.view.topControlOverlay.bounds.size.width;
        NSLog(@"TOPVIEW ::: %.2f",topviewCtr);
        fontSize = 14.0;
        cellH = 100;
        
        
        CGFloat imgHeight;
        //UIImage *playBig = [UIImage imageNamed:@"VKVideoPlayer_play_big.png"];
        
        imgHeight = 30.0;
       
    
        
        topViewPortRect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100);
        
        lblcategoryDescRect = CGRectMake(10 , topViewPortRect.size.height/2 + 5, 60, 15);
        lblcategoryTypeRect = CGRectMake(lblcategoryDescRect.origin.x + 60 , topViewPortRect.size.height/2 + 5, topViewPortRect.size.width/2, 15);
        
        imgPinPortRect = CGRectMake(10,topViewPortRect.size.height/2 - 13, 25, 25);
       
        doneButtonPortRect = CGRectMake(10, topViewPortRect.size.height/2 - 50 , 40, 40);
        vdoLabelPortRect = CGRectMake(10 ,topViewPortRect.size.height/2 - 18 , 200, 20);
        
        propViewPortRect = CGRectMake(0, self.view.bounds.size.height -  self.view.bounds.size.height/3 , self.view.bounds.size.width, 70);
        imgLivePortRect = CGRectMake(20, 2, 35, 35);
        
        lblLocationDescRect = CGRectMake(10 , propViewPortRect.size.height - 25, 60, 15);
        lblLocationLivePortRect = CGRectMake(lblLocationDescRect.origin.x + 60,  propViewPortRect.size.height - 25, self.view.bounds.size.width - (lblLocationDescRect.origin.x + 50), 15);
        
        shareBtnPortRect = CGRectMake(propViewPortRect.size.width - 35 ,  10 , 25 , 25);
        shareimgPortRect = CGRectMake(0, 0, shareBtnPortRect.size.width, shareBtnPortRect.size.height);
        btnLovePortRect = CGRectMake(topViewPortRect.size.width - 45 ,topViewPortRect.size.height/2 - 18 ,35,35);
        
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
        
        usernameLblRect = CGRectMake(60, profileViewRect.size.height/2 - fontSize, 200, fontSize);
        followerLblRect = CGRectMake(60, profileViewRect.size.height/2 + 5 , 50 , fontSize - 2);
        followerCountLblRect = CGRectMake(110 , profileViewRect.size.height/2 + 5 , 50 , fontSize - 2);
        
        liveSnapshortImgRect = CGRectMake(10 , 10 , self.view.bounds.size.width/2 - 40 , cellH - 20);
      
        waterMarkRect = CGRectMake((liveSnapshortImgRect.size.width) - (imgHeight+5), (liveSnapshortImgRect.size.height)-(imgHeight+5), imgHeight, imgHeight);
        
         streamTitleCellLblRect = CGRectMake(self.view.bounds.size.width/2 - 20, cellH/4 - (fontSize/2), self.view.bounds.size.width/2, fontSize);
         categoryTitleCellLblRect =  CGRectMake(self.view.bounds.size.width/2 - 20, cellH/2 - (fontSize/2), 60, fontSize);
         categoryTypeCellLblRect = CGRectMake(self.view.bounds.size.width/2 + 40, cellH/2 - (fontSize/2), 100, fontSize);
         imgLoveCellRect = CGRectMake(self.view.bounds.size.width/2 - 20, cellH - 30, 20, 20);
         loveCountCellLblRect = CGRectMake(self.view.bounds.size.width/2 + 5 , cellH - 25, 50, fontSize);
         userAvatarCellimgRect = CGRectMake(self.view.bounds.size.width - 50, cellH - 50 , 40, 40);
        
        
        
         moreBtnRect = CGRectMake(self.view.bounds.size.width/2 - 40, liveIncategoryTblRect.origin.y + liveIncategoryTblRect.size.height + 10 , 80, 30);
        
        
        

    }
}


- (void)viewDidAppear:(BOOL)animated {
    

    
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [self playStream:[NSURL URLWithString:self.objStreaming.streamUrl]];
   
}

- (void)playStream:(NSURL*)url {
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    track.hasNext = YES;    
    NSLog(@"playStream");
    [self.player loadVideoWithTrack:track];
    //self.player.state = VKVideoPlayerStateContentPaused;

}

- (void)addLabel {

    
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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
            self.objStreaming.lovesCount++;
            [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
            [btnLove setImage:[UIImage imageNamed:@"ic_love2.png"] forState:UIControlStateNormal];
            self.objStreaming.isLoved = true;
            
            // [self viewDidLoad];
            
        }];
    }else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:self.objStreaming.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);
            
            self.objStreaming.lovesCount--;
            [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
           [btnLove setImage:[UIImage imageNamed:@"ic_love.png"] forState:UIControlStateNormal];
            //[self viewDidLoad];
            self.objStreaming.isLoved = false;
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
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refresh"
             object:nil];
            [videoPlayer pauseContent:YES completionHandler:nil];
        }
        
   
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (event == VKVideoPlayerControlEventTapFullScreen) {
        if (self.player.isFullScreen) {
            NSLog(@"11");
            self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
            self.player.isFullScreen = false;
        }
        else{
            NSLog(@"12");
            
            self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
            self.player.isFullScreen = true;
            
        }
        NSLog(@"VKVideoPlayerControlEventTapDone Start");

    }
    
    
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

#pragma mark - Orientation
- (BOOL)shouldAutorotate {
    return NO;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//
//    if (self.player.isFullScreen) {
//        NSLog(@"FullScreen");
//        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//        
//    } else {
//        NSLog(@"not FullScreen");
//        return NO;
//    }
//
//}
/*
-(void)videoPlayer:(VKVideoPlayer *)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation {
  
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==
        UIInterfaceOrientationLandscapeRight) {
        NSLog(@"UIInterfaceOrientationIsPortrait 1");
        if (self.player.isFullScreen) {
            self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - bottomHeight);
            self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
            self.player.view.topControlOverlay.hidden = false;
            NSLog(@"FULLSCREEN");
            self.player.isFullScreen = false;
        }
        else{
            self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - bottomHeight);
            self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
            self.player.view.topControlOverlay.hidden = false;
            NSLog(@"FULLSCREEN");

            self.player.isFullScreen = true;
        }
    }
   else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
           NSLog(@"UIInterfaceOrientationIsPortrait 2");
        
        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/2);
        
    }
    else if (orientation == UIInterfaceOrientationMaskPortrait){
     NSLog(@"UIInterfaceOrientationMaskPortrait 22");
          self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/2);
    }
 
    else {
        if (self.player.isFullScreen) {
            self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
            self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
            self.player.isFullScreen = false;
        }
        else{
        
            self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - bottomHeight);
            self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
            self.player.isFullScreen = true;
        }
        NSLog(@"UIInterfaceOrientationIsLandscape");
        
    }
    
    
}




*/



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
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    liveSnapshortImg = [[UIImageView alloc] initWithFrame:liveSnapshortImgRect];
    liveSnapshortImg.backgroundColor = [UIColor greenColor];
    liveSnapshortImg.image = [UIImage imageNamed:@"sil_big.jpg"];
    
    waterMark = [[UIImageView alloc] initWithFrame:waterMarkRect];
    waterMark.image = [UIImage imageNamed:@"play.png"];
    [liveSnapshortImg addSubview:waterMark];
    
    [cell.contentView addSubview:liveSnapshortImg];
    
    streamTitleCellLbl = [[UILabel alloc] initWithFrame:streamTitleCellLblRect];
    streamTitleCellLbl.text = @"Title stream";
    streamTitleCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    [cell.contentView addSubview:streamTitleCellLbl];
    
    categoryTitleCellLbl = [[UILabel alloc] initWithFrame:categoryTitleCellLblRect];
    categoryTitleCellLbl.text = @"Category : ";
    categoryTitleCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryTitleCellLbl.textColor = [UIColor grayColor];
    [cell.contentView addSubview:categoryTitleCellLbl];
    
    categoryTypeCellLbl = [[UILabel alloc] initWithFrame:categoryTypeCellLblRect];
    categoryTypeCellLbl.text = @"Travel";
    categoryTypeCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryTypeCellLbl.textColor = [UIColor redColor];
    [cell.contentView addSubview:categoryTypeCellLbl];
    
    imgLoveCell = [[UIImageView alloc] initWithFrame:imgLoveCellRect];
    imgLoveCell.image = [UIImage imageNamed:@"ic_love2.png"];
    imgLoveCell.contentMode = UIViewContentModeScaleAspectFit;
      [cell.contentView addSubview:imgLoveCell];
    
    loveCountCellLbl = [[UILabel alloc] initWithFrame:loveCountCellLblRect];
    loveCountCellLbl.textColor = [UIColor redColor];
    loveCountCellLbl.text = @"54K";
    loveCountCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    [cell.contentView addSubview:loveCountCellLbl];

    userAvatarCellimg = [[UIImageView alloc] initWithFrame:userAvatarCellimgRect];
    userAvatarCellimg.image = [UIImage imageNamed:@"blank.png"];
    userAvatarCellimg.layer.cornerRadius = userAvatarCellimgRect.size.width/2;
    userAvatarCellimg.clipsToBounds = YES;
    [cell addSubview:userAvatarCellimg];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Select");
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
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,0,width,height)];
}
- (void)initSocket
{
    NSURL* url = [[NSURL alloc] initWithString:@"http://192.168.9.117:3008"];
    //socket
    SocketIOClient* socket = [[SocketIOClient alloc] initWithSocketURL:url options:nil];

    [socket joinNamespace:@"/websocket"];
    
    [socket on:@"ack-connected" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected %@",data);
        [socket emit:@"join" withItems:@[@"demo/room-2"]];
    }];
//    [socket connect];
    
    
    [socket on:@"message:new" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"HandlingEvent : %@",data);
        NSError *jsonError;
        NSData *objectData = [data[0] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&jsonError];
        //
        if([json[@"message_type"]  isEqual: @"test"])
        {
            
        
            NSLog(@"message : %@",json[@"message"]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Socket Data"
                                  
                                                            message:json[@"message"]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }];
    //    [socket connect];
    //    NSArray *room = @[self.roomNameTxt.text];
    
}



@end
