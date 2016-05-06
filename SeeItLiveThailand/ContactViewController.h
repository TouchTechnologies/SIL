//
//  ContactViewController.h
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/2/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController<UIWebViewDelegate> {
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *urlName;
@property (nonatomic,strong) NSDictionary *customHeader ;
- (BOOL) webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType) navigationType;
@end
