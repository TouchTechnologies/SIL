//
//  RegisterVC.m
//  TouchCCTV
//
//  Created by weerapons suwanchatree on 12/16/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//

#import "RegisterVC.h"
#import "UserManager.h"
#import "MBProgressHUD.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import <Google/Analytics.h>
@interface RegisterVC ()<UITextFieldDelegate,UIAlertViewDelegate>{
    IBOutlet UITextField * emailTxt;
    IBOutlet UITextField * passwordTxt;
    IBOutlet UITextField * conPasswordTxt;
    IBOutlet UITextField * firstnameTxt;
    IBOutlet UITextField * lastnameTxt;
    IBOutlet UISwitch *checkTerms;
    IBOutlet UIButton *termsBtn;
    IBOutlet UIButton *regisBtn;
    IBOutlet UIBarButtonItem *loginpageBtn;
   
  
    IBOutlet UIScrollView *scrollView;
    
   
    
    BOOL isAcceptTermAndConditon;
    
    
}


@end
@implementation RegisterVC


-(void)viewDidLoad{
   
   // loginpageBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(loginPageBtn:)];
    [loginpageBtn setAction:@selector(loginPageBtn:)];
    [loginpageBtn setTarget:self];
    
    regisBtn.layer.cornerRadius = 5;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat navbarheight = self.navigationController.navigationBar.bounds.size.height;
    
//
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        [scrollView setFrame:CGRectMake(0,navbarheight,width,height/2+50)];
//
//        [scrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 1000)];
//        
//        // scHeight = 240 * SCALING_Y;
//        
//    }

    
    
    
      NSLog(@"%@",[UIDevice currentDevice].model);
    
    NSLog(@"%f",navbarheight);
    [scrollView setFrame:CGRectMake(0,navbarheight,width,height/2+50)];
    
  

    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Terms of service Privacy Policy email policy"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:(NSRange){0,[attributeString length]}];
    termsBtn.titleLabel.attributedText = [attributeString copy];
    emailTxt.delegate = self;
    passwordTxt.delegate = self;
    conPasswordTxt.delegate = self;
    firstnameTxt.delegate = self;
    lastnameTxt.delegate = self;
    regisBtn.enabled = NO;
    regisBtn.backgroundColor = [UIColor grayColor];
    
    [emailTxt addTarget:self action:@selector(isValidEmail:) forControlEvents:UIControlEventEditingChanged];
    [passwordTxt addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [conPasswordTxt addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [firstnameTxt addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
    [lastnameTxt addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
 
}
-(void)viewWillAppear:(BOOL)animated{
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_CreateAccount_Register"];
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
-(void)loginPageBtn:(UIBarButtonItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:true];
    [self dismissViewControllerAnimated:true completion:nil];
//    NSString * storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    UIViewController *regis =[storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
//    regis.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:regis animated:YES completion:nil];
}

- (IBAction)RegisterBtn:(id)sender {

    
    
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_CreateAccount_Register"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Menu_CreateAccount_Register_Action"     // Event category (required)
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
    
    [[UserManager shareIntance] registerNewAccount_WithEmail:
        [emailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
        Password:[passwordTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
        ConfirmPassword:[conPasswordTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
        FirstName:[firstnameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
        LastName:[lastnameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
        Completion:^(NSError *error, NSDictionary *result, NSString * message) {
            NSLog(@"result %@",result);
     // ** Cannot Connect API
     if (error) {
     
     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     return ;
     }
     [hud hide:YES];
     // ** Connect API Success
     NSString * result_Message = result[@"message"];
        int status = [result[@"status"] integerValue];
        NSLog(@"Status string %@",result[@"status"]);
        NSLog(@"Statut : %d",status);
        if (status == 1 || status == 2 || status == 0)
     {
     // *** Register Success
//     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Register Success" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Success"
                                                         message:result_Message
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
     [alert show];

     }
     else
         
     {
     // *** Register Failed
     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     
     }
     }];
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do your action
        NSLog(@"cancelButtonIndex");
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        //reset clicked
    }
}

- (NSString*)trimmingCharacters:(NSString*)message
{
    return [message stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
}
- (IBAction)viewTermsBtn:(id)sender {
    NSLog(@"View Terms");
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    NSLog(@"TF End : %@",textField.text);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  

    
    CGPoint scrollPoint = CGPointMake(0 ,-scrollView.contentInset.top);
    [scrollView setContentOffset:scrollPoint animated:YES];
    NSLog(@"%f", -scrollView.contentInset.top);
    
//    NSLog(@"TF Begin : %@",textField.text);
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
   
    //    [usernameTxt resignFirstResponder];
    if (textField == emailTxt) {
        [textField resignFirstResponder];
        [passwordTxt becomeFirstResponder];

    } else if (textField == passwordTxt) {
        [textField resignFirstResponder];
        [conPasswordTxt becomeFirstResponder];
        // here you can define what happens
    }else if (textField == conPasswordTxt)
    {
        [textField resignFirstResponder];
        [firstnameTxt becomeFirstResponder];
        

    }else if(textField == firstnameTxt)
    {
        [textField resignFirstResponder];
        [lastnameTxt becomeFirstResponder];
        NSLog(@"%f",lastnameTxt.frame.origin.y);
        CGPoint scrollPoint = CGPointMake(0 , lastnameTxt.frame.origin.y/2-100);
        [scrollView setContentOffset:scrollPoint animated:YES];
        NSLog(@"Firstname na");
    }else if (textField == lastnameTxt)
    {
        [lastnameTxt resignFirstResponder];
        NSLog(@"มันคือ LastName น่ะแจ๊ะ");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        
        [self.view endEditing:YES];
         }
    
    NSLog(@"textFieldShouldReturn");
    
    return YES;
}
- (void)checkTextField:(id)sender{
    if ([passwordTxt.text length] >= 6) {
        passwordTxt.textColor = [UIColor whiteColor]; // No cargo-culting please, this color is very ugly...
    } else {
        passwordTxt.textColor = [UIColor redColor];
        /* Must be done in case the user deletes a key after adding 8 digits,
         or adds a ninth digit */
    }
    if([passwordTxt.text isEqualToString:conPasswordTxt.text])
    {
        conPasswordTxt.textColor = [UIColor whiteColor];
    }else{
        conPasswordTxt.textColor = [UIColor redColor];
    }
    if ([firstnameTxt.text length] >= 2) {
        firstnameTxt.textColor = [UIColor whiteColor];
    }else
    {
        firstnameTxt.textColor = [UIColor redColor];
    }
    if ([lastnameTxt.text length] >= 2) {
        lastnameTxt.textColor = [UIColor whiteColor];
    }else
    {
        lastnameTxt.textColor = [UIColor redColor];
    }
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
- (IBAction)changStatusTerms:(id)sender {
    
    if (checkTerms.isOn) {
        NSLog(@"On");
        regisBtn.enabled = YES;
        regisBtn.backgroundColor = [UIColor colorWithRed:0.09 green:0.23 blue:0.5 alpha:1];
    }else{
        NSLog(@"Off");
        regisBtn.enabled = NO;
        regisBtn.backgroundColor = [UIColor grayColor];
    }
//    NSLog(@"Terms State : %@",checkTerms.)
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  if(textField == lastnameTxt){
        NSLog(@"textFieldShouldEndEditing");
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
  //  CGPoint scrollPoint = CGPointMake(0 , lastnameTxt.frame.origin.y/2+200);
  [scrollView setContentOffset:CGPointZero animated:YES];
        [self.view endEditing:YES];
      
    
  }
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat navbarheight = self.navigationController.navigationBar.bounds.size.height;

    scrollView.scrollEnabled = YES;
  
    // Assign new frame to your view
    
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(navbarheight, 0.0, 0.0, 0.0);
    
    
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    [self.view setFrame:CGRectMake(0,0,width,height)];
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    scrollView.frame = CGRectMake(0, 0, width, height/2+50);
    scrollView.contentSize = CGSizeMake(width, height/2 + 100);
    
    

}

-(void)keyboardDidHide:(NSNotification *)notification
{   //scrollView.frame = CGRectMake(0, 0 , 320, 328);
    

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat navbarheight = self.navigationController.navigationBar.bounds.size.height;
    //  [self.view setFrame:CGRectMake(0,0,width,height)];
    //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
 
   
   
    [scrollView setFrame:CGRectMake(0,navbarheight,width,height/2+50)];
    [scrollView setContentSize:CGSizeMake(width, height/2 + 50)];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(80.0, 0.0, 0.0, 0.0);
    
    
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    scrollView.scrollEnabled = NO;
    [self.view setFrame:CGRectMake(0,0,width,height)];
   // scrollView.hidden = YES;
}
@end
