//
//  VideoDetailTableViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/5/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "VideoDetailTableViewController.h"
#import "ScreenShotsCell.h"
#import <Google/Analytics.h>
@interface VideoDetailTableViewController ()
@property (nonatomic) NSString *loadingTitle;
@end

typedef enum {
    eScreenShotsField,
    eLocationField,
    eDescriptionField
    
}EAppDetailFields;

static CGFloat kLoadingCellHeight = 111.0f;

@implementation VideoDetailTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 68.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
        self.imageList = @[@"activities02.jpg",@"activities02.jpg",@"activities02.jpg",@"activities02.jpg"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    // Configure the cell...
    cell = [self customCellForIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0.0;    
    
    rowHeight = self.tableView.rowHeight;
    
    return rowHeight;
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
#pragma mark -
#pragma mark Private

- (UITableViewCell *)customCellForIndexPath:(NSIndexPath *)path
{
    UITableViewCell *cell = nil;
    switch (path.row)
    {
        case eScreenShotsField:
        {
            ScreenShotsCell *screenShotCell = [self.tableView dequeueReusableCellWithIdentifier:@"ScreenShotsCellId"];
            [screenShotCell configureCellForApp:self.imageList andCity:@"" andPlace:@""];
            cell = screenShotCell;
        }
            break;
            
        case eLocationField:
        {

        }
            
            break;
            
        case eDescriptionField:
        {
  
        }
            break;
    }
    return cell;
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)path
{
    CGFloat height = 0.0;
    switch (path.row)
    {
        case eDescriptionField:
        case eLocationField:
        {
            height = self.tableView.rowHeight;
        }
            break;
            
        case eScreenShotsField:
        {
            height = self.view.frame.size.height;
        }
            break;
    }
    return height;
}





@end
