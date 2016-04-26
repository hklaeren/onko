//
//  DiaryVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "DiaryVC.h"
#import "SWTableViewCell.h"
#import "DatabaseManager.h"
#import "Diary.h"
#import "DPLocalizationManager.h"
#import "AppDelegate.h"
@import MessageUI;
@interface DiaryVC ()<SWTableViewCellDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    AppDelegate *delegate;
    SWTableViewCell *cell;
}

@end

@implementation DiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate=[AppDelegate initAppdelegate];
    [Utility setNavigationBar:self.navigationController];
    tblDiary.tableHeaderView=headerView;
    isAll=true;
    
    [btnAddtxt_Box.layer setBorderWidth:1.0];
    [btnCancel_AddBox.layer setBorderWidth:1.0];
    [btnCancel_AddBox.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
    [btnAddtxt_Box.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
    [txtView_AddEntry.layer setBorderColor:NAVBARCOLOR.CGColor];
    [view_addText.layer setBorderWidth:3.0];
    [view_addText.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
    
    [txtView_AddDate.layer setBorderColor:NAVBARCOLOR.CGColor];

    txtView_AddDate.inputView=View_datePicker;
       [self getAllData];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_message_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(mailButtonPressed)]];
    [self setLocalizationLabels];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [tblDiary reloadData];
    if(delegate.isAddDiary==true)
    {
        [self showText];
        delegate.isAddDiary=false;
    }
    [super viewWillAppear:YES];
}
-(void)showText
{
    [self performSelector:@selector(btnAddTextPressed:) withObject:btnAddtxt_Box afterDelay:0.2 ];

  /*  txtView_AddEntry.text=@"";
    
   
        lblTitle_addView.text=DPLocalizedString(@"add_text", nil);
        txtView_AddEntry.placeholder=DPLocalizedString(@"add_note", nil);
        txtView_AddEntry.keyboardType=UIKeyboardTypeAlphabet;
        isWeight=false;
        popover = [DXPopover popover];
        popover.arrowSize=CGSizeMake(0, 0);
        [popover showAtPoint:CGPointMake((WIDTH)/2, HEIGHT/2) popoverPostion:0 withContentView:view_addText inView:self.view];
*/
  // }
}
-(void)setLocalizationLabels
{
    self.title=DPLocalizedString(@"diary_tab", nil);
    [btnAddtxt_Box setTitle:DPLocalizedString(@"ok", nil) forState:UIControlStateNormal];
    [btnCancel_AddBox setTitle:DPLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [btnCancel_BP setTitle:DPLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [btnOK_BP setTitle:DPLocalizedString(@"ok", nil) forState:UIControlStateNormal];
    [btnBP setTitle:DPLocalizedString(@"btn_bp", nil) forState:UIControlStateNormal];
    [btnWeight setTitle:DPLocalizedString(@"btn_weight", nil) forState:UIControlStateNormal];
    [btnText setTitle:DPLocalizedString(@"btn_text", nil) forState:UIControlStateNormal];

    
    lblTitle_addView.text=DPLocalizedString(@"add_text", nil);
    lblAddBP.text=DPLocalizedString(@"add_BP", nil);
    lblDate_bp.text=DPLocalizedString(@"lbl_Date_Time", nil);
    lblDateType_all.text=DPLocalizedString(@"lbl_Date_Time", nil);
    lblInfo_all.text=DPLocalizedString(@"lbl_Info", nil);
    lblType_all.text=DPLocalizedString(@"lbl_Type", nil);
    
    //lblTitleHeader.text=DPLocalizedString(@"ok", nil)

}
-(void)getAllData
{
    NSMutableArray *arrData=[[DatabaseManager getSharedInstance]getAllDiaryData];
  //  arrDiaryData=[[DatabaseManager getSharedInstance]getAllDiaryData];
    
    
NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
   NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    arrDiaryData =[[NSMutableArray alloc]initWithArray:[arrData sortedArrayUsingDescriptors:sortDescriptors]];
    arrMainData=[[NSArray alloc]initWithArray:arrDiaryData];

    if(CurrentFilter==1)
    {
        [tblDiary reloadData];

        return;
    }else if (CurrentFilter==2)
    {
        [self showDataWithText:nil];
    }else if (CurrentFilter==3)
    {
        [self showDataWithWeight:nil];
    }else if ( CurrentFilter==4)
    {
        [self showDataWithBP:nil];
    }

    
    [tblDiary reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark- Tableview Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  arrDiaryData.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell1 forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell1.backgroundColor=BG_COLOR;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.leftUtilityButtons = nil;
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:30.0f];
    //        cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    if(isAll==true){
        
        UILabel *lblDate=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, 98, 35)];
        lblDate.textColor=txtView_AddEntry.textColor;
        lblDate.font=[UIFont fontWithName:FONT_LBL_REG size:10.0];
        lblDate.tag=100;
        [lblDate setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:lblDate];
        
        
        UIView *sep1=[[UIView alloc]initWithFrame:CGRectMake(102, 0, 1, 35)];
        sep1.backgroundColor=SEP_COLOR;
        [cell.contentView addSubview:sep1];
        
        UILabel *lblType=[[UILabel alloc]initWithFrame:CGRectMake(104, 0, 50, 35)];
        lblType.textColor=txtView_AddEntry.textColor;
        lblType.font=[UIFont fontWithName:FONT_LBL_REG size:10.0];
        lblType.tag=101;
        [lblType setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:lblType];
        
        UIView *sep2=[[UIView alloc]initWithFrame:CGRectMake(156, 0, 1, 35)];
        sep2.backgroundColor=SEP_COLOR;
        [cell.contentView addSubview:sep2];
        
        
        UILabel *lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 100, 35)];
        lblInfo.textColor=txtView_AddEntry.textColor;
        lblInfo.font=[UIFont fontWithName:FONT_LBL_REG size:10.0];
        lblInfo.tag=102;
        [lblInfo setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:lblInfo];
    }else
    {
        UILabel *lblDate=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, 130, 35)];
        lblDate.textColor=txtView_AddEntry.textColor;
        lblDate.font=[UIFont fontWithName:FONT_LBL_REG size:10.0];
        lblDate.tag=100;
        [lblDate setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:lblDate];
        
        UIView *sep1=[[UIView alloc]initWithFrame:CGRectMake(132, 0, 1, 35)];
        sep1.backgroundColor=SEP_COLOR;
        [cell.contentView addSubview:sep1];
        
        UILabel *lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(135, 0, 130, 35)];
        lblInfo.textColor=txtView_AddEntry.textColor;
        lblInfo.font=[UIFont fontWithName:FONT_LBL_REG size:10.0];
        lblInfo.tag=102;
        [lblInfo setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:lblInfo];
        
    }
    
    
    Diary *objDiary=[arrDiaryData objectAtIndex:indexPath.row];
    UILabel *lbldat=(UILabel *)[cell viewWithTag:100];
    lbldat.text=objDiary.date;
    
    UILabel *lblTyp=(UILabel *)[cell viewWithTag:101];
    
    NSString *type=objDiary.type;
    NSLog(@"%@ ",type);
    
    if([type isEqualToString:@"Weight"])
    {
        lblTyp.text=DPLocalizedString(@"btn_weight", nil);
    }else if ([type isEqualToString:@"BP"])
    {
        lblTyp.text=DPLocalizedString(@"btn_bp", nil);
    }else if([type isEqualToString:@"Text"])
    {
        lblTyp.text=objDiary.type;
    }else
    {
        lblTyp.text=DPLocalizedString(@"medication", nil);
    }
    UILabel *lblinfor=(UILabel *)[cell viewWithTag:102];
    lblinfor.text=objDiary.info;
    
    if([objDiary.type isEqualToString:@"BP"])
    {
        NSArray *arr=[objDiary.info componentsSeparatedByString:@","];
        lblinfor.text=[NSString stringWithFormat:@"SYS : %@   DIA : %@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
        
    }
    UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 34.5, WIDTH, 0.5)];
    sepView.backgroundColor=SEP_COLOR;
    [cell addSubview:sepView];
    
    
    return cell;
}

