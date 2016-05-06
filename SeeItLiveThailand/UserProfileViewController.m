//
//  UserProfileViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserData.h"
#import "UserManager.h"

@interface UserProfileViewController ()
{
    
    UIImageView *imgProfile ;
    CGFloat imgW;
    CGFloat cgGrap;
    CGFloat font;
    CGRect headerViewRect;
    CGRect userNameRect;
    UIView *headerView;
    UILabel *userName;
    CGFloat statusbarH;
    
    UILabel *followersCount;
    UILabel *followingCount;
    
    IBOutlet UIView *containerView;
    
    CGFloat ScreenW;
    CGFloat ScreenH;
    
    UIButton *FollowBtn;
    CGRect imgProfileRect ;
    CGRect followerLblRect;
    CGRect followingLblRect;
    CGRect followersCountRect;
    CGRect followingCountRect;
    CGRect FollowBtnRect;
    CGRect  containerViewRect;
    UserData *userData;
   // UIView *secondView;
    //IBOutlet UIView *secondView;
    
}


@end

@implementation UserProfileViewController


- (void)viewDidLoad {
        [super viewDidLoad];
        [self initialSize];
        [self initial];
    

     // Do any additional setup after loading the view.
}
-(void)initialSize{
    CGFloat scx = (768.0/360.0);
    CGFloat scy = (1024.0/480.0);
    ScreenW = [UIScreen mainScreen].bounds.size.width;
    ScreenH = [UIScreen mainScreen].bounds.size.height;
    
       if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        statusbarH = [UIApplication sharedApplication].statusBarFrame.size.height;
        imgW = 100*scx ;
        cgGrap = 10*scx ;
        font = 14*scy;
        
        
        headerViewRect = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+statusbarH,ScreenW, 160*scy);
        imgProfileRect = CGRectMake(ScreenW/4 - (imgW/2 + (10*scx)), headerViewRect.size.height/2 - imgW/2, imgW, imgW);
        userNameRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2 - imgW/2,ScreenW - (cgGrap*2)+imgW, 30*scy);
        
        
        
           
        followerLblRect = CGRectMake(ScreenW/2,  headerViewRect.size.height/2 - (30*scy) , ScreenW/2, 30*scy);
        followingLblRect = CGRectMake(ScreenW/2 + ScreenW/4,  headerViewRect.size.height/2 - (30*scy) ,100*scx, 30*scy);
        followersCountRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2, 70 *scx, 30*scy);
        followingCountRect = CGRectMake(ScreenW/2 + ScreenW/4, headerViewRect.size.height/2 , 70*scx , 30*scy);
        FollowBtnRect = CGRectMake(ScreenW/2 + followersCountRect.size.width/(4*scx), headerViewRect.size.height/2 + (40*scy), ScreenW/3 , 30*scy);
        containerViewRect =CGRectMake(0, (headerViewRect.origin.y + headerViewRect.size.height)*scy, self.view.bounds.size.width ,  self.view.bounds.size.height - (headerViewRect.origin.y + headerViewRect.size.height));
    }
    else{
         statusbarH = [UIApplication sharedApplication].statusBarFrame.size.height;
        font = 14;
        imgW = 100;
        cgGrap = 10 ;
        headerViewRect = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+statusbarH, self.view.frame.size.width, 160);
        userNameRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2 - imgW/2,self.view.frame.size.width - (cgGrap*2)+imgW, 30);
      
        imgProfileRect = CGRectMake(ScreenW/4 - (imgW/2 + 10), headerViewRect.size.height/2 - imgW/2, imgW, imgW);
        followerLblRect = CGRectMake(ScreenW/2,  headerViewRect.size.height/2 - 30 , ScreenW/2, 30);
        followingLblRect = CGRectMake(ScreenW/2 + ScreenW/4,  headerViewRect.size.height/2 - 30 ,100, 30);
        followersCountRect = CGRectMake(ScreenW/2, headerViewRect.size.height/2, 70 , 30);
        followingCountRect = CGRectMake(ScreenW/2 + ScreenW/4, headerViewRect.size.height/2 , 70 , 30);
        FollowBtnRect = CGRectMake(ScreenW/2 + followersCountRect.size.width/4, headerViewRect.size.height/2 + 40, ScreenW/3 , 30);
       containerViewRect =CGRectMake(0,  headerViewRect.origin.y + headerViewRect.size.height, self.view.bounds.size.width ,  self.view.bounds.size.height - (headerViewRect.origin.y + headerViewRect.size.height));
    }

}
-(void)initial{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    userData = _userData;
    NSLog(@"alldata %@",userData);
    NSLog(@"PassingData %@",_userData.userId);
    
    
    headerView = [[UIView alloc] initWithFrame:headerViewRect];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    imgProfile = [[UIImageView alloc] initWithFrame:imgProfileRect];
    
    imgProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userData.profile_picture]]];
    imgProfile.layer.cornerRadius = imgW/2;
    imgProfile.clipsToBounds = TRUE;
    [headerView addSubview:imgProfile];
    
    userName = [[UILabel alloc] initWithFrame:userNameRect];
    userName.text = [userData.first_name stringByAppendingString:[@" " stringByAppendingString:userData.last_name]];
    userName.font = [UIFont fontWithName:@"Helvetica" size:font+6];
