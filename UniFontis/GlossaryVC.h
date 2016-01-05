//
//  GloassaryVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;

@interface GlossaryVC : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UITextFieldDelegate>
{
    NSMutableDictionary *dict;
    NSMutableArray *currentRow;
    IBOutlet UITableView *tblGlosary;
    NSArray *arrmainData;
    NSMutableArray *arrGlossaryData;

}
@end