// Icons made by Rami McMin from www.flaticon.com, licensed by Creative Commons BY 3.0


#pragma mark - AFMSlidingCellDelegate

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:NAVBARCOLOR icon:[UIImage imageNamed:@"edit_icon.png"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:NAVBARCOLOR icon:[UIImage imageNamed:@"delete_icon.png"]];
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell1 didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    [cell1 hideUtilityButtonsAnimated:YES];
    NSIndexPath *indexPath = [tblDiary indexPathForCell:cell1];
    Diary *objDia=[arrDiaryData objectAtIndex:indexPath.row];
    
    switch (index) {
        case 0:
        {
            
            
            /*  lbldat.text=objDiary.date;
             lblTyp.text=objDiary.type;
             lblinfor.text=objDiary.info;*/
            if([objDia.type isEqualToString:@"BP"])
            {
                
                NSArray *arr=[objDia.info componentsSeparatedByString:@","];
                txt_sys_addBp.text=[arr objectAtIndex:0];
                txt_dia_addbp.text=[arr objectAtIndex:1];
                lblAddBP.text=DPLocalizedString(@"edit_bp", nil);
                [self btnAddBPPressed:nil];
                
                
            }else if ([objDia.type isEqualToString:@"Text"])
            {
                lblTitle_addView.text=DPLocalizedString(@"edit_text", nil);;
                txtView_AddEntry.text=objDia.info;
                objDiary_current=objDia;
                [self btnAddTextPressed:nil];
                
                
            }else
            {
                lblTitle_addView.text=DPLocalizedString(@"edit_weight", nil);
                
                txtView_AddEntry.text=objDia.info;
                objDiary_current=objDia;
                
                [self btnAddTextPressed:nil];
                
            }
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"Delete");
            
            [[DatabaseManager getSharedInstance]deleteDiaryInfoWithId:objDia.id_diary];
            [self getAllData];
            // Delete button was pressed
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}

