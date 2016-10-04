//
//  UnderConViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/2/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "UnderConViewController.h"
#import "defs.h"
#import "AFNetworking.h"
#import "ROI.h"
#import "Streaming.h"
#import "CCTVS.h"
#import "CollectionViewCell.h"
#import "MyAccountViewController.h"
#import "SettingTableViewController.h"
#import "LoginNavViewController.h"
#import "AppDelegate.h"
#import "SCFacebook.h"
#import <Google/Analytics.h>
#import <QuartzCore/QuartzCore.h>
#import "HelpfullContactViewController.h"
#import "MyDestinationViewController.h"

#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);


@interface UnderConViewController ()
{
    IBOutlet UIView *topView;
    NSArray * _menuImageName;
    NSArray *_menuLabelName;
    IBOutlet UILabel *nameTxt;
    CGRect nameTxtRect;
    
    IBOutlet UIButton *loginBtn;
    IBOutlet UIView *profileView;
    
    IBOutlet UIButton *myAccountBtn;
    
    IBOutlet UILabel *profileDes;
    
    CGFloat collectionViewH;
    CGFloat collectionViewW;
    CGFloat cellH;
    CGFloat cellW;
    CGFloat imgH;
    CGFloat imgW;
    CGFloat fontSize;
    CGFloat labelH;
    CGFloat labelW;
    CGFloat buttonW;
    CGFloat buttonH;
    
