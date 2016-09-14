//
//  LiveAroundViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/27/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "LiveAroundViewController.h"
//#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "DataManager.h"
#import "defs.h"
#import "Streaming.h"
#import "MyAnnotation.h"
#import "Haneke.h"
#import "DXAnnotation.h"
#import <DXAnnotationView.h>
#import <DXAnnotationSettings.h>
#import "StreamingDetailViewController.h"
#import <Google-Maps-iOS-Utils/GMUMarkerClustering.h>
#import <GoogleMaps/GoogleMaps.h>
#import "playStreamViewController.h"


@interface POIItem : NSObject<GMUClusterItem>

@property(nonatomic, readonly) CLLocationCoordinate2D position;
@property(nonatomic, readonly) NSString *name;

- (instancetype)initWithPosition:(CLLocationCoordinate2D)position name:(NSString *)name;

@end

@implementation POIItem

- (instancetype)initWithPosition:(CLLocationCoordinate2D)position name:(NSString *)name {
    if ((self = [super init])) {
        _position = position;
        _name = [name copy];
    }
    return self;
}

@end

static const NSUInteger kClusterItemCount = 10000;
//static const double kCameraLatitude = 40.714353;
//static const double kCameraLongitude = -74.005973;
GMSMarker *marker;


@interface LiveAroundViewController ()<GMUClusterManagerDelegate, GMSMapViewDelegate>{
    
    AppDelegate *appDelegate;
    CGFloat fontSize;
    CGFloat cellH;
    
    UIView *navView;
    CGRect navViewRect;
    
    UIButton *doneBtn;
    CGRect doneBtnRect;
    
    UILabel *navTitleLbl;
    CGRect navTitleLblRect;
    
//    MKMapView *myMapView;
    CGRect mapViewRect;
    
    UIImageView *imgSnapshot;
    CGRect imgSnapshotRect;
    
    UIImageView *imgPin;
    CGRect imgPinRect;
    
    UIImageView *imgWaterMark;
    CGRect imgWaterMarkRect;
    
    UILabel *videoCount;
    CGRect videoCountRect;
    UILabel *videocountDesc;
    CGRect videocountDescRect;
    
    UIView *detailView ;
    CGRect detailViewRect;
    
    UIImageView *snapshotDetailImg;
    CGRect snapshotDetailImgRect;
    
    UIImageView *waterMarkDetailImg;
    CGRect waterMarkDetailImgRect;
    
    UILabel *TitleDetailLbl;
    CGRect TitleDetailLblRect;
    
    UILabel *categoryDetailLbl;
    NSString *strCategoryType;
    CGRect categoryDetailLblRect;
    
    UIImageView *AvatarDetailImg;
    CGRect AvatarDetailImgRect;
    
    UITableView *tableView;
    CGRect tableViewRect;
    UITableViewCell *cell;
    
    UIImageView *imgSnapshotcell;
    CGRect imgSnapshotcellRect;
    
    UIImageView *imgWaterMarkcell;
    CGRect imgWaterMarkcellRect;
    
    UILabel *streamTitleCellLbl;
    CGRect streamTitleCellLblRect;
    
    UILabel *categoryTitleCellLbl;
    CGRect categoryTitleCellLblRect;
    
    UILabel *categoryTypeCellLbl;
    CGRect categoryTypeCellLblRect;
    
    UIImageView *imgLoveCell;
    CGRect imgLoveCellRect;
    
    UILabel *loveCountCellLbl;
    CGRect loveCountCellLblRect;
    
    UIImageView *userAvatarCellimg;
    CGRect userAvatarCellimgRect;
    

    IBOutlet UIScrollView *scrollView;
    CGRect scrollViewRect;
    NSString* pinSnapShot;
    HNKCacheFormat *format;
    int pinCount;
    int streamCount;
    _Bool pinChange;
    
    NSUInteger *indexPin;
    CGRect watermarkMapRect;
    UIImageView *snap;
    UIView *outerView;
}
@property(nonatomic, strong) IBOutlet UIView *myMapView;
@property (nonatomic, strong) NSArray *streamList;
@property (nonatomic, strong) NSArray *anotationList;

