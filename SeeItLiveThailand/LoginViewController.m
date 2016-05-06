//
//  LoginViewController.m
//  TouchCCTV
//
//  Created by Touch on 12/16/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//

#import "LoginViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "ContainerViewController.h"
#import "MBProgressHUD.h"
#import <Google/Analytics.h>
#import "SCFacebook.h"
#import "UserManager.h"

#import "ModelManager.h"
@interface LoginViewController ()<UITextFieldDelegate>{
    IBOutlet UITextField * usernameTxt;
    IBOutlet UITextField * passwordTxt;
    
    IBOutlet UIButton *loginButton;
    
    NSString *fbAccessToken;
    NSString *socialID;
    //IBOutlet UIButton *loginFBBtn;
    
}
- (IBAction)loginFBBtn:(id)sender;
- (IBAction)registerPageBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *loginFB;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
   // self.navigationController.navigationItem.title = @"Back";
    
    loginButton.layer.cornerRadius = 5 ;
    
    
    //NSLog(@"Facebook btn width %f",loginFBBtn.frame.size.width);
   // NSLog(@"Facebook btn height %f",loginFBBtn.frame.size.height);
    
    //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.frame = loginFBBtn.frame;
//    [loginButton addTarget:self action:@selector(loginFBBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginButton];
    
//    usernameTxt.text = @"weerapon.3at@gmail.com";
//    passwordTxt.text = @"123456";
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.isProfile = true;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_newlogin.png"]];
//    [usernameTxt resignFirstResponder];
    
    usernameTxt.delegate = self;
    passwordTxt.delegate = self;
//    [usernameTxt addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(loginFBBtn:)];
    [self.loginFB addGestureRecognizer:singleFingerTap];
}

