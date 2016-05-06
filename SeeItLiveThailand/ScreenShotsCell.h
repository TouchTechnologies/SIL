//
//  ScreenShotsCell.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/5/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenShotsCell : UITableViewCell<UIScrollViewDelegate>
- (void)configureCellForApp:(NSArray *)imageList andCity:(NSString *)city andPlace:(NSString *)place;

@end
