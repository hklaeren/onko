//
//  GloassaryVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "InfoVC.h"
#import "Utility.h"
#import "DPLocalizationManager.h"
@import MessageUI;

@interface InfoVC ()
{
    NSMutableArray *arrData;
    NSMutableArray *detailListArray;
    NSArray *arr;
}
@end

@implementation InfoVC
@synthesize webView;

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    self = [super initWithNibName:nibName bundle:bundle];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utility setNavigationBar:self.navigationController];
    self.title= DPLocalizedString(@"info_tab", nil);
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contact-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callButttonPressed)]];
    
    NSString *urlAddress = @"https://www.klaeren.com/webview/";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Request Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)webViewDidFinishLoad:(UIWebView *)webViewLocal {
    // Disable user selection
    [webViewLocal stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webViewLocal stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

-(void)callButttonPressed
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Question"];
    // Set up recipients
    // NSArray *toRecipients = [NSArray arrayWithObject:@"kontakt@unifontis.net"];
    NSArray *toRecipients = [NSArray arrayWithObject:@"herbert@klaeren.com"];

    [picker setToRecipients:toRecipients];
    
    
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    /* NSString *msg;
     switch (result)
     {
     case MFMailComposeResultCancelled:
     msg = @"Result: Mail sending canceled";
     break;
     case MFMailComposeResultSaved:
     msg = @"Result: Mail saved";
     break;
     case MFMailComposeResultSent:
     msg = @"Result: Mail sent";
     break;
     case MFMailComposeResultFailed:
     msg = @"Result: Mail sending failed";
     break;
     default:
     msg = @"Result: Mail not sent";
     break;
     }
     NSLog(@"%@",msg);
     */
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
