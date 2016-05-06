//
//  MyAccountViewController.m
//  TouchCCTV
//
//  Created by Touch on 12/16/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//

#import "MyAccountViewController.h"
#import "UnderConViewController.h"
#import "ContainerViewController.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "MBProgressHUD.h"
#import <Google/Analytics.h>
#import <QuartzCore/QuartzCore.h>

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface MyAccountViewController ()<UITextFieldDelegate>{
    IBOutlet UITextField * emailTxt;
    IBOutlet UITextField * firstnameTxt;
    IBOutlet UITextField * lastnameTxt;
    IBOutlet UITextField * birth_date;
    IBOutlet UIButton *updateprofile;
    IBOutlet UIImageView *profileImg;
    IBOutlet UIView *topView;
   
    CGFloat imgH;
    CGFloat imgW;
    
    CGFloat topViewW;
    CGFloat topViewH;
    
    CGFloat navH;
    CGFloat originY;
    
}
- (IBAction)backMainBtn:(UIBarButtonItem *)sender;
@end
@implementation MyAccountViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self initialobj];
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
   
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.isProfile = true;
  
    if (appDelegate.isLogin) {
        NSLog(@"LOGINNNNN");
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.profile_picture]];

        
        NSLog(@"imageURL: %@",appDelegate.profile_picture);
        if (![appDelegate.profile_picture  isEqual: @""]) {
            
           profileImg.image = [UIImage imageWithData:imageData];
            NSLog(@"เข้า login face");
        }
        else
        {
            NSLog(@"เข้า login email");
         profileImg.image = [UIImage imageNamed:@"ic_new_imgaccount2.png"];
        }

        
    }
    firstnameTxt.text = appDelegate.first_name;
    lastnameTxt.text = appDelegate.last_name;
    emailTxt.text = appDelegate.email;
//    birth_date.text = appDelegate.birth_date;
    
    
    emailTxt.delegate = self;
    firstnameTxt.delegate = self;
    lastnameTxt.delegate = self;
    
    emailTxt.textColor = [UIColor grayColor];
    updateprofile.layer.cornerRadius = 5;
    
    [self initialSize];
   
     // topView.frame = CGRectMake(0 , self.navigationController.navigationBar.frame.size.height , topViewW , topViewH);
      profileImg.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width/2 - imgW/2),topView.frame.size.height/2 - imgH/2, imgW, imgH);
      profileImg.layer.cornerRadius = imgW/2;
      profileImg.clipsToBounds = YES;
    
    
    NSLog(@" topView %f" , topView.frame.origin.y);
    

}
- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imgH = 120*SCALING_Y;
        imgW = 120*SCALING_X;

    }
    else{
    
        imgH = 120;
        imgW = 120;
        
       
        
    }
}
-(void)initialobj{
   
    
    emailTxt.layer.borderWidth = 1;
    emailTxt.layer.borderColor = [UIColor grayColor].CGColor;
    emailTxt.layer.cornerRadius = 5;
    
    firstnameTxt.layer.borderWidth = 1;
    firstnameTxt.layer.cornerRadius = 5;
    firstnameTxt.layer.borderColor = [UIColor grayColor].CGColor;
    
    lastnameTxt.layer.borderWidth = 1;
    lastnameTxt.layer.cornerRadius = 5;
    lastnameTxt.layer.borderColor = [UIColor grayColor].CGColor;

    

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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"backmain"])
    {
        // Get reference to the destination view controller
        UINavigationController *nav = [segue destinationViewController];
        ContainerViewController *vc = (ContainerViewController *)nav.topViewController;
//        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        
        // UnderConViewController *underConView = [self.storyboard instantiateViewControllerWithIdentifier:@"underconstruction"];
       // [vc swapCurrentControllerWith : underConView];

    }
}


- (IBAction)backMainBtn:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
//     [self performSegueWithIdentifier:@"backmain" sender:self];
    
}
- (IBAction)updateProfile:(id)sender {
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_Account_Update"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Menu_Account_Update_Action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"Button"          // Event label
                                                           value:nil] build]];    // Event value
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [hud show:YES];
    [[UserManager shareIntance] updateProfile:firstnameTxt.text Lastname:lastnameTxt.text Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];

        
        // ** Cannot Connect API
        if (error) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
        [hud hide:YES];
        // ** Connect API Success
        NSString * result_Message = result[@"message"];
        int status = [result[@"status"] integerValue];;
        NSLog(@"Status string %@",result[@"status"]);
        NSLog(@"Statut : %d",status);
        if (status == 0)
        {
//            appDelegate.birth_date = result[@"data"][@"birth_date"];
            appDelegate.first_name = result[@"data"][@"first_name"];
            appDelegate.last_name = result[@"data"][@"last_name"];
//            appDelegate.profile_picture = result[@"data"][@"profile_picture"];
            appDelegate.isLogin = YES;
            // *** Update Success
            
            // Update the data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:appDelegate.first_name forKey:@"first_name"];
            [defaults setObject:appDelegate.last_name forKey:@"last_name"];
            [defaults setBool:true forKey:@"isLogin"];
            [defaults synchronize];
            
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Update Success" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [self dismissViewControllerAnimated:true completion:nil];
            //            [self performSegueWithIdentifier:@"backmain" sender:self];
//            UIViewController *vc =[ self.storyboard instantiateViewControllerWithIdentifier:@"firstvc"];
//            [self presentViewController:vc animated:YES completion:NULL];
        }
        else
        {
            // *** Register Failed
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        
        
    }];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    //    [usernameTxt resignFirstResponder];
    if (textField == firstnameTxt) {
        [textField resignFirstResponder];
        [lastnameTxt becomeFirstResponder];
    } else if (textField == lastnameTxt) {
        [lastnameTxt resignFirstResponder];
        // here you can define what happens
    }
    
    return YES;
}
-(void)isValidEmail:(id)sender
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if([emailTest evaluateWithObject:emailTxt.text])
    {
        emailTxt.textColor = [UIColor whiteColor];
    }
    else{
        emailTxt.textColor = [UIColor redColor];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"TF End : %@",textField.text);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"TF Begin : %@",textField.text);
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,-110,width,height)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,0,width,height)];
}

@end
