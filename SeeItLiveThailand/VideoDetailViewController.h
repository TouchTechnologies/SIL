//
//  VideoDetailViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/5/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class ROI;

@interface VideoDetailViewController : UIViewController<UIScrollViewDelegate,MKMapViewDelegate> {
    
}
- (IBAction)commentBtn:(id)sender;

@property (nonatomic, weak) IBOutlet UIView *ssView;
@property (nonatomic, weak) IBOutlet UIView *descView;
@property(weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *lblTitleDesc;
@property (nonatomic, weak) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIView *infoHistoryView;

@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) ROI *roi;
@property (nonatomic, assign) NSUInteger rowIndex;

- (IBAction)viewHistoryBtn:(id)sender;

@end