- (void)viewWillAppear:(BOOL)animated{
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_Login"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
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

- (IBAction)loginBtn:(id)sender {
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_Login"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Menu_Login_Action"     // Event category (required)
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
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSLog(@"user : %@",appDelegate.username);
    [[UserManager shareIntance] Login:usernameTxt.text Password:passwordTxt.text Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        //
        //
        //        [self.loading hide:true afterDelay:0.3];
        // ** Cannot Connect API
        if (error) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
        [hud hide:YES];
        NSLog(@"Result(login) %@",result);
        // ** Connect API Success
        NSString * result_Message = result[@"message"];
        int status = [result[@"status"] integerValue];
        NSLog(@"Status string %@",result[@"status"]);
        NSLog(@"Statut : %d",status);
        if (status == 0)
        {
            appDelegate.access_token = (result[@"data"][@"access_token"] != (id)[NSNull null])?result[@"data"][@"access_token"] :@"-";
            appDelegate.username = (result[@"data"][@"email"] != (id)[NSNull null])?result[@"data"][@"email"] :@"-";
            appDelegate.email = (result[@"data"][@"email"] != (id)[NSNull null])?result[@"data"][@"email"] :@"-";
            appDelegate.password = passwordTxt.text;
            appDelegate.birth_date = (result[@"data"][@"birth_date"] != (id)[NSNull null])?result[@"data"][@"birth_date"] :@"-";
            appDelegate.first_name = (result[@"data"][@"first_name"] != (id)[NSNull null])?result[@"data"][@"first_name"] :@"-";
            appDelegate.last_name = (result[@"data"][@"last_name"] != (id)[NSNull null])?result[@"data"][@"last_name"] :@"-";
            appDelegate.profile_picture = (result[@"data"][@"profile_picture"] != (id)[NSNull null])?result[@"data"][@"profile_picture"] :@"-";
            appDelegate.user_ID = (result[@"data"][@"id"] != (id)[NSNull null])?result[@"data"][@"id"] :@"-";
            appDelegate.isLogin = YES;
            
            //            NSString *province = (result[@"data"][@"province"] != (id)[NSNull null])?result[@"data"][@"province"] :@"is Null";
            //            NSLog(@"Ok Data %@",appDelegate.birth_date);
            //            NSLog(@"province %@",province);
            
            // *** Login Success
            // Store the data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:usernameTxt.text forKey:@"username"];
            [defaults setObject:passwordTxt.text forKey:@"password"];
            
            [defaults setObject:appDelegate.access_token forKey:@"access_token"];
            [defaults setObject:appDelegate.email forKey:@"email"];
            [defaults setObject:appDelegate.birth_date forKey:@"birth_date"];
            [defaults setObject:appDelegate.first_name forKey:@"first_name"];
            [defaults setObject:appDelegate.last_name forKey:@"last_name"];
            [defaults setObject:appDelegate.profile_picture forKey:@"profile_picture"];
            [defaults setObject:appDelegate.user_ID forKey:@"user_ID"];
            
            [defaults setBool:true forKey:@"isLogin"];
            [defaults synchronize];
            
            //End
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Success" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refresh"
             object:nil];
            [self dismissViewControllerAnimated:true completion:nil];
            
            //            [self performSegueWithIdentifier:@"backmain" sender:self];
            //            ContainerViewController *vc =[ self.storyboard instantiateViewControllerWithIdentifier:@"firstvc"];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"back2main"])
    {
        // Get reference to the destination view controller
    UINavigationController *nav = [segue destinationViewController];
        ContainerViewController *vc = (ContainerViewController *)nav.topViewController;
//        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        // UnderConViewController *underConView = [self.storyboard instantiateViewControllerWithIdentifier:@"underconstruction"];
        // [vc swapCurrentControllerWith : underConView];
        
        
    }
}
- (IBAction)backmainloginBtn:(id)sender {
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refresh"
     object:nil];
    [self dismissViewControllerAnimated:true completion:nil];
   // [self viewDidLoad];
//    NSString * storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"underconstruction"];
//    [self presentViewController:vc animated:YES completion:nil];
//    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
     NSLog(@"TF End : %@",textField.text);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"TF Begin : %@",textField.text);
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
//    [usernameTxt resignFirstResponder];
    if (textField == usernameTxt) {
        [textField resignFirstResponder];
        [passwordTxt becomeFirstResponder];
    } else if (textField == passwordTxt) {
        // here you can define what happens
       [passwordTxt resignFirstResponder];
    }
    
    NSLog(@"textFieldShouldReturn");
    
    return YES;
}
- (void)checkTextField:(id)sender{
    if ([usernameTxt.text length] == 8) {
        usernameTxt.textColor = [UIColor greenColor]; // No cargo-culting please, this color is very ugly...
    } else {
        usernameTxt.textColor = [UIColor redColor];
        /* Must be done in case the user deletes a key after adding 8 digits,
         or adds a ninth digit */
    }
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
- (void)loginFBBtn:(UITapGestureRecognizer *)recognizer  {
    NSLog(@"Login FB");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    [hud show:YES];

    //    loadingView.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading...";
    [SCFacebook loginCallBack:^(BOOL success, id result) {
//        loadingView.hidden = YES;
        NSLog(@"result %@",result);
        
        if (success) {
//            [self showMessage:@"Success"];
            NSLog(@"Success");
           
            [SCFacebook getUserFields:@"id, name, email, birthday, about, picture" callBack:^(BOOL success, id result) {
                if (success) {
                    NSLog(@"Mark success");
                    NSLog(@"%@", result);
                    NSLog(@"Picture %@", result[@"picture"][@"data"][@"url"]);
                    appDelegate.profile_picture = result[@"picture"][@"data"][@"url"];
                  
                    fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
                    NSLog(@"Acess Token %@",fbAccessToken);
                    NSLog(@"email :%@",result[@"email"]);
                    NSLog(@"birthday :%@",result[@"birthday"]);
                    
                    NSLog(@"name :%@",result[@"name"]);
                    NSLog(@"id :%@",result[@"id"]);

                    
                    socialID = result[@"id"];
                    
                    appDelegate.access_token = (result[@"data"][@"access_token"] != (id)[NSNull null])?result[@"data"][@"access_token"] :@"-";
                    
                    NSArray* birthday;
                    NSString* birthdate;
                    NSArray* name;
                    NSString* first_name;
                    NSString* last_name;
                    NSString* email;
                    if (result[@"birthday"]!= NULL) {
                        birthday = [result[@"birthday"]componentsSeparatedByString: @"/"];
                        birthdate = [[birthday objectAtIndex:2] stringByAppendingString:[@"-" stringByAppendingString:[[ birthday objectAtIndex:0] stringByAppendingString:[@"-" stringByAppendingString:[birthday objectAtIndex:1]]]]];
                         NSLog(@"birthdate : %@" ,birthdate);
                    }
                    else{
                    birthdate = @"2000-01-01";
                    name = [result[@"name"]componentsSeparatedByString: @" "];
                    first_name = [name objectAtIndex: 0];
                    last_name = [name objectAtIndex: 1];
                    email = result[@"email"];
                    NSLog(@"first_name :%@",first_name);
                    NSLog(@"last_name :%@",last_name);
                   
                    }
                    
                    
                    [[UserManager shareIntance] validateSocialAccount:socialID social_access_token:fbAccessToken Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                      //  NSLog(@"result  validate : %@",result);
                        NSLog(@"validate data : %@ , %@",socialID,fbAccessToken);
                        // ** Connect API Success
                        NSString * result_Message = result[@"message"];
                        int validatestatus = [result[@"status"] integerValue];
                        NSLog(@"validate status : %d",validatestatus);
                        NSLog(@"Status : %d and Message %@",validatestatus,result_Message);

                        NSLog(@"Statut : %d",validatestatus);
                        if (validatestatus == 0) {
                            NSLog(@"status 0");
                        // login FB API
                            NSLog(@"login data : %@ , %@",socialID,fbAccessToken);
                            
                            [[UserManager shareIntance] loginSocialAccount:socialID social_access_token:fbAccessToken Completion:^(NSError *error, NSDictionary *result, NSString *message) {
                                NSLog(@"result  login : %@",result);
                                
                                int loginstatus = [result[@"status"] integerValue];
                                if (loginstatus == 0)
                                {
                                    
                                    NSLog(@"login FB ตอนไหนไม่รู้");
                                    appDelegate.access_token = (result[@"data"][@"access_token"] != (id)[NSNull null])?result[@"data"][@"access_token"] :@"-";
                                    appDelegate.username = (result[@"data"][@"email"] != (id)[NSNull null])?result[@"data"][@"email"] :@"-";
                                    appDelegate.email = (result[@"data"][@"email"] != (id)[NSNull null])?result[@"data"][@"email"] :@"-";
                                   // appDelegate.password = passwordTxt.text;
                                    appDelegate.birth_date = (result[@"data"][@"birth_date"] != (id)[NSNull null])?result[@"data"][@"birth_date"] :@"-";
                                    appDelegate.first_name = (result[@"data"][@"first_name"] != (id)[NSNull null])?result[@"data"][@"first_name"] :@"-";
                                    appDelegate.last_name = (result[@"data"][@"last_name"] != (id)[NSNull null])?result[@"data"][@"last_name"] :@"-";
                                    appDelegate.profile_picture = (result[@"data"][@"profile_picture"] != (id)[NSNull null])?result[@"data"][@"profile_picture"] :@"-";
                                    appDelegate.user_ID = (result[@"data"][@"id"] != (id)[NSNull null])?result[@"data"][@"id"] :@"-";
                                    appDelegate.isLogin = YES;
                                    
                                    // *** Login Success
                                    // Store the data
                                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                    [defaults setObject:usernameTxt.text forKey:@"username"];
                    
                                    [defaults setObject:appDelegate.access_token forKey:@"access_token"];
                                    [defaults setObject:appDelegate.email forKey:@"email"];
                                    [defaults setObject:appDelegate.birth_date forKey:@"birth_date"];
                                    [defaults setObject:appDelegate.first_name forKey:@"first_name"];
                                    [defaults setObject:appDelegate.last_name forKey:@"last_name"];
                                    [defaults setObject:appDelegate.profile_picture forKey:@"profile_picture"];
                                    [defaults setObject:appDelegate.user_ID forKey:@"user_ID"];
                                    
                                    [defaults setBool:true forKey:@"isLogin"];
                                    [defaults synchronize];
                                    
                                    //End
                                    
                                    
                                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Success" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    [self dismissViewControllerAnimated:true completion:nil];
                                    [[NSNotificationCenter defaultCenter]
                                     postNotificationName:@"refresh"
                                     object:nil];

                                     [hud hide:YES];
                                    
                                }
                                else
                                {
                                     [hud hide:YES];
                                    // *** login Failed
                                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    
                                }

                                
                                // ** Connect API Success
//                                NSString * result_Message = result[@"message"];
//                                int status = [result[@"status"] integerValue];
//                                NSLog(@"Status : %d and Message %@",status,result_Message);
//                                
//                                NSLog(@"Statut : %d",status);
                            }];
                            
                        }
                        else{
                            NSLog(@"Please call P'Ply");
                             [hud hide:YES];
                            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Fail" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];

                        }
                        }];
                }else{
                     [hud hide:YES];
                    NSLog(@"else %@",[result description]);
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Fail" message:@"Validate Fail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }];
        }
        else{
             [hud hide:YES];
            NSLog(@"FBERROR");
//            [self showMessage:[result description]];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Fail" message:[result description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            NSLog(@"else %@",[result description]);
        }
    }];
    
}
- (void)logoutFB
{
    NSLog(@"logout FB");
    [SCFacebook logoutCallBack:^(BOOL success, id result) {
        if (success) {
            
            NSLog(@"logout FB success");

//            [self showMessage:[result description]];
        }
        else{
        
            NSLog(@"logout FB not success");

        }
    }];
}

- (IBAction)registerPageBtn:(id)sender {
   
    NSLog(@"regis");
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *regis =[storyboard instantiateViewControllerWithIdentifier:@"regisnav"];
    regis.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:regis animated:YES completion:nil];
    
}
- (void)FBRegister{
    
    
}
@end
