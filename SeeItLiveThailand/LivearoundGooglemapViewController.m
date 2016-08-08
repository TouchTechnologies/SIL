//
//  LivearoundGooglemapViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 8/5/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "LivearoundGooglemapViewController.h"

#import <Google-Maps-iOS-Utils/GMUMarkerClustering.h>
#import <GoogleMaps/GoogleMaps.h>
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
static const double kCameraLatitude = 40.714353;
static const double kCameraLongitude = -74.005973;
GMSMarker *marker;


@interface LivearoundGooglemapViewController ()<GMUClusterManagerDelegate, GMSMapViewDelegate>


@end

@implementation LivearoundGooglemapViewController{
    GMSMapView *_mapView;
    
    GMUClusterManager *_clusterManager;
}
- (void)loadView {
    GMSCameraPosition *camera =
    [GMSCameraPosition cameraWithLatitude:kCameraLatitude longitude:kCameraLongitude zoom:10];
    
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = NO;
    //_myMapView = _mapView;
    self.view = _mapView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView.delegate = self;
    marker = [[GMSMarker alloc]init];
    marker.position = CLLocationCoordinate2DMake(40.714353, -74.005973);
    marker.title = @"NEW YORK";
    marker.icon = [UIImage imageNamed:@"mappin.png"];
    marker.snippet =@"new york ,USA";
    marker.map = _mapView;
    // Do any additional setup after loading the view.
}
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    NSLog(@"custom callout view");
    int popupWidth = 300;
    int contentWidth = 280;
    int contentHeight = 140;
    int contentPad = 10;
    int popupHeight = 200;
    int popupBottomPadding = 16;
    int popupContentHeight = contentHeight - popupBottomPadding;
    int buttonHeight = 30;
    int anchorSize = 20;
    
    CLLocationCoordinate2D anchor = marker.position;
    CGPoint point = [_mapView.projection pointForCoordinate:anchor];
    
    
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popupWidth, popupHeight)];
    float offSet = anchorSize * M_SQRT2;
    CGAffineTransform rotateBy45Degrees = CGAffineTransformMakeRotation(M_PI_4); //rotate by 45 degrees
    UIView *callOut = [[UIView alloc] initWithFrame:CGRectMake((popupWidth - offSet)/2.0, popupHeight - offSet, anchorSize, anchorSize)];
    callOut.transform = rotateBy45Degrees;
    callOut.backgroundColor = [UIColor blackColor];
    [outerView addSubview:callOut];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popupWidth, 190)];
    [view setBackgroundColor:[UIColor greenColor]];
    
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 2.0f;
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentPad, 0, contentWidth, 22)];
    [titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    titleLabel.text = [marker title];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentPad, 24, contentWidth, 80)];
    [descriptionLabel setFont:[UIFont systemFontOfSize:12.0]];
    descriptionLabel.numberOfLines = 5;
    descriptionLabel.text = [marker snippet];
    
    [view addSubview:titleLabel];
    [view addSubview:descriptionLabel];
    [view setBackgroundColor:[UIColor greenColor]];
    
    [outerView addSubview:view];
    
    return outerView;
    
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    //  POIItem *poiItem = marker.userData;
    //  if (poiItem != nil) {
    NSLog(@"Did tap marker for cluster item ");
    marker.icon = [UIImage imageNamed:@"pin.png"];
    [self mapView:mapView markerInfoWindow:marker];
    mapView.selectedMarker = marker;
    //  } else {
    //    NSLog(@"Did tap a normal marker");
    //  }
    return YES;
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
