//
//  StreamHistoryViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/12/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>

@interface StreamHistoryViewController : UIViewController;//<KKGridViewDataSource, KKGridViewDelegate>

@property (nonatomic, strong) KKGridView *gridView;

@end
