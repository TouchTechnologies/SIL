//
//  HelpfulContactTableViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/21/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "HelpfullContactViewController.h"
#import "HelpfullTableViewCell.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "Helpful.h"
#import "Hotline.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Haneke.h"
#import "MYTapGestureRecognizer.h"
#define SCALING_Y (1024.0/480.0);
#define SCALING_X (768.0/360.0);

@interface HelpfullContactViewController ()
{
    HelpfullTableViewCell *Cell;
    //IBOutlet UISearchBar *searchbar;
    AppDelegate* appDelegate;
    NSArray *contactList;
    NSMutableArray *searchResults;
    NSMutableArray *searchData;
    NSArray *imgContactList;
    NSArray *callNumberlblList;
    NSArray *hotlinesDic;
    
    NSMutableArray *filteredResult; // this holds filtered data source
    NSMutableArray *tableData;
    NSMutableArray* helpfulData;
    Helpful *Helpful;
    Hotline *Hotline;
    HNKCacheFormat *format;
    
    
    UIView *searchBar;
    NSString* searchKey;
    UIImageView *img;
    UITextField *searchTxt;
    CGFloat cellH;
    CGFloat font;
    CGFloat fontDesc;
    CGRect imgContactRect;
    CGRect iconCallRect;
    

}
- (IBAction)SearchBtn:(id)sender;

- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HelpfullContactViewController

- (void)viewDidLoad {
    helpfulData = [[NSMutableArray alloc]init];
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];

    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    
    format = [HNKCache sharedCache].formats[@"thumbnail"];
    if (!format)
    {
        format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
        format.size = CGSizeMake(320, 240);
        format.scaleMode = HNKScaleModeAspectFill;
        format.compressionQuality = 0.5;
        format.diskCapacity = 1 * 1024 * 1024; // 1MB
        format.preloadPolicy = HNKPreloadPolicyLastSession;
    }
//    searchData = [[NSMutableArray alloc]init];
//    for (NSDictionary* hotlineGroup in appDelegate.helpfulData) {
//        NSLog(@"hotline_group_name %@",hotlineGroup[@"hotline_group_name"]);
//        Helpful* helpful = [[Helpful alloc] init];
//        NSMutableArray*hotlineObj = [[NSMutableArray alloc]init];
//        helpful.hotline_group_name = hotlineGroup[@"hotline_group_name"];
//        for (NSDictionary* hotlines in hotlineGroup[@"hotlines"]) {
//            NSLog(@"hotlineshotline_call %@",hotlines[@"hotline_call"]);
//            Hotline* hotline = [[Hotline alloc]init];
//            
//            hotline.hotline_call = hotlines[@"hotline_call"];
//            hotline.hotline_image = hotlines[@"hotline_image"];
//            hotline.hotline_name = hotlines[@"hotline_name"];
//            hotline.hotline_id = hotlines[@"id"];
//            
//            [hotlineObj addObject:hotline];
//            NSLog(@"HOTTTTTTT : %@",hotline);
//            [searchData addObject:hotlines];
//        }
//        helpful.hotline = hotlineObj;
//        [helpfulData addObject:helpful];
//        
//    }

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[UserManager shareIntance] getAPIData:@"listhotline" Completion:^(NSError *error, NSDictionary *result, NSString *message) {
        NSLog(@"listhotline : %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        searchData = [[NSMutableArray alloc]init];
        for (NSDictionary* hotlineGroup in result) {
            NSLog(@"hotline_group_name %@",hotlineGroup[@"hotline_group_name"]);
            Helpful* helpful = [[Helpful alloc] init];
            NSMutableArray*hotlineObj = [[NSMutableArray alloc]init];
            helpful.hotline_group_name = hotlineGroup[@"hotline_group_name"];
            for (NSDictionary* hotlines in hotlineGroup[@"hotlines"]) {
                NSLog(@"hotlineshotline_call %@",hotlines[@"hotline_call"]);
                Hotline* hotline = [[Hotline alloc]init];
                
                hotline.hotline_call = hotlines[@"hotline_call"];
                hotline.hotline_image = hotlines[@"hotline_image"];
                hotline.hotline_name = hotlines[@"hotline_name"];
                hotline.hotline_id = hotlines[@"id"];
       
                [hotlineObj addObject:hotline];
                NSLog(@"HOTTTTTTT : %@",hotline);
                [searchData addObject:hotlines];
            }
            helpful.hotline = hotlineObj;
            [helpfulData addObject:helpful];
            
        }
        [self.tableView reloadData];
        NSLog(@"searchData : %@",searchData);
        NSLog(@"searchData Count : %lu",(unsigned long)searchData.count);
        
    }];

