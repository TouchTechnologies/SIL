//
//  LiveAroundViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/27/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "LiveAroundViewController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "DataManager.h"
#import "defs.h"
#import "Streaming.h"
#import "MyAnnotation.h"
#import "Haneke.h"
#import "DXAnnotation.h"
#import <DXAnnotationView.h>
#import <DXAnnotationSettings.h>


@interface LiveAroundViewController ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,MKAnnotation>
{
    
    AppDelegate *appDelegate;
    CGFloat fontSize;
    CGFloat cellH;
    
    UIView *navView;
    CGRect navViewRect;
    
    UIButton *doneBtn;
    CGRect doneBtnRect;
    
    UILabel *navTitleLbl;
    CGRect navTitleLblRect;
    
    MKMapView *mapView;
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

    
}
//@property (nonatomic, strong) NSArray *streamList;

@end

@implementation LiveAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];

    
    [self initialSize];
    [self initial];
    [self LoadMap];
    [self initMap];
    
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
    mapView = [[MKMapView alloc] init];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    
    
    
//    NSLog(@"Live Around %@",self.objStreaming);
    // Do any additional setup after loading the view.
    
    

}
-(void)viewWillAppear:(BOOL)animated
{
}
- (void)initial{
    
    
    navView = [[UIView alloc] initWithFrame:navViewRect];
    navView.backgroundColor = [UIColor whiteColor];
    
    doneBtn = [[UIButton alloc] initWithFrame:doneBtnRect];
    [doneBtn setImage:[UIImage imageNamed:@"back_black.png"] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:doneBtn];
    
    navTitleLbl = [[UILabel alloc] initWithFrame:navTitleLblRect];
    navTitleLbl.text = @"Live Around";
    navTitleLbl.textAlignment = NSTextAlignmentCenter;
    navTitleLbl.font = [UIFont fontWithName:@"Helvetica" size:fontSize + 4];
    [navView addSubview:navTitleLbl];
    
    [self.view addSubview:navView];
    
    [scrollView setFrame:scrollViewRect];
    //= [[UIScrollView alloc] initWithFrame:scrollViewRect];
  //  [self.view addSubview:scrollView];
    
    mapView = [[MKMapView alloc] initWithFrame:mapViewRect];
    mapView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
    [scrollView addSubview:mapView];

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
    snapshotDetailImg.image = (self.objStreaming.snapshot != nil)?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.snapshot]]]:[UIImage imageNamed:@"sil_big.jpg"];
    waterMarkDetailImg = [[UIImageView alloc] initWithFrame:waterMarkDetailImgRect];
    waterMarkDetailImg.image = [UIImage imageNamed:@"play.png"];
    [snapshotDetailImg addSubview:waterMarkDetailImg];
    [detailView addSubview:snapshotDetailImg];
    
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
    AvatarDetailImg.image = (self.objStreaming.streamUserImage != nil)?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.objStreaming.streamUserImage]]]:[UIImage imageNamed:@"blank.png"];
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
    tableView.separatorStyle = UITableViewCellStyleDefault;
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
        
        categoryDetailLblRect = CGRectMake(width/2 - (20*scx), detailViewRect.size.height/2 - (fontSize/2), width/2- (40*scx), fontSize);
        TitleDetailLblRect = CGRectMake(width/2 - (20*scx), categoryDetailLblRect.origin.y - (fontSize + 5), width/2, fontSize+2);
        AvatarDetailImgRect = CGRectMake(detailViewRect.size.width - (50*scx), detailViewRect.size.height - (50*scy), 40*scx, 40*scy);
        
        videoCountRect = CGRectMake(0*scx,detailViewRect.origin.y + detailViewRect.size.height,30*scx,30*scy);
        videocountDescRect = CGRectMake(30*scx,detailViewRect.origin.y + detailViewRect.size.height,width - (30*scx),30*scy);
        
        
        tableViewRect = CGRectMake(0*scx, detailViewRect.origin.y + detailViewRect.size.height + (30*scy) , width , 500*scy);
        cellH = 100*scy;
        
        imgSnapshotcellRect = CGRectMake(10*scx , 10*scy , width/2 - (40*scx) , cellH - (20*scy));
        
        imgWaterMarkcellRect = CGRectMake(imgSnapshotcellRect.size.width - (35*scx) , imgSnapshotcellRect.size.height - (35*scy), 30*scx, 30*scy);
        
        streamTitleCellLblRect = CGRectMake(width/2 - (20*scx), cellH/4 - (fontSize/2),width/2, fontSize);
        categoryTitleCellLblRect =  CGRectMake(width/2 - (20*scx), cellH/2 - (fontSize/2), 60*scx, fontSize);
        categoryTypeCellLblRect = CGRectMake(width/2 + (40*scx), cellH/2 - (fontSize/2), 100*scx, fontSize);
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#init tableview
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
    
