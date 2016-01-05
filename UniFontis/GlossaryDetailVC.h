//
//  GlossaryDetailVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface GlossaryDetailVC : UIViewController
{
    
     IBOutlet UILabel *detail;
     IBOutlet UILabel *titleLabel;
     IBOutlet UITextView *txtDetail;
     IBOutlet UIView *bgView;
}
@property (strong,nonatomic)NSMutableDictionary *dict;
@property (strong,nonatomic)NSMutableArray *arrAllGlossary;

- (IBAction)tapResponse:(UITapGestureRecognizer *)recognizer;

@end
