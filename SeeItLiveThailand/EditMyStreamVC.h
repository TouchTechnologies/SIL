//
//  EditMyStreamVC.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 2/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Streaming.h"
@interface EditMyStreamVC : UIViewController
{
    UIImageView *deleteImg ;
    
}
@property (strong, nonatomic) IBOutlet UILabel *nameLB;
@property (strong, nonatomic) IBOutlet UILabel *createDateLB;
@property (strong, nonatomic) IBOutlet UILabel *lastUpdateLB;
@property (strong, nonatomic) IBOutlet UILabel *viewLb;
@property (strong, nonatomic) IBOutlet UIImageView *videoImageIV;
@property (strong, nonatomic) IBOutlet UITextField *titleTF;
@property (strong, nonatomic) IBOutlet UITextView *detailTV;
@property (nonatomic, strong) NSString *streamingID;
@property (nonatomic, strong) Streaming *objStreaming;
@property (nonatomic, strong) NSString *streamingType;
@property (strong, nonatomic) IBOutlet UIButton *updateBtn;
@property (strong, nonatomic) IBOutlet UIView *FullView;
// call back function, a block
@property (nonatomic, strong) void (^onDismiss)(UIViewController *sender, NSString *objectYouWantToPassBackToParentController);
@property (strong, nonatomic) IBOutlet UILabel *lblSetpublic;
@property (strong, nonatomic) IBOutlet UISwitch *setPublicSwitch;


@end
