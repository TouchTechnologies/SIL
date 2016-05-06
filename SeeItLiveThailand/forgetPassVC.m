//
//  forgetPassVC.m
//  TouchCCTV
//
//  Created by weerapons suwanchatree on 12/17/2558 BE.
//  Copyright © 2558 touchtechnologies. All rights reserved.
//

#import "forgetPassVC.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <Google/Analytics.h>

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@implementation forgetPassVC{
    IBOutlet UITextField * emailTxt;
    IBOutlet UIButton *fogotpassButton;
    IBOutlet UILabel *topic1;
    IBOutlet UILabel *topic2;
    CGFloat fontSize;
    
}
-(void)viewDidLoad{
    //[self initialSize];
    //[self initialize];
    
    emailTxt.delegate = self;
    
     fogotpassButton.layer.cornerRadius = 5;

    
}
- (void) drawPlaceholderInRect:(CGRect)rect {
       //  [[UIColor blueColor] setFill];
}
-(void)initialize{
    topic1.font = [UIFont systemFontOfSize:fontSize];
    topic2.font = [UIFont systemFontOfSize:fontSize];

}
-(void)initialSize{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        fontSize = 90;
        // scHeight = 240 * SCALING_Y;
        
    }
    else {
        
        fontSize = 18;
        
      //  cellH = 70;
    }

}
-(void)viewWillAppear:(BOOL)animated{
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_ForgotPass"];
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
- (IBAction)forgetPassBtn:(id)sender {
    
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_ForgotPass"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Menu_ForgotPass_Action"     // Event category (required)
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
//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
        [[UserManager shareIntance] forgotPassword:emailTxt.text Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        
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
            
            // *** Login Success
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Reset Password Success" message:result_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            
            //            [self performSegueWithIdentifier:@"backmain" sender:self];
            UIViewController *vc =[ self.storyboard instantiateViewControllerWithIdentifier:@"firstvc"];
            [self presentViewController:vc animated:YES completion:NULL];
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
        [emailTxt resignFirstResponder];
    
    return YES;
}
@end
