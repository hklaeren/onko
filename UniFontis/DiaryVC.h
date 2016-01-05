//
//  DiaryVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "DXPopover.h"
#import "Diary.h"
@class AFMSlidingCellDelegate;
@interface DiaryVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
     IBOutlet UIButton *btnAddtxt_Box;
    
    IBOutlet UIView *view_addText;
     IBOutlet UIButton *btnCancel_AddBox;
    IBOutlet UIView *buttonView;
    IBOutlet UIView *headerView;
    
     IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *View_datePicker;
     IBOutlet UITableView *tblDiary;
     IBOutlet UITextField *txtView_AddEntry;
     IBOutlet UITextField *txtView_AddDate;
     IBOutlet UILabel *lblTitle_addView;
    DXPopover *popover;
    BOOL isWeight;
    int CurrentFilter;
     IBOutlet UIButton *btnOK_BP;
     IBOutlet UIButton *btnCancel_BP;
    IBOutlet UIView *header_Text;
     IBOutlet UITextField *txt_dia_addbp;
     IBOutlet UITextField *txt_sys_addBp;
    IBOutlet UIView *view_addBp;
    NSMutableArray *arrDiaryData;
    NSArray *arrMainData;
    BOOL isAll;
     IBOutlet UILabel *lblTitleHeader;
    
     IBOutlet UIButton *btnBP;
     IBOutlet UIButton *btnWeight;
     IBOutlet UIButton *btnText;
      Diary *objDiary_current;
     IBOutlet UILabel *lblAddBP;
    
    
     IBOutlet UILabel *lblDate_bp;
     IBOutlet UILabel *lblInfo_all;
     IBOutlet UILabel *lblType_all;
     IBOutlet UILabel *lblDateType_all;
    
}
- (IBAction)dismissDatePicker:(id)sender;
- (IBAction)showAllData:(UIButton *)sender;
- (IBAction)showDataWithText:(UIButton *)sender;
- (IBAction)showDataWithWeight:(UIButton *)sender;
- (IBAction)showDataWithBP:(UIButton *)sender;
- (IBAction)btnAddTextPressed:(UIButton *)sender;
- (IBAction)btnAddBPPressed:(UIButton *)sender;
- (IBAction)hideAddTextView:(UIButton *)sender;
- (IBAction)addBpTOChart:(id)sender;
@end
