//
//  LivestreamRealtimeViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Streaming;
@interface LivestreamRealtimeViewController : UIViewController

@property (nonatomic, strong) NSString *streamingID;
@property (nonatomic, strong) Streaming *objStreaming;
@property (nonatomic, strong) NSString *streamingType;

@end