//    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    appDelegate.isSearch = false;
      [self.tableView setFrame:CGRectMake(0,-50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 50)];

    [super viewDidLoad];
 
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    searchTxt.delegate = self;
    [self initialSize];
}
-(void)initial{
    //[searchbar setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];

}
-(void)initialSize
{
    CGFloat scy = (1024.0/480.0);
     CGFloat scx = (768.0/360.0);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat Height = [UIScreen mainScreen].bounds.size.height;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cellH = 70*SCALING_Y;
        font = 16*SCALING_Y;
        fontDesc = 14*SCALING_Y;
        
        imgContactRect = CGRectMake(10*scx, 10*scy, cellH - (20*scx) , cellH - (20*scy));
        iconCallRect = CGRectMake(width - (cellH - 10*scx ), 10*scy, cellH - 20*scx , cellH - (20*scy) );
    }
    else{
        cellH = 70;
        font = 16;
        fontDesc = 14;
        
        imgContactRect = CGRectMake(10, 10, cellH - 20 , cellH - 20 );
        iconCallRect = CGRectMake(width - (cellH-10), 10, cellH - 20 , cellH - 20 );
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void) filterForSearchText:(NSString *) text scope:(NSString *) scope
//{
//    [filteredResult removeAllObjects]; // clearing filter array
//    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF.restaurantName contains[c] %@",text]; // Creating filter condition
//    filteredResult = [NSMutableArray arrayWithArray:[tableData filteredArrayUsingPredicate:filterPredicate]]; // filtering result
//}
//-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterForSearchText:searchString scope:[[[[self searchDisplayController] searchBar] scopeButtonTitles] objectAtIndex:[[[self searchDisplayController] searchBar] selectedScopeButtonIndex] ]];
//    
//    return YES;
//}
//
//-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
//{
//    [self filterForSearchText:self.searchDisplayController.searchBar.text scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
//    
//    return YES;
//}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    searchResults = [[NSMutableArray alloc]init];
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"self contains[cd] %@",
//                                    searchText];
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"ANY hotline.hotline_name contains[c]%@",
//                                    searchText];
    
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"hotline_name contains[c]%@",
                                    searchText];
//    NSLog(@"searchText :%@",searchText);
    searchKey = searchText;
//    NSLog(@"searchData2 %@",searchData2);
    NSLog(@"helpfulData : %@",[searchData filteredArrayUsingPredicate:resultPredicate]);
//    Hotline *searchHotline = searchData;
//    searchResults = [searchData filteredArrayUsingPredicate:resultPredicate];

//    searchResults = [searchData2 filteredArrayUsingPredicate:resultPredicate]
//    [searchResults addObject:[searchData2 filteredArrayUsingPredicate:resultPredicate]];
    [searchResults addObjectsFromArray:[searchData filteredArrayUsingPredicate:resultPredicate]];
//    [searchResults arrayByAddingObjectsFromArray:[searchData2 filteredArrayUsingPredicate:resultPredicate]];
//    for(int i = 0;i<[searchData2 filteredArrayUsingPredicate:resultPredicate].count;i++)
//    {
//        NSLog(@"index : %d",i);
//        [searchResults addObject:[searchData2 filteredArrayUsingPredicate:resultPredicate][i]];
//    }
    NSLog(@"searchResultsCount %ld",searchResults.count);
    
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    NSLog(@"searchDisplayController");
    return YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
        
    }else
    {
        return helpfulData.count;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return @"Search Results";
        
    }else{
        Helpful *helpful = [helpfulData objectAtIndex:section];
        return helpful.hotline_group_name;
    }

}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
//    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
//    return [sectionAnimals count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"search results %lu",(unsigned long)searchResults.count);
        return searchResults.count;
        
    } else {
        Helpful *helpful = [helpfulData objectAtIndex:section];
        NSLog(@"helpful %@",helpful.hotline_group_name );
    return helpful.hotline.count;
}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINib *nib = [UINib nibWithNibName:@"HelpfullCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (Cell == nil) {
        Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MYTapGestureRecognizer* TapCall = [[MYTapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(Call:)];//Here should be actionViewTap:
    [TapCall setNumberOfTouchesRequired:1];
    [TapCall setDelegate:self];
    Cell.btnCall.userInteractionEnabled = YES;
    [Cell.btnCall addGestureRecognizer:TapCall];
    TapCall.enabled = YES;

    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"search Data : %@",[searchResults objectAtIndex:indexPath.row]);
        NSDictionary* searchRS = [searchResults objectAtIndex:indexPath.row];
        NSLog(@"namaaaaaaa %@",searchRS[@"hotline_name"]);
//        Helpful *helpful = [searchResults objectAtIndex:indexPath.section];
//        Hotline *hotline = [helpful.hotline objectAtIndex:indexPath.row];
        
//        NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:[searchResults objectAtIndex:indexPath.row]];
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:searchRS[@"hotline_name"]];
//        NSLog(@"aaaaaaaaaaaa");

        NSLog(@"hotlinename %@",string);
        
        NSLog(@"searchKey : %@",searchKey);
        Cell.imgContact.hnk_cacheFormat = format;
            if ([searchRS[@"hotline_name"] rangeOfString:searchKey options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSLog(@"inIf");
                
                NSRange range=[searchRS[@"hotline_name"] rangeOfString:searchKey options:NSCaseInsensitiveSearch];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            }
//
        [Cell.contactNamelbl setAttributedText:string];
//        Cell.contactNamelbl.text = searchRS[@"hotline_name"];
        Cell.callNumberlbl.text = searchRS[@"hotline_call"];
        
        [Cell.imgContact hnk_setImageFromURL:[NSURL URLWithString:searchRS[@"hotline_image"]]];
//        Cell.imgContact.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:searchRS[@"hotline_image"]]]];
        TapCall.data = searchRS[@"hotline_call"];
    } else {
        Helpful *helpful = [helpfulData objectAtIndex:indexPath.section];
        Hotline *hotline = [helpful.hotline objectAtIndex:indexPath.row];

        NSLog(@"helpful.hotline %@",hotline.hotline_name);
        Cell.contactNamelbl.text = hotline.hotline_name;
        Cell.callNumberlbl.text =hotline.hotline_call;
        [Cell.imgContact hnk_setImageFromURL:[NSURL URLWithString:hotline.hotline_image]];
//        Cell.imgContact.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:hotline.hotline_image]]];
        TapCall.data = hotline.hotline_call;
    }
