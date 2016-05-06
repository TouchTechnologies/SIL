//
//  OnAirCell.h
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/28/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnAirCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lblPlace;
@property (nonatomic, strong) UILabel *lblCreateBy;
@property (nonatomic, strong) UILabel *lblViewCount;
@property (nonatomic, strong) UILabel *lblcommentCount;
@property (nonatomic, strong) UIImageView *imgViewicon;
@property (nonatomic, strong) UIImageView *imgSnapshot;

@property (nonatomic, strong) UILabel *lblLoveCount;
@property (nonatomic, strong) UIImageView *imgComment;
@property (nonatomic, strong) UIButton *btnLoveicon;
@property (nonatomic, strong) UILabel *lblCreateDesc;
@property (nonatomic, strong) UIButton *btnCreatbyName;

@property (nonatomic, retain) UIButton *shareLivestream;
@property (nonatomic, retain) UIButton *commentLivebtn;

@property (nonatomic, assign) NSInteger cellTag;
@property (nonatomic, retain) UIButton *editLivestream;

- (void)generateWarterMark;


@end