//@property (nonatomic, strong) NSArray *streamList;

@end

@implementation LiveAroundViewController{
    GMSMapView *_mapView;
    GMUClusterManager *_clusterManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Streaming *sss = [self.liveAroundData objectAtIndex:1];
    NSLog(@"LIVE DATA %@",sss.createBy);
    
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    pinCount = 0;
    streamCount = [_liveAroundData count];
    pinChange = false;
    marker.zIndex= 0;
    [self initialSize];
    [self initial];
    [self LoadMap];
  //  [self initMap];
    
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
    
    scrollView.delegate = self;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    id<GMUClusterAlgorithm> algorithm = [[GMUNonHierarchicalDistanceBasedAlgorithm alloc] init];
    id<GMUClusterIconGenerator> iconGenerator = [[GMUDefaultClusterIconGenerator alloc] init];
    id<GMUClusterRenderer> renderer =
    [[GMUDefaultClusterRenderer alloc] initWithMapView:_mapView
                                  clusterIconGenerator:iconGenerator];
    _clusterManager =
    [[GMUClusterManager alloc] initWithMap:_mapView algorithm:algorithm renderer:renderer];

    [_clusterManager cluster];

    [_clusterManager setDelegate:self mapDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *filter = [@"/" stringByAppendingFormat:@"nearby?at=%@,%@&distance=%d&filterLimit=%d&filtersPage=%d",self.objStreaming.latitude,self.objStreaming.longitude,20,20,1];
    
    [[DataManager shareManager] getStreamingWithCompletionBlockWithFilter:^(BOOL success, NSArray *streamRecords, NSError *error) {
        
        if (success) {
            
            
            NSLog(@"filter LiveAround Data : %@",streamRecords);
            self.liveAroundData = streamRecords;
             NSLog(@"filter LiveAround Count : %lu", (unsigned long)self.liveAroundData.count );
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NotConnect message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } Filter:filter];
    
    
}
- (void)initial{
    
    
    navView = [[UIView alloc] initWithFrame:navViewRect];
    navView.backgroundColor = [UIColor blackColor];
    
    doneBtn = [[UIButton alloc] initWithFrame:doneBtnRect];
    [doneBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:doneBtn];
    
    navTitleLbl = [[UILabel alloc] initWithFrame:navTitleLblRect];
    navTitleLbl.text = @"Live Around";
    navTitleLbl.textColor = [UIColor whiteColor];
    navTitleLbl.textAlignment = NSTextAlignmentCenter;
    navTitleLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize + 4];
    [navView addSubview:navTitleLbl];
    
    [self.view addSubview:navView];
    
    [scrollView setFrame:scrollViewRect];

    
    self.myMapView = [[UIView alloc] initWithFrame:mapViewRect];
    self.myMapView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:self.myMapView];
  
    
    
    //Google map///
    
    GMSCameraPosition *camera =
    [GMSCameraPosition cameraWithLatitude:[self.objStreaming.latitude floatValue] longitude:[self.objStreaming.longitude floatValue] zoom:10];
    
    _mapView = [GMSMapView mapWithFrame: self.myMapView.bounds camera:camera];
    _mapView.myLocationEnabled = NO;
    [self.myMapView addSubview:_mapView];
    _mapView.delegate = self;
    

//    imgSnapshot = [[UIImageView alloc] initWithFrame:imgSnapshotRect];
//    imgSnapshot.image = [UIImage imageNamed:@"activities02.jpg"];
//    imgSnapshot.layer.borderWidth = 2 ;
//    imgSnapshot.layer.borderColor = [UIColor whiteColor].CGColor;
//
//    imgWaterMark = [[UIImageView alloc] initWithFrame:imgWaterMarkRect];
//    imgWaterMark.image = [UIImage imageNamed:@"play.png"];
//    [imgSnapshot addSubview:imgWaterMark];
//    [mapView addSubview:imgSnapshot];
//    
//    imgPin = [[UIImageView alloc] initWithFrame:imgPinRect];
//    imgPin.image = [UIImage imageNamed:@"pin_2.png"];
//    [mapView addSubview:imgPin];
    
    detailView = [[UIView alloc] initWithFrame:detailViewRect];
    detailView.backgroundColor = [UIColor redColor];
    
    snapshotDetailImg = [[UIImageView alloc] initWithFrame:snapshotDetailImgRect];
    snapshotDetailImg.backgroundColor = [UIColor greenColor];
     snapshotDetailImg.image = [UIImage imageNamed:@"sil_big.jpg"];
    snapshotDetailImg.hnk_cacheFormat = format;
    [snapshotDetailImg hnk_setImageFromURL:[NSURL URLWithString:self.objStreaming.snapshot]];

//    if (self.objStreaming.snapshot != nil) {
//        snapshotDetailImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.snapshot]]];
//        
//    }
//  snapshotDetailImg.image = (self.objStreaming.snapshot != nil)?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.snapshot]]]:[UIImage imageNamed:@"sil_big.jpg"];
    snapshotDetailImg.contentMode = UIViewContentModeScaleToFill;
    [detailView addSubview:snapshotDetailImg];
    
    waterMarkDetailImg = [[UIImageView alloc] initWithFrame:waterMarkDetailImgRect];
    waterMarkDetailImg.image = [UIImage imageNamed:@"play.png"];
    [snapshotDetailImg addSubview:waterMarkDetailImg];
    
    TitleDetailLbl = [[UILabel alloc] initWithFrame:TitleDetailLblRect];
    TitleDetailLbl.text = self.objStreaming.streamTitle;
    TitleDetailLbl.textColor = [UIColor whiteColor];
    TitleDetailLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    [detailView addSubview:TitleDetailLbl];
    
    NSString *typeStr = self.objStreaming.categoryName;
    strCategoryType = [[NSString alloc] init];
    strCategoryType = [NSString stringWithFormat:@"Category : %@" ,typeStr];
    categoryDetailLbl = [[UILabel alloc] initWithFrame:categoryDetailLblRect];
    categoryDetailLbl.text = strCategoryType;
    categoryDetailLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryDetailLbl.textColor = [UIColor whiteColor];
    [detailView addSubview:categoryDetailLbl];

    
    AvatarDetailImg = [[UIImageView alloc] initWithFrame:AvatarDetailImgRect];
    AvatarDetailImg.image = (self.objStreaming.streamUserImage != nil)?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.streamUserImage]]]:[UIImage imageNamed:@"anonymous.png"];
    AvatarDetailImg.layer.cornerRadius = AvatarDetailImgRect.size.width/2;
    AvatarDetailImg.clipsToBounds =YES ;
    AvatarDetailImg.contentMode = UIViewContentModeScaleAspectFill;
    [detailView addSubview:AvatarDetailImg];
    
    
    [scrollView addSubview:detailView];
    
    videoCount = [[UILabel alloc] initWithFrame:videoCountRect];
    videoCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)_liveAroundData.count];
    videoCount.textColor = [UIColor blackColor];
    videoCount.textAlignment = NSTextAlignmentCenter;
    videoCount.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize-2];
    [scrollView addSubview:videoCount];
    
    videocountDesc = [[UILabel alloc] initWithFrame:videocountDescRect];
    videocountDesc.text = @"Video around here";
    videocountDesc.textColor = [UIColor grayColor];
    videocountDesc.textAlignment = NSTextAlignmentLeft;
    videocountDesc.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    [scrollView addSubview:videocountDesc];
    
    
    tableView = [[UITableView alloc] initWithFrame:tableViewRect];
    tableView.backgroundColor = [UIColor grayColor];
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];

    [scrollView addSubview:tableView];
}
- (void)doneAction : (id)sender{

    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)initialSize{
   
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        fontSize = 14*scy;
        
        navViewRect = CGRectMake(0*scx, 20*scy , width, 50);
        scrollViewRect = CGRectMake(0*scx, 50*scy, width, height - (50*scy));
        doneBtnRect = CGRectMake(10, navViewRect.size.height/2 - (15*scy), 30*scx, 30*scy);
        
        navTitleLblRect = CGRectMake(navViewRect.size.width/2 - (50*scx) , navViewRect.size.height/2 - (15*scy), 100*scx, 30*scy);
        
        scrollViewRect = CGRectMake(0*scx, navViewRect.origin.y + navViewRect.size.height, width, height - (navViewRect.size.height + (20*scy)));
        mapViewRect = CGRectMake(0*scx, 0*scy, width, height/2 - navViewRect.size.height);
        
        imgSnapshotRect = CGRectMake(mapViewRect.size.width/2 - (50*scx), mapViewRect.size.height/2 - (70*scy), 100*scx, 70*scy);
        imgWaterMarkRect = CGRectMake(imgSnapshotRect.size.width/2 - (15*scx) , imgSnapshotRect.size.height/2 - (15*scy), 30*scx, 30*scy);
        imgPinRect = CGRectMake(mapViewRect.size.width/2 - (25*scx), mapViewRect.size.height/2 + (5*scy), 50*scx, 50*scy);
        
        detailViewRect = CGRectMake(0*scx , mapViewRect.origin.y + mapViewRect.size.height, width, 100*scy);
        snapshotDetailImgRect = CGRectMake(10*scx, 10*scy , width/2 - (40*scx), detailViewRect.size.height - (20*scy));
        waterMarkDetailImgRect = CGRectMake(snapshotDetailImgRect.size.width - (35*scx) , snapshotDetailImgRect.size.height - (35*scy), 30*scx, 30*scy);
        
        categoryDetailLblRect = CGRectMake(width/2 - (20*scx), detailViewRect.size.height/2 - (fontSize/2), width/2- (40*scx), fontSize+4);
        TitleDetailLblRect = CGRectMake(width/2 - (20*scx), categoryDetailLblRect.origin.y - (fontSize + 5), width/2, fontSize+4);
        AvatarDetailImgRect = CGRectMake(detailViewRect.size.width - (50*scx), detailViewRect.size.height - (50*scy), 40*scx, 40*scy);
        
        videoCountRect = CGRectMake(0*scx,detailViewRect.origin.y + detailViewRect.size.height,30*scx,30*scy);
        videocountDescRect = CGRectMake(30*scx,detailViewRect.origin.y + detailViewRect.size.height,width - (30*scx),30*scy);
        
        
        tableViewRect = CGRectMake(0*scx, detailViewRect.origin.y + detailViewRect.size.height + (30*scy) , width , 500*scy);
        cellH = 100*scy;
        
        imgSnapshotcellRect = CGRectMake(10*scx , 10*scy , width/2 - (40*scx) , cellH - (20*scy));
        
        imgWaterMarkcellRect = CGRectMake(imgSnapshotcellRect.size.width - (35*scx) , imgSnapshotcellRect.size.height - (35*scy), 30*scx, 30*scy);
        
        streamTitleCellLblRect = CGRectMake(width/2 - (20*scx), cellH/4 - (fontSize/2),width/2, fontSize+4);
        categoryTitleCellLblRect =  CGRectMake(width/2 - (20*scx), cellH/2 - (fontSize/2), 65*scx, fontSize+4);
        categoryTypeCellLblRect = CGRectMake(categoryTitleCellLblRect.origin.x +categoryTitleCellLblRect.size.width, cellH/2 - (fontSize/2), 100*scx, fontSize+4);
        imgLoveCellRect = CGRectMake(width/2 - (20*scx), cellH - (30*scy), 20*scx, 20*scy);
        loveCountCellLblRect = CGRectMake(width/2 + (5*scx) , cellH - (25*scy), 50*scx, fontSize);
        userAvatarCellimgRect = CGRectMake(width - (50*scx), cellH - (50*scy) , 40*scx, 40*scy);
    }
    else{
    fontSize = 14;
    
    navViewRect = CGRectMake(0, 20 , width, 50);
    scrollViewRect = CGRectMake(0, 50, width, height - 50);
    doneBtnRect = CGRectMake(10, navViewRect.size.height/2 - 15, 30, 30);
    navTitleLblRect = CGRectMake( navViewRect.size.width/2 - 50 , navViewRect.size.height/2 - 15, 100, 30);
    
    scrollViewRect = CGRectMake(0, navViewRect.origin.y + navViewRect.size.height, width, height - (navViewRect.size.height + 20));
    mapViewRect = CGRectMake(0, 0, width, height/2 - navViewRect.size.height);

    imgSnapshotRect = CGRectMake(mapViewRect.size.width/2 - 50, mapViewRect.size.height/2 - 70, 100, 70);
    imgWaterMarkRect = CGRectMake(imgSnapshotRect.size.width/2 - 15 , imgSnapshotRect.size.height/2 - 15, 30, 30);
    imgPinRect = CGRectMake(mapViewRect.size.width/2 - 25, mapViewRect.size.height/2 + 5, 50, 50);
  

    detailViewRect = CGRectMake(0 , mapViewRect.origin.y + mapViewRect.size.height, width, 100);
    snapshotDetailImgRect = CGRectMake(10, 10 , width/2 - 40, detailViewRect.size.height - 20);
    waterMarkDetailImgRect = CGRectMake(snapshotDetailImgRect.size.width - 35 , snapshotDetailImgRect.size.height - 35, 30, 30);
        
    categoryDetailLblRect = CGRectMake(width/2 - 20, detailViewRect.size.height/2 - (fontSize/2), width/2-40, fontSize);
    TitleDetailLblRect = CGRectMake(width/2 - 20, categoryDetailLblRect.origin.y - (fontSize + 5), width/2, fontSize+2);
    AvatarDetailImgRect = CGRectMake(detailViewRect.size.width - 50, detailViewRect.size.height - 50, 40, 40);
    
    videoCountRect = CGRectMake(0,detailViewRect.origin.y + detailViewRect.size.height,30,30);
    videocountDescRect = CGRectMake(30,detailViewRect.origin.y + detailViewRect.size.height,width - 30,30);

    
    tableViewRect = CGRectMake(0, detailViewRect.origin.y + detailViewRect.size.height + 30 , width , 500);
    cellH = 100;
    
    imgSnapshotcellRect = CGRectMake(10 , 10 , width/2 - 40 , cellH - 20);
    
    imgWaterMarkcellRect = CGRectMake(imgSnapshotcellRect.size.width - 35 , imgSnapshotcellRect.size.height - 35, 30, 30);
   
    streamTitleCellLblRect = CGRectMake(width/2 - 20, cellH/4 - (fontSize/2),width/2, fontSize);
    categoryTitleCellLblRect =  CGRectMake(width/2 - 20, cellH/2 - (fontSize/2), 60, fontSize);
    categoryTypeCellLblRect = CGRectMake(width/2 + 40, cellH/2 - (fontSize/2), 100, fontSize);
    imgLoveCellRect = CGRectMake(width/2 - 20, cellH - 30, 20, 20);
    loveCountCellLblRect = CGRectMake(width/2 + 5 , cellH - 25, 50, fontSize);
    userAvatarCellimgRect = CGRectMake(width - 50, cellH - 50 , 40, 40);
    }

    
}