//    Cell.imgContact.image = [UIImage imageNamed:[imgContactList objectAtIndex:indexPath.row]];

    [Cell.imgContact setFrame:imgContactRect];
    Cell.imgContact.layer.cornerRadius = Cell.imgContact.bounds.size.width/2;
    Cell.imgContact.contentMode = UIViewContentModeScaleAspectFit;
    Cell.imgContact.clipsToBounds = YES ;
    Cell.imgContact.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    Cell.contactNamelbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    Cell.callNumberlbl.font = [UIFont fontWithName:@"Helvetica" size:fontDesc];
    
    [Cell.btnCall setFrame:iconCallRect];
    
    img = [[UIImageView alloc] initWithFrame: Cell.btnCall.bounds];
    img.contentMode = UIViewContentModeScaleAspectFit ;
    img.image = [UIImage imageNamed:@"call_icon2.png"];
    

    
    [Cell.btnCall addSubview:img];
//    Cell.btnCall.tag = 555555;
//    [Cell.btnCall addTarget:self action:@selector(Call:) forControlEvents:UIControlEventTouchUpInside];
    
//    Cell.backgroundColor = [UIColor yellowColor];
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return cellH;
}

-(void)Call:(id)sender{

    MYTapGestureRecognizer *tapRecognizer = (MYTapGestureRecognizer *)sender;
    NSLog (@"callNumber %@",tapRecognizer.data);

    
    NSLog(@":::::Test Call:::::");
    
//    if(appDelegate.isSearch)
//    {
//        Hotline *hotline = [helpful.hotline objectAtIndex:callTag];
//        
//        NSLog(@"helpful.hotline %@",hotline.hotline_name);
//        Cell.contactNamelbl.text = hotline.hotline_name;
//        Cell.callNumberlbl.text =hotline.hotline_call;
//        
//    }
//    NSString *phoneCallNum = [NSString stringWithFormat:@"tel://%@",tapRecognizer.data];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
    
//    NSLog(@"phone btn touch %@", phoneCallNum);
    
   // NSString *phNo = @"+919876543210";
//    NSArray* phoneString = [tapRecognizer.data componentsSeparatedByString: @","];
//    
//
//    NSString* phoneNumber = [phoneString[0] stringByReplacingOccurrencesOfString:@" "
//                                                               withString:@""];;
//    NSLog(@"phoneArray %@",phoneString);
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",tapRecognizer.data]];
    NSLog(@":::::phoneUrl Call::::: : %@",phoneUrl);
//    [[UIApplication sharedApplication] openURL:phoneUrl];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        
        NSLog(@"NOT CALL") ;
        
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
     [calert show];
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

- (IBAction)SearchBtn:(id)sender {
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
    BOOL sw = appDelegate.isSearch ;
    if (appDelegate.isSearch == false) {
       [self.tableView setFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        appDelegate.isSearch = true ;
    }
    else{
        [self.tableView setFrame:CGRectMake(0,-50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 50)];
     appDelegate.isSearch = false ;
    }
        NSLog(@"ISSEARCH ::: %@",sw ? @"true" : @"false");
    
//    searchbar.hidden = false;
   
}
-(void)closeSearch:(id)sender{
    searchBar.hidden = true;
   [self.tableView setFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50)];

}

- (IBAction)backBtn:(id)sender {
         [self dismissViewControllerAnimated:true completion:nil];
}
@end
