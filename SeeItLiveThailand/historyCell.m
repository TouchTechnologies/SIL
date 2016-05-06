//
//  historyCell.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/11/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "historyCell.h"

@implementation historyCell
@synthesize timeHistoryLbl;
- (void)awakeFromNib {
    // Initialization code
    [self initialSize];
}
- (void)initialSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        timeHistoryLbl.font = [UIFont systemFontOfSize:30];
    }
    else
    {
    
    
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