    CGFloat imgGrapX;
    CGFloat imgGrapY;
    CGRect imgActRect;
    CGRect lblNameRect;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
- (IBAction)LoginBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *menuImg;
@property (weak, nonatomic) IBOutlet UILabel *menuLbl;


@end
@implementation UnderConViewController
-(void)initialObj{
    
    
    _profileImg.frame = CGRectMake(imgGrapX - 10, imgGrapY, imgW, imgH);
    [_profileImg setCenter:CGPointMake((imgW/2 + imgGrapX),topView.frame.size.height/2)];
    _profileImg.layer.borderWidth = 6;
    _profileImg.layer.borderColor = [UIColor colorWithRed:0.87 green:0.91 blue:0.95 alpha:1.0].CGColor;
    
    
    [myAccountBtn setFrame:CGRectMake((imgGrapX + imgW)-imgW/3,  _profileImg.center.y - (imgW/1.8), imgW/2, imgW/2)];
    myAccountBtn.layer.cornerRadius = myAccountBtn.bounds.size.width/2;
    myAccountBtn.clipsToBounds = YES;
    myAccountBtn.layer.borderWidth = 4;
    myAccountBtn.layer.borderColor = [UIColor colorWithRed:0.87 green:0.91 blue:0.95 alpha:1.0].CGColor;
    [myAccountBtn addTarget:self action:@selector(myAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgAccount = [[UIImageView alloc] initWithFrame:CGRectMake(imgGrapY/4, imgGrapY/4, myAccountBtn.frame.size.width - imgGrapY/2,myAccountBtn.frame.size.height - imgGrapY/2)];
    //    imgAccount.layer.cornerRadius = imgAccount.bounds.size.width/2;
    //    imgAccount.clipsToBounds = YES;
    
    imgAccount.image = [UIImage imageNamed:@"ic_new_myaccount_newmore.png"];
    imgAccount.contentMode = UIViewContentModeScaleAspectFit;
    [myAccountBtn addSubview:imgAccount];
    
    //    [topView addSubview:myAccountBtn];
    [nameTxt setFrame:nameTxtRect];
    nameTxt.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    [nameTxt setBackgroundColor:[UIColor whiteColor]];
    [topView addSubview:nameTxt];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialObj];
    [self initialSize];
    _profileImg.layer.cornerRadius =  _profileImg.bounds.size.width/2;
    _profileImg.clipsToBounds = YES;
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    _menuImageName = [NSArray arrayWithObjects:@"call_icon.png",@"ic_new_mylivestream_newmore.png" ,@"ic_new_goto_newmore.png" ,@"ic_facebook_share.png",@"unnamed.png",@"ic_more_setting.png", nil];
    _menuLabelName = [NSArray arrayWithObjects:@"Helpful Contact",@"My Live Stream" ,@"Back To Hotel" ,@"Share See it Live",@"Fanpage",@"Setting", nil];
    
    
    
    
    
}
- (void)myAccount:(id)sender{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    if (appDelegate.isLogin) {
        
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"Menu_Account"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        [self performSegueWithIdentifier:@"showaccount" sender:self];
    }else{
        // NSString * storyboardName = @"Main";
        // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}
- (void)initialSize {
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        collectionViewH = 303*SCALING_Y;
        collectionViewW = 320*SCALING_X;
        cellH = 129*SCALING_Y;
        cellW = 119*SCALING_X;
        imgH = 110*SCALING_Y;
        imgW = 110*SCALING_X;
        fontSize = 20 *SCALING_Y;
        labelH = 25*SCALING_Y;
        labelW = 106*SCALING_X;
        buttonW = 155 * SCALING_X;
        buttonH = 40 * SCALING_Y;
        imgGrapX = 20* SCALING_X;
        imgGrapY = 40* SCALING_Y;
        
        nameTxtRect = CGRectMake(self.view.bounds.size.width /2 - (15*scx),  _profileImg.center.y - (imgW/(1*scy)), self.view.bounds.size.width /2 , 30*scy);
        
        
    } else {
        fontSize = 20;
        imgH = 110;
        imgW = 110;
        imgGrapX = 20;
        imgGrapY = 40;
        
        nameTxtRect = CGRectMake(self.view.bounds.size.width /2,  _profileImg.center.y - (imgW/1.8), self.view.bounds.size.width /2 , 30);
        
        
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [self viewDidLoad];
    NSLog(@"viewDidAppear under");
    
    //log in button
    loginBtn.layer.cornerRadius = 5 ;
    _profileImg.layer.cornerRadius =  _profileImg.bounds.size.width/2;
    _profileImg.clipsToBounds = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear under");
}
-(void)viewWillAppear:(BOOL)animated
{
    _profileImg.layer.cornerRadius =  _profileImg.bounds.size.width/2;
    _profileImg.clipsToBounds = YES;
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.isLogin) {
        //        nameTxt.text = appDelegate.first_name;
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: appDelegate.profile_picture]];
        NSLog(@"imageURL: %@",appDelegate.profile_picture);
        if (![appDelegate.profile_picture  isEqual: @""]) {
            
            self.profileImg.image = [UIImage imageWithData:imageData];
            NSLog(@"เข้า login face");
        }
        else
        {
            NSLog(@"เข้า login email");
            self.profileImg.image = [UIImage imageNamed:@"ic_new_imgaccount2.png"];
        }
        
        nameTxt.text = [NSString stringWithFormat:@"%@ %@", appDelegate.first_name, appDelegate.last_name];
        profileDes.hidden = true;
        
        
        //: imageData];
        [loginBtn setTitle:@"LOGOUT" forState:UIControlStateNormal];
        //        [loginBtn setBackgroundColor:[UIColor redColor]];
        [loginBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [loginBtn addTarget:self  action:@selector(logOut:) forControlEvents:UIControlEventTouchDown];
        
    }
    else
    {
        [loginBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [loginBtn addTarget:self  action:@selector(logIN:) forControlEvents:UIControlEventTouchDown];
    }
    NSLog(@"viewWillAppear Reload");
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [self viewDidLoad];
    NSLog(@"viewWillDisappear under");
}
- (void)logIN:(id)sender{
    NSLog(@"LogIn");
    // NSString * storyboardName = @"Main";
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginnav"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)logOut:(id)sender{
    
    /////////////////////////////////////////////////////////////////
    // The UA-XXXXX-Y tracker ID is loaded automatically from the
    // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
    // If you're copying this to an app just using Analytics, you'll
    // need to configure your tracking ID here.
    // [START screen_view_hit_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSString *name = [NSString stringWithFormat:@"Menu_Logout"];
    NSLog(@"analytics %@",name);
    NSString *dimensionValue = @"iOS";
    NSString *metricValue = @"iOS_METRIC_VALUE";
    [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
    [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // [END screen_view_hit_objc]
    //////////////////////////////////////////////////////////////////
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.isLogin = NO;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    
    
    nameTxt.text = @"My Account";
    _profileImg.image = [UIImage imageNamed:@"ic_new_imgaccount2.png"];
    
    profileDes.hidden = NO;
    [loginBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [loginBtn addTarget:self  action:@selector(logIN:) forControlEvents:UIControlEventTouchDown];
    [loginBtn setTitle:@"LOGIN HERE" forState:UIControlStateNormal];
    NSLog(@"LogOut");
    [SCFacebook logoutCallBack:^(BOOL success, id result) {
        if (success) {
            
            NSLog(@"logout FB success");
            _profileImg.image = [UIImage imageNamed:@"ic_new_imgaccount2.png"];
            //[self showMessage:[result description]];
        }
        else{
            
            NSLog(@"logout FB not success");
            
        }
    }];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadJSON {
    //NSURL *url = [NSURL URLWithString:RoiApiURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:RoiApiURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //NSArray *response = (NSArray *)responseObject;
        /*
         for (NSDictionary *stmRecord in response) {
         
         NSLog(@"id_stream: %@", stmRecord[@"id_stream"]);
         NSLog(@"title: %@", stmRecord[@"title"]);
         NSLog(@"snapshots: %@", stmRecord[@"snapshots"][@"320x240"]);
         NSLog(@"urls: %@", stmRecord[@"urls"][@"http"]);
         NSLog(@"createdate: %@", stmRecord[@"createdate"]);
         NSLog(@"latitude: %@", stmRecord[@"latitude"]);
         NSLog(@"longitude: %@", stmRecord[@"longitude"]);
         
         }
         */
        
        /*
         //NSDictionary
         NSMutableArray *recordObjects = [NSMutableArray array];
         for (NSDictionary *roiRecord in response) {
         ROI *roi = [[ROI alloc] init];
         roi.roiTagKeyName = roiRecord[@"id_provider_information_tag_keyname"];
         roi.roiKeyName = roiRecord[@"provider_information_tag_keyname"];
         roi.roiName = roiRecord[@"provider_information_tag_name"];
         
         
         NSMutableArray *cctvObjects = [NSMutableArray array];
         for (NSDictionary *cctvRecord in roiRecord[@"cctvs"]) {
         CCTVS *cctvs = [[CCTVS alloc] init];
         cctvs.cctvName = cctvRecord[@"label_en"];
         cctvs.imageUrl = cctvRecord[@"live_url"];
         cctvs.latitude = cctvRecord[@"latitude"];
         cctvs.longitude = cctvRecord[@"longitude"];
         for (NSDictionary *url in cctvRecord[@"url"]) {
         cctvs.shareUrl = url[@"url"];
         }
         
         
         
         
         [cctvObjects addObject:cctvs];
         }
         
         roi.cctvs = [NSArray arrayWithArray:cctvObjects];
         
         [recordObjects addObject:roi];
         }
         
         
         //NSArray *cctv = [response valueForKey:@"cctvs"];
         
         for (ROI *roi in recordObjects) {
         //NSLog(@"roi_id: %@", roi.roiTagKeyName);
         //NSLog(@"roi_key: %@", roi.roiKeyName);
         NSLog(@"roi: %@", roi.roiName);
         for (CCTVS *cctvs in roi.cctvs) {
         NSLog(@"- %@",cctvs.cctvName);
         NSLog(@"- %@",cctvs.imageUrl);
         NSLog(@"- %@",cctvs.latitude);
         NSLog(@"- %@",cctvs.longitude);
         NSLog(@"- %@",cctvs.shareUrl);
         }
         }
         */
        //NSLog(@"JSON: %@", response);
        //NSLog(@"JSON: %@", cctv);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)LoginBtn:(id)sender {
    NSLog(@"LogOut");
}
#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return [_menuImageName count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    CollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imgMenu.image = [UIImage imageNamed:[_menuImageName objectAtIndex:indexPath.item]];
    cell.lblMenu.text =[_menuLabelName objectAtIndex:indexPath.item];
    
    if(indexPath.item == 1){
        cell.lblMenu.textColor = [UIColor grayColor];
    }
    else if(indexPath.item == 2){
        //            cell.lblMenu.textColor = [UIColor grayColor];
    }
    else if(indexPath.item == 3){
        cell.lblMenu.textColor = [UIColor grayColor];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        //        [self initialSize];
        //      return CGSizeMake(cellW ,cellH);
        
        return CGSizeMake(self.collectionView.frame.size.width / 3 - 1 ,self.collectionView.bounds.size.height/ 2 - 35);
        
    }
    else{
        return CGSizeMake(collectionView.frame.size.width / 3 - 1 ,collectionView.frame.size.height/ 2);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    if(indexPath.item == 0){
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"Menu_HelpfullContact"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        
        
        HelpfullContactViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"helpfullNav"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:true completion:nil];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        //        [self performSegueWithIdentifier:@"showaccount" sender:self];
        
    }
    if(indexPath.item == 2){
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"Menu_HelpfullContact"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        
        
        MyDestinationViewController *DestinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"destinationNav"];
        DestinationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:DestinationVC animated:true completion:nil];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        //        [self performSegueWithIdentifier:@"showaccount" sender:self];
        
    }
    if(indexPath.item == 4){
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"Menu_ShareFP"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        // [END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        NSURL *urlFanpage = [ [ NSURL alloc ] initWithString: @"https://www.facebook.com/seeitlivethailand/?fref=ts" ];
        [[UIApplication sharedApplication] openURL:urlFanpage];
    }
    if(indexPath.item == 5){
        /////////////////////////////////////////////////////////////////
        // The UA-XXXXX-Y tracker ID is loaded automatically from the
        // GoogleService-Info.plist by the `GGLContext` in the AppDelegate.
        // If you're copying this to an app just using Analytics, you'll
        // need to configure your tracking ID here.
        // [START screen_view_hit_objc]
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *name = [NSString stringWithFormat:@"Menu_Setting"];
        NSLog(@"analytics %@",name);
        NSString *dimensionValue = @"iOS";
        NSString *metricValue = @"iOS_METRIC_VALUE";
        [tracker set:[GAIFields customDimensionForIndex:1] value:dimensionValue];
        [tracker set:[GAIFields customMetricForIndex:1] value:metricValue];
        [tracker set:kGAIScreenName value:name];
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        //[END screen_view_hit_objc]
        //////////////////////////////////////////////////////////////////
        
        [self performSegueWithIdentifier:@"setting" sender:self];
    }
}
//- (CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath {
//
//
//    return CGSize[collectionView.frame.size.width/3-2, collectionView.frame.size.width/3-2];
//
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showaccount"])
    {
        // Get reference to the destination view controller
        UINavigationController *nav = [segue destinationViewController];
        MyAccountViewController *vc = (MyAccountViewController *)nav.topViewController;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    //    else if([[segue identifier] isEqualToString:@"under2login"])
    //    {
    //        // Get reference to the destination view controller
    //        UINavigationController *nav = [segue destinationViewController];
    //        LoginNavViewController *vc = (LoginNavViewController *)nav.topViewController;
    //        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //
    //    }
    else if ([[segue identifier] isEqualToString:@"setting"]){
        UINavigationController *nav = [segue destinationViewController];
        SettingTableViewController *settingVc = (SettingTableViewController *)nav.topViewController;
        settingVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
}

//
//- (void)canRotate{
//   NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait]; [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//  }
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


@end
