//
//  UILabel+MFAutoresizeLabel.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 8/13/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "UILabel+MFAutoresizeLabel.h"

@implementation UILabel (MFAutoresizeLabel)

-(void) setAutoresizedText:(NSString *) text
{
    if([self.font pointSize] <= self.minimumFontSize)
    {
        [self setText:text];
        return;
    }
    
    int i;
    UIFont *aFont = self.font;
    
    int jumps = 1;
    if([self.font pointSize] - self.minimumFontSize > 12)
    {
        jumps = 2;
    }
    if([self.font pointSize] - self.minimumFontSize > 24)
    {
        jumps = 3;
    }
    
    for(i = [self.font pointSize]; i > self.minimumFontSize; i=i-jumps)
    {
        if(i < self.minimumFontSize)
        {
            i = self.minimumFontSize;
        }
        aFont = [aFont fontWithSize:i];
        
        CGSize constraintSize = CGSizeMake(self.bounds.size.width, MAXFLOAT);
        
        CGSize labelSize = [text sizeWithFont:aFont constrainedToSize:constraintSize lineBreakMode:self.lineBreakMode];
        
        if(labelSize.height <= self.bounds.size.height)
            break;
    }
    
    self.font = aFont;
    
    [self setText:text];
}

@end
