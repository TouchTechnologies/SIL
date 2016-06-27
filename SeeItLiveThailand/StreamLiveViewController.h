//
//  StreamLiveViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/12/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>

@interface StreamLiveViewController : UIViewController<KKGridViewDataSource, KKGridViewDelegate>

{
 bool *isPresented;
}

//@property (strong, nonatomic) REDPuzzleGridView *puzzleGridView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) KKGridView *gridView;


@end
