//
//  DestinationMapViewController.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/24/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "DestinationMapViewController.h"
#import <MapKit/MapKit.h>
@interface DestinationMapViewController ()<MKMapViewDelegate>
{
    
    NSMutableArray *saveLocationData;
    NSString* routeName;
    float *routeLat;
    float *routeLong;
    
}
@property(weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DestinationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMyDestData];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    //    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100000, 100000);
    //    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    
    
    // Add an annotation
    for(NSDictionary* myLocation in saveLocationData)
    {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D pinCoordinate;
        pinCoordinate.latitude = [myLocation[@"latitude"] doubleValue];
        pinCoordinate.longitude = [myLocation[@"longitude"] doubleValue];
        point.coordinate = pinCoordinate;
        point.title = myLocation[@"name_en"];
        point.subtitle =myLocation[@"address_en"];
        
        [self.mapView addAnnotation:point];
    }
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 1000000, 1000000);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [mapView setVisibleMapRect:zoomRect animated:YES];
    
}
- (void)zoomToFitMapAnnotations:(MKMapView *)mapView {
    if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    
    // Add a little extra space on the sides
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if(annotationView)
        return annotationView;
    else
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:AnnotationIdentifier];
        annotationView.image = [UIImage imageNamed:@"maker.png"];
        CGRect resize = annotationView.frame;
        resize.size.height = resize.size.width = 60;
        annotationView.frame = resize;
        annotationView.canShowCallout = YES;
        
        
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //        [rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        return annotationView;
    }
    return nil;
    
    
    
    //
    //    if ([annotation isKindOfClass:[MKUserLocation class]])
    //        return nil;
    //
    //    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    //    annotationView.image = [UIImage imageNamed:@"maker.png"];
    //    annotationView.canShowCallout = YES;
    //    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //
    //
    //    return annotationView;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self routeDirection:[view.annotation title] latitude:[view.annotation coordinate].latitude longitude:[view.annotation coordinate].longitude];
}
- (void)routeDirection:(NSString*)locationName latitude:(float)latitude longitude:(float)longitude
{
    
    //first create latitude longitude object
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude);
    
    //create MKMapItem out of coordinates
    MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    [destination setName:locationName];
    if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
    {
        //using iOS6 native maps app
        [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
    }
    else
    {
        //using iOS 5 which has the Google Maps application
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current+Location&daddr=%f,%f", latitude,longitude];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}
- (void)getMyDestData
{
    ModelManager *modelManager = [ModelManager getInstance];
    saveLocationData = [[NSMutableArray alloc]initWithArray:[modelManager getMyDestData]];
    NSLog(@"saveLocationData %@",saveLocationData);
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
