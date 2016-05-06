//
//  SettingTableViewCell.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/14/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell
@synthesize textLbl;
- (void)awakeFromNib {
   
  [self initialSize];

    // Initialization code
}

-(void)initialSize{
    //CGFloat scy = (1024.0/480.0);
    //CGFloat scx = (768.0/360.0);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textLbl.font = [UIFont systemFontOfSize:30];
        
        
    }
    else
    {
        
        textLbl.font = [UIFont systemFontOfSize:17];
          }
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//       // parentGrab = 120.0 * scx;
//        cellSize = CGSizeMake((self.contentView.frame.size.width / 2) - (15 * scx), (230 * scy));
//        
//        
//        paddingSize = CGSizeMake((10.0 * scx), (10.0 * scy));
//        rcBarH = 90.0 * scy;
//        rcGrapY = (180 * scy) + 20;
//        rcButtonW = 80.0 * scx;
//        imgPHW01 = 40.0 * scx;
//        imgPHW02 = 25.0 * scx;
//        
//    } else {
//        
//    }
//
//
//
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
