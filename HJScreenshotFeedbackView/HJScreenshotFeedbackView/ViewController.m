//
//  ViewController.m
//  HJScreenshotFeedbackView
//
//  Created by 2345 on 2019/8/14.
//  Copyright © 2019 wll. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    WKWebView * web = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [web loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:web];
    
}


@end