//init tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.liveAroundData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak LiveAroundViewController *weakSelf = self;
    Streaming* stream = [[Streaming alloc]init];
    stream = [weakSelf.liveAroundData objectAtIndex:indexPath.row];
    
    CGRect setFrame ;
    CGFloat scy = (1024.0/480.0);
    CGFloat scx = (768.0/360.0);
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      setFrame =  CGRectMake(0*scx, detailViewRect.origin.y + detailViewRect.size.height + (30*scy) , width , cellH*(self.liveAroundData.count));

    }
    else{
       setFrame = CGRectMake(0, detailViewRect.origin.y + detailViewRect.size.height + 30 , width , cellH*(self.liveAroundData.count));

    }
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    imgSnapshotcell = [[UIImageView alloc] initWithFrame:imgSnapshotcellRect];
    imgSnapshotcell.backgroundColor = [UIColor greenColor];
    imgSnapshotcell.image = [UIImage imageNamed:@"sil_big.jpg"];
    imgSnapshotcell.hnk_cacheFormat = format;
    [imgSnapshotcell hnk_setImageFromURL:[NSURL URLWithString:stream.snapshot]];
    imgSnapshotcell.contentMode = UIViewContentModeScaleToFill;
    imgSnapshotcell.tag =  [indexPath row];

    imgWaterMarkcell = [[UIImageView alloc] initWithFrame:imgWaterMarkcellRect];
    imgWaterMarkcell.image = [UIImage imageNamed:@"play.png"];
    [imgSnapshotcell addSubview:imgWaterMarkcell];
    [cell.contentView addSubview:imgSnapshotcell];

