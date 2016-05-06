//
//  LivestreamRealtimeViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "LivestreamRealtimeViewController.h"
#import "VKVideoPlayer.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Streaming.h"
#import "CommentViewController.h"
#import "UserProfileViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"

#import "SeeItLiveThailand-Swift.h"

@interface LivestreamRealtimeViewController  ()<VKVideoPlayerDelegate , UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    
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
    
    CGRect streamUserPortRect;
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
    
    CGRect chatViewPortRect;
    CGRect chatViewLandRect;
    
    CGRect chatTblPortRect;
    CGRect chatTblLandRect;
    
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
    

    
    CGRect userChatImgRect;
    CGRect chatplaceViewRect;
    CGRect textchatLblRect;
    CGRect userChatLblRect;
    

       // object
  
    UIFont *font;
    UILabel *lblLocationLive;
    UILabel *steamingTitle;
    UILabel *liveStreamLocationLbl;
    UIImageView *imgPin;
    UIView *topView;
    UIView *propViewPort;
    UIImageView *imgPinLive;
    
    UIView *chatView;
    UITableView *chatTbl;
    UITextField *chatboxTxt;
    UIButton *sendchatBtn;
    
    UIImageView *userChatImg;
    UIView *chatplaceView;
    UILabel *textchatLbl;
    UILabel *userChatLbl;
    //UITableViewCell *cell;

    UIImageView *imgCommentIcon;
    UILabel *lblCommentCount;
    UIImageView *imgViewIcon;
    UILabel *lblViewCount;
    UILabel *lblStreamUser;
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
  
    
}
@property (nonatomic, strong) VKVideoPlayer* player;

@end

@implementation LivestreamRealtimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSocket];
    [self initialSize];
    [self initialPort];
    [self addLabel];
   
    self.view.backgroundColor = [UIColor whiteColor];

    NSLog(@"IS FULLSCREEN ::: %@" , self.player.isFullScreen ? @"true":@"false");
    
    self.player.delegate = self;
    chatboxTxt.delegate = self;
    chatTbl.delegate = self;
    chatTbl.dataSource = self;
   }
- (void)initialLand{


}

