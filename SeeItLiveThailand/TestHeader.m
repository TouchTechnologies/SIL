//
//  TestHeader.m
//  SeeItLiveThailand
//
//  Created by Touch on 1/7/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

#import "TestHeader.h"
#import <SMPageControl/SMPageControl.h>

@interface TestHeader (){

    UIView *rootView;
    EAIntroView *_intro;
    IBOutlet UIView *vieww;
}
@end

@implementation TestHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // rootView = self.navigationController.view;
    //vieww = self.navigationController.view;
    

    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.bgImage = [UIImage imageNamed:@"activities02"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgColor = [UIColor redColor];
  //  page2.bgImage = [UIImage imageNamed:@"activities02"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.bgColor = [UIColor greenColor];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_live1"]];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:vieww.bounds andPages:@[page1,page2,page3]];
    [intro setDelegate:self];
    
     [intro showInView:vieww animateDuration:0.3];
    _intro = intro;
   
   //page2.bgImage = [UIImage imageNamed:@"activities02.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
