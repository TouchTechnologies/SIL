//
//  StreamingDetailViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/26/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Streaming;

@interface StreamingDetailViewController : UIViewController

@property (nonatomic, strong) NSString *streamingID;
@property (nonatomic, strong) Streaming *objStreaming;
@property (nonatomic, strong) NSString *streamingType;

@end
