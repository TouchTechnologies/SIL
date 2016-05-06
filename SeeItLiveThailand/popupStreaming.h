//
//  popupStreaming.h
//  SeeItLiveThailand
//
//  Created by Touch on 1/13/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popupStreaming : UIView <UITextFieldDelegate>

@property (nonatomic) BOOL isPresented;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextField *TitleTxt;
@property (weak, nonatomic) IBOutlet UIButton *changeCam;
-(void)canRotate;

@end
