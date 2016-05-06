//
//  VideoPagingViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 6/29/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EAIntroView/EAIntroView.h>
@interface VideoPagingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate , EAIntroDelegate> {
    //UITapGestureRecognizer *tapGestureRec;
}

@property (nonatomic, weak) IBOutlet UITableView *tblViewVideo;
@property (nonatomic, strong) NSArray *placeSection;
@property (nonatomic, strong) NSArray *imageList;

@property (nonatomic, strong) NSArray *vdoList;
@property (nonatomic, strong) NSMutableArray *vdoSectionList;
@property (nonatomic,strong) NSDictionary *customHeader ;





@end
