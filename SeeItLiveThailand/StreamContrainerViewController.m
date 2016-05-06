//
//  StreamContrainerViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/21/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "StreamContrainerViewController.h"
#import "YSLContainerViewController.h"
#import "StreamLiveViewController.h"
#import "StreamHistoryViewController.h"
#import "UnderConViewController.h"
#import "MBProgressHUD.h"

@interface StreamContrainerViewController ()<YSLContainerViewControllerDelegate>
@end

@implementation StreamContrainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initial];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initial {
    
    //CGRect parentFrame = self.view.bounds;
    //self.gridView.bounds = CGRectMake(parentFrame.origin.x, parentFrame.origin.y , parentFrame.size.width, parentFrame.size.height - 80);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    
    StreamLiveViewController *streamLive = [self.storyboard instantiateViewControllerWithIdentifier:@"StreamLive"];
    streamLive.title = @"Live Streaming";
    
    StreamHistoryViewController *streamHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"StreamHistory"];
    //streamHistory.view.frame = CGRectMake(parentFrame.origin.x, parentFrame.origin.y , parentFrame.size.width, parentFrame.size.height - 180);
    streamHistory.title = @"History Streaming";
    
    
    
    
//   LiveStreamVC *liveStream = [self.storyboard instantiateViewControllerWithIdentifier:@"livestream"];
//    //streamHistory.view.frame = CGRectMake(parentFrame.origin.x, parentFrame.origin.y , parentFrame.size.width, parentFrame.size.height - 180);
//    streamHistory.title = @"My Livestream";
    // ContainerView
    //float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    //float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[streamLive,streamHistory]
                                                                                        topBarHeight:0
    
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:25];
    
    
    [self.view addSubview:containerVC.view];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
        //NSLog(@"current Index : %ld",(long)index);
        //NSLog(@"current controller : %@",controller);
    //[controller loadView];
    [controller viewDidLoad];
    //[controller viewWillDisappear:NO];
    //[controller viewWillAppear:NO];
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
