//
//  FoodVC.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Diary.h"
@interface FoodVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
     IBOutlet UITableView *tblFood;
     IBOutlet UITextField *txtQty;
     IBOutlet UITextField *tatName;
     IBOutlet UITextField *cal;
    IBOutlet UIView *view_addFood;
    
     IBOutlet UIScrollView *scrollview;
     IBOutlet UIButton *btnPiece;
     IBOutlet UIButton *btnCup;
     IBOutlet UIButton *btnG;
     IBOutlet UIButton *btnML;
     IBOutlet UITextField *carb;
     IBOutlet UITextField *protein;
     IBOutlet UITextField *fat;
     
    
     IBOutlet UILabel *lblFood,*lblQty,*lblUnit,*lblKcal,*lblFat,*lblProt,*lblCarb,*lblgram,*lblCup,*lblPiece;
    IBOutlet UIButton *btnOk,*btnCancel;
    
    
    NSString *strUnit;
    NSMutableArray *arrFoodData;
    FoodClass *objFood_Current;
}
@property (nonatomic, strong) NSArray *responders;
- (IBAction)hideAddFoodview:(id)sender;

-(IBAction)selectUnitForFood:(UIButton *)btn;
@end
