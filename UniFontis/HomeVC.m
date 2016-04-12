//
//  HomeVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "HomeVC.h"
#import "Utility.h"
#import "DPLocalizationManager.h"
@import MessageUI;


@implementation HomeVC
@synthesize webView;

// Loads the url when the view loads

- (void)viewDidLoad {
    NSString *urlAddress = @"https://www.klaeren.com/webview/";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Request Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
}


@end