- (void)initialPort{
    
    self.player = [[VKVideoPlayer alloc] init];
    chatView.hidden = FALSE;

    CGFloat ss;
    ss = 100;
    
    if (self.player.isFullScreen) {

        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height); //self.view.bounds;
        NSLog(@"NOT FULLSCREEN");
        self.player.view.doneButton.frame = doneButtonPortRect;

    }
    else{
        self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/2); //self.view.bounds;
        NSLog(@"NOT FULLSCREEN");
        self.player.view.doneButton.frame = doneButtonPortRect;
   }
    self.player.view.playerControlsAutoHideTime = @1000;
    self.player.forceRotate = YES;
    self.player.view.fullscreenButton.hidden = TRUE;
    self.player.view.nextButton.hidden = TRUE;
    self.player.view.rewindButton.hidden = TRUE;
    self.player.view.topControlOverlay.hidden = TRUE;
    self.player.view.bottomControlOverlay.hidden = TRUE;

    
    
    propViewPort = [[UIView alloc] initWithFrame:propViewPortRect];
    propViewPort.backgroundColor = [UIColor blackColor];
    [self.view addSubview:propViewPort];
    [self.view addSubview:self.player.view];
    
    
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
    steamingTitle.font =  [UIFont fontWithName:@"Helvetica" size: fontSize+2];
    [propViewPort addSubview:steamingTitle];

        imgPin = [[UIImageView alloc] initWithFrame:imgPinPortRect];
        imgPin.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        imgPin.contentMode = UIViewContentModeScaleToFill;
        imgPin.image = [UIImage imageNamed:@"pin_2.png"];
    [topView addSubview:imgPin];
    
    lblLocationLive = [[UILabel alloc] initWithFrame:lblLocationLivePortRect];
    lblLocationLive.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblLocationLive.text = @"live location";
    lblLocationLive.textColor = [UIColor grayColor];
    lblLocationLive.backgroundColor = [UIColor clearColor];
    lblLocationLive.textAlignment = NSTextAlignmentLeft;
    lblLocationLive.font = font;
    [topView addSubview:lblLocationLive];

    
  

    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    imgLive = [[UIImageView alloc] initWithFrame:imgLivePortRect];
    imgLive.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    imgLive.contentMode = UIViewContentModeScaleToFill;
    imgLive.image = [UIImage imageNamed:@"live_now_s.png"];
    //[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.avatarUrl]]];
    float width = imgLive.bounds.size.height;
    imgLive.layer.cornerRadius = width/2;
    imgLive.layer.masksToBounds = YES;
    imgLive.layer.borderWidth = 0;
    [propViewPort addSubview:imgLive];
    
    
    lblStreamUser = [[UILabel alloc] initWithFrame:streamUserPortRect];
    lblStreamUser.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblStreamUser.text = self.objStreaming.createBy;
    lblStreamUser.textColor = [UIColor colorWithRed:0.241 green:0.241 blue:0.241 alpha:1];
    lblStreamUser.backgroundColor = [UIColor clearColor];
    lblStreamUser.textAlignment = NSTextAlignmentLeft;
    lblStreamUser.font = font;
    [propViewPort addSubview:lblStreamUser];
    
    
    UITapGestureRecognizer* goProfile = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(goProfile:)];
    //    [goProfile setNumberOfTouchesRequired:1];
    //     goProfile.enabled = YES;
    [imgLive addGestureRecognizer:goProfile];
    [lblStreamUser addGestureRecognizer:goProfile];
    
    btnLove = [[UIButton alloc] initWithFrame:btnLovePortRect];
     btnLove.userInteractionEnabled = YES;
    heartimg = [[UIImageView alloc] initWithFrame:heartimgPortRect];
    heartimg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    heartimg.contentMode = UIViewContentModeScaleAspectFit;
    heartimg.image = [UIImage imageNamed:@"Heart.png"];
    [btnLove addSubview:heartimg];
    [propViewPort addSubview:btnLove];
    
    
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
    if (self.objStreaming.isLoved) {
        //  UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
        [heartimg setBackgroundColor:[UIColor redColor]];
   //    [self.player.view addSubviewForControl:imgLoveIcon];
        //        [cell.contentView addSubview:cell.btnLoveicon];
    }else
    {
        //  UIImageView *img = [[UIImageView alloc] initWithFrame:cell.btnLoveicon.bounds];
       [heartimg setBackgroundColor:[UIColor clearColor]];
   //    [self.player.view addSubviewForControl:imgLoveIcon];
        //        [cell.contentView addSubview:cell.btnLoveicon];
        
    }
    
    
    
    UITapGestureRecognizer* TapLove = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(loveSend:)];
    [TapLove setNumberOfTouchesRequired:1];
    [TapLove setDelegate:self];
    
