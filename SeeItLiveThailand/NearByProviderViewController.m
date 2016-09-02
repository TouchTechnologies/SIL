//
//  NearByProviderViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 9/1/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//
#import "AppDelegate.h"
#import "NearByProviderViewController.h"
#import "ADPageControl.h"
#import <Google-Maps-iOS-Utils/GMUMarkerClustering.h>
#import <GoogleMaps/GoogleMaps.h>
#import "DetailNearbyViewController.h"

@interface POIItem : NSObject<GMUClusterItem>
//@property(nonatomic, readonly) CLLocationCoordinate2D position;
//@property(nonatomic, readonly) NSString *name;
//- (instancetype)initWithPosition:(CLLocationCoordinate2D)position name:(NSString *)name;
//
@end
//
//@implementation POIItem
//- (instancetype)initWithPosition:(CLLocationCoordinate2D)position name:(NSString *)name {
//    if ((self = [super init])) {
////        _position = position;
////        _name = [name copy];
//    }
//    return self;
//}

//@end

static const NSUInteger kClusterItemCount = 10000;

@interface NearByProviderViewController ()<ADPageControlDelegate,GMUClusterManagerDelegate, GMSMapViewDelegate>
{
    ADPageControl *pageControl;
      BOOL isLazy;
    GMSMarker *marker;
    
    UIImageView *snap;
    UIView *outerView;
}
@property(nonatomic, strong) IBOutlet UIView *myMapView;
@end

@implementation NearByProviderViewController
{
    GMSMapView *_mapView;
    GMUClusterManager *_clusterManager;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initialPager];
    id<GMUClusterAlgorithm> algorithm = [[GMUNonHierarchicalDistanceBasedAlgorithm alloc] init];
    id<GMUClusterIconGenerator> iconGenerator = [[GMUDefaultClusterIconGenerator alloc] init];
    id<GMUClusterRenderer> renderer =
    [[GMUDefaultClusterRenderer alloc] initWithMapView:_mapView
                                  clusterIconGenerator:iconGenerator];
    _clusterManager =
    [[GMUClusterManager alloc] initWithMap:_mapView algorithm:algorithm renderer:renderer];
    
    [_clusterManager cluster];
    
    [_clusterManager setDelegate:self mapDelegate:self];
    // Do any additional setup after loading the view.
}
- (void)initialPager{
    self.headerView.backgroundColor = [UIColor redColor];
    ADPageModel *providerAll = [[ADPageModel alloc] init];
    providerAll.strPageTitle = @"   All   ";
    providerAll.iPageNumber = 0;
    //historyModel.viewController = streamHistory;
    providerAll.bShouldLazyLoad = YES;
    
    
    //Live
    ADPageModel *providerHotel = [[ADPageModel alloc] init];
    providerHotel.strPageTitle = @"  Hotel  ";
    providerHotel.iPageNumber = 1;
    providerHotel.bShouldLazyLoad = YES;
    
    ADPageModel *providerRest = [[ADPageModel alloc] init];
    providerRest.strPageTitle = @" Restaurant ";
    providerRest.iPageNumber = 2;
    providerRest.bShouldLazyLoad = YES;
    
    ADPageModel *providerAttraction = [[ADPageModel alloc] init];
    providerAttraction.strPageTitle = @" Attraction ";
    providerAttraction.iPageNumber = 3;
    providerAttraction.bShouldLazyLoad = YES;
    
    
    /**** 2. Initialize page control ****/
    pageControl = [[ADPageControl alloc] init];
    pageControl.delegateADPageControl = self;
    
    pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:providerAll,providerHotel,providerRest,providerAttraction, nil];
    
    pageControl.iFirstVisiblePageNumber = 0;
    pageControl.iTitleViewWidth = self.view.bounds.size.width/4;
    pageControl.iTitleViewHeight = 40;
    pageControl.iPageIndicatorHeight = 5;
    pageControl.fontTitleTabText = [UIFont fontWithName:@"Helvetica" size:16];
    
    pageControl.bEnablePagesEndBounceEffect = NO;
    pageControl.bEnableTitlesEndBounceEffect = NO;
    
    pageControl.colorTabText = [UIColor blackColor]; //orangeColor
    pageControl.colorTitleBarBackground = [UIColor whiteColor];
    pageControl.colorPageIndicator = [UIColor redColor];
    pageControl.colorPageOverscrollBackground = [UIColor lightGrayColor];
    pageControl.bShowMoreTabAvailableIndicator = NO;
    

    pageControl.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 20);
    [self.view addSubview:pageControl.view];
    
  
    
    
    

}

