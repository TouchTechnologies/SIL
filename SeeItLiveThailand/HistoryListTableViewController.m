//
//  HistoryListTableViewController.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/11/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "HistoryListTableViewController.h"
#import "VideoDetailViewController.h"
#import "VideoPagingViewController.h"
#import "ROI.h"
#import "historyCell.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#define SCALING_Y (1024.0/480.0);

@interface HistoryListTableViewController (){

    
    CGFloat cellHeight;
    CGFloat fontSize;
    CGFloat scHeight;
    NSInteger shareIndex;

    
}

@end

@implementation HistoryListTableViewController
@synthesize tableView , historyCell;



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"passsing data %@",_CCTV_ID);
    
    NSLog(@"count : %lu",(unsigned long)[_imgArr count]);
    [self setTitleBar];
    [self initialSize];
//    UINavigationBar *navbar = [self.navigationController navigationBar];
//    navbar.barTintColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.7 alpha:1];
    
    UINib *nib = [UINib nibWithNibName:@"historyCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"historyCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setTitleBar {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:fontSize],UITextAttributeFont, nil];
        self.navigationController.navigationBar.titleTextAttributes = size;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.7 alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
    } else {
        NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:fontSize],NSFontAttributeName, nil];
        self.navigationController.navigationBar.titleTextAttributes = size;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.22 green:0.47 blue:0.7 alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
}
- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cellHeight = 260 * SCALING_Y;
        scHeight = 240 * SCALING_Y;
    //    imgHeight = 180 * SCALING_Y;
        
        fontSize = 14.0 * SCALING_Y;
        //grapFontW = 25.0 * SCALING_X;
//        grapFontW = 7 * SCALING_X;
//        lblH = 25 * SCALING_Y;
//        lblPlaceY = 32 * SCALING_Y;
//        lblInitialY = 189 * SCALING_Y;
//        lblChangelY = 194 * SCALING_Y;
//        icoInitialY = 185 * SCALING_Y;
//        iconPointW = 25 * SCALING_X;
//        iconPlaceW = 25 * SCALING_X;
//        grapLblPointW = 5 * SCALING_X;
        //grapLblPointW = 5;
//        grapIconPointW = 5 * SCALING_X;
//        grapIconPointWL = 2 * SCALING_X;
//        pagingSize = 30 * SCALING_X;
//        dotSize = 11.0 * SCALING_X;
        
    } else {
        
        cellHeight = 260;
//        scHeiht = 240;
//        imgHeight = 180;
        
        fontSize = 14;
//        grapFontW = 7;
//        lblH = 25;
//        lblPlaceY = 32;
//        lblInitialY = 189;
//        lblChangelY = 194;
//        icoInitialY = 185;
//        iconPointW = 25;
//        iconPlaceW = 25;
//        grapLblPointW = 5;
//        grapIconPointW = 5;
//        grapIconPointWL = 2;
//        pagingSize = 30;
//        dotSize = 11.0;
    }
}

//- (void)initialSize {
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        cellHeight = 260 * SCALING_Y;
//        fontSize = 14.0 * SCALING_Y;
//        scHeight = 240 * SCALING_Y;
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSLog(@"count : %lu",(unsigned long)[appDelegate.imgArr count]);
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 3;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    return appDelegate.imgArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat rowHeight = self.vdoList.count ? 260 : 100;
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"historyCell";
    historyCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    
    //    NSArray *imgArr = @[@"image4.jpg" , @"image5.jpg" ,@"image6.jpg"];
    //    NSArray *timeArr = @[@"12.09" , @"12.06" ,@"12.03"];
    cell.image.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:appDelegate.imgArr[indexPath.row]]]];
    cell.timeHistoryLbl.text =  appDelegate.timeArr[indexPath.row];
    [cell.shareHistoryBtn addTarget:self action:@selector(share:)  forControlEvents:UIControlEventTouchUpInside];
    shareIndex = indexPath.row;
    return cell;
}

- (void)share:(UIButton*)sender {
    
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    NSLog(@"Test Shared");
        
    NSString * shareUrl = appDelegate.imgArr[shareIndex];
    NSLog(@"Share Image %@",shareUrl);
        
        NSArray *shareItems = @[shareUrl];
        
        //UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
        //NSMutableArray * shareItems = [NSMutableArray new];
        //[shareItems addObject:imgShare];
        //[shareItems addObject:message];
        
        UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
        
        //if iPhone
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentViewController:avc animated:YES completion:nil];
        }
        //if iPad
        else {
            // Change Rect to position Popover
            UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:avc];
            [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width-35, 60, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)backtoVdodetailBtn:(UIBarButtonItem*)sender {
    //  VideoDetailViewController *vdoDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videodetail"];
    NSLog(@"Back 2 vdoDetail");
//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    [self dismissViewControllerAnimated:true completion:nil];

}
@end
