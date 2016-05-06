//
//  VideoListViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/18/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoPlace;

@interface VideoListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblViewVideo;
@property (nonatomic, strong) NSArray *placeSection;
@property (nonatomic, strong) NSArray *vdoList;
@property (nonatomic, strong) NSMutableArray *vdoSectionList;
//@property (nonatomic, strong) VideoPlace *vdoPlace;
//@property (nonatomic, strong) UINavigationController *navViewController;
@property (nonatomic, strong) NSMutableArray *roiList;

@end
