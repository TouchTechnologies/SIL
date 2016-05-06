//
//  ADViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 8/8/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>
@interface ADViewController : UIViewController<KKGridViewDataSource, KKGridViewDelegate>

{
    bool *isPresented;
}
//@property (strong, nonatomic) REDPuzzleGridView *puzzleGridView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) KKGridView *gridView;



@end
