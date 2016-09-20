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
#import "MBProgressHUD.h"

@interface MyDestinationViewController ()
{
    AppDelegate *appDelegate;

    IBOutlet UIView *searchView;
    
    IBOutlet UIView *previewView;
    CGRect previewViewRect;
    IBOutlet UIImageView *pinTypepreviewImg;
    CGRect pinTypepreviewImgRect;
    IBOutlet UILabel *locationNamepreViewLbl;
    CGRect locationNamepreViewLblRect;
    IBOutlet UILabel *addressPreviewLbl;
    CGRect addressPreviewLblRect;
    IBOutlet UILabel *distancePreviewLbl;
    CGRect distancePreviewLblRect;
    IBOutlet UIButton *closePreviewBtn;
    CGRect closePreviewBtnRect;
    
    
    
    
    IBOutlet UIView *destinationHeaderView;
    
    IBOutlet UIView *hotelHeaderView;
    IBOutlet UILabel *hotelListLbl;
    IBOutlet UIButton *editHotel;
    CGRect hotelHeaderViewRect;
    CGRect hotelListLblRect;
    CGRect editHotelRect;
    
    
    
    
    
    UIView *claerAllView;
    UIButton *closeBtn;
    
    
    IBOutlet UILabel *DestLbl;
    
    IBOutlet UIButton *editBtn;
    
    IBOutlet UISearchBar *searchBar;
    IBOutlet UISearchController *searchDisplayController;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *addLoctaionBtn;

    
    
    
    IBOutlet UITableView *destinationListTbl;
    CGRect destinationListTblRect;
    
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
    NSMutableArray *saveHotelData;
    
    NSDictionary *saveLocation;
    NSDictionary *groupLocation;
    
    NSArray *groupKey;
    NSArray *groupName;
    
    
}
- (IBAction)Back:(id)sender;

@end

