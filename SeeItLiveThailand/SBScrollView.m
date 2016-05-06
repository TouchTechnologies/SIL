//
//  SBScrollView.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/5/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "SBScrollView.h"

@implementation SBScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews {
    
    //CGFloat scy = (1024.0/480.0);
    //CGFloat scx = (768.0/360.0);
    
    CGFloat scrollViewHeight = 0.0f;
    CGFloat scGrap;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        scGrap = 150.0;
        
    } else {
        scGrap = 15.0;
    }
    
    
    
     self.showsVerticalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO ;
    for (UIView* view in self.subviews)
    {
        if (!view.hidden)
        {
            CGFloat y = view.frame.origin.y;
            CGFloat h = view.frame.size.height;
            if (y + h > scrollViewHeight)
            {
                scrollViewHeight = h + y;
            }
        }
    }
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self setContentSize:(CGSizeMake(self.frame.size.width, scrollViewHeight + scGrap))];
}

@end
