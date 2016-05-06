//
//  UserLiveViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 2/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>

@interface UserLiveViewController : UIViewController<KKGridViewDataSource, KKGridViewDelegate>

@property (nonatomic, strong) KKGridView *gridView;



@end
