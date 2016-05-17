//
//  CategoryListViewController.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 5/3/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>
@interface CategoryListViewController : UIViewController<KKGridViewDataSource, KKGridViewDelegate>

{
    bool *isPresented;
}
//@property (strong, nonatomic) REDPuzzleGridView *puzzleGridView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) KKGridView *gridView;
@property (nonatomic, assign) int catID;



@end
