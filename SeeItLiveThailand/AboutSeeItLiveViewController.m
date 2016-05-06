//
//  AboutSeeItLiveViewController.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/14/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "AboutSeeItLiveViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Google/Analytics.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

#define URLEMail @"mailto:support@touchtechnologies.co.th?subject=title&body=content"

@interface AboutSeeItLiveViewController () <MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation AboutSeeItLiveViewController
@synthesize contentTextview,contentView;
- (void)viewDidLoad {
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    contentTextview.text = @"See it Live Thailand is an innovative multimedia mobile and web application for tourists and Thai citizens alike to showcase Thailand’s natural and cultural beauty LIVE, in real-time. Through SEE IT LIVE THAILAND's live function, tourists can share their memorable journey in Thailand,in addition to our beautiful real-time images from well-known attractions.";
    contentView.layer.cornerRadius = 15;
    contentView.layer.masksToBounds = YES;
    self.appVersionLB.text = appDelegate.appVersion;
    
    // Do any additional setup after loading the view.

   
    //Launch Safari with the URL you created
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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)websiteBtn:(id)sender {
    NSURL *urlweb = [ [ NSURL alloc ] initWithString: @"http://www.seeitlivethailand.com"];
    [[UIApplication sharedApplication] openURL:urlweb];

}
- (IBAction)byBtn:(id)sender {
    NSURL *urlweb = [ [ NSURL alloc ] initWithString: @"http://www.touchtechnologies.co.th"];
    [[UIApplication sharedApplication] openURL:urlweb];
}
- (IBAction)emailBtn:(id)sender {
    NSLog(@"Email Btn");
    
//    NSString *url = [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
//    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: url]];
    
    
    
    // Email Subject
    NSString *emailTitle = @"";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@touchtechnologies.co.th"];
    
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }else
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts"
                                                            message:@"Please set up a Mail account in order to send email."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Add Email Accounts", nil];
        [alertView show];
        
    }
    
//    
//        if ([MFMailComposeViewController canSendMail])
//        {
//            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
//    
//            mailer.mailComposeDelegate = self;
//    
//            [mailer setSubject:@""];
//    
//            NSArray *toRecipients = [NSArray arrayWithObjects:@"support@touchtechnologies.co.th", nil];
//            [mailer setToRecipients:toRecipients];
//    
//    
//            NSString *emailBody = @"";
//    
//            [mailer setMessageBody:emailBody isHTML:NO];
//    
//            [self presentModalViewController:mailer animated:YES];
//    
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
//                                                            message:@"Your device doesn't support the composer sheet"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles: nil];
//            [alert show];
//        }
    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=ACCOUNT_SETTINGS&path=ADD_ACCOUNT"]];
    }
    else
    {
//        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
@end
