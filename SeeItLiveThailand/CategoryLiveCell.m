//
//  CategoryLiveCell.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 4/29/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "CategoryLiveCell.h"

@implementation CategoryLiveCell
@synthesize imgCategoryicon,lblcategoryName;

- (void)awakeFromNib {
    [super awakeFromNib];
    imgCategoryicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [self.contentView addSubview:imgCategoryicon];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