//    UITapGestureRecognizer* playStream = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self action:@selector(play:)];
//    [playStream setNumberOfTouchesRequired:1];
//    [playStream setDelegate:self];
//    imgSnapshotcell.userInteractionEnabled = YES;
//    [imgSnapshotcell addGestureRecognizer:playStream];
    
//    [cell addGestureRecognizer:tapGestureRec];
    
//  UITapGestureRecognizer* goProfile = [[UITapGestureRecognizer alloc]
//                                         initWithTarget:self action:@selector(goProfile:)];
//    Here should be actionViewTap:
//    
//    [goProfile setNumberOfTouchesRequired:1];
//    [goProfile setDelegate:self];
//    goProfile.enabled = YES;
//    
//    cell.lblCreateBy.userInteractionEnabled = YES;
//    cell.lblCreateBy.tag = [indexPath index];
//    [cell.lblCreateBy addGestureRecognizer:goProfile];
//    
//    [imgWaterMark addGestureRecognizer:];
    
    streamTitleCellLbl = [[UILabel alloc] initWithFrame:streamTitleCellLblRect];
    streamTitleCellLbl.text = stream.streamTitle;
    streamTitleCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    [cell.contentView addSubview:streamTitleCellLbl];
    
    categoryTitleCellLbl = [[UILabel alloc] initWithFrame:categoryTitleCellLblRect];
    categoryTitleCellLbl.text = @"Category : ";
    categoryTitleCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryTitleCellLbl.textColor = [UIColor grayColor];
    [cell.contentView addSubview:categoryTitleCellLbl];
    
    categoryTypeCellLbl = [[UILabel alloc] initWithFrame:categoryTypeCellLblRect];
    categoryTypeCellLbl.text = stream.categoryName;
    categoryTypeCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize - 2];
    categoryTypeCellLbl.textColor = [UIColor redColor];
    [cell.contentView addSubview:categoryTypeCellLbl];
    
    imgLoveCell = [[UIImageView alloc] initWithFrame:imgLoveCellRect];
    imgLoveCell.image = [UIImage imageNamed:@"ic_love2.png"];
    imgLoveCell.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imgLoveCell];
    
    loveCountCellLbl = [[UILabel alloc] initWithFrame:loveCountCellLblRect];
    loveCountCellLbl.textColor = [UIColor redColor];
    loveCountCellLbl.text = [NSString stringWithFormat:@"%ld",(long)stream.lovesCount];
    loveCountCellLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
    [cell.contentView addSubview:loveCountCellLbl];
    
    userAvatarCellimg = [[UIImageView alloc] initWithFrame:userAvatarCellimgRect];
    userAvatarCellimg.image = [UIImage imageNamed:@"anonymous.png"];
    
    userAvatarCellimg.hnk_cacheFormat = format;
    [userAvatarCellimg hnk_setImageFromURL:[NSURL URLWithString:stream.streamUserImage]];
    userAvatarCellimg.layer.cornerRadius = userAvatarCellimgRect.size.width/2;
    userAvatarCellimg.clipsToBounds = YES;
    [cell addSubview:userAvatarCellimg];
    [tableView setFrame:setFrame];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (cell == nil) {}
    else{
        [scrollView setContentOffset:CGPointMake(0,0) animated:YES];
        [self changeLocation:[indexPath row]];
    }
    NSLog(@"Select");

  }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellH ;
}


