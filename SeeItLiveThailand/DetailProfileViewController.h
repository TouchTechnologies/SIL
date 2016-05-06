//
//  DetailProfileViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>
#import "Streaming.h"
@interface DetailProfileViewController : UIViewController<KKGridViewDataSource, KKGridViewDelegate>

@property (nonatomic, strong) KKGridView *gridView;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTxt;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTxt;


@end
