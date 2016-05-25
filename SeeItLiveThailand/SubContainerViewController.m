//
//  SubContainerViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/2/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "SubContainerViewController.h"
#import "VideoListViewController.h"
#import "VideoPagingViewController.h"
#import "NavVideoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface SubContainerViewController ()<CLLocationManagerDelegate> {
    CGFloat parentBarHeight;
    CGFloat barHeight;
    CGFloat btY;
    CGFloat btW;
    CGFloat btGrab;
    CGFloat lblTitleW;
    CGFloat lblTitleH;
    
    CGFloat fontSize;
    
}
@property UIViewController  *currentDetailViewController;
@property (nonatomic, strong) UIView *toolbarView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation SubContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialSize];
    [self initial];
    
    VideoPagingViewController *vdoPaging = [self.storyboard instantiateViewControllerWithIdentifier:@"videoPaging"];
    
    [self presentDetailController:vdoPaging];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        parentBarHeight = 45.0 * SCALING_Y;
        barHeight = 40.0 * SCALING_Y;
        btY = 5.0 * SCALING_Y;
        btW = 30.0 * SCALING_X;
        btGrab = 10 * SCALING_X;
        lblTitleH = 35.0 * SCALING_Y;
        lblTitleW = 200.0 * SCALING_X;
        fontSize = 18.0  * SCALING_X;
        
    } else {

        parentBarHeight = 45.0;
        barHeight = 40.0;
        btY = 5.0;
        btW = 30.0;
        btGrab = 10;
        lblTitleH = 35.0;
        lblTitleW = 200.0;
        fontSize = 18.0;
    }
}

- (void)initial {
    
    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    [self.locationManager startUpdatingLocation];
    
    CGFloat boundWidth = self.view.bounds.size.width;
    CGFloat boundHeight = self.view.bounds.size.height;
    CGRect topbarRect = CGRectMake(0, 0, self.view.bounds.size.width, barHeight);
    CGFloat heightExtend;
    
    if([[UIApplication sharedApplication] isStatusBarHidden]) {
        heightExtend = 0;
    } else {
        heightExtend = 20;
    }
    
    
    _toolbarView = [[UIView alloc] initWithFrame:topbarRect];
    _toolbarView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolbarView];
    
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(0, parentBarHeight, boundWidth, (boundHeight-parentBarHeight)-heightExtend)];
    self.detailView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.detailView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.detailView];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    UILabel *titleBar = [[UILabel alloc] initWithFrame:CGRectMake((boundWidth/2) - (lblTitleW/2), btY, lblTitleW, lblTitleH)];
    titleBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    titleBar.text = @"CCTV Live";
    titleBar.font = font;
    titleBar.backgroundColor = [UIColor clearColor];
    titleBar.textAlignment = NSTextAlignmentCenter;
    [_toolbarView addSubview:titleBar];
    
    UIButton *btnSlView = [[UIButton alloc] initWithFrame:CGRectMake(boundWidth - ((btW * 2) + (btGrab * 2)), btY, btW, btW)];
    btnSlView.tag = 1;
    [btnSlView setBackgroundImage:[UIImage imageNamed:@"icon_J.png"] forState:UIControlStateNormal];
    [btnSlView addTarget:self action:@selector(selectSlView:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnSlView];
    
    UIButton *btnTbView = [[UIButton alloc] initWithFrame:CGRectMake(boundWidth - (btW + btGrab), btY, btW, btW)];
    btnTbView.tag = 2;
    [btnTbView setBackgroundImage:[UIImage imageNamed:@"icon_H1.png"] forState:UIControlStateNormal];
    [btnTbView addTarget:self action:@selector(selectTbView:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarView addSubview:btnTbView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)activeMenu:(NSInteger)buttonNumber {
    for (UIView *view in [self.toolbarView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *menuButton = (UIButton *)view;
            //NSLog(@"%ld",menuButton.tag);
            NSMutableString *imgButtonName = [[NSMutableString alloc] init];
            switch (view.tag) {
                case 1:
                    [imgButtonName setString:@"icon_J"];
                    break;
                case 2:
                    [imgButtonName setString:@"icon_H"];
                    break;
                    
                default:
                    break;
            }
            
            if (buttonNumber != view.tag) {
                [imgButtonName appendString:@"1"];
            }
            
            [imgButtonName appendString:@".png"];
            
            [menuButton setBackgroundImage:[UIImage imageNamed:imgButtonName] forState:UIControlStateNormal];
            
        }
        //NSLog(@"%ld",view.tag);
    }
}

- (void)presentDetailController:(UIViewController*)detailVC{
    
    //0. Remove the current Detail View Controller showed
    if(self.currentDetailViewController){
        [self removeCurrentDetailViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:detailVC];
    
    //2. Define the detail controller's view size
    //detailVC.view.frame = [self frameForDetailController];
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    [self.detailView addSubview:detailVC.view];
    self.currentDetailViewController = detailVC;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [detailVC didMoveToParentViewController:self];
    
}

- (void)removeCurrentDetailViewController{
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.currentDetailViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
    [self.currentDetailViewController removeFromParentViewController];
}

- (void)swapCurrentControllerWith:(UIViewController*)viewController{
    
    //1. The current controller is going to be removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. The new controller is a new child of the container
    [self addChildViewController:viewController];
    
    //3. Setup the new controller's frame depending on the animation you want to obtain
    //viewController.view.frame = CGRectMake(0, 2000, viewController.view.frame.size.width, viewController.view.frame.size.height);
    
    //3b. Attach the new view to the views hierarchy
    [self.detailView addSubview:viewController.view];
    
    [self.currentDetailViewController.view removeFromSuperview];
    
    //Remove the old Detail controller from the hierarchy
    [self.currentDetailViewController removeFromParentViewController];
    
    //Set the new view controller as current
    self.currentDetailViewController = viewController;
    [self.currentDetailViewController didMoveToParentViewController:self];
    
}

-(IBAction)selectSlView:(id)sender {
    [self activeMenu:1];
    VideoPagingViewController *vdoPaging = [self.storyboard instantiateViewControllerWithIdentifier:@"videoPaging"];
    [self swapCurrentControllerWith:vdoPaging];
}

-(IBAction)selectTbView:(id)sender {
    [self activeMenu:2];
    VideoListViewController *vdoList = [self.storyboard instantiateViewControllerWithIdentifier:@"videoList"];
    [self swapCurrentControllerWith:vdoList];
    
    /*
    //navigatevideo
    NavVideoViewController *navVideo = [self.storyboard instantiateViewControllerWithIdentifier:@"navigatevideo"];
    [self swapCurrentControllerWith:navVideo];
     */
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    CLLocation *newLocation = locations.lastObject;


    NSLog(@"currentLocation.coordinate.latitude  %@",[NSString stringWithFormat:@"%.8f", newLocation.coordinate.latitude]);
    NSLog(@"currentLocation.coordinate.longitude %@",[NSString stringWithFormat:@"%.8f", newLocation.coordinate.longitude]);
    appDelegate.latitude = newLocation.coordinate.latitude;
    appDelegate.longitude = newLocation.coordinate.longitude;
}


@end