//    NSLog(@"tabelView Data : %@",stream.streamTitle);
    
//    HNKCacheFormat *format = [HNKCache sharedCache].formats[@"thumbnail"];
//    if (!format)
//    {
//        format = [[HNKCacheFormat alloc] initWithName:@"thumbnail"];
//        format.size = CGSizeMake(320, 240);
//        format.scaleMode = HNKScaleModeAspectFill;
//        format.compressionQuality = 0.5;
//        format.diskCapacity = 1 * 1024 * 1024; // 1MB
//        format.preloadPolicy = HNKPreloadPolicyLastSession;
//    }

    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    imgSnapshotcell = [[UIImageView alloc] initWithFrame:imgSnapshotcellRect];
    imgSnapshotcell.backgroundColor = [UIColor greenColor];
    imgSnapshotcell.image = [UIImage imageNamed:@"sil_big.jpg"];
    imgSnapshotcell.hnk_cacheFormat = format;
    [imgSnapshotcell hnk_setImageFromURL:[NSURL URLWithString:stream.snapshot]];
    
    imgWaterMarkcell = [[UIImageView alloc] initWithFrame:imgWaterMarkcellRect];
    imgWaterMarkcell.image = [UIImage imageNamed:@"play.png"];
    [imgSnapshotcell addSubview:imgWaterMarkcell];
    
    [cell.contentView addSubview:imgSnapshotcell];
    
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
    userAvatarCellimg.image = [UIImage imageNamed:@"blank.png"];
    
    userAvatarCellimg.hnk_cacheFormat = format;
    [userAvatarCellimg hnk_setImageFromURL:[NSURL URLWithString:stream.streamUserImage]];
    userAvatarCellimg.layer.cornerRadius = userAvatarCellimgRect.size.width/2;
    userAvatarCellimg.clipsToBounds = YES;
    [cell addSubview:userAvatarCellimg];
    [tableView setFrame:setFrame];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Select");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellH ;
}


-(void)initMap
{
    mapView.delegate = self;
//    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
//    MKCoordinateRegion region;
//    region.center.latitude = [self.objStreaming.latitude floatValue];
//    region.center.longitude = [self.objStreaming.longitude floatValue];
//    region.span.latitudeDelta = 1;
//    region.span.longitudeDelta = 1;
//    
//    [mapView setRegion:region animated:YES];
    
    
    DXAnnotation *annotation1 = [DXAnnotation new];
    annotation1.coordinate = CLLocationCoordinate2DMake([self.objStreaming.latitude floatValue],[self.objStreaming.longitude floatValue]);
    [mapView addAnnotation:annotation1];
    _rowIndex = 0;
    for(Streaming *stream in _liveAroundData)
    {
//        NSLog(@"stream NAME %lu %@ lat : %@ long : %@",_rowIndex,stream.streamTitle,stream.latitude,stream.longitude);
        pinSnapShot = stream.snapshot;
        NSLog(@"pinSnapShot %@",pinSnapShot);
        DXAnnotation *ann = [DXAnnotation new];
        ann.coordinate = CLLocationCoordinate2DMake([stream.latitude doubleValue],[stream.longitude doubleValue]);
        [mapView addAnnotation:ann];
//        Streaming *data = [_liveAroundData objectAtIndex:_rowIndex];
//        NSLog(@"_liveAroundData %@",data.snapshot);
        _rowIndex++;
    }
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation1.coordinate, 10000, 10000)];

    
}




