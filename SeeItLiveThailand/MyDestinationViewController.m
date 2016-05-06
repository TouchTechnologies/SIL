//
//  MyDestinationViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/22/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "MyDestinationViewController.h"
#import "DestinationCell.h"
#import "AppDelegate.h"
#import "Model_POIS.h"
@interface MyDestinationViewController ()
{
    AppDelegate *appDelegate;
    IBOutlet UIImageView *iconDestination;
    IBOutlet UILabel *descripLbl;
    IBOutlet UIView *searchView;
    IBOutlet UIView *destinationHeaderView;
    
    UIView *claerAllView;
    UIButton *closeBtn;
    
    
    IBOutlet UILabel *DestLbl;
    
    IBOutlet UIButton *editBtn;
    
    IBOutlet UISearchBar *searchBar;
    IBOutlet UISearchController *searchDisplayController;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *saveLoctaionBtn;
    
    IBOutlet UIView *notDestinationView;
    
    IBOutlet UIImageView *notLocationIcon;
    IBOutlet UILabel *notLocationLbl;
    
    IBOutlet UITableView *tableView;
    IBOutlet UITableView *searchDisplayTbl;
    
    UIButton *barRight;
    
    DestinationCell *Cell;
    CGRect iconDestinationRect;
    CGRect descripLblRect;
    CGRect searchViewRect;
    CGRect scrollViewRect;
    CGRect saveLoctaionBtnRect;
    CGRect destinationHeaderViewRect;
    CGRect DestLblRect;
    CGRect notDestinationViewRect;
    CGRect notLocationIconRect;
    CGRect notLocationLblRect;
    CGFloat font;
    CGFloat cellH;
    CGFloat searchCellH;
    CGRect tableViewRect;
    CGRect searchtableViewRect;
    CGRect closeBtnRect;
    CGRect editBtnRect;
    CGRect barRightRect;
    CGRect clrBtnRect;
    CGRect imgclearRect;
    CGRect lblClearRect;
    UIColor *routeBtnColor;
    int *count;
    BOOL searchActive;
    BOOL isEdit;
    NSArray *destinationList;
    NSMutableArray *searchDisplayList;
    NSMutableArray *resultSearch;
    
    NSMutableArray *saveLocationData;
    NSDictionary *saveLocation;
    
    
}
- (IBAction)Back:(id)sender;

@end

@implementation MyDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    // Register notification when the keyboard will be show
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // Register notification when the keyboard will be hide
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    searchActive = false;
    isEdit = false;
    //    __weak MyDestinationViewController *weakSelf = self;
    //    searchDisplayList  = [[NSMutableArray alloc] initWithObjects:@"rama 9",@"dindang",@"huaykwang",@"sathorn" , @"rca",nil];
    // searchDisplayList  = [[NSMutableArray alloc] initWithObjects:weakSelf.poiData,nil];
    //    NSLog(@"POI::: %@",weakSelf.poiData[0][@"name_en"]);
    resultSearch = [[NSMutableArray alloc] init];
    saveLocationData = [[NSMutableArray alloc] init];
    searchDisplayTbl.hidden = true;
    [self getPOIDataAPI];
    [self getMyDestinationData];
    [self initialSize];
    [self initial];
    
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
}


