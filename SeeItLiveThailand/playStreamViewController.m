//
//  playStreamViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 8/15/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "playStreamViewController.h"
#import "VKVideoPlayer.h"
#import "VKVideoPlayerCaptionSRT.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreLocation/CoreLocation.h>
#import "Streaming.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import "MBProgressHUD.h"
#import "defs.h"
#import "SeeItLiveThailand-Swift.h"

@interface playStreamViewController ()<VKVideoPlayerDelegate> {

AppDelegate *appDelegate;
SocketIOClient *socket;
    UIButton *doneBtn;
}
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic, strong) VKVideoPlayer* player;
@end

@implementation playStreamViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    [self initobject];
   // [self setVideoData];
    //Fix Port
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    // Do any additional setup after loading the view.
    
}
- (void)orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
            break;
            
        case UIDeviceOrientationFaceUp:
            [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
            break;
        case UIDeviceOrientationLandscapeRight:
            [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
            break;
        default:
            [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
            break;
    };
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"disconnect socket");
   // self.player.state = VKVideoPlayerStateContentPaused;
   
}
- (void)viewDidAppear:(BOOL)animated {
  //  NSString *url = self.objStreaming;
   
    [self playSampleClip1];
}
- (void)initobject{
    self.player = [[VKVideoPlayer alloc] init];
    self.player.delegate = self;
    self.player.view.frame = self.view.bounds;
    self.player.forceRotate = YES;
    self.player.view.rewindButton.hidden = TRUE;
    self.player.view.nextButton.hidden = TRUE;
    self.player.view.doneButton.hidden = FALSE;
    
    self.player.view.videoQualityButton.hidden = TRUE;
    doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(Close:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.backgroundColor = [UIColor clearColor];
    doneBtn.layer.borderWidth = 2;
    doneBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    doneBtn.layer.cornerRadius = 5;
    [self.player.view addSubview:doneBtn];
    
    [self.view addSubview:self.player.view];
}
-(void)Close:(id)sender{
    
    [self.player pauseContent:YES completionHandler:nil];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)setVideoData{
    
    
    NSLog(@"streamID ::::%@",self.objStreaming.ID);
      [self setSocket:[self.objStreaming.ID intValue]];
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
    
    [socket connect];
    //    NSArray *room = @[self.roomNameTxt.text];
    
}


- (void)playSampleClip1 {
    //[self playStream:[NSURL URLWithString:@"http://203.151.133.7:1935/live/ch3_1/playlist.m3u8"]];
    NSLog(@"playSampleClip1");
    NSLog(@"URL :::: %@",self.objStreaming.streamUrl);
    [self playStream:[NSURL URLWithString:self.objStreaming.streamUrl]];
    
}
- (void)playStream:(NSURL*)url {
    NSLog(@"playStream");
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    track.hasNext = YES;
    
    [self.player loadVideoWithTrack:track];
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
#pragma mark - VKVideoPlayerControllerDelegate
- (void)videoPlayer:(VKVideoPlayer*)videoPlayer didControlByEvent:(VKVideoPlayerControlEvent)event {
    
    
    if (event == VKVideoPlayerControlEventTapDone) {
           }
    else if (event == VKVideoPlayerControlEventTapFullScreen) {
        NSNotification *note;
            UIDevice * device = note.object;
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                    [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
                    break;
                    
                case UIDeviceOrientationFaceUp:
                    [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                    [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
                    break;
                case UIDeviceOrientationLandscapeRight:
                    [doneBtn setFrame:CGRectMake(self.view.bounds.size.height - 70, 10, 50, 30)];
                    break;
                case UIDeviceOrientationLandscapeLeft:
                    [doneBtn setFrame:CGRectMake(self.view.bounds.size.height - 70, 10, 50, 30)];
                    break;
                default:
                    [doneBtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 50, 30)];
                    break;
            };

    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