#pragma mark- Textfield Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    return true;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string.length)
        return YES;
    
    if (textField == txt_dia_addbp || textField==txt_sys_addBp)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    return YES;
}


#pragma mark- Button Actions

- (IBAction)dismissDatePicker:(id)sender {
}

- (IBAction)showAllData:(UIButton *)sender {
    isAll=true;

    
  /*  NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    arrDiaryData =[[NSMutableArray alloc]initWithArray:[[[DatabaseManager getSharedInstance]getAllDiaryData] sortedArrayUsingDescriptors:sortDescriptors]];*/
    CurrentFilter=1;
    [self getAllData];
    [tblDiary reloadData];
    tblDiary.tableHeaderView=headerView;
}

- (IBAction)showDataWithText:(UIButton *)sender {
    
    CurrentFilter=2;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type == %@", @"Text"];
    NSArray *filteredArr = [arrMainData filteredArrayUsingPredicate:predicate];
    arrDiaryData=[[NSMutableArray alloc]initWithArray:filteredArr];
    isAll=false;
    
    [tblDiary reloadData];
    lblTitleHeader.text=DPLocalizedString(@"btn_text", nil);
    tblDiary.tableHeaderView=header_Text;
}

- (IBAction)showDataWithWeight:(UIButton *)sender {
    
    CurrentFilter=3;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type == %@", @"Weight"];
    NSArray *filteredArr = [arrMainData filteredArrayUsingPredicate:predicate];
    arrDiaryData=[[NSMutableArray alloc]initWithArray:filteredArr];
    isAll=false;
    lblTitleHeader.text=DPLocalizedString(@"btn_weight", nil);
    [tblDiary reloadData];
    tblDiary.tableHeaderView=header_Text;
    
}

- (IBAction)showDataWithBP:(UIButton *)sender {
    
    CurrentFilter=4;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type == %@", @"BP"];
    NSArray *filteredArr = [arrMainData filteredArrayUsingPredicate:predicate];
    arrDiaryData=[[NSMutableArray alloc]initWithArray:filteredArr];
    isAll=false;
    lblTitleHeader.text=DPLocalizedString(@"btn_bp", nil);
    
    [tblDiary reloadData];
    tblDiary.tableHeaderView=header_Text;
    
}