//    lblLove = [[UILabel alloc] initWithFrame: lblLoveRect];
//    lblLove.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    lblLove.text = @"Love";
//    lblLove.textColor = [UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1];
//    lblLove.backgroundColor = [UIColor clearColor];
//    lblLove.textAlignment = NSTextAlignmentLeft;
//    lblLove.font = font;
   
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
    imgCommentIcon.image = [UIImage imageNamed:@"comment.png"];
    
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

    
    
    chatView = [[UIView alloc] initWithFrame:chatViewPortRect];
    chatView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:chatView];
    
    chatTbl = [[UITableView alloc] initWithFrame:chatTblPortRect];
    chatTbl.backgroundColor = [UIColor clearColor];
    chatTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    [chatView addSubview:chatTbl];
    
    
    
    chatboxTxt = [[UITextField alloc] initWithFrame:chatboxTxtPortRect];
    chatboxTxt.borderStyle = UITextBorderStyleNone;
    chatboxTxt.textColor = [UIColor whiteColor];
    chatboxTxt.layer.cornerRadius = 5;
    chatboxTxt.clipsToBounds = TRUE;
    chatboxTxt.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent: 0.7];
    chatboxTxt.placeholder = @"Say Something";
   // chatboxTxt.placeholder = [UIColor whiteColor];
    chatboxTxt.enabled = TRUE;
    [chatView addSubview:chatboxTxt];
    
    sendchatBtn = [[UIButton alloc] initWithFrame:sendchatBtnPortRect];
    sendchatBtn.titleLabel.text = @"send";
    sendchatBtn.backgroundColor = [UIColor greenColor];
    sendchatBtn.layer.cornerRadius = 5;
    sendchatBtn.clipsToBounds = TRUE;
    [chatView addSubview:sendchatBtn];
    
    //obj for tableview chat
    [chatTbl registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
  //  chatplaceView = [[UIView alloc] initWithFrame:CGRectMake(42, 2 ,chatTblRect.size.width - 44, cellH - 4)];
    
}
- (void)initialSize {
    
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        bottomHeight = 100.0 * scy;
        vdoLabelPortRect = CGRectMake((self.player.view.bounds.size.width/2)-(100 * scx), (10 * scy), (200 * scx), (25 * scy));
        imgPinPortRect = CGRectMake((self.player.view.bounds.size.width - (100 * scx)),(10 * scy), (60 * scx), (20 * scy));
        fontSize = 14.0 * scx;
        imgLivePortRect = CGRectMake(20 * scx, self.view.bounds.size.height - 75 * scy, 50 * scx, 50 * scy);
        streamUserPortRect = CGRectMake(80 * scx, self.view.bounds.size.height - 60 * scy, self.view.bounds.size.width - 100 * scx, 20 * scy);
        
        imgViewIconPortRect = CGRectMake(self.view.bounds.size.width - (125*scx), self.view.bounds.size.height- (93*scy) , 25*scx,25*scy);
        lblViewCountPortRect = CGRectMake(self.view.bounds.size.width - (95*scx),self.view.bounds.size.height- (90*scy), 40*scx, 20*scy);
       // lblViewPortRect = CGRectMake(self.view.bounds.size.width - (55*scx),self.view.bounds.size.height- (90*scy), 55*scx, 20*scy);
        btnLovePortRect = CGRectMake(self.view.bounds.size.width - (125*scx), self.view.bounds.size.height- (65*scy) , 25*scx, 25*scy);
        lblLoveCountPortRect = CGRectMake(self.view.bounds.size.width - (95*scx), self.view.bounds.size.height- (62*scx) , 40*scx, 20*scy);
        //lblLoveRect = CGRectMake(self.view.bounds.size.width - (55*scx), self.view.bounds.size.height- (62*scy) , 40*scx, 20*scy);
        
        imgCommentPortRect = CGRectMake(self.view.bounds.size.width - (125*scx), self.view.bounds.size.height- (35*scy) , 25*scx, 25*scy);
        lblCommentCountPortRect = CGRectMake(self.view.bounds.size.width - (95*scx), self.view.bounds.size.height- (32*scy) , 40*scx, 20*scy);
        //lblCommentRect = CGRectMake(self.view.bounds.size.width - (55*scx), self.view.bounds.size.height- (32*scy) , 40*scx, 20*scy);
        
    } else {
        CGFloat topviewCtr = self.player.view.topControlOverlay.bounds.size.width;
        NSLog(@"TOPVIEW ::: %.2f",topviewCtr);
        fontSize = 14.0;
        
        //////////////////////////////// Portrait ///////////////////////////////////////////
        
        topViewPortRect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50);
        imgPinPortRect = CGRectMake(10,topViewPortRect.size.height/2 - 13, 25, 25);
        lblLocationLivePortRect = CGRectMake(imgPinPortRect.origin.x + 30, topViewPortRect.size.height/2 - 10, self.view.bounds.size.width - (imgPinPortRect.origin.x + 30), 20);
        doneButtonPortRect = CGRectMake(topViewPortRect.size.width - 45, topViewPortRect.size.height/2 - 20 , 40, 40);
        
        
        propViewPortRect = CGRectMake(0, self.view.bounds.size.height / 2 , self.view.bounds.size.width, 70);
        imgLivePortRect = CGRectMake(20, 2, 35, 35);

        vdoLabelPortRect = CGRectMake(imgLivePortRect.size.width + imgLivePortRect.origin.x + 5, 2, 200, 20);
        streamUserPortRect = CGRectMake(imgLivePortRect.size.width + imgLivePortRect.origin.x + 5, 17, 200, 25);
        
        
        shareBtnPortRect = CGRectMake(propViewPortRect.size.width - 80 ,  5, 25 , 25);
        shareimgPortRect = CGRectMake(0, 0, shareBtnPortRect.size.width, shareBtnPortRect.size.height);
        btnLovePortRect = CGRectMake(propViewPortRect.size.width - 45 ,5 ,35,35);
        heartimgPortRect = CGRectMake(0, 0, btnLovePortRect.size.width , btnLovePortRect.size.height );
        
        imgCommentPortRect = CGRectMake(20, propViewPortRect.size.height - 25, 20, 20);
        lblCommentCountPortRect = CGRectMake(imgCommentPortRect.origin.x + 25, propViewPortRect.size.height - 20, 40, 15);
        
        imgViewIconPortRect = CGRectMake(lblCommentCountPortRect.origin.x + 45 , propViewPortRect.size.height - 25 ,20,20);
        lblViewCountPortRect = CGRectMake(imgViewIconPortRect.origin.x + 25, propViewPortRect.size.height - 20, 40, 15);

        imgLoveIconPortRect = CGRectMake(lblViewCountPortRect.origin.x + 45,propViewPortRect.size.height - 25 ,20,20);
        lblLoveCountPortRect = CGRectMake(imgLoveIconPortRect.origin.x + 25 , propViewPortRect.size.height - 20, 40, 15);
        
        bottomHeight = 100.0;
        
       
        chatViewPortRect = CGRectMake(0, self.view.bounds.size.height / 2 + 70 , self.view.bounds.size.width, self.view.bounds.size.height - (self.view.bounds.size.height / 2 + 70));
      
        chatTblPortRect = CGRectMake(20, 10 , self.view.bounds.size.width - 100, chatViewPortRect.size.height - 60);
        userChatImgRect = CGRectMake(0, 0 , 40 , 40);
        
        textchatLblRect = CGRectMake(0, 0, chatplaceViewRect.size.width, 20);
        userChatLblRect = CGRectMake(0, chatplaceViewRect.size.height - 20 , self.view.bounds.size.width, 20);
        chatboxTxtPortRect = CGRectMake(20, chatTblPortRect.origin.y + chatTblPortRect.size.height + 10, self.view.bounds.size.width - 100, 30);
        sendchatBtnPortRect = CGRectMake(chatboxTxtPortRect.origin.x + chatboxTxtPortRect.size.width,  chatTblPortRect.origin.y + chatTblPortRect.size.height + 10, 30 , 30);

        cellH = 50;
        
        
        
        
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
        chatView.hidden = TRUE;
        appDelegate.isChat = true;
    }
  else
    {
       chatView.hidden = FALSE;
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
            [heartimg setBackgroundColor:[UIColor redColor]];
            self.objStreaming.isLoved = true;

           // [self viewDidLoad];
            
        }];
    }else
    {
        [[UserManager shareIntance] loveAPI:@"unlove" streamID:self.objStreaming.streamID userID:@"" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            
            NSLog(@"unloveloveSendresult : %@",result);
           
            self.objStreaming.lovesCount--;
            [loveCount setText:[NSString stringWithFormat:@"%ld",(long)self.objStreaming.lovesCount]];
             [heartimg setBackgroundColor:[UIColor clearColor]];
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
            
            NSLog(@"mylivestreamEnd");
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refresh"
             object:nil];
            /*
             UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake((self.player.view.bounds.size.width - 45), 15, 35, 35)];
             [shareButton setBackgroundImage:[UIImage imageNamed:@"share_blue.png"] forState:UIControlStateNormal];
             [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
             [self.player.view addSubviewForControl:shareButton];
             */
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"refresh"
         object:nil];
        [videoPlayer pauseContent:YES completionHandler:nil];
    }
    
    else if (event == VKVideoPlayerControlEventTapFullScreen) {
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
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
   
    
//        if (self.player.isFullScreen) {
//            NSLog(@"FullScreen");
            return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//    
//        } else {
//            NSLog(@"not FullScreen");
//            return NO;
//        }
//    

}

