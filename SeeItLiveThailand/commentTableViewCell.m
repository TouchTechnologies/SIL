//
//  commentTableViewCell.m
//  SeeItLiveThailand
//
//  Created by Touch Developer on 3/11/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "commentTableViewCell.h"

@implementation commentTableViewCell
@synthesize usercommentImg,commentLbl;
- (void)awakeFromNib {
    
    //usercommentImg.backgroundColor = [UIColor redColor];
    if  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSLog(@"IPAD");
    }
    else{
       //
        NSLog(@"IPHONE");
    }
    self.usercommentImg.layer.cornerRadius = self.usercommentImg.bounds.size.width/2;
    self.usercommentImg.clipsToBounds = TRUE;


}
//- (void)initialSize{
//    CGFloat scy = (1024.0/480.0);
//    CGFloat scx = (768.0/360.0);
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        _usercommentImg.frame = CGRectMake(10*scx, 10*scy, 100 ,  100 );
//    }
//    else{
//        _usercommentImg.frame = CGRectMake(10, 10, 40 ,  40 );
//    }
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