- (IBAction)btnAddTextPressed:(UIButton *)sender {
    [txtView_AddEntry becomeFirstResponder];
    if(sender!= nil)
    {
        txtView_AddEntry.text=@"";
        
        if(sender.tag==1)
        {
            lblTitle_addView.text=DPLocalizedString(@"add_text", nil);
            txtView_AddEntry.placeholder=DPLocalizedString(@"add_note", nil);
            txtView_AddEntry.keyboardType=UIKeyboardTypeAlphabet;
            isWeight=false;
        }else if(sender.tag==2)
        {
            lblTitle_addView.text=DPLocalizedString(@"btn_weight", nil);
            txtView_AddEntry.placeholder=DPLocalizedString(@"enter_weight", nil);
                    txtView_AddEntry.keyboardType=UIKeyboardTypeNumberPad;
            isWeight=true;
        }
    }else {    if([objDiary_current.type isEqualToString:@"Add Text"])
    {
        isWeight=false;
        
    }else
    {
        isWeight=true;
    }
    }
    popover = [DXPopover popover];
    popover.arrowSize=CGSizeMake(0, 0);
    [popover showAtPoint:CGPointMake((WIDTH)/2, HEIGHT/2) popoverPostion:0 withContentView:view_addText inView:self.view];
    
    
}



- (IBAction)btnAddBPPressed:(UIButton *)sender {
    [txt_sys_addBp becomeFirstResponder];
    if(sender!=nil){
        txt_dia_addbp.text=@"";
        txt_sys_addBp.text=@"";
    }
    popover = [DXPopover popover];
    popover.arrowSize=CGSizeMake(0, 0);
    [popover showAtPoint:CGPointMake((WIDTH)/2, HEIGHT/2) popoverPostion:0 withContentView:view_addBp inView:self.view];
}



- (IBAction)hideAddTextView:(UIButton *)sender {
    
    [popover dismiss];
    
}

- (IBAction)addtextEntryToDatabase:(id)sender {
    NSString *type;
    if(isWeight==false)
    {
        type=@"Text";
    }else
    {
        type=@"Weight";
    }
    if(txtView_AddEntry.text.length == 0)
    {
        [Utility showAlertWithwithMessage:[NSString stringWithFormat:@"Please enter %@ information",[type lowercaseString]]];
        return;
    }
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy, HH:mm";
    NSString *yourDate = [dateFormatter stringFromDate:[NSDate date]];
    if(objDiary_current)
    {
        objDiary_current.date=yourDate;
        objDiary_current.info=txtView_AddEntry.text;
        
        BOOL addInfo=[[DatabaseManager getSharedInstance] updateDiaryInfo:objDiary_current];
        if(addInfo==true)
        {
//            [Utility showAlertWithwithMessage:@"Diary Updated Successfully"];
            objDiary_current=nil;
          
        }
        
        
    }else
    {
        
        Diary *objdiary=[[Diary alloc]init];
        objdiary.date=yourDate;
        objdiary.type=type;
        objdiary.info=txtView_AddEntry.text;
        
        BOOL addInfo=[[DatabaseManager getSharedInstance] addDiaryInfo:objdiary];
        NSLog(@" %s", addInfo ? "true" : "false");
    }
    [popover dismiss];
    tblDiary.tableHeaderView=headerView;
            [self getAllData];
    
}