-(void)setPortrait{
    
   // self.player.view.doneButton.hidden = TRUE;
    self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/2);
    [self.player.view.doneButton setFrame:doneButtonPortRect];
    self.player.view.topControlOverlay.hidden = false;
    self.player.view.bottomControlOverlay.hidden = true;
    [topView setFrame:topViewPortRect];
    [topView setBackgroundColor:[UIColor blackColor]];
    [propViewPort setFrame:propViewPortRect];
    [propViewPort setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:propViewPort];
    
    [imgLive setFrame: imgLivePortRect];
    [propViewPort addSubview:imgLive];
    
    [steamingTitle setFrame:vdoLabelPortRect];
    [propViewPort addSubview:steamingTitle];
    
    [lblStreamUser setFrame:streamUserPortRect];
    [propViewPort addSubview:lblStreamUser];
    
    [lblLocationLive setFrame: lblLocationLivePortRect];
    [topView addSubview:lblLocationLive];
    [imgPin setFrame:imgPinPortRect];
    [topView addSubview:imgPin];
    
    [topView addSubview:self.player.view.doneButton];
    [self.player.view addSubview:topView];
    
    [chatView setFrame:chatViewPortRect];
    [chatView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:chatView];
    
    [shareBtn setFrame:shareBtnPortRect];
    [propViewPort addSubview:shareBtn];
    
    [imgCommentIcon setFrame:imgCommentPortRect];
    [propViewPort addSubview:imgCommentIcon];
    
    [lblCommentCount setFrame:lblCommentCountPortRect];
    [propViewPort addSubview:lblCommentCount];
    
    [imgViewIcon setFrame:imgViewIconPortRect];
    [propViewPort addSubview:imgViewIcon];
    
    [lblViewCount setFrame:lblViewCountPortRect];
    [propViewPort addSubview:lblViewCount];
    
    [imgLoveIcon setFrame:imgLoveIconPortRect];
    [propViewPort addSubview:imgLoveIcon];
    
    [loveCount setFrame:lblLoveCountPortRect];
    [propViewPort addSubview:loveCount];
    
    [btnLove setFrame:btnLovePortRect];
    [heartimg setFrame:heartimgPortRect];
    btnLove.layer.cornerRadius = btnLove.bounds.size.width/2;
    btnLove.clipsToBounds = NO;
    [btnLove setBackgroundColor:[UIColor clearColor] ];
    [btnLove addSubview:heartimg];
    [propViewPort addSubview:btnLove];
}
-(void)setLandscap{
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {}
    else{
        //////////////////////////////// Landscape ///////////////////////////////////////////
        topViewLandRect =  CGRectMake(0, 0, self.view.bounds.size.width, 50);
        doneButtonLandRect = CGRectMake(topViewLandRect.size.width - 45, topViewLandRect.size.height/2 - 20 , 40, 40);
        chatViewLandRect = CGRectMake(0, 50, self.view.bounds.size.width /2 , self.view.bounds.size.height - 100);
        propViewLandRect = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
        imgLiveLandRect = CGRectMake(20, topViewLandRect.size.height/2 - 18, 35, 35);
        vdoLabelLandRect = CGRectMake(imgLiveLandRect.size.width + imgLiveLandRect.origin.x + 30, topViewLandRect.size.height/2 - 18,self.view.bounds.size.width/2, 20);
        imgPinLandRect = CGRectMake((self.view.bounds.size.width/2+self.view.bounds.size.width/4)-30,topView.bounds.size.height/2 - 13, 25, 25);
        streamUserLandRect = CGRectMake(imgLiveLandRect.size.width + imgLiveLandRect.origin.x + 30, topViewLandRect.size.height/2, self.view.bounds.size.width/2, 20);
        lblLocationLiveLandRect = CGRectMake(self.view.bounds.size.width/2+self.view.bounds.size.width/4,topViewLandRect.size.height/2 - 10, topViewLandRect.size.width - (imgPinLandRect.origin.x + 30), 20);
        
        chatButtonLandRect = CGRectMake(20 , propViewLandRect.size.height/2 - 13, 25, 25);
        
        shareBtnLandRect = CGRectMake(60 , propViewLandRect.size.height/2 - 13, 25, 25);
        imgCommentLandRect = CGRectMake(self.view.bounds.size.width/4, propViewLandRect.size.height/2 - 10, 20, 20);
        lblCommentCountLandRect = CGRectMake(self.view.bounds.size.width/4 + 25 , propViewLandRect.size.height/2 - 8, 40, 15);
        imgViewIconLandRect = CGRectMake(self.view.bounds.size.width/4 + 70 , propViewLandRect.size.height/2 - 10, 20, 20);
        lblViewCountLandRect = CGRectMake(self.view.bounds.size.width/4 + 95 , propViewLandRect.size.height/2 - 8, 40, 15);
        
        imgLoveIconLandRect = CGRectMake(self.view.bounds.size.width/4 + 140 , propViewLandRect.size.height/2 - 10, 20, 20);
        lblLoveCountLandRect = CGRectMake(self.view.bounds.size.width/4 + 165 , propViewLandRect.size.height/2 - 8, 40, 15);
        btnLoveLandRect = CGRectMake(self.view.bounds.size.width - 75 ,0 , 45 , 45);
        heartimgLandRect = CGRectMake(5, 5, btnLoveLandRect.size.width - 10,  btnLoveLandRect.size.height - 10);
        
       
    }
    
    
    self.player.view.topControlOverlay.hidden = TRUE;
    self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
     chatView.hidden = TRUE;
    // self.player.view.doneButton.frame = CGRectMake(self.player.view.bounds.size.width - 30, 0, 30, 30);
    self.player.view.bottomControlOverlay.hidden = true;
    [topView setFrame:topViewLandRect];
    [topView setBackgroundColor: [[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [self.player.view addSubview:topView];
    
   
    
    [chatView setFrame:chatViewLandRect];
    [chatView setBackgroundColor:[UIColor clearColor]];
     [self.player.view addSubview:chatView];
    
    
    [propViewPort setFrame:propViewLandRect];
    [propViewPort setBackgroundColor: [[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [self.player.view addSubview:propViewPort];
    
    [imgLive setFrame:imgLiveLandRect];
    [topView addSubview:imgLive];
    [steamingTitle setFrame:vdoLabelLandRect];
    [topView addSubview:steamingTitle];
    [lblStreamUser setFrame:streamUserLandRect];
    [topView addSubview:lblStreamUser];
    
    [lblLocationLive setFrame: lblLocationLiveLandRect];
    [topView addSubview:lblLocationLive];
    [imgPin setFrame:imgPinLandRect];
    [topView addSubview:imgPin];
    
    [self.player.view.doneButton setFrame:doneButtonLandRect];
    [topView addSubview:self.player.view.doneButton];
    
    [chatBtn setFrame: chatButtonLandRect];
    [propViewPort addSubview:chatBtn];
    
    [shareBtn setFrame:shareBtnLandRect];
    [propViewPort addSubview:shareBtn];
    
    [imgCommentIcon setFrame:imgCommentLandRect];
    [propViewPort addSubview:imgCommentIcon];
    
    [lblCommentCount setFrame:lblCommentCountLandRect];
    [propViewPort addSubview:lblCommentCount];
    
    [imgViewIcon setFrame:imgViewIconLandRect];
     [propViewPort addSubview:imgViewIcon];
    
    [lblViewCount setFrame:lblViewCountLandRect];
    [propViewPort addSubview:lblViewCount];
    
    [imgLoveIcon setFrame:imgLoveIconLandRect];
    [propViewPort addSubview:imgLoveIcon];
    
    [loveCount setFrame:lblLoveCountLandRect];
    [propViewPort addSubview:loveCount];

    [btnLove setFrame:btnLoveLandRect];
    [heartimg setFrame:heartimgLandRect];
    btnLove.layer.cornerRadius = btnLoveLandRect.size.width/2;
    btnLove.clipsToBounds = TRUE;
    [btnLove setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.25f]];
    [btnLove addSubview:heartimg];
    [propViewPort addSubview:btnLove];
    
    
}

-(void)videoPlayer:(VKVideoPlayer *)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation {
  
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==
        UIInterfaceOrientationLandscapeRight) {
        NSLog(@"UIInterfaceOrientationIsPortrait 1");
       // if (self.player.isFullScreen) {
        chatView.hidden = FALSE;
        [self setPortrait];
        
//         [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];

  }
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"UIInterfaceOrientationIsPortrait 2");
         chatView.hidden = FALSE;
         [self setPortrait];
         [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        //self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height/2);
        
    }
    else if (orientation == UIInterfaceOrientationMaskPortrait){
        NSLog(@"UIInterfaceOrientationMaskPortrait 22");
        [self setLandscap];
//         [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
      //  self.player.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    else {
      
        if (self.player.isFullScreen) {
            NSLog(@"มาที่นี่");
            [self setLandscap];
//             [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
            self.player.isFullScreen = false;
        }
        else{
             NSLog(@"UIInterfaceOrientationIsLandscape");
             chatView.hidden = FALSE;
            [self setPortrait];
//             [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
            self.player.isFullScreen = true;
        }
       
        
    }

}
//#init tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    userChatImg = [[UIImageView alloc] initWithFrame:userChatImgRect];
    

    userChatImg.layer.cornerRadius = 5;
    userChatImg.clipsToBounds = YES;
    userChatImg.image = [UIImage imageNamed:@"blank.png"];

    [cell.contentView addSubview:userChatImg];
    chatplaceView = [[UIView alloc] init];
    [chatplaceView setFrame:CGRectMake(52, 2 ,chatTblPortRect.size.width - 54, cellH - 4)];
    chatplaceView.backgroundColor = [UIColor whiteColor];
    chatplaceView.layer.cornerRadius = 5;
    chatplaceView.clipsToBounds = YES;
    [cell.contentView addSubview:chatplaceView];
    
    
    textchatLbl = [[UILabel alloc] initWithFrame:CGRectMake(55, 4, chatplaceView.bounds.size.width - 10 , 20)];
    
    textchatLbl.text = @"brcyfvryevcyrevcyrevyrvycyrvcyrevycrvyc";
    textchatLbl.font = [UIFont fontWithName:@"Helvetica" size: fontSize - 2];
    textchatLbl.lineBreakMode = NSLineBreakByWordWrapping;
    textchatLbl.numberOfLines = 0;
    textchatLbl.textAlignment = NSTextAlignmentJustified;
    [textchatLbl sizeToFit];
    [cell.contentView addSubview:textchatLbl];
    
    userChatLbl = [[UILabel alloc] initWithFrame:CGRectMake(55,textchatLbl.bounds.size.height +2 , chatplaceView.bounds.size.width - 10, 20)];
    

    userChatLbl.text = @"giftfy";
    userChatLbl.textColor = [UIColor grayColor];
    userChatLbl.font = [UIFont fontWithName:@"Helvetica" size: fontSize - 4];
    [cell.contentView addSubview:userChatLbl];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Select");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (textchatLbl.bounds.size.height + userChatLbl.bounds.size.height + 5 <= cellH) {
        return cellH ;
    }
    else{
       
        [chatplaceView setFrame:CGRectMake(52, 2, chatTblPortRect.size.width - 54 ,textchatLbl.bounds.size.height + userChatLbl.bounds.size.height + 6)];
        return textchatLbl.bounds.size.height + userChatLbl.bounds.size.height + 10;
        
    }
  

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
