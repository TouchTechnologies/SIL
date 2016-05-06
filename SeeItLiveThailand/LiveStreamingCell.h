//
//  LiveStreamingCell.h
//  SeeItLiveThailand
//
//  Created by weerapons suwanchatree on 3/8/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridViewCell.h>

@interface LiveStreamingCell : KKGridViewCell

@property (nonatomic, strong) UILabel *lblPlace;
@property (nonatomic, strong) UILabel *lblCreateBy;
@property (nonatomic, strong) UILabel *lblViewCount;
@property (nonatomic, strong) UILabel *lblView;
@property (nonatomic, strong) UIImageView *imgViewicon;
@property (nonatomic, strong) UIImageView *imgSnapshot;

@property (nonatomic, strong) UILabel *lblLoveCount;
@property (nonatomic, strong) UILabel *lblLove;
@property (nonatomic, strong) UIButton *btnLoveicon;
@property (nonatomic, strong) UILabel *lblCreateDesc;
@property (nonatomic, strong) UIButton *btnCreatbyName;

@property (nonatomic, retain) UIButton *shareLivestream;

@property (nonatomic, assign) NSInteger cellTag;
@property (nonatomic, assign) KKGridViewCell* gridView;
- (void)generateWarterMark;


@end