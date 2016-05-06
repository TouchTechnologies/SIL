//
//  CommentViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/26/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *propertyView;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfileView;
@property (strong, nonatomic) IBOutlet UITextField *txtCommentText;
@property (strong, nonatomic) IBOutlet UIButton *btnSendComment;


@end