-(void)initPin:(NSInteger)rowIndex{
    //marker.zIndex = 0;

    [self.liveAroundData enumerateObjectsUsingBlock:^(Streaming *stream, NSUInteger idx, BOOL *stop) {
        marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([stream.latitude doubleValue], [stream.longitude doubleValue]);
        marker.title = stream.streamTitle;
        marker.map = _mapView;
        marker.icon = [UIImage imageNamed:@"mappin.png"];
        marker.tappable = YES;
        NSLog(@"Long ::: %@",stream.longitude);
        NSLog(@"Lat ::: %@", stream.latitude);
        
        
        
        
            NSLog(@"index idx %lu",(unsigned long)idx);
            NSLog(@"rowIndex idx %lu",(unsigned long)rowIndex);
        indexPin = idx;
        if (idx == rowIndex) {
            
            GMSCameraPosition *newCamera =
            [GMSCameraPosition cameraWithTarget:marker.position zoom:_mapView.camera.zoom];
            GMSCameraUpdate *update = [GMSCameraUpdate setCamera:newCamera];
            
            marker.icon = [UIImage imageNamed:@"pin1.png"];
            _mapView.selectedMarker = marker;
            marker.tappable = NO;
            [_mapView moveCamera:update];
        }

        pinCount++;
        marker.zIndex++;
        NSLog(@"MARKER INDEX ::: %d",marker.zIndex);
        NSLog(@"PIN INDEX ::: %lu",(unsigned long)indexPin);
        
        
        marker.zIndex = (int)indexPin;

    }];
    
    NSLog(@"PIN COUNT ::: %d",pinCount);
    
}

