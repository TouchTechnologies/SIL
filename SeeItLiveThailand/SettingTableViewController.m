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
#import "CustomIOSAlertView.h"
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
    
    UIButton *upgradeBtn;
    CGRect upgradeViewRect;
    CGRect closePopupRect;
    CGRect upgradeBtnRect;
    CGRect titleRect;
    CGRect keyTxtRect;
    CGRect submitBtnRect;
    UITextField *keyTxt;
    
    SettingTableViewCell *cell;
    CustomIOSAlertView *alertView;
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
    return 4 ;
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
    else if([indexPath row] == 3){
    
        upgradeBtn = [[UIButton alloc] initWithFrame:upgradeBtnRect];
        upgradeBtn.backgroundColor = [UIColor colorWithRed:0.20 green:0.36 blue:0.60 alpha:1.0];
        upgradeBtn.layer.cornerRadius = 5 ;
        [upgradeBtn addTarget:self action:@selector(upgrade:) forControlEvents: UIControlEventTouchUpInside];
        [cell setSelected:NO];
        
        [upgradeBtn setTitle: @"Upgrade" forState:UIControlStateNormal];
        [cell.accessoryTypeImg setHidden:TRUE];
        cell.textLbl.text = nil;
        [cell.Img setHidden: TRUE];
        [cell.contentView addSubview:upgradeBtn];
    
    }
    
    // Configure the cell...
    
    return cell;
}
-(void)upgrade:(id)sender{
    NSLog(@"UPgrade");
    alertView = [[CustomIOSAlertView alloc] init];
    [alertView setContainerView:[self createPopup]];
    alertView.buttonTitles = nil;
    [alertView setDelegate:self];
    [alertView setUseMotionEffects:true];
    [alertView show];

}
- (UIView *)createPopup
{
    UIView *upgradeView = [[UIView alloc] initWithFrame:upgradeViewRect];
    upgradeView.backgroundColor = [UIColor whiteColor];
    upgradeView.layer.cornerRadius = 10;
    
    UIButton *closePopup = [[UIButton alloc] initWithFrame:CGRectMake(upgradeView.bounds.size.width - 30 , 0 , 30, 30)];
    [closePopup setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    closePopup.backgroundColor = [UIColor redColor];
    closePopup.layer.cornerRadius = 5 ;
    [closePopup addTarget:self action:@selector(ClosePopup:) forControlEvents:UIControlEventTouchUpInside];
    [upgradeView addSubview:closePopup];
    
    UILabel *title = [[UILabel alloc] initWithFrame:titleRect ];
    title.text = @"Please enter your key";
    title.textAlignment = NSTextAlignmentCenter;
     [upgradeView addSubview:title];
    
    
    keyTxt = [[UITextField alloc] initWithFrame:keyTxtRect];
    keyTxt.backgroundColor = [UIColor lightGrayColor];
    keyTxt.layer.cornerRadius = 5 ;
    keyTxt.delegate = self;
    keyTxt.autocapitalizationType = false;
    [upgradeView addSubview:keyTxt];

    UIButton *submitBtn = [[UIButton alloc] initWithFrame:submitBtnRect];
    [submitBtn setTitle:@"OK" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius =5;
    submitBtn.backgroundColor = [UIColor colorWithRed:0.20 green:0.36 blue:0.60 alpha:1.0];
    [submitBtn addTarget:self action:@selector(submitKey:) forControlEvents:UIControlEventTouchUpInside];
     [upgradeView addSubview:submitBtn];
    
    
    return upgradeView;
}
-(void)ClosePopup:(id)sender{
    [alertView close];
}
-(void)submitKey:(id)sender{

    NSLog(@"Key OK : %@ ",keyTxt.text);
    
    // Store the data
    if([keyTxt.text isEqualToString:@"S331tLiv3Th@il@nd"])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:true forKey:@"isActivate"];
        [defaults synchronize];
    }else{
        keyTxt.text = @"key fail";
    }

    [alertView close];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return true;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if([indexPath row] == 2){
        
      //  [cell.Img setImage:[UIImage imageNamed:@"ic_more_about.png"]];
     //   image = [UIImage imageNamed:@"ic_more_about.png"];
      //  [cell.textLbl setTextColor:[UIColor redColor]];
        
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
    CGFloat scx = (768.0/360.0);
    CGFloat scy = (1024.0/480.0);

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cellH = 70 * SCALING_Y;
        // scHeight = 240 * SCALING_Y;
        upgradeBtnRect = CGRectMake(self.view.bounds.size.width/2 - (40*scx), cellH/2 - (20*scy), 80*scx, 40*scy);
        upgradeViewRect = CGRectMake(0*scx, 0*scy, self.view.bounds.size.width/1.5 ,150*scy);
        titleRect = CGRectMake(0*scx, 20*scy, upgradeViewRect.size.width , 30*scy);
        keyTxtRect = CGRectMake(10*scx, 50*scy, upgradeViewRect.size.width - (20*scx), 30*scy) ;
        submitBtnRect = CGRectMake(upgradeViewRect.size.width/2 - (20*scx),keyTxtRect.origin.y + keyTxtRect.size.height + (5*scy), 40*scx, 30*scy);
    }
    else {
        cellH = 70;
        upgradeBtnRect = CGRectMake(self.view.bounds.size.width/2 - 40, cellH/2 - 20, 80, 40);
        upgradeViewRect = CGRectMake(0, 0, self.view.bounds.size.width/1.5 , 150);
        titleRect = CGRectMake(0, 20, upgradeViewRect.size.width , 30);
        keyTxtRect = CGRectMake(10, 50, upgradeViewRect.size.width - 20, 30) ;
        submitBtnRect = CGRectMake(upgradeViewRect.size.width/2 - 20, keyTxtRect.size.height + keyTxtRect.origin.y + 5, 40, 30);
    
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
