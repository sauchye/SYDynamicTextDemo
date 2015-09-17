//
//  SYWebViewController.m
//  SYDynamicTextDemo
//
//  Created by Saucheong Ye on 9/17/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kTITLE_COLOR [UIColor colorWithRed:0/255.0 green:180/255.0f blue:234/255.0f alpha:1]


#import "SYWebViewController.h"
#import "SYHUDView.h"

@interface SYWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@interface SYWebViewController ()

@end

@implementation SYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Detail";

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.hidden = NO;
    [self.view addSubview:_webView];
    
    NSError *error = nil;
    
    //检查为是否有效的链接
    BOOL isVaildUrl = [_url checkResourceIsReachableAndReturnError:&error];

    if (!isVaildUrl) {
        
        _webView.hidden = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
        
    }else{
        
        _webView.hidden = YES;
        UILabel *showError = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 40 - 128)/2, SCREEN_WIDTH, 40)];
        showError.textAlignment = NSTextAlignmentCenter;
        showError.text = @"This web page is not available";
        showError.textColor = [UIColor blackColor];
        [self.view addSubview:showError];
        
        [SYHUDView showToBottomView:self.view text:[NSString stringWithFormat:@"%@", error.description] hide:2.0];
    }

}


#pragma mark - webView Delegate Method
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [SYHUDView showToView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SYHUDView hideHUDForView:self.view animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
        
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [SYHUDView hideHUDForView:self.view animated:YES];
    [SYHUDView showToBottomView:self.view text:[NSString stringWithFormat:@"%@", error.description] hide:2.0];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