- (IBAction)addBpTOChart:(id)sender {
    
    if(txt_sys_addBp.text.length == 0)
    {
        [Utility showAlertWithwithMessage:DPLocalizedString(@"alert_sys", nil)];
        return;
    }else if (txt_dia_addbp.text.length==0)
    {
        [Utility showAlertWithwithMessage:DPLocalizedString(@"alert_dia", nil)];
        return;
    }
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy, HH:mm";
    NSString *yourDate = [dateFormatter stringFromDate:[NSDate date]];
    if(objDiary_current)
    {
        objDiary_current.date=yourDate;
        objDiary_current.type=@"BP";
        objDiary_current.info=[NSString stringWithFormat:@"%@,%@",txt_sys_addBp.text,txt_dia_addbp.text];
        
        BOOL addInfo=[[DatabaseManager getSharedInstance] updateDiaryInfo:objDiary_current];
        if(addInfo==true)
        {
           // [Utility showAlertWithwithMessage:DPLocalizedString(@"diary_updated", nil)];
            objDiary_current=nil;
           
        }
        
        
    }else
    {
        
        Diary *objdiary=[[Diary alloc]init];
        objdiary.date=yourDate;
        objdiary.type=@"BP";
        objdiary.info=[NSString stringWithFormat:@"%@,%@",txt_sys_addBp.text,txt_dia_addbp.text];
        
        BOOL addInfo=[[DatabaseManager getSharedInstance] addDiaryInfo:objdiary];
        if(addInfo==true)
        {
        //    [Utility showAlertWithwithMessage:DPLocalizedString(@"diary_updated", nil)];
        }
        [popover dismiss];
        tblDiary.tableHeaderView=headerView;
            [self getAllData];
        txt_dia_addbp.text=@"";
        txt_sys_addBp.text=@"";
    }
}


#pragma mark- Mail Delegates Meethods
-(NSString *)dataFilePath {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"MyDiary.csv"];
}
-(void)mailButtonPressed
{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
        NSLog(@"Route creato");
    }else
    {
        [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
        [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
        
    }
    
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0]; //don't worry about the capacity, it will expand as necessary
    for (int i=0; i<[arrDiaryData count]; i++) {
        
        Diary *objDiary=[arrDiaryData objectAtIndex:i];
        NSString *info;
        
        if([objDiary.type isEqualToString:@"BP"])
        {
            NSArray *arr=[objDiary.info componentsSeparatedByString:@","];
            info=[NSString stringWithFormat:@"SYS : %@   DIA : %@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
        }
        else
        {
            info=objDiary.info;
        }
        NSString *type;
        if([objDiary.type isEqualToString:@"Weight"]){
            type=DPLocalizedString(@"btn_weight", nil);
        }else if ([objDiary.type isEqualToString:@"BP"]){
            type=DPLocalizedString(@"btn_bp", nil);
        }else if([objDiary.type isEqualToString:@"Text"]){
            type=objDiary.type;
        }else{
            type=DPLocalizedString(@"medication", nil);
        }
        NSLog(@"%@ ",type);
        /*
        if([objDiary.type isEqualToString:@"Weight"])
        {
            
            
           type=DPLocalizedString(@"btn_weight", nil);
        }else if ([objDiary.type isEqualToString:@"BP"])
        {
            type=DPLocalizedString(@"btn_bp", nil);
            
        }else if ([objDiary.type isEqualToString:@"hourly"])
        {
            type=DPLocalizedString(@"btn_bp", nil);
            
        }else
        {
            type=objDiary.type;
            
        }*/
        
        NSString *writeStr1=[NSString stringWithFormat:@"%@; %@; %@ \n",objDiary.date,type,info];
        [writeString appendString:writeStr1];
        
    }
    //writeString =[writeStr mutableCopy]; //the \n will put a newline in
    
    //Moved this stuff out of the loop so that you write the complete string once and only once.
    NSLog(@"writeString :%@",writeString);
    
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath] ];
    //say to handle where's the file fo write
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    //position handle cursor to the end of file
    [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:DPLocalizedString(@"diary_tab", nil)];

    
    NSMutableData *myPdfData = [NSMutableData dataWithContentsOfFile:[self dataFilePath]];
    [picker addAttachmentData:myPdfData mimeType:@"application/csv" fileName:[[self dataFilePath] lastPathComponent]];
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    if (error){
        NSString *errorTitle = @"Erro to send";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show];
    }
    
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
 /*   NSString *msg;
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
    NSLog(@"%@",msg);*/
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark- DatePicker Methods





@end