-(void)initial{
    
    UINib *nib = [UINib nibWithNibName:@"Destinationcell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    //    destinationList = @[@"oneTTTTTTTTTTTTTTTTSSFSGSDSSSSSFSFSFSFSFFFFFFFFFFFFSGSGSGSGSGSGSGS",@"two",@"three",@"four"];
    //destinationList = nil;
    
    
    if (saveLocationData.count == 0) {
        NSLog(@"saveLocationData == nil");
        tableView.hidden = true;
        editBtn.hidden = true ;
        //        destinationHeaderView.hidden = NO;
        //        claerAllView.hidden = YES;
        //        tableView.hidden =true;
    }
    else{
        NSLog(@"saveLocationData != nil");
        tableView.hidden = false;
        editBtn.hidden = false;
    }
    
    //Check Search Result
    
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [iconDestination setFrame:iconDestinationRect];
    [descripLbl setFrame:descripLblRect];
    descripLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    descripLbl.text = @"Find nearby and your destination";
    [searchView setFrame:searchViewRect];
    searchView.layer.cornerRadius = 5 ;
    searchView.clipsToBounds = YES;
    [searchBar setFrame:searchView.bounds];
    
    // searchDisplayTbl = [[UITableView alloc] initWithFrame:searchtableViewRect ];
    [searchDisplayTbl setFrame:searchtableViewRect];
    [searchDisplayTbl setBackgroundColor:[UIColor clearColor]];
    searchDisplayTbl.layer.cornerRadius = 5;
    searchDisplayTbl.clipsToBounds = YES;
    
    // [scrollView addSubview:searchDisplayTbl];
    
    [saveLoctaionBtn setFrame:saveLoctaionBtnRect];
    [saveLoctaionBtn addTarget:self action:@selector(saveLocation:) forControlEvents:UIControlEventTouchUpInside];
    saveLoctaionBtn.enabled = false;
    saveLoctaionBtn.layer.cornerRadius = 5;
    saveLoctaionBtn.clipsToBounds = YES;
    saveLoctaionBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    
    [destinationHeaderView setFrame:destinationHeaderViewRect];
    destinationHeaderView.layer.cornerRadius = 5 ;
    destinationHeaderView.clipsToBounds = YES;
    
    [DestLbl setFrame:DestLblRect];
    DestLbl.text = @"Destination List";
    DestLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    [notDestinationView setFrame:notDestinationViewRect];
    notDestinationView.layer.cornerRadius = 5 ;
    notDestinationView.clipsToBounds = YES;
    
    [notLocationIcon setFrame:notLocationIconRect];
    notLocationIcon.image = [UIImage imageNamed:@"ic_more_checkin.png"];
    
    [notLocationLbl setFrame:notLocationLblRect];
    notLocationLbl.text = @"Not List Location";
    notLocationLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    notLocationLbl.textColor = [UIColor grayColor];
    
    [editBtn setFrame:editBtnRect];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    [barRight setFrame:barRightRect];
    barRight.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar addSubview:barRight];
    
}
-(void)initialSize{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat navBarWithStatusH = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height ;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        font = 14*scy;
        cellH = 130*scy;
        searchCellH = 50*scy;
        iconDestinationRect = CGRectMake(10*scx, [UIApplication sharedApplication].statusBarFrame.size.height, width - (20*scx), 180*scy);
        descripLblRect = CGRectMake(0*scx, iconDestinationRect.origin.y + iconDestinationRect.size.height, width, 30*scy);
        searchViewRect = CGRectMake(10*scx, descripLblRect.origin.y + descripLblRect.size.height + (5*scy), width - (20*scx), 60*scy);
        searchtableViewRect = CGRectMake(10*scx, searchViewRect.origin.y + searchViewRect.size.height , width - (20*scx), 150*scy);
        
        scrollViewRect = CGRectMake(0, navBarWithStatusH, width, height - navBarWithStatusH);
        saveLoctaionBtnRect = CGRectMake(60*scx, searchViewRect.origin.y + searchViewRect.size.height + (10*scy), width - (120*scx), 50*scy);
        destinationHeaderViewRect = CGRectMake(10*scx, saveLoctaionBtnRect.origin.y + saveLoctaionBtnRect.size.height + (10*scy), width - (20*scx), 60*scy);
        
        DestLblRect = CGRectMake(5*scx, 15*scy, destinationHeaderViewRect.size.width - (50*scx), 30*scy);
        editBtnRect = CGRectMake(destinationHeaderViewRect.size.width - (45*scx), 10*scy , 45*scx, 45*scy);
        
        notDestinationViewRect = CGRectMake(10*scx, destinationHeaderViewRect.origin.y + destinationHeaderViewRect.size.height + (5*scy), width - (20*scx), 160*scy);
        
        notLocationIconRect = CGRectMake(notDestinationViewRect.size.width/2 - (40*scx), notDestinationViewRect.size.height/2 - (60*scy), 80*scx, 80*scy);
        notLocationLblRect = CGRectMake(0*scx, notLocationIconRect.origin.y + notLocationIconRect.size.height + (5*scy), notDestinationViewRect.size.width, 30*scy);
        tableViewRect = CGRectMake(10*scx, destinationHeaderViewRect.origin.y + destinationHeaderViewRect.size.height + (5*scy), width - (20*scx), 160*scy);
        closeBtnRect = CGRectMake(destinationHeaderView.bounds.size.width - (55*scx) ,5*scy, 50*scx, 50*scy);
        clrBtnRect = CGRectMake(closeBtnRect.origin.x - (110*scx), closeBtnRect.origin.y, 100*scx, closeBtnRect.size.height);
        imgclearRect = CGRectMake(5*scx, clrBtnRect.size.height/4,clrBtnRect.size.height/2, clrBtnRect.size.height/2);
        lblClearRect = CGRectMake(imgclearRect.size.width + (5*scx), clrBtnRect.size.height/2 - (15*scy), clrBtnRect.size.width - (imgclearRect.origin.x + imgclearRect.size.width + (5*scx)), 30*scy);
    }
    else{
        font = 14 ;
        cellH =130;
        searchCellH = 50;
        iconDestinationRect = CGRectMake(10, [UIApplication sharedApplication].statusBarFrame.size.height , width - 20, 180);
        descripLblRect = CGRectMake(0, iconDestinationRect.origin.y + iconDestinationRect.size.height, width, 30);
        searchViewRect = CGRectMake(10, descripLblRect.origin.y + descripLblRect.size.height + 5, width - 20, 60);
        
        searchtableViewRect = CGRectMake(10, searchViewRect.origin.y + searchViewRect.size.height, width - 20, 150);
        
        scrollViewRect = CGRectMake(0, 0, width, height - navBarWithStatusH);
        
        saveLoctaionBtnRect = CGRectMake(60, searchViewRect.origin.y + searchViewRect.size.height + 10, width - 120, 50);
        
        destinationHeaderViewRect = CGRectMake(10, saveLoctaionBtnRect.origin.y + saveLoctaionBtnRect.size.height + 10, width - 20, 60);
        
        DestLblRect = CGRectMake(5, 15, destinationHeaderViewRect.size.width - 50, 30);
        editBtnRect = CGRectMake(destinationHeaderViewRect.size.width - 45, 10 , 45, 45);
        notDestinationViewRect = CGRectMake(10, destinationHeaderViewRect.origin.y + destinationHeaderViewRect.size.height + 5, width - 20, 160);
        notLocationIconRect = CGRectMake(notDestinationViewRect.size.width/2 - 40, notDestinationViewRect.size.height/2 - 60, 80, 80);
        notLocationLblRect = CGRectMake(0, notLocationIconRect.origin.y + notLocationIconRect.size.height + 5, notDestinationViewRect.size.width, 30);
        tableViewRect = CGRectMake(10, destinationHeaderViewRect.origin.y + destinationHeaderViewRect.size.height + 5, width - 20, 160);
        closeBtnRect = CGRectMake(destinationHeaderView.bounds.size.width - 55 ,5, 50, 50);
        barRightRect = CGRectMake(width - 60, navBarWithStatusH/2 - 25, 50, 50);
        clrBtnRect = CGRectMake(closeBtnRect.origin.x - 110, closeBtnRect.origin.y, 100, closeBtnRect.size.height);
        imgclearRect = CGRectMake(5, clrBtnRect.size.height/4,clrBtnRect.size.height/2, clrBtnRect.size.height/2);
        lblClearRect = CGRectMake(imgclearRect.size.width + 5, clrBtnRect.size.height/2 - 15, clrBtnRect.size.width - (imgclearRect.origin.x + imgclearRect.size.width + 5), 30);
    }
    
}
- (void)getPOIDataAPI
{
    __weak MyDestinationViewController *weakSelf = self;
    ModelManager *modelManager = [ModelManager getInstance];
    
    //    weakSelf.poiData  = [modelManager getPOIData];
    if(!weakSelf.poiData.count)
    {
        weakSelf.poiData = [modelManager getPOIDataDB];
        NSLog(@"weakSelf.poiData %@",weakSelf.poiData );
        if(weakSelf.poiData != nil)
        {
            [[PoiManager shareIntance]getPOIData:@"" Completion:^(NSError *error, NSMutableArray *result, NSString *message) {
                
                _searchData = [[NSMutableArray alloc]init];
                weakSelf.poiData = result;
            }];
        }

    }
    //    NSLog(@"weakSelf : %@",weakSelf.searchData);
    
}
- (void)getMyDestinationData
{
    ModelManager *modelManager = [ModelManager getInstance];
    saveLocationData = [[NSMutableArray alloc]initWithArray:[modelManager getMyDestData]];
    [tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveLocation:(id)sender{
    ModelManager *modelManager = [ModelManager getInstance];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"name_en contains[c]%@",
                                    saveLocation[@"name_en"]];
    NSLog(@"filteredArrayUsingPredicate : %lu",(unsigned long)[saveLocationData filteredArrayUsingPredicate:resultPredicate].count);
    
    if([saveLocationData filteredArrayUsingPredicate:resultPredicate].count == 0 )
    {
        [saveLocationData addObject:saveLocation];
        Model_POIS* poi = [[Model_POIS alloc]init];
        poi.provider_type_id = saveLocation[@"provider_type_id"];
        poi.provider_type_keyname = saveLocation[@"provider_type_keyname"];
        poi.name_en = saveLocation[@"name_en"];
        poi.name_th = saveLocation[@"name_th"];
        poi.province_name_en = saveLocation[@"province_name_en"];
        poi.longitude = saveLocation[@"longitude"];
        poi.latitude = saveLocation[@"latitude"];
        poi.address_th = saveLocation[@"address_th"];
        poi.address_en = saveLocation[@"address_en"];
        
        NSLog(@"saveLocationData %@",poi);
        [modelManager insertMyDestData:poi];
        
        tableView.hidden = false;
        editBtn.hidden = false;
        [tableView reloadData];
        NSLog(@"saveLocationData : %@",saveLocationData);
    }
    
}
-(void)edit:(id)sender{
    isEdit = true;
    [tableView reloadData];
    destinationHeaderView.hidden = YES;
    claerAllView = [[UIView alloc] initWithFrame:destinationHeaderViewRect];
    claerAllView.backgroundColor = destinationHeaderView.backgroundColor;
    claerAllView.layer.cornerRadius = 5;
    claerAllView.clipsToBounds = YES;
    [scrollView addSubview:claerAllView];
    
    closeBtn = [[UIButton alloc] initWithFrame:closeBtnRect];
    closeBtn.layer.cornerRadius = 5;
    closeBtn.clipsToBounds = YES;
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgClose = [[UIImageView alloc] initWithFrame:closeBtn.bounds];
    imgClose.image = [UIImage imageNamed:@"ic_exit_checkin.png"];
    [closeBtn addSubview:imgClose];
    [claerAllView addSubview:closeBtn];
    
    UIButton *clrBtn = [[UIButton alloc] initWithFrame:clrBtnRect];
    clrBtn.backgroundColor =[UIColor redColor];
    clrBtn.layer.cornerRadius = 5;
    clrBtn.clipsToBounds = YES;
    
    UIImageView *imgclear = [[UIImageView alloc] initWithFrame:imgclearRect];
    imgclear.image = [UIImage imageNamed:@"ic_clear_all.png"];
    [clrBtn addSubview:imgclear];
    
    UILabel *lblClear = [[UILabel alloc] initWithFrame:lblClearRect ];
    lblClear.text = @"Clear All";
    lblClear.font = [UIFont fontWithName:@"Helvetica" size:font];
    lblClear.textColor = [UIColor whiteColor];
    [clrBtn addSubview:lblClear];
    [clrBtn addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [claerAllView addSubview:clrBtn];
    
    
}
-(void)close:(id)sender{
    isEdit = false;
    [tableView reloadData];
    destinationHeaderView.hidden = NO;
    claerAllView.hidden = YES;
}
-(void)deleteSaveLocationByID:(id)sender{
    NSLog(@"deleteSaveLocationByID");
    MYTapGestureRecognizer *tapRecognizer = (MYTapGestureRecognizer *)sender;
    NSLog (@"routeDirection %@",tapRecognizer.dataArr[0]);
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You sure delete?" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
    
    MYAlertView *alert = [[MYAlertView alloc]initWithTitle:@"You sure delete?" message:tapRecognizer.dataArr[0][@"name_en"] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.dataArr = tapRecognizer.dataArr;
    alert.tag = 1;
    [alert show];
    
}

-(void)deleteAll:(id)sender{
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You sure delete all?" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
    MYAlertView *alert = [[MYAlertView alloc]initWithTitle:@"You sure delete all?" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.tag = 0;
    [alert show];
    
}
- (void)alertView:(MYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 0)
    {
        if (buttonIndex != [alertView cancelButtonIndex]) {
            ModelManager *modelManager = [ModelManager getInstance];
            [modelManager deleteMyDestData];
            [saveLocationData removeAllObjects];
            destinationHeaderView.hidden = NO;
            claerAllView.hidden = YES;
            tableView.hidden =true;
        }
    }else if(alertView.tag == 1)
    {
        if (buttonIndex != [alertView cancelButtonIndex]) {
            
            NSLog(@"Aleart Delate Data %@",alertView.dataArr[0][@"name_en"]);
            ModelManager *modelManager = [ModelManager getInstance];
            [modelManager deleteMyDestDataByID:alertView.dataArr[0][@"name_en"]];
            [self getMyDestinationData];
            if(saveLocationData.count == 0)
            {
                destinationHeaderView.hidden = NO;
                claerAllView.hidden = YES;
                tableView.hidden =true;
            }
            //            else
            //            {
            //                int index;
            //                for(index = 0; index < saveLocationData.count; index++)
            //                {
            ////                    if([alertView.dataArr[0][@"name_en"] isEqualToString:saveLocationData[index][@"name_en"]])
            //                    if(alertView.dataArr[0][@"name_en"] == saveLocationData[index][@"name_en"])
            //                    {
            //                        NSLog(@"removeObjectAtIndex %@ == %@",saveLocationData[index][@"name_en"],alertView.dataArr[0][@"name_en"]);
            //                        [saveLocationData removeObjectAtIndex:index];
            //                        isEdit = false;
            //                        [tableView reloadData];
            //                        NSLog(@"New saveLocationData %@",saveLocationData);
            //                    }
            //                }
            //            }
            
        }
        
    }
}
-(void)dismissKeyboard{
    [searchBar resignFirstResponder];
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5f];
//    [UIView setAnimationDelegate:self];
//    CGFloat scy = (1024.0/480.0);
//    CGFloat scx = (768.0/360.0);
//    claerAllView.frame =CGRectMake(10, saveLoctaionBtnRect.origin.y + saveLoctaionBtnRect.size.height + (50*scy), [UIScreen mainScreen].bounds.size.width - (60*scx), 60*scy);
//    [scrollView addSubview:claerAllView];
//
//    [UIView commitAnimations];
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
///////////// SETTING SEARCH BAR//////////////
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    
    
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // called twice every time
    NSLog(@"SEARCH BAR ACTIVE1");
    searchActive = true;
    searchDisplayTbl.hidden = false;
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldEndEditing");
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
//    searchDisplayTbl.hidden = true;
    searchActive = false;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)SearchBar
{
    NSLog(@"searchBarCancelButtonClicked called");
    
    searchDisplayTbl.hidden = true;
    searchBar.text = nil;
    
    [searchBar resignFirstResponder];
    searchActive = false;
    [searchDisplayTbl reloadData];
}
- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    [searchController.searchBar becomeFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *) searchText{
    NSLog(@"GO FILTER");
    
    if(isEdit)
    {
        isEdit = false;
        [tableView reloadData];
        destinationHeaderView.hidden = NO;
        claerAllView.hidden = YES;
    }
    
    if(searchText.length == 0)
    {
        searchActive = false;
    }
    else if(searchText.length >= 2)
    {
        searchActive = true;
        searchDisplayTbl.hidden = false;
        resultSearch = [[NSMutableArray alloc]init];
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"name_en contains[c]%@",
                                        searchText];
        NSLog(@"PoiDataSearch : %@",[_poiData filteredArrayUsingPredicate:resultPredicate]);
        [resultSearch addObjectsFromArray:[_poiData filteredArrayUsingPredicate:resultPredicate]];
        
        //        BOOL success = results.count > 0;
        //        if(resultSearch.count > 0)
        //        {
        //            NSLog(@"success success success success : %lu",(unsigned long)resultSearch.count);
        //        }
        
        
        
        //        resultSearch = [[NSMutableArray alloc] init];
        //
        //        NSString *search;
        //        for (search in searchDisplayList)
        //        {
        //
        //            NSRange nameRange = [search rangeOfString:searchText options:NSCaseInsensitiveSearch];
        ////            NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
        //
        //
        //            if(nameRange.location != NSNotFound)
        //            {
        //
        //                [resultSearch addObject:search];
        //            }
        //
        //        }
        //        if (resultSearch ==nil) {
        //            searchActive = false ;
        //            [searchDisplayTbl reloadData];
        //        }
        
    }
    
    [searchDisplayTbl reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    if(tableView == searchDisplayTbl){
        if (searchActive) {
            
            return  resultSearch.count;
        }
        else{
            return searchDisplayList.count;
        }
        
    }
    else{
        return saveLocationData.count;
    }
    
    //    return _searchResults.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(isEdit)
    {
        Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (Cell == nil)
        {
            Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        Cell.placeLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"name_en"];
        
        Cell.placeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        //    Cell.placeLbl.numberOfLines = 3;
        Cell.placeLbl.textAlignment = NSTextAlignmentJustified;
        //    [ Cell.placeLbl sizeToFit];
        
        Cell.addressLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"address_en"];
        Cell.addressLbl.lineBreakMode = NSLineBreakByWordWrapping;
        Cell.addressLbl.numberOfLines = 3;
        Cell.addressLbl.textAlignment = NSTextAlignmentJustified;
        [Cell.addressLbl sizeToFit];
        
        
        //getDistance
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitute longitude:appDelegate.longitude];
        CLLocation *poiLocation = [[CLLocation alloc] initWithLatitude:[[saveLocationData objectAtIndex:indexPath.row][@"latitude"] floatValue] longitude:[[saveLocationData objectAtIndex:indexPath.row][@"longitude"] floatValue]];
        CLLocationDistance meters = [poiLocation distanceFromLocation:currentLoc];
        
        Cell.distanceLbl.text = [NSString stringWithFormat:@"%.02f",meters/1000];;
        
        [Cell.routeBtn setTitle:@"Delete" forState:UIControlStateNormal];
        Cell.routeBtn.backgroundColor = [UIColor redColor];
        [Cell.routeBtn setFrame:CGRectMake(Cell.contentView.bounds.size.width - (Cell.routeBtn.bounds.size.width + 5), Cell.contentView.bounds.size.height - (Cell.routeBtn.bounds.size.height + 5) , Cell.routeBtn.bounds.size.width, Cell.routeBtn.bounds.size.height)];
        MYTapGestureRecognizer* TapCall = [[MYTapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(deleteSaveLocationByID:)];//Here should be actionViewTap:
        [TapCall setNumberOfTouchesRequired:1];
        [TapCall setDelegate:self];
        Cell.routeBtn .userInteractionEnabled = YES;
        [Cell.routeBtn  addGestureRecognizer:TapCall];
        TapCall.enabled = YES;
        TapCall.dataArr = [[NSMutableArray alloc]initWithObjects:[saveLocationData objectAtIndex:indexPath.row], nil];
        return Cell;
        
    }
    else if (tableView == searchDisplayTbl) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        if(searchActive){
            
            //                NSLog(@"OKOKOK %@",[resultSearch objectAtIndex:indexPath.row][@"name_en"]);
            cell.textLabel.text = [resultSearch objectAtIndex:indexPath.row][@"name_en"];
            
            //resultSearch[indexPath.row];
        } else {
            //                NSLog(@"Table count ::: %lu", (unsigned long)searchDisplayList.count);
            cell.textLabel.text = [searchDisplayList objectAtIndex:indexPath.row];
        }
        [cell setBackgroundColor: [UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.0]];
        
        return cell;
        
        //[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
        
    }
    else{
        Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (Cell == nil) {
            Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        Cell.placeLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"name_en"];
        
        Cell.placeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        //    Cell.placeLbl.numberOfLines = 3;
        Cell.placeLbl.textAlignment = NSTextAlignmentJustified;
        //    [ Cell.placeLbl sizeToFit];
        
        Cell.addressLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"address_en"];
        Cell.addressLbl.lineBreakMode = NSLineBreakByWordWrapping;
        Cell.addressLbl.numberOfLines = 3;
        Cell.addressLbl.textAlignment = NSTextAlignmentJustified;
        [Cell.addressLbl sizeToFit];
        
        
        //getDistance
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitute longitude:appDelegate.longitude];
        CLLocation *poiLocation = [[CLLocation alloc] initWithLatitude:[[saveLocationData objectAtIndex:indexPath.row][@"latitude"] floatValue] longitude:[[saveLocationData objectAtIndex:indexPath.row][@"longitude"] floatValue]];
        CLLocationDistance meters = [poiLocation distanceFromLocation:currentLoc];
        
        Cell.distanceLbl.text = [NSString stringWithFormat:@"%.02f",meters/1000];;
        
        [Cell.routeBtn setTitle:@"Route" forState:UIControlStateNormal];
        Cell.routeBtn.backgroundColor = [UIColor colorWithRed:0.15 green:0.39 blue:0.64 alpha:1.00];
        
        [Cell.routeBtn setFrame:CGRectMake(Cell.contentView.bounds.size.width - (Cell.routeBtn.bounds.size.width + 5), Cell.contentView.bounds.size.height - (Cell.routeBtn.bounds.size.height + 5) , Cell.routeBtn.bounds.size.width, Cell.routeBtn.bounds.size.height)];
        MYTapGestureRecognizer* TapCall = [[MYTapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(routeDirection:)];//Here should be actionViewTap:
        [TapCall setNumberOfTouchesRequired:1];
        [TapCall setDelegate:self];
        Cell.routeBtn .userInteractionEnabled = YES;
        [Cell.routeBtn  addGestureRecognizer:TapCall];
        TapCall.enabled = YES;
        TapCall.dataArr = [[NSMutableArray alloc]initWithObjects:[saveLocationData objectAtIndex:indexPath.row], nil];
        
        return Cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == searchDisplayTbl) {
        
        return searchCellH;
    }
    
    return cellH;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == searchDisplayTbl) {
        saveLoctaionBtn.enabled = true;
        NSLog(@"index : %ld",(long)indexPath.row);
        NSLog(@"Result : %@",[resultSearch objectAtIndex:indexPath.row][@"name_en"]);
        saveLocation = [[NSDictionary alloc]initWithDictionary:[resultSearch objectAtIndex:indexPath.row]];
        searchBar.text = [resultSearch objectAtIndex:indexPath.row][@"name_en"];
        
        NSLog(@"saveLocation : %@",saveLocation);
        searchDisplayTbl.hidden = true;
        [searchBar resignFirstResponder];
        
    }else
    {
        NSLog(@"not Search Table");
        
    }
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == searchDisplayTbl) {
        
        if([indexPath row] == ((NSIndexPath*)[[searchDisplayTbl indexPathsForVisibleRows] lastObject]).row){
            
            if (searchActive) {
                
                NSLog(@"Have Result");
                NSLog(@"ResultCOUNT:::: %d",resultSearch.count);
                [searchDisplayTbl setFrame:CGRectMake(searchtableViewRect.origin.x,searchtableViewRect.origin.y, searchtableViewRect.size.width,(searchCellH*(resultSearch.count)))];
            }
            else{
                
                
                [searchDisplayTbl setFrame:searchtableViewRect];
                
            }
            //        count = _searchResults.count;
            [searchDisplayTbl setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
            
        }
        NSLog(@"NO Result");
        
    }
    else{
        if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            
            [tableView setFrame:CGRectMake(tableViewRect.origin.x,tableViewRect.origin.y, tableViewRect.size.width,(cellH*(saveLocationData.count)))];
            tableView.layer.cornerRadius = 5;
            tableView.clipsToBounds = YES;
        }
    }
}
- (void)routeDirection:(id)sender
{
    MYTapGestureRecognizer *tapRecognizer = (MYTapGestureRecognizer *)sender;
    NSLog (@"routeDirection %@",tapRecognizer.dataArr[0][@"name_en"]);
    //first create latitude longitude object
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([tapRecognizer.dataArr[0][@"latitude"] doubleValue],[tapRecognizer.dataArr[0][@"longitude"] doubleValue]);
    
    //create MKMapItem out of coordinates
    MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    [destination setName:tapRecognizer.dataArr[0][@"name_en"]];
    if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
    {
        //using iOS6 native maps app
        [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
    }
    else
    {
        //using iOS 5 which has the Google Maps application
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current+Location&daddr=%f,%f", [tapRecognizer.dataArr[0][@"latitude"] doubleValue],[tapRecognizer.dataArr[0][@"longitude"] doubleValue]];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBounds;
    
    NSLog(@"keyboard Show");
    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBounds];
    //    scrollView.contentOffset = CGPointMake(0,keyboardBounds.origin.y);
    //    [scrollView setContentOffset:CGPointMake(0,searchBar.center.y+200) animated:YES];
    
    //    UIScrollView* v = (UIScrollView*) self.view ;
    //    CGRect rc = [searchBar bounds];
    //    rc = [searchBar convertRect:rc toView:v];
    //    rc.origin.x = 0 ;
    //    rc.origin.y -= 60 ;
    //
    //    rc.size.height = 300;
    //    [self->scrollView scrollRectToVisible:rc animated:YES];
    NSDictionary* info = [notification userInfo];
    CGRect kbRawRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect scrollViewFrame = [scrollView.window convertRect:scrollView.frame fromView:scrollView.superview];
    
    // Calculate the area that is covered by the keyboard
    CGRect coveredFrame = CGRectIntersection(scrollViewFrame, kbRawRect);
    // Convert again to window coordinates to take rotations into account
    coveredFrame = [scrollView.window convertRect:scrollView.frame fromView:scrollView.superview];
    
    //    NSLog(@"coveredFrame %f",coveredFrame.size.height);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 300, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect activeFieldRect = [searchBar convertRect:searchBar.bounds toView:scrollView];
    [scrollView scrollRectToVisible:activeFieldRect animated:YES];
    
    // Do something with keyboard height
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect keyboardBounds;
    
    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBounds];
    //    scrollView.contentOffset = CGPointMake(0, - keyboardBounds.origin.y);
    
    //    UIScrollView* v = (UIScrollView*) self.view ;
    //    CGRect rc = [searchBar bounds];
    //    rc = [searchBar convertRect:rc toView:v];
    //    rc.origin.x = 0 ;
    //    rc.origin.y -= 60 ;
    //    
    //    rc.size.height = -300;
    //    [self->scrollView scrollRectToVisible:rc animated:YES];
    // Do something with keyboard height
    
}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