@implementation MyDestinationViewController
- (void)viewWillAppear:(BOOL)animated{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    groupName = [NSArray arrayWithObjects:@"Hotel List",@"Destination List", nil];
    groupLocation = [[NSDictionary alloc] init];
    groupKey = [[NSArray alloc] init];
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
    saveHotelData = [[NSMutableArray alloc] init];
    searchDisplayTbl.hidden = TRUE;
    destinationListTbl.hidden = FALSE;
    destinationListTbl.separatorStyle = UITableViewStyleGrouped;
//hotelListTbl.separatorStyle = UITableViewStyleGrouped;
    
  
    
    [self getPOIDataAPI];
    [self getMyDestinationData];
    [self initialSize];
    [self initial];
    
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    
}
-(void)initial{
    
    UINib *nib = [UINib nibWithNibName:@"Destinationcell" bundle:nil];
    [destinationListTbl registerNib:nib forCellReuseIdentifier:@"cell"];
    
    if (saveLocationData.count == 0) {
        NSLog(@"saveLocationData == nil");
        editBtn.hidden = true ;
    }
    else if (saveHotelData.count == 0)
    {
        NSLog(@"saveHotelData == nil");
        editHotel.hidden = true;
    }
    else{
        NSLog(@"saveLocationData != nil");
        editBtn.hidden = false;
        editHotel.hidden = FALSE;
    }
 
    //Check Search Result
    
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [searchView setFrame:searchViewRect];
    searchView.layer.cornerRadius = 5 ;
    searchView.clipsToBounds = YES;
    searchView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    [searchBar setTintColor: [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1]];
    [searchBar setFrame:searchView.bounds];
    
    
    
    
   // [containnerView setFrame:containnerViewRect];
   
 
    [hotelHeaderView setFrame:hotelHeaderViewRect];
    hotelHeaderView.layer.cornerRadius = 5;
    hotelHeaderView.clipsToBounds = YES;
    [hotelListLbl setFrame:hotelListLblRect];
    hotelListLbl.text = @"Hotel List";
    hotelListLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    [editHotel setFrame:editHotelRect];
    [editHotel addTarget:self action:@selector(edithotel:) forControlEvents:UIControlEventTouchUpInside];
    editHotel.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    [destinationListTbl setFrame:destinationListTblRect];
    [destinationListTbl setSeparatorStyle:UITableViewStyleGrouped];
    
    
    [destinationHeaderView setFrame:destinationHeaderViewRect];
    destinationHeaderView.layer.cornerRadius = 5;
    destinationHeaderView.clipsToBounds = YES;
   
    // searchDisplayTbl = [[UITableView alloc] initWithFrame:searchtableViewRect ];
    [searchDisplayTbl setFrame:searchtableViewRect];
    [searchDisplayTbl setBackgroundColor:[UIColor clearColor]];
    searchDisplayTbl.layer.cornerRadius = 5;
    searchDisplayTbl.clipsToBounds = YES;
    searchDisplayTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  
    // [scrollView addSubview:searchDisplayTbl];
    
    
    [DestLbl setFrame:DestLblRect];
    DestLbl.text = @"Destination List";
    DestLbl.font = [UIFont fontWithName:@"Helvetica" size:font];
    
  //  [notDestinationView setFrame:notDestinationViewRect];
    [editBtn setFrame:editBtnRect];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    
    [barRight setFrame:barRightRect];
    barRight.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar addSubview:barRight];
    
}
- (void)closePreView:(id)sender{
     [previewView setFrame:CGRectMake(10, searchView.bounds.origin.y + searchView.bounds.size.height + 5, self.view.bounds.size.width-20, 0)];
    [destinationListTbl setFrame:destinationListTblRect];
   // [scrollView reloadInputViews];

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
        searchViewRect = CGRectMake(10,10, width - 20, 40);
        searchtableViewRect = CGRectMake(10, searchViewRect.origin.y + searchViewRect.size.height, width - 20, 50 );
        
        scrollViewRect = CGRectMake(0, 0, width, height - navBarWithStatusH);
     //   containnerViewRect = CGRectMake(10 , searchViewRect.origin.y + searchViewRect.size.height +10 , width-20, height - 100);
        
        previewViewRect = CGRectMake(10, searchViewRect.origin.y + searchViewRect.size.height + 5, width-20, 200);
        
       
         hotelListLblRect = CGRectMake(5,hotelHeaderViewRect.size.height/2 - 15, hotelHeaderViewRect.size.width - 50, 30);
         editHotelRect = CGRectMake(hotelHeaderViewRect.size.width - 30, 10 , 30, 30) ;
        
        
        DestLblRect = CGRectMake(5,destinationHeaderViewRect.size.height/2 - 15, destinationHeaderViewRect.size.width - 50, 30);
        editBtnRect = CGRectMake(destinationHeaderViewRect.size.width - 30, 10 , 30, 30) ;
        destinationListTblRect =CGRectMake(10, searchViewRect.origin.y + searchViewRect.size.height + 10 ,previewViewRect.size.width , height - (destinationListTblRect.origin.y + 150));
        
        
        tableViewRect = CGRectMake(10, destinationHeaderViewRect.origin.y + destinationHeaderViewRect.size.height + 5, width - 20, 160);
        closeBtnRect = CGRectMake(destinationHeaderView.bounds.size.width - 45 ,5, 40, 40);
        barRightRect = CGRectMake(width - 60, navBarWithStatusH/2 - 25, 50, 50);
        clrBtnRect = CGRectMake(closeBtnRect.origin.x - 100 , closeBtnRect.origin.y, 100, closeBtnRect.size.height);
        imgclearRect = CGRectMake(5, clrBtnRect.size.height/4,clrBtnRect.size.height/2, clrBtnRect.size.height/2);
        lblClearRect = CGRectMake(imgclearRect.size.width + 5, clrBtnRect.size.height/2 - 15, clrBtnRect.size.width - (imgclearRect.origin.x + imgclearRect.size.width + 5), 30);
    }
    
}
- (void)getPOIDataAPI
{
    __weak MyDestinationViewController *weakSelf = self;
    ModelManager *modelManager = [ModelManager getInstance];
    
  //  weakSelf.poiData  = [modelManager getPOIData];
    if(!weakSelf.poiData.count)
    {
        weakSelf.poiData = [modelManager getPOIDataDB];
        NSLog(@"weakSelf.poiData %@",weakSelf.poiData );
        if(weakSelf.poiData != nil)
        {
            NSLog(@"poiData = nil");
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[PoiManager shareIntance]getPOIData:@"" Completion:^(NSError *error, NSMutableArray *result, NSString *message) {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
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
//    saveHotelData = [[NSMutableArray alloc]initWithArray:[modelManager getMyDestData]];
//        [modelManager deleteAllData];
//    if (saveLocation.count == 0) {
//        editBtn.hidden = TRUE;
//    }
//    else if (saveHotelData.count == 0){
//        editHotel.hidden =true;
//
//    }
//    else{
//        editBtn.hidden = FALSE;
//        editHotel.hidden = FALSE;
//    }
    [destinationListTbl reloadData];
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
    if ( [[saveLocation objectForKey:@"provider_type_keyname"] isEqual:@"hotel"]) {
        NSLog(@"filteredArrayUsingPredicate : %lu",(unsigned long)[saveHotelData filteredArrayUsingPredicate:resultPredicate].count);
        if([saveHotelData filteredArrayUsingPredicate:resultPredicate].count == 0 )
        {
            
            
            [saveHotelData addObject:saveLocation];
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
            
            NSLog(@"saveHotelData  %@",poi);
            [modelManager insertMyDestData:poi];
            
            destinationListTbl.hidden = false;
            editBtn.hidden = false;
            editHotel.hidden = FALSE;
            previewView.hidden = TRUE;
            [previewView setFrame:previewViewRect];
            [destinationListTbl setFrame:destinationListTblRect];
            [destinationListTbl reloadData];
            
//            NSLog(@"saveHotelData hotel : %@",saveHotelData);
//            groupLocation =[[NSDictionary alloc]initWithObjectsAndKeys:saveHotelData,@"Hotel",nil];
            //[saveLocation objectForKey:@"provider_type_keyname"]
        }

    }
    else{
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
        
        destinationListTbl.hidden = false;
        editBtn.hidden = false;
        editHotel.hidden = FALSE;
        previewView.hidden = TRUE;
        [previewView setFrame:previewViewRect];
        [destinationListTbl setFrame:destinationListTblRect];
        [destinationListTbl reloadData];
//        NSLog(@"saveLocationData Destination : %@",saveLocationData);
        
//        groupLocation =[[NSDictionary alloc]initWithObjectsAndKeys:saveLocationData,@"Destination", nil];
//[saveLocation objectForKey:@"provider_type_keyname"]
    }
  }
//    NSLog(@"saveHotelData hotel : %@",saveHotelData);
//    NSLog(@"saveLocationData Destination : %@",saveLocationData);
    
    groupLocation =[[NSDictionary alloc]initWithObjectsAndKeys:saveHotelData,@"Hotel",saveLocationData,@"Destination",nil];
    groupKey = [[NSArray alloc] init];
    groupKey = [groupLocation allKeys];
    NSLog(@"groupLocation %@",groupLocation);
    NSLog(@"groupKey %@",groupKey);
}
-(void)edit:(id)sender{
    isEdit = true;
    
    claerAllView = [[UIView alloc] initWithFrame:hotelHeaderViewRect];
    claerAllView.backgroundColor = destinationHeaderView.backgroundColor;
    claerAllView.layer.cornerRadius = 5;
    claerAllView.clipsToBounds = YES;
   
    
    closeBtn = [[UIButton alloc] initWithFrame:closeBtnRect];
    closeBtn.backgroundColor = [UIColor grayColor];
    closeBtn.layer.cornerRadius = 5;
    closeBtn.clipsToBounds = YES;
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgClose = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, closeBtn.bounds.size.width - 20, closeBtn.bounds.size.height - 20)];
    imgClose.image = [UIImage imageNamed:@"close.png"];
  
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
      hotelHeaderView.hidden = NO;
    claerAllView.hidden = YES;
}
-(void)deleteSaveLocationByID:(id)sender{
    NSLog(@"deleteSaveLocationByID");
    MYTapGestureRecognizer *tapRecognizer = (MYTapGestureRecognizer *)sender;
    NSLog (@"routeDirection %@",tapRecognizer.dataArr[0]);
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You sure delete?" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
    
    MYAlertView *alert = [[MYAlertView alloc]initWithTitle:@"Are you sure to delete?" message:tapRecognizer.dataArr[0][@"name_en"] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.dataArr = tapRecognizer.dataArr;
    alert.tag = 1;
    [alert show];
    
}

-(void)deleteAll:(id)sender{
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You sure delete all?" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
    MYAlertView *alert = [[MYAlertView alloc]initWithTitle:@"Are you sure clear all?" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
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
            hotelHeaderView.hidden = NO;
            claerAllView.hidden = YES;
       
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
                hotelHeaderView.hidden = NO;
                claerAllView.hidden = YES;
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation


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
     [previewView setFrame:CGRectMake(10, searchView.bounds.origin.y + searchView.bounds.size.height + 5, self.view.bounds.size.width-20, 0)];
    [destinationListTbl setFrame:destinationListTblRect];

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)SearchBar
{
    NSLog(@"searchBarCancelButtonClicked called");
    
    searchDisplayTbl.hidden = true;
    searchBar.text = nil;
    
    [searchBar resignFirstResponder];
    searchActive = false;
    [searchDisplayTbl reloadData];
    
     [previewView setFrame:CGRectMake(10, searchView.bounds.origin.y + searchView.bounds.size.height + 5, self.view.bounds.size.width-20, 0)];
    [destinationListTbl setFrame:destinationListTblRect];

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
//#warning Incomplete implementation, return the number of sections
    if(tableView == searchDisplayTbl){
        return 1;
    }
    else{
        return [groupKey count];
        NSLog(@"Group Key count %lu",(unsigned long)[groupKey count]);
    }
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == searchDisplayTbl){
        return UITableViewStylePlain;
    }
    else{
        NSLog(@"Group name %@",[groupLocation objectForKey:@"Destination"]);
    return [groupKey objectAtIndex:section];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    if(tableView == searchDisplayTbl){
        if (searchActive) {
            
            return  resultSearch.count;
        }
        else{
            return searchDisplayList.count;
        }
        
    }
    else{
//        if (saveLocationData.count == 0) {
//            return 1 ;
//        }
//        else{
        return saveLocationData.count;
 //       }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"TABLE HEIGHT %.2f",destinationListTbl.sectionHeaderHeight);
    if(isEdit)
    {
        Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (Cell == nil)
        {
            Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        Cell.placeLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"name_en"];
        
        Cell.placeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        //  Cell.placeLbl.numberOfLines = 3;
        Cell.placeLbl.textAlignment = NSTextAlignmentJustified;
        // [ Cell.placeLbl sizeToFit];
        
        Cell.addressLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"address_en"];
        Cell.addressLbl.lineBreakMode = NSLineBreakByWordWrapping;
        Cell.addressLbl.numberOfLines = 3;
        Cell.addressLbl.textAlignment = NSTextAlignmentJustified;
        [Cell.addressLbl sizeToFit];
        
        
        //getDistance
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitude longitude:appDelegate.longitude];
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

        
    }
   
    else{
        
        NSArray *listData =[groupLocation objectForKey:[groupKey objectAtIndex:[indexPath section]]];
        NSLog(@"Listttttttttt %@",[listData valueForKey:@"cover_image"]);
        
        Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (Cell == nil) {
            Cell = [[DestinationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        
//        NSUInteger row = [indexPath row];
//        Cell.placeLbl.text = [listData objectAtIndex:row];
        
//        Cell.placeLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"name_en"];
//        
//        Cell.placeLbl.lineBreakMode = NSLineBreakByWordWrapping;
//        //    Cell.placeLbl.numberOfLines = 3;
//        Cell.placeLbl.textAlignment = NSTextAlignmentJustified;
//        //    [ Cell.placeLbl sizeToFit];
//        
//        Cell.addressLbl.text = [saveLocationData objectAtIndex:indexPath.row][@"address_en"];
//        Cell.addressLbl.lineBreakMode = NSLineBreakByWordWrapping;
//        Cell.addressLbl.numberOfLines = 3;
//        Cell.addressLbl.textAlignment = NSTextAlignmentJustified;
//        [Cell.addressLbl sizeToFit];
//        
//        
//        //getDistance
//        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitude longitude:appDelegate.longitude];
//        CLLocation *poiLocation = [[CLLocation alloc] initWithLatitude:[[saveLocationData objectAtIndex:indexPath.row][@"latitude"] floatValue] longitude:[[saveLocationData objectAtIndex:indexPath.row][@"longitude"] floatValue]];
//        CLLocationDistance meters = [poiLocation distanceFromLocation:currentLoc];
//        
//        Cell.distanceLbl.text = [NSString stringWithFormat:@"%.02f",meters/1000];;
//        
//        [Cell.routeBtn setTitle:@"Route" forState:UIControlStateNormal];
//        Cell.routeBtn.backgroundColor = [UIColor colorWithRed:0.15 green:0.39 blue:0.64 alpha:1.00];
//        
//        [Cell.routeBtn setFrame:CGRectMake(Cell.contentView.bounds.size.width - (Cell.routeBtn.bounds.size.width + 5), Cell.contentView.bounds.size.height - (Cell.routeBtn.bounds.size.height + 5) , Cell.routeBtn.bounds.size.width, Cell.routeBtn.bounds.size.height)];
//        MYTapGestureRecognizer* TapCall = [[MYTapGestureRecognizer alloc]
//                                           initWithTarget:self action:@selector(routeDirection:)];
//        //Here should be actionViewTap:
//        [TapCall setNumberOfTouchesRequired:1];
//        [TapCall setDelegate:self];
//        Cell.routeBtn .userInteractionEnabled = YES;
//        [Cell.routeBtn  addGestureRecognizer:TapCall];
//        TapCall.enabled = YES;
//        TapCall.dataArr = [[NSMutableArray alloc]initWithObjects:[saveLocationData objectAtIndex:indexPath.row], nil];
//            
//       
//        
        return Cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == searchDisplayTbl) {
        
        return searchCellH;
    }
    else{
    return cellH;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == searchDisplayTbl) {
        addLoctaionBtn.enabled = true;
        NSLog(@"index : %ld",(long)indexPath.row);
        NSLog(@"Result : %@",[resultSearch objectAtIndex:indexPath.row][@"name_en"]);
        saveLocation = [[NSDictionary alloc]initWithDictionary:[resultSearch objectAtIndex:indexPath.row]];
        searchBar.text = [resultSearch objectAtIndex:indexPath.row][@"name_en"];
        
        NSLog(@"saveLocation : %@",saveLocation);
        searchDisplayTbl.hidden = true;
        [searchBar resignFirstResponder];
        [previewView setHidden:false];
        [previewView setFrame:previewViewRect ];
        previewView.layer.cornerRadius = 5;
        previewView.clipsToBounds = YES;
        [destinationListTbl setFrame:CGRectMake(destinationListTblRect.origin.x, previewViewRect.origin.y + previewViewRect.size.height +10 , destinationListTblRect.size.width, destinationListTblRect.size.height)];
        
        
        
        [pinTypepreviewImg setFrame:CGRectMake(10, 10, 45, 45)];
        
        [locationNamepreViewLbl setFrame:CGRectMake(pinTypepreviewImg.bounds.origin.x + pinTypepreviewImg.bounds.size.width + 20 , 10 , previewView.bounds.size.width - 100 , 30)];
        locationNamepreViewLbl.text = [resultSearch objectAtIndex:indexPath.row][@"name_en"];
        locationNamepreViewLbl.lineBreakMode = NSLineBreakByWordWrapping;
        locationNamepreViewLbl.numberOfLines = 2;
        locationNamepreViewLbl.textAlignment = NSTextAlignmentJustified;
        [locationNamepreViewLbl sizeToFit];
        
        NSLog(@"Provider Type ::: %@",[resultSearch objectAtIndex:indexPath.row][@"provider_type_keyname"]);
        
        [addressPreviewLbl setFrame:CGRectMake(pinTypepreviewImg.bounds.origin.x + pinTypepreviewImg.bounds.size.width + 20, locationNamepreViewLbl.bounds.origin.y + locationNamepreViewLbl.bounds.size.height + 20 , previewView.bounds.size.width - 100 , 60)];
        addressPreviewLbl.text = [resultSearch objectAtIndex:indexPath.row][@"address_en"];
        addressPreviewLbl.lineBreakMode = NSLineBreakByWordWrapping;
        addressPreviewLbl.numberOfLines = 3;
        addressPreviewLbl.textAlignment = NSTextAlignmentJustified;
        [addressPreviewLbl sizeToFit];

        
        [distancePreviewLbl setFrame:CGRectMake(pinTypepreviewImg.bounds.origin.x + pinTypepreviewImg.bounds.size.width + 20, previewView.bounds.size.height/2 +20 , 170 , 20)];
        [closePreviewBtn setFrame:CGRectMake(previewView.bounds.size.width - 35, 10, 25, 25)];
        [closePreviewBtn addTarget:self action:@selector(closePreView:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[resultSearch objectAtIndex:indexPath.row][@"provider_type_keyname"] isEqualToString:@"hotel"]) {
            [addLoctaionBtn setTitle:@"Add Hotel" forState:UIControlStateNormal];
            [pinTypepreviewImg setImage:[UIImage imageNamed:@"pin_hotel_2.png"]];

        }
        else{
            if ([[resultSearch objectAtIndex:indexPath.row][@"provider_type_keyname"] isEqualToString:@"restaurant"])  {
                 [pinTypepreviewImg setImage:[UIImage imageNamed:@"pin_res_2.png"]];
            }
            else{
             [pinTypepreviewImg setImage:[UIImage imageNamed:@"pin_att_2.png"]];
            }
            [addLoctaionBtn setTitle:@"Add Destination" forState:UIControlStateNormal];
        }
        
        [addLoctaionBtn setFrame:CGRectMake(60, previewView.bounds.size.height - 50 , previewView.bounds.size.width - 120, 40)];
        [addLoctaionBtn addTarget:self action:@selector(saveLocation:) forControlEvents:UIControlEventTouchUpInside];
        addLoctaionBtn.enabled = TRUE;
        addLoctaionBtn.layer.cornerRadius = 5;
        addLoctaionBtn.clipsToBounds = YES;
      
       
        
             //getDistance
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:appDelegate.latitude longitude:appDelegate.longitude];
        CLLocation *poiLocation = [[CLLocation alloc] initWithLatitude:[[resultSearch objectAtIndex:indexPath.row][@"latitude"] floatValue]
                                    longitude:[[resultSearch objectAtIndex:indexPath.row][@"longitude"] floatValue]];
        CLLocationDistance meters = [poiLocation distanceFromLocation:currentLoc];
        NSString *strdistance = [NSString stringWithFormat:@"%.02f Km",meters/1000];
        NSLog(@"DISTANCE ::: %@",strdistance);
        distancePreviewLbl.text = strdistance ;
        
        
        
    }
    else
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
                [searchDisplayTbl setFrame:CGRectMake(searchtableViewRect.origin.x,searchtableViewRect.origin.y, searchtableViewRect.size.width,(searchCellH*(3)))];
            }
            else{
                
                
                [searchDisplayTbl setFrame:searchtableViewRect];
                
            }
            //        count = _searchResults.count;
            [searchDisplayTbl setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
            
        }
        NSLog(@"NO Result");
        
    }
    else {
        if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            
            [destinationListTbl setFrame:CGRectMake(destinationListTblRect.origin.x,destinationListTblRect.origin.y, destinationListTblRect.size.width,(cellH*(saveLocationData.count*2)+180))];
            NSLog(@"LOCATION COUNT %lu:::",(unsigned long)saveLocationData.count);
            
            
            destinationListTbl.layer.cornerRadius = 5;
            destinationListTbl.clipsToBounds = YES;
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
    
//    NSLog(@"keyboard Show");
//    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBounds];
//    //    scrollView.contentOffset = CGPointMake(0,keyboardBounds.origin.y);
//    //    [scrollView setContentOffset:CGPointMake(0,searchBar.center.y+200) animated:YES];
//    
//    //    UIScrollView* v = (UIScrollView*) self.view ;
//    //    CGRect rc = [searchBar bounds];
//    //    rc = [searchBar convertRect:rc toView:v];
//    //    rc.origin.x = 0 ;
//    //    rc.origin.y -= 60 ;
//    //
//    //    rc.size.height = 300;
//    //    [self->scrollView scrollRectToVisible:rc animated:YES];
//    NSDictionary* info = [notification userInfo];
//    CGRect kbRawRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect scrollViewFrame = [scrollView.window convertRect:scrollView.frame fromView:scrollView.superview];
//    
//    // Calculate the area that is covered by the keyboard
//    CGRect coveredFrame = CGRectIntersection(scrollViewFrame, kbRawRect);
//    // Convert again to window coordinates to take rotations into account
//    coveredFrame = [scrollView.window convertRect:scrollView.frame fromView:scrollView.superview];
//    
//    //    NSLog(@"coveredFrame %f",coveredFrame.size.height);
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 300, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    CGRect activeFieldRect = [searchBar convertRect:searchBar.bounds toView:scrollView];
//    [scrollView scrollRectToVisible:activeFieldRect animated:YES];
    
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
