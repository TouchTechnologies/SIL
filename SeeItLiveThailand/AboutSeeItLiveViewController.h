//
//  AboutSeeItLiveViewController.h
//  SeeItLiveThailand
//
//  Created by Touch on 1/14/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutSeeItLiveViewController : UIViewController
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *contentTextview;

@property (strong, nonatomic) IBOutlet UILabel *appVersionLB;
- (IBAction)websiteBtn:(id)sender;
- (IBAction)byBtn:(id)sender;
@end
