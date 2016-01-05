//
//  MedicationVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Diary.h"
@interface MedicationVC : UIViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    IBOutlet UIView *view_addMedicine;
     IBOutlet UITableView *tblView;
    IBOutlet UIView *headerView;
    NSString *selectedTimes;
    
     IBOutlet UITextField *txtQty;
     IBOutlet UITextField *txtMedicine;
     IBOutlet UIButton *btn1X,*btn2X,*btn3X,*btn4X,*btnHourly;
    NSMutableArray *arrMedicineData;
    Medicine *objMed_current;
    
     IBOutlet UILabel *lblMedicine;
    
     IBOutlet UILabel *lblTime;
     IBOutlet UILabel *lblQty;
     IBOutlet UILabel *lblMedicine_header;
     IBOutlet UILabel *lblQty_header;
     IBOutlet UILabel *lblTime_header;
    
     IBOutlet UILabel *lblHourley;
    
     IBOutlet UIButton *btnOk;
     IBOutlet UIButton *btnCancel;
    
    Diary *objDiary_current; // For Taken Medication
}
    //-(void)LocalNotificationCall:(NSString *)message;
-(IBAction)selectTimes:(UIButton *)sender;
@end