//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    NSLog(@"MKAnnotationView");
//    if (annotation == mapView.userLocation)
//        return nil;
//    
//    static NSString *s = @"identifier";
//    MKAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:s];
//    if (!pin) {
//        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:s];
//        pin.canShowCallout = YES;
//        pin.image = [UIImage imageNamed:@"maker.png"];
//        pin.calloutOffset = CGPointMake(0, 0);
//    }
//    return pin;
//}
//-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    NSLog(@"MKAnnotationView");
//    MKPinAnnotationView *MyPin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
//    MyPin.pinColor = MKPinAnnotationColorPurple;
//
////    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
////    [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
//    
//    /*MyPin.rightCalloutAccessoryView = advertButton;
//     MyPin.draggable = YES;
//     
//     MyPin.animatesDrop=TRUE;
//     MyPin.canShowCallout = YES;*/
//    MyPin.highlighted = NO;
//    MyPin.image = [UIImage imageNamed:@"maker.png"];
//    
//    return MyPin;
//}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id )annotation {
//    NSLog(@"MKAnnotationView");
//    
//    if (annotation == mapView.userLocation)
//        return nil;
//    
//    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
//    annotationView.canShowCallout = YES;
////    UIImage *image = [UIImage imageNamed:@"pin_2.png"];
////    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
////    imageView.image = image;
//    
//    
////    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
////    [advertButton addTarget:self action:@selector(annotationClick:) forControlEvents:UIControlEventTouchUpInside];
////    annotationView.rightCalloutAccessoryView = advertButton;
//    
//    
//    imgSnapshot = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,70)];
//    imgSnapshot.image = [UIImage imageNamed:@"activities02.jpg"];
//    imgSnapshot.layer.borderWidth = 2 ;
//    imgSnapshot.layer.borderColor = [UIColor whiteColor].CGColor;
//    
//    
//    
//
//    [imgSnapshot setUserInteractionEnabled:YES];
//    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(annotationClick:)];
//    [singleTap setNumberOfTapsRequired:1];
//    [imgSnapshot addGestureRecognizer:singleTap];
//    
//    
//    
//
//    
//    [annotationView addSubview:imgSnapshot];
//    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
//    [annotationView addSubview:pinView];
//    
//    return annotationView;
//    
//}
- (void)annotationClick:(id)sender
{
    NSLog(@"annotationClick");
}





//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    NSLog(@"mapView");
//    if ([annotation isKindOfClass:[DXAnnotation class]]) {
//        
//        UIImageView *pinView = nil;
//        UIView *calloutView = nil;
//        
//         DXAnnotation *annotation1 = (DXAnnotation *)annotation;
//        
//        DXAnnotationView *annotationView = (DXAnnotationView *)[self->mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
//        if (!annotationView) {
//            pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pin_checkin"]];
////            pinView = [[UIImageView alloc] initWithImage:[self resizeImage:[UIImage imageNamed:@"ic_pin_checkin"] imageSize:CGSizeMake(30, 60)]];
//            pinView.contentMode = UIViewContentModeScaleAspectFit;
//            pinView.clipsToBounds = YES;
//            calloutView = [[[NSBundle mainBundle] loadNibNamed:@"liveAroundAnnotation" owner:self options:nil] firstObject];
//            UIImageView *annoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activities02.jpg"]];
////            UIImageView *annoImage = [[UIImageView alloc] initWithImage:[self resizeImage:[UIImage imageNamed:@"activities02.jpg"] imageSize:CGSizeMake(200, 100)]];
//
////            UIImageView *annoImage = [[UIImageView alloc] init];
////            UIImageView *annoImage = [[UIImageView alloc] initWithImage:[self resizeImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pinSnapShot]]] imageSize:CGSizeMake(200, 100)]];
////            annoImage.hnk_cacheFormat = format;
////            [annoImage hnk_setImageFromURL:[NSURL URLWithString:pinSnapShot]];
////            [calloutView addSubview:annoImage];
//            
//            annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:NSStringFromClass([DXAnnotationView class])
//                                                                  pinView:pinView
//                                                              calloutView:calloutView
//                                                                 settings:[DXAnnotationSettings defaultSettings]];
//            
//        }else {
//            
//            //Changing PinView's image to test the recycle
////            pinView = (UIImageView *)annotationView.pinView;
////            pinView.image = [UIImage imageNamed:@"car-blue-icorn"];
//        }
//        
//        annotationView.tag = annotation1.tag;
//        return annotationView;
//    }
//    return nil;
//}
//
//
//
//- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
//    if ([view isKindOfClass:[DXAnnotationView class]]) {
//        [((DXAnnotationView *)view)hideCalloutView];
//        view.layer.zPosition = -1;
//    }
//}
//
//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    if ([view isKindOfClass:[DXAnnotationView class]]) {
//        [((DXAnnotationView *)view)showCalloutView];
//        view.layer.zPosition = 0;
//        
//        DXAnnotationView *dxView = (DXAnnotationView *)view;
//        NSInteger indexObj = dxView.tag;
//        NSLog(@"select anno : %ld",indexObj);
//    }
//}