//    userName.font = [UIFont fo]
    userName.textColor = (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    [headerView addSubview:userName];
    
    UILabel *followerLbl = [[UILabel alloc] initWithFrame:followerLblRect];
    followerLbl.text = @"Followers";
    followerLbl.textColor = [UIColor grayColor];
    followerLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    [headerView addSubview:followerLbl];
    
    UILabel *followingLbl = [[UILabel alloc] initWithFrame:followingLblRect];
    followingLbl.text = @"Following";
    followingLbl.textColor = [UIColor grayColor];
    followingLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    [headerView addSubview:followingLbl];
    
    followersCount = [[UILabel alloc] initWithFrame:followersCountRect];
    followersCount.backgroundColor = [UIColor whiteColor];
    followersCount.text = userData.count_follower;
    followersCount.font =[UIFont fontWithName:@"Helvetica" size:font];
    followersCount.textAlignment = NSTextAlignmentCenter ;
    followersCount.textColor =  (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    followersCount.layer.borderWidth = 1;
    followersCount.layer.borderColor = [UIColor grayColor].CGColor;
  
    followersCount.layer.cornerRadius = 5;
    followersCount.clipsToBounds = YES;
    [headerView addSubview:followersCount];
    
    followingCount = [[UILabel alloc] initWithFrame:followingCountRect];
    followingCount.backgroundColor = [UIColor whiteColor];
    followingCount.text = userData.count_following;
    followingCount.font =[UIFont fontWithName:@"Helvetica" size:font];
    followingCount.textAlignment = NSTextAlignmentCenter ;
    followingCount.textColor =  (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    followingCount.layer.borderWidth = 1;
    followingCount.layer.borderColor =   [UIColor grayColor].CGColor;
    followingCount.layer.cornerRadius = 5;
    followingCount.clipsToBounds = YES;
    [headerView addSubview:followingCount];

    FollowBtn = [[UIButton alloc] initWithFrame:FollowBtnRect];
    UILabel *btnLbl = [[UILabel alloc] initWithFrame:FollowBtn.bounds];
    btnLbl.text = @"Follow";
    btnLbl.font =[UIFont fontWithName:@"Helvetica" size:font];
    btnLbl.textColor =  (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1]));
    btnLbl.textAlignment = NSTextAlignmentCenter;
    
    [FollowBtn addSubview:btnLbl];
    FollowBtn.backgroundColor = [UIColor whiteColor];
    FollowBtn.layer.borderWidth = 1;
    FollowBtn.layer.borderColor =  [UIColor grayColor].CGColor;    
    
    FollowBtn.layer.cornerRadius = 5;
    FollowBtn.clipsToBounds = YES;
    if(userData.is_followed && ![appDelegate.user_ID isEqualToString:userData.userId])
    {
        btnLbl.textColor = [UIColor whiteColor];
        FollowBtn.backgroundColor = [UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1];
    }else
    {
        btnLbl.textColor = [UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1];
        FollowBtn.backgroundColor = [UIColor whiteColor];
    }
    FollowBtn.tag = 7;
    [FollowBtn addTarget:self action:@selector(setFollow:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:FollowBtn];
    
    
      containerView = [[UIView alloc] init];
     [containerView setFrame:containerViewRect];

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

- (IBAction)backBarbtn:(id)sender {
//   AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    NSLog(@"pagename ::: %@",appDelegate.pageName);
//   appDelegate.pageName = @"MyStream";
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"refresh"
//     object:nil];

}
- (void)setFollow:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
            NSLog(@"setFollow tag %ld",(long)FollowBtn.tag);
    if(!userData.is_followed && ![appDelegate.user_ID isEqualToString:userData.userId])
    {
        [[UserManager shareIntance] followAPI:@"follow" userID:userData.userId Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            NSLog(@"setFollow %@",result);
            
            
//            UILabel *btnLbl = [[UILabel alloc] initWithFrame:FollowBtn.bounds];
//            btnLbl.text = @"Follow";
//            btnLbl.font =[UIFont fontWithName:@"Helvetica" size:font];
//            btnLbl.textColor =  (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor whiteColor]));
//            btnLbl.textAlignment = NSTextAlignmentCenter;
//            FollowBtn.backgroundColor = [UIColor colorWithRed:0.071 green:0.459 blue:0.714 alpha:1];
//            [FollowBtn reloadInputViews];
//            [headerView reloadInputViews];

//            [self viewDidLoad];
        }];
        userData.is_followed = true;
        [self initial];
        [headerView reloadInputViews];
    }else
    {
        [[UserManager shareIntance] followAPI:@"unfollow" userID:userData.userId Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            NSLog(@"setFollow %@",result);
            
//            UILabel *btnLbl = [[UILabel alloc] initWithFrame:FollowBtn.bounds];
//            btnLbl.text = @"Follow";
//            btnLbl.font =[UIFont fontWithName:@"Helvetica" size:font];
//            btnLbl.textColor =  (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor redColor]));
//            btnLbl.textAlignment = NSTextAlignmentCenter;
//            FollowBtn.backgroundColor = [UIColor whiteColor];
//            [FollowBtn reloadInputViews];
//            [headerView reloadInputViews];

//            [self viewDidLoad];
            
        }];
        userData.is_followed = false;
        [self initial];
        [headerView reloadInputViews];
    }
    

    
}

@end
