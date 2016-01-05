//
//  HomeVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
@interface HomeVC : UIViewController
{
     IBOutlet UIButton *btnFood;
    
     IBOutlet UIButton *btnAddDiary;
     IBOutlet UIButton *btnPSetting;
     IBOutlet UIButton *btnAddMedication;
     IBOutlet UIButton *btnChangeLang;
}
- (IBAction)addMedication:(id)sender;
- (IBAction)addDiary:(id)sender;
- (IBAction)addFood:(id)sender;

- (IBAction)goToPersonalSettings:(id)sender;
- (IBAction)changelanguage:(id)sender;

@end