- (void)LoadMap {
    
    //CCTVS *cctvs = [self.roi.cctvs objectAtIndex:self.rowIndex];
    
    [self changeLocation:self.rowIndex];
    
}
- (void)changeLocation:(NSInteger)rowIndex {
    NSLog(@"changeLocation");
    mapView.delegate = self;
    [mapView removeAnnotations:mapView.annotations];
    
    [self.liveAroundData enumerateObjectsUsingBlock:^(Streaming *stream, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"index idx %lu",(unsigned long)idx);
        if (idx != rowIndex) {
            NSLog(@"rowIndex idx %lu",(unsigned long)rowIndex);
            DXAnnotation *annotation1 = [DXAnnotation new];
            annotation1.tag = idx;
            annotation1.coordinate = CLLocationCoordinate2DMake([stream.latitude doubleValue],[stream.longitude doubleValue]);
            annotation1.pinName = @"mappin";
            [mapView addAnnotation:annotation1];
            [mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation1.coordinate, 10000, 10000)];
        }
        
    }];
    
    Streaming *stream = [self.liveAroundData objectAtIndex:rowIndex];
    
    DXAnnotation *annoActive = [DXAnnotation new];
    annoActive.tag = rowIndex;
    annoActive.coordinate = CLLocationCoordinate2DMake([stream.latitude doubleValue],[stream.longitude doubleValue]);
    annoActive.pinName = @"pin";
    [mapView addAnnotation:annoActive];
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(annoActive.coordinate, 10000, 10000)];
    
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    [self changePoint:pageIndex];
    
//    self.customPageControl.currentPage = pageIndex;
    
}

- (void)changePoint:(NSInteger)index {
    //change label
    Streaming *stream = [self.liveAroundData objectAtIndex:index];
//    lblPoint.frame = lblPointRect; //CGRectMake(35, 194, 400, 25);
//    lblPoint.text = cctvs.cctvName;
//    lblPoint.lineBreakMode = NSLineBreakByWordWrapping;
//    lblPoint.numberOfLines = 0;
//    lblPoint.textAlignment = NSTextAlignmentLeft;
//    [lblPoint sizeToFit];
    
    //change location
    [self changeLocation:index];
    
    //change description
    
//    self.lblDesc.text = cctvs.cctvDesc;
//    self.lblDesc.lineBreakMode = NSLineBreakByWordWrapping;
//    self.lblDesc.numberOfLines = 0;
//    self.lblDesc.textAlignment = NSTextAlignmentJustified;
//    [self.lblDesc sizeToFit];
    
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[DXAnnotation class]]) {
        
        DXAnnotation *annotation1 = (DXAnnotation *)annotation;
        UIView *calloutView = [[[NSBundle mainBundle] loadNibNamed:@"liveAroundAnnotation" owner:self options:nil] firstObject];
        
        DXAnnotationView *annotationView = (DXAnnotationView *)[self->mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
        /*
         NSString *pinName = @"";
         
         if (annotation1.tag == 1) {
         pinName = @"pin";
         } else {
         pinName = @"mappin";
         }
         */
        
        UIView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:annotation1.pinName]];
        
        
        //if (!annotationView) {
        
        annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:NSStringFromClass([DXAnnotationView class])
                                                              pinView:pinView
                                                          calloutView:nil
                                                             settings:[DXAnnotationSettings defaultSettings]];
        /*
         } else {
         [pinView removeFromSuperview];
         [annotationView addSubview:pinView];
         }
         */
        
        /*
         annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([DXAnnotationView class])];
         [annotationView addSubview:pinView];
         */
        
        //annotationView.image = [UIImage imageNamed:annotation1.pinName];
        
        
        annotationView.tag = annotation1.tag;
        
        return annotationView;
    }
    
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[DXAnnotationView class]]) {
        [((DXAnnotationView *)view)showCalloutView];
        view.layer.zPosition = 0;
        DXAnnotationView *dxView = (DXAnnotationView *)view;
        
        NSInteger indexObj = dxView.tag;
        
        NSLog(@"test annotation %ld",(long)indexObj);
        [self->mapView removeAnnotations:self->mapView.annotations];
//        [self changeLocation:5];
        
//        [previewScrollView setContentOffset:CGPointMake(previewScrollView.frame.size.width * indexObj, 0.0f)];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    [((DXAnnotationView *)view)hideCalloutView];
    view.layer.zPosition = -1;
    //NSLog(@"deselect test annotation");
}


-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
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
