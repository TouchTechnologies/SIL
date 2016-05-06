//
//  ContactViewController.m
//  TouchCCTV
//
//  Created by naratorn sarobon on 7/2/2558 BE.
//  Copyright (c) 2558 touchtechnologies. All rights reserved.
//

#import "ContactViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
@interface ContactViewController ()
{
  MBProgressHUD *hud;
}
@end

@implementation ContactViewController
- (IBAction)backBtn:(id)sender {
    NSLog(@"back");
    [self.webView goBack];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    NSString * accessToken = (![appDelegate.access_token isEqual:@""])?appDelegate.access_token:@"";
    self.customHeader =  @{@"x-tit-access-token":accessToken,@"x-tit-web-view":@"iOS"};
    NSLog(@"header %@",self.customHeader);
    NSLog(@"Access Token : %@",appDelegate.access_token);
    // Do any additional setup after loading the view.
    
    UIActivityIndicatorView *progressWheel = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    //makes activity indicator disappear when it is stopped
    progressWheel.hidesWhenStopped = YES;
    
    //used to locate position of activity indicator
    progressWheel.center = CGPointMake(self.view.bounds.size.width/2,
                                       ((self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height)-35)/2);
    
    //activityIndicator = progressWheel;
    //[self.view addSubview: activityIndicator];
    
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    // NSString *urlName = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:self.urlName];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self.webView loadRequest:requestURL];
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
#pragma mark UIWebView delegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [hud show:YES];
    //[activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [hud hide:YES];
    //[activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [hud hide:YES];
    //[activityIndicator stopAnimating];
}
- (BOOL) webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType) navigationType
{
    BOOL headerIsPresent = [[request allHTTPHeaderFields] objectForKey:@"x-tit-access-token"]!=nil;
    
    if(headerIsPresent) return YES;
    
    NSLog(@"Custom Webview");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [request URL];
            NSLog(@"URL : %@",url);
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            NSLog(@"Request : %@",request);
            // set the new headers
            for(NSString *key in [self.customHeader allKeys]){
                [request addValue:[self.customHeader objectForKey:key] forHTTPHeaderField:key];
            }
            
            // reload the request
            [self.webView loadRequest:request];
        });
    });
    return NO;
}

@end
