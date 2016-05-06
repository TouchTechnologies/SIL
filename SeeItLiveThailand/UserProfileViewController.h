//
//  UserProfileViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Streaming.h"
#import "UserData.h"
@interface UserProfileViewController : UIViewController
- (IBAction)backBarbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *followersLbl;
@property (strong, nonatomic) IBOutlet UILabel *followingLbl;
@property (strong, nonatomic) IBOutlet UIView *FollowerView;
@property (strong, nonatomic) IBOutlet UILabel *FollowersCountLbl;
@property (strong, nonatomic) IBOutlet UIView *FollowingView;
@property (strong, nonatomic) IBOutlet UILabel *FollowingCountLbl;
@property (strong, nonatomic) IBOutlet UIView *containerView;
//@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;

@property UserData *userData;
@property (strong, nonatomic) NSString *userID;


@end
