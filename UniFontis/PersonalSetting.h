//
//  PersonalSetting.h
//  UniFontis
//
//  Created by Kalpit Gajera on 14/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PersonalSetting : UIViewController <UITextViewDelegate,UITextFieldDelegate>
{
     IBOutlet UIButton *btnSave;
    
     IBOutlet UIScrollView *scrollView;
     IBOutlet UITextField *firstName,*lastName,*email,*dob,*weight,*height;
    
    IBOutlet UIView *view_datePicker;
     IBOutlet UIDatePicker *datePicker;
     IBOutlet UITextField *mobile;
         IBOutlet UITextField *zip;
     IBOutlet UITextField *city;
     IBOutlet UITextField *add2;
     IBOutlet UITextField *add1;
     IBOutlet UINavigationBar *navBar;
}
@end
