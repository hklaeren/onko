//
//  InfoVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;

@interface InfoVC : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UITextFieldDelegate>
{
    IBOutlet UIWebView *webView;

}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