#pragma mark GMUClusterManagerDelegate
- (void)clusterManager:(GMUClusterManager *)clusterManager didTapCluster:(id<GMUCluster>)cluster {
}
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    
    NSLog(@"MARKER ID %d" ,marker.zIndex);
    return YES;
}
-(void)initPin:(NSInteger)rowIndex{
    //marker.zIndex = 0;
    
//    [self.liveAroundData enumerateObjectsUsingBlock:^(Streaming *stream, NSUInteger idx, BOOL *stop) {
        marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
        marker.map = _mapView;
        marker.icon = [UIImage imageNamed:@"pin1.png"];
        marker.tappable = YES;
    

//        NSLog(@"index idx %lu",(unsigned long)idx);
//        NSLog(@"rowIndex idx %lu",(unsigned long)rowIndex);
//        indexPin = idx;
//        if (idx == rowIndex) {
//            
            GMSCameraPosition *newCamera =
            [GMSCameraPosition cameraWithTarget:marker.position zoom:_mapView.camera.zoom];
            GMSCameraUpdate *update = [GMSCameraUpdate setCamera:newCamera];
//            
//            marker.icon = [UIImage imageNamed:@"pin.png"];
            _mapView.selectedMarker = marker;
//            marker.tappable = NO;
            [_mapView moveCamera:update];
    //    }
        
//        pinCount++;
//        marker.zIndex++;
//        NSLog(@"MARKER INDEX ::: %d",marker.zIndex);
//        NSLog(@"PIN INDEX ::: %lu",(unsigned long)indexPin);
//        

//        marker.zIndex = (int)indexPin;
    
//    }];
//    
//    NSLog(@"PIN COUNT ::: %d",pinCount);
//    
}

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
    NSLog(@"เลือก เพจ ");
    self.myMapView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    self.myMapView.backgroundColor = [UIColor redColor];
    [pageControl.view addSubview:self.myMapView];
    GMSCameraPosition *camera =
    [GMSCameraPosition cameraWithLatitude:40.714353 longitude:-74.005973 zoom:5];
    
    _mapView = [GMSMapView mapWithFrame: self.myMapView.bounds camera:camera];
    _mapView.myLocationEnabled = NO;
    [self.myMapView addSubview:_mapView];
    _mapView.delegate = self;
    
    if (isLazy == FALSE) {
        ADPageModel *pageModel = [pageControl.arrPageModel objectAtIndex:iCurrentVisiblePage];
    }
    [self initPin:_rowIndex];
    isLazy = FALSE;
    
}
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
//    Streaming* stream1 = [[Streaming alloc]init];
//    stream1 = [self.streamList objectAtIndex: (int)indexPin];
//    NSLog(@"MARKER IDD %d" ,(int)indexPin);
    
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
//    [snap hnk_setImageFromURL:[NSURL URLWithString:stream1.snapshot]];
    [outerView addSubview:snap];
    
//    UIButton *WaterMarkicon = [[UIButton alloc] initWithFrame:imgWaterMarkRect];
//    [WaterMarkicon setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
//    [snap addSubview:WaterMarkicon];
    
    outerView.tag =_rowIndex;
    outerView.backgroundColor = [UIColor greenColor];
    return outerView;
    
}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    
       NSInteger PlayTag  = [outerView tag];
    NSLog (@"Tag Playyyyy %ld",(long)PlayTag);
//    Streaming *stream = [self.liveAroundData objectAtIndex:PlayTag];
//    
    DetailNearbyViewController *Detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detailnearby"];
    
    [self presentViewController:Detail animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
