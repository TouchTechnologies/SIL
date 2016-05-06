//
//  MyLivestreamViewController.h
//  SeeItLiveThailand
//
//  Created by Touch on 1/12/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>
#import "Streaming.h"
@interface MyLivestreamViewController : UIViewController<KKGridViewDataSource, KKGridViewDelegate>

@property (nonatomic, strong) KKGridView *gridView;
@property (nonatomic, strong) NSString *streamingID;
@property (nonatomic, strong) Streaming *objStreaming;
@property (nonatomic, strong) NSString *streamingType;
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (nonatomic, strong) UILabel *lblNoStream;

@end
