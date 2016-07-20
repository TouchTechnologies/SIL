//
//  EditMyStreamVC.m
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 2/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "EditMyStreamVC.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "MyAccountViewController.h"
#import "MBProgressHUD.h"
#import "Haneke.h"
#define SCALING_Y = (1024.0/480.0)
#define SCALING_X = (768.0/360.0)

@interface EditMyStreamVC ()<UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate> {

    CGFloat scy;
    CGFloat scx;
    
    CGFloat imgW;
    CGFloat imgH;
    CGFloat labelW;
    CGFloat labelH;
    
    CGFloat txtfieldW;
    CGFloat txtfieldH;
    
    CGFloat txtviewW;
    CGFloat txtviewH;
    
    CGFloat ButtonW;
    CGFloat ButtonH;

    CGFloat fontSize;
    
    CGFloat iconW;
    CGFloat iconH;
    
    CGFloat navH;
    CGFloat navW;
    
    
    
}
@property UIViewController  *currentDetailViewController;
@property (nonatomic, strong) UIView *toolbarView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;


@end
@implementation EditMyStreamVC

-(void)viewDidLoad{
    
    self.navbar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
   // self.navigationController.navigationBar.titleTextAttributes =
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.pageName = @"MyStream";
  
    [self initDeletebutton];
    [self initSize];
    [self initData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tap setNumberOfTouchesRequired:1];
    [tap setDelegate:self];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    
    NSLog(@"navHeight : %f",navH);
    NSLog(@"navWidth :%f",navW);
    
    
}

- (void)initData
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSLog(@"Data %d",self.objStreaming.categoryID);
    NSLog(@"Creata by %@",self.objStreaming.createBy);
    NSLog(@"streamTotalViewEdit : %@",self.objStreaming.streamTotalView);
    NSLog(@"StreamImage : %@",self.objStreaming.snapshot);
    
//    self.videoImageIV.image = ([self.objStreaming.snapshot  isEqual: @""])?[UIImage imageNamed:@"sil_big.jpg"]:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.snapshot]]];

    [self.videoImageIV hnk_setImageFromURL:[NSURL URLWithString:self.objStreaming.snapshot]];
    self.streamingID = self.objStreaming.streamID;
    self.nameLB.text =  [appDelegate.first_name stringByAppendingString:[@" " stringByAppendingString:appDelegate.last_name]];
    self.createDateLB.text = self.objStreaming.streamCreateDate;
    self.lastUpdateLB.text = self.objStreaming.streamUpdateDate;
    self.viewLb.text = self.objStreaming.streamTotalView;
    self.titleTF.text = self.objStreaming.streamTitle;
    self.detailTV.text = self.objStreaming.streamDetail;
    
    [self.setPublicSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    if (self.objStreaming.isPublic) {
        
        [self.setPublicSwitch setOn:true animated:true];
        self.lblSetpublic.text = @"Public";
    }else
    {
        [self.setPublicSwitch setOn:false animated:true];
        self.lblSetpublic.text = @"Unpublic";
    }
    
}
- (void)setState:(id)sender
{
    BOOL state = [sender isOn];
    if (state) {
        self.lblSetpublic.text = @"Public";
    }else
    {
         self.lblSetpublic.text = @"Unpublic";
    }
}
-(void)initSize
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,0,width,height)];

    
   // self.FullView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    
    
    [[self.detailTV layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.detailTV layer] setBorderWidth:1];
    [[self.detailTV layer] setCornerRadius:5];
    
    [[self.titleTF layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.titleTF layer] setBorderWidth:1];
    [[self.titleTF layer] setCornerRadius:5];
    
    [[self.updateBtn layer] setCornerRadius:5];
}

-(void)initDeletebutton
{
    UIImageView *delete ;
    navH = self.navbar.bounds.size.height;
    navW = self.navbar.bounds.size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
     delete = [[UIImageView alloc] initWithFrame:CGRectMake((navW - (navH - 15))-15,7.5, navH-15,  navH-15)];
    }
    else {
     
       delete = [[UIImageView alloc] initWithFrame:CGRectMake((navW - (navH - 15))-15,7.5, navH-15,  navH-15)];
    }

    UITapGestureRecognizer* TapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(deleteMyStream:)];
    
    [TapGestureRecognizer setNumberOfTouchesRequired:1];
    [TapGestureRecognizer setDelegate:self];
    delete.userInteractionEnabled = YES;
    [delete addGestureRecognizer:TapGestureRecognizer];
    

    
//    [delete targetForAction:@selector(deleteMyStream:) withSender:nil];
     //[dalete center].y = navH/2
     delete.image = [UIImage imageNamed:@"ic_bin"];
     [self.navbar addSubview:delete];
    

}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do your action
        NSLog(@"Cancel Alert");
    }else{
        //reset clicked

        NSLog(@"OK Alert");
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[UserManager shareIntance]deleteMyStream:@"" StreamID:self.streamingID Completion:^(NSError *error, NSDictionary *result, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"result : %@",result);
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"update"
             object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];

    }
}
-(void)deleteMyStream:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You sure delete Video?"
                                                    message:self.objStreaming.streamTitle
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
    NSLog(@"deleteMyStream : %@",self.streamingID);
    
}


- (IBAction)backMyStreamBtn:(UIBarButtonItem *)sender {

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refresh"
     object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
 
    
    NSLog(@"MyStream");
    
}
- (IBAction)updateMyStream:(id)sender {
    NSLog(@"Title : %@",self.titleTF.text);
    NSLog(@"Note : %@",self.detailTV.text);
    NSLog(@"Cat ID : %d",self.objStreaming.categoryID);
    NSLog(@"Switch state %lu",(unsigned long)self.setPublicSwitch.isOn);
    NSString *categoryID = [NSString stringWithFormat:@"%d", self.objStreaming.categoryID];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[UserManager shareIntance] updateMyStream:self.objStreaming.streamID title:self.titleTF.text note:self.detailTV.text catID:categoryID public:self.setPublicSwitch.isOn Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"UpdateMyStream : %@",result);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"update"
         object:nil];
        
    }];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Update your stream success !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    

    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"MyStream");
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"TF End : %@",textField.text);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"TF Begin : %@",textField.text);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
   
    return true;

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return false;
    }
    
    return true;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
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
    [self.view setFrame:CGRectMake(0,-110,width,height)];
    //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [self.view setFrame:CGRectMake(0,0,width,height)];
}
-(void)dismissKeyboard {
    NSLog(@"dissmissKeyboard");
    [self.titleTF resignFirstResponder];
    [self.detailTV resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Back ViewDidAppear");
}
@end