- (void)LoadMap{
   // [self.myMapView setDelegate:self];
    [self initPin:_rowIndex];
    
}
- (void)changeLocation:(NSInteger)rowIndex{
    NSLog(@"changeLocation");
    pinCount = 0;
    [_mapView clear];
    [self initPin:rowIndex];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);

    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/////////////////Google map///////////////
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    Streaming* stream1 = [[Streaming alloc]init];
    stream1 = [self.streamList objectAtIndex: (int)indexPin];
    NSLog(@"MARKER IDD %d" ,(int)indexPin);

    NSLog(@"custom callout view");
    int popupWidth = 100;
    int contentWidth = 80;
    int contentHeight = 140;
    int contentPad = 10;
    int popupHeight = 70;
    int popupBottomPadding = 16;
    int popupContentHeight = contentHeight - popupBottomPadding;
    int buttonHeight = 30;
    int anchorSize = 20;
    
    CLLocationCoordinate2D anchor = marker.position;
    CGPoint point = [_mapView.projection pointForCoordinate:anchor];
    
    
    outerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popupWidth, popupHeight)];
    [outerView setBackgroundColor:[UIColor redColor]];
    
    snap = [[UIImageView alloc] initWithFrame:outerView.bounds];
    snap.image = [UIImage imageNamed: @"sil_big.jpg"];
    [snap hnk_setImageFromURL:[NSURL URLWithString:stream1.snapshot]];
    [outerView addSubview:snap];
    
    UIButton *WaterMarkicon = [[UIButton alloc] initWithFrame:imgWaterMarkRect];
    [WaterMarkicon setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [snap addSubview:WaterMarkicon];
  
    outerView.tag =(int)indexPin;
    
    return outerView;
    
}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    
    NSLog(@"didTapInfoWindowOfMarker index!!!");
    NSLog(@"PIN INDEXXXX %d",(int)indexPin);
    NSInteger PlayTag  = [outerView tag];
    NSLog (@"Tag Playyyyy %ld",(long)PlayTag);
    Streaming *stream = [self.liveAroundData objectAtIndex:PlayTag];
    
    playStreamViewController *streamingDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"playstream"];
    streamingDetail.objStreaming = stream;
    streamingDetail.streamingType = @"history";
   
    
    
    NSLog(@"OBJ STREAM :::%@",stream);
    
    [self presentViewController:streamingDetail animated:YES completion:nil];

}

#pragma mark GMUClusterManagerDelegate
- (void)clusterManager:(GMUClusterManager *)clusterManager didTapCluster:(id<GMUCluster>)cluster {
   }
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
   
    NSLog(@"MARKER ID %d" ,marker.zIndex);
    [self changeLocation:marker.zIndex];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) refreshList:(NSNotification *)refreshName
{
    NSLog(@"ADView Notiname: %@",[refreshName name]);
    if ([[refreshName name] isEqualToString:@"refresh"])
    {
        
        
        [self.view reloadInputViews];
    }
    
}

@end
