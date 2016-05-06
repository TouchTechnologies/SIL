//
//  DetailProfileViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "UserManager.h"
#import "UserData.h"
#import "AppDelegate.h"

@interface DetailProfileViewController ()

@end

@implementation DetailProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initial
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    self.emailTxt.enabled = false;
    self.firstNameTxt.enabled = false;
    self.lastNameTxt.enabled = false;
    
    self.emailTxt.text = appDelegate.followData.email;
    self.firstNameTxt.text = appDelegate.followData.first_name;
    self.lastNameTxt.text = appDelegate.followData.last_name;
    
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
