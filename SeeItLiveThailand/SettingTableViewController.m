//
//  SettingTableViewController.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/14/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SettingTableViewCell.h"
#import "AboutSeeItLiveViewController.h"
#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface SettingTableViewController ()
{
    CGFloat imgW;
    CGFloat imgH;
    CGFloat LabelW;
    CGFloat LabelH;
    CGFloat cellH;
    CGFloat cellW;
    
    SettingTableViewCell *cell;
}
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [super viewDidLoad];
    [self initialSize];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    //[return YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINib *nib = [UINib nibWithNibName:@"settingCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
   cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if([indexPath row] == 0){
         cell.Img.image = [UIImage imageNamed:@"ic_new_language_newmore2.png"];
         cell.textLbl.text = @"Language";
       
    
    }
    else if([indexPath row] == 1){
    
        cell.Img.image = [UIImage imageNamed:@"ic_new_mynotification_newmore2.png"];
        cell.textLbl.text = @"My Notification";
    }
    else if([indexPath row] == 2){
        cell.Img.image = [UIImage imageNamed:@"ic_more_about2.png"];
        cell.textLbl.text = @"About See it Live";
         cell.textLbl.textColor = [UIColor blackColor];
    }
    
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if([indexPath row] == 2){
    
        cell.Img.image = [UIImage imageNamed:@"ic_more_about.png"];
        cell.textLbl.textColor = [UIColor redColor];
        
        [self performSegueWithIdentifier:@"showabout" sender:self];
    }
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat rowHeight = self.vdoList.count ? 260 : 100;
    return cellH;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
  if ([[segue identifier] isEqualToString:@"showabout"])
    {
        // Get reference to the destination view controller
        UINavigationController *nav = [segue destinationViewController];
        AboutSeeItLiveViewController *about = (AboutSeeItLiveViewController *)nav.topViewController;
        about.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
 
    }
 
}
- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cellH = 70 * SCALING_Y;
        // scHeight = 240 * SCALING_Y;
        
    }
    else {
        cellH = 70;
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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
