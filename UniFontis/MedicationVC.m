//
//  MedicationVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//
#import "SWTableViewCell.h"
#import "MedicationVC.h"
#import "Utility.h"
#import "DXPopover.h"
#import "MedicineCell.h"
#import "DatabaseManager.h"
#import "Diary.h"
#import "DPLocalizationManager.h"
#import "AppDelegate.h"
@import MessageUI;
@interface MedicationVC ()<MFMailComposeViewControllerDelegate,SWTableViewCellDelegate>
{
    DXPopover *popover;
    AppDelegate *delegate;
    NSString *strShowMe;
}
@end

NSString *kRemindMeNotificationDataKey = @"kRemindMeNotificationDataKey";

@implementation MedicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [txtMedicine becomeFirstResponder];
    delegate=[AppDelegate initAppdelegate];
    [Utility setNavigationBar:self.navigationController];
    self.navigationItem.title=DPLocalizedString(@"medication_tab", nil);
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_message_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(mailButtonPressed)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_add_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonpressed)]];
    selectedTimes=@"1X";

    tblView.tableHeaderView=headerView;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getAllMedicineData];
    [self setLangLabels];
    
    if(delegate.isAddMedicine==true)
    {
        [self addButtonpressed];
        delegate.isAddMedicine=false;
    }
    [super viewWillAppear:YES];
}
-(void)setLangLabels
{
    lblHourley.text=DPLocalizedString(@"hourly", nil);
    lblMedicine.text=DPLocalizedString(@"medicine", nil);
    lblMedicine_header.text=DPLocalizedString(@"medicine", nil);
    lblQty.text=DPLocalizedString(@"qty", nil);
    lblQty_header.text=DPLocalizedString(@"qty", nil);
    lblTime.text=DPLocalizedString(@"time", nil);
    lblTime_header.text=DPLocalizedString(@"time", nil);
    [btnOk setTitle:DPLocalizedString(@"ok", nil) forState:UIControlStateNormal];
    [btnCancel setTitle:DPLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    strShowMe=DPLocalizedString(@"Showme", nil);
}

-(void)getAllMedicineData
{
    NSMutableArray *arrData=[[DatabaseManager getSharedInstance]getAllMedicineData];
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id_Medicine" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    arrMedicineData =[[NSMutableArray alloc]initWithArray:[arrData sortedArrayUsingDescriptors:sortDescriptors]];
    
    [tblView reloadData];
}

-(void)addButtonpressed
{
    [txtMedicine becomeFirstResponder];
    if(objMed_current==nil)
    {
        txtQty.text=@"";
        txtMedicine.text=@"";
        btn1X.selected=true;
        btn2X.selected=false;
        btn3X.selected=false;
        btn4X.selected=false;
        btnHourly.selected=false;
        selectedTimes=@"1X";
    }
    popover = [DXPopover popover];
    popover.arrowSize=CGSizeMake(0, 0);
    [popover showAtPoint:CGPointMake((WIDTH)/2, HEIGHT/2) popoverPostion:0 withContentView:view_addMedicine inView:self.view];
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
#pragma mark- TABLE VIEW DELEGATE METHODS
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  arrMedicineData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.leftUtilityButtons = nil;
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:30.0f];
        //        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
        
        UILabel *lblDate=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, 110, 30)];
        lblDate.textColor=txtMedicine.textColor;
        lblDate.font=[UIFont fontWithName:FONT_LBL_REG size:12.0];
        [lblDate setBackgroundColor:[UIColor clearColor]];
        lblDate.tag=100;
        lblDate.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:lblDate];
        
        
        UIView *sep1=[[UIView alloc]initWithFrame:CGRectMake(111, 0, 1, 30)];
        sep1.backgroundColor=SEP_COLOR;
        [cell.contentView addSubview:sep1];
        
        UILabel *lblType=[[UILabel alloc]initWithFrame:CGRectMake(130, 0, 50, 30)];
        lblType.textColor=txtMedicine.textColor;
        lblType.font=[UIFont fontWithName:FONT_LBL_REG size:12.0];
        lblType.tag=101;
        lblType.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:lblType];
        
        UIView *sep2=[[UIView alloc]initWithFrame:CGRectMake(201, 0, 1, 30)];
        sep2.backgroundColor=SEP_COLOR;
        [cell.contentView addSubview:sep2];
        
        
        UILabel *lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(212, 0, 80, 30)];
        lblInfo.textAlignment=NSTextAlignmentCenter;
        lblInfo.textColor=txtMedicine.textColor;
        lblInfo.font=[UIFont fontWithName:FONT_LBL_REG size:12.0];
        lblInfo.tag=102;
        [cell.contentView addSubview:lblInfo];
        
        cell.contentView.backgroundColor=BG_COLOR;
        cell.backgroundColor=BG_COLOR;
        UIView *sep=[[UIView alloc]initWithFrame:CGRectMake(0,29,320, 0.5)];
        sep.backgroundColor=SEP_COLOR;
        [cell.contentView addSubview:sep];
    }
    Medicine *objMed=[arrMedicineData objectAtIndex:indexPath.row];
    
    UILabel *lbldat=(UILabel *)[cell viewWithTag:100];
    lbldat.text=objMed.name;
    
    UILabel *lblTyp=(UILabel *)[cell viewWithTag:101];
    lblTyp.text= objMed.qty;
    
    UILabel *lblinfor=(UILabel *)[cell viewWithTag:102];
    
    if ([objMed.time_duration isEqualToString:@"Hourly"]) {
     lblinfor.text=DPLocalizedString(@"hourly", nil);
    }else{
        lblinfor.text=objMed.time_duration;
    }
    return cell;
}
- (IBAction)hideAddaMedicineview:(id)sender {
    objMed_current=nil;
    [popover dismiss];
}

- (IBAction)addMedicationToDatabase:(id)sender {
//    http://stackoverflow.com/questions/11303413/iphone-daily-local-notifications
    if(txtMedicine.text.length==0)
    {
        [Utility showAlertWithMessage:DPLocalizedString(@"enter_medicine_name", nil)];
        return;
    }
    
    if(txtQty.text.length==0)
    {
        [Utility showAlertWithMessage:DPLocalizedString(@"enter_medicine_qty", nil)];
        return;
    }
    
    if(objMed_current)
    {
        objMed_current.name=txtMedicine.text;
        objMed_current.qty=txtQty.text;
        objMed_current.time_duration=selectedTimes;
        [[DatabaseManager getSharedInstance]updateMedicationInfo:objMed_current];
        [self setLocalnotification:objMed_current];
        
        [self getAllMedicineData];
        objMed_current=nil;
        
    }else
    {
        Medicine *objM=[[Medicine alloc]init];
        objM.name=txtMedicine.text;
        objM.qty=txtQty.text;
        objM.time_duration=selectedTimes;
        [self setLocalnotification:objM];
        [[DatabaseManager getSharedInstance]insertMedicationData:objM];
    }
    
    [popover dismiss];
    [self getAllMedicineData];

}


-(IBAction)selectTimes:(UIButton *)sender;
{
    if(sender==btn1X)
    {
    btn1X.selected=true;
    btn2X.selected=false;
    btn3X.selected=false;
    btn4X.selected=false;
    btnHourly.selected=false;
        selectedTimes=@"1X";
    }
    else if (sender==btn2X)
    {
        btn1X.selected=false;
        btn2X.selected=true;
        btn3X.selected=false;
        btn4X.selected=false;
        btnHourly.selected=false;
        selectedTimes=@"2X";
        
    }
    else if (sender==btn3X)
    {
    btn1X.selected=false;
    btn2X.selected=false;
    btn3X.selected=true;
    btn4X.selected=false;
    btnHourly.selected=false;
                selectedTimes=@"3X";
    }
    else if (sender==btn4X)
    {
        btn1X.selected=false;
        btn2X.selected=false;
        btn3X.selected=false;
        btn4X.selected=true;
        btnHourly.selected=false;
                selectedTimes=@"4X";
    }    else if (sender==btnHourly)
    {
        btn1X.selected=false;
        btn2X.selected=false;
        btn3X.selected=false;
        btn4X.selected=false;
        btnHourly.selected=true;
                selectedTimes=@"Hourly";
    }
}
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

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    [cell hideUtilityButtonsAnimated:YES];
    
    NSIndexPath *indexPath = [tblView indexPathForCell:cell];

    Medicine *objMed=[arrMedicineData objectAtIndex:indexPath.row];
    
    UILabel *lbldat=(UILabel *)[cell viewWithTag:100];
    lbldat.text=objMed.name;
    
    UILabel *lblTyp=(UILabel *)[cell viewWithTag:101];
    lblTyp.text=objMed.qty;
    
    UILabel *lblinfor=(UILabel *)[cell viewWithTag:102];
    lblinfor.text=objMed.time_duration;

    switch (index) {
        case 0:
        {
            
            objMed_current=objMed;
            txtMedicine.text=objMed_current.name;
            txtQty.text=objMed_current.qty;
            if([objMed_current.time_duration isEqualToString:@"1X"])
            {
                btn1X.selected=true;
                btn2X.selected=false;
                btn3X.selected=false;
                btn4X.selected=false;
                btnHourly.selected=false;
                selectedTimes=@"1X";
            }
            else if ([objMed_current.time_duration isEqualToString:@"2X"])
            {
                btn1X.selected=false;
                btn2X.selected=true;
                btn3X.selected=false;
                btn4X.selected=false;
                btnHourly.selected=false;
                selectedTimes=@"2X";
                
            }
            else if ([objMed_current.time_duration isEqualToString:@"3X"])
            {
                btn1X.selected=false;
                btn2X.selected=false;
                btn3X.selected=true;
                btn4X.selected=false;
                btnHourly.selected=false;
                selectedTimes=@"3X";
            }
            else if ([objMed_current.time_duration isEqualToString:@"4X"])
            {
                btn1X.selected=false;
                btn2X.selected=false;
                btn3X.selected=false;
                btn4X.selected=true;
                btnHourly.selected=false;
                selectedTimes=@"4X";
            }    else if ([objMed_current.time_duration isEqualToString:@"hourly"])
            {
                btn1X.selected=false;
                btn2X.selected=false;
                btn3X.selected=false;
                btn4X.selected=false;
                btnHourly.selected=true;
                selectedTimes=@"hourly";
            }

            
            [self addButtonpressed];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"%d",objMed.id_Medicine);
            [[DatabaseManager getSharedInstance] deleteMedicationInfoWithId:objMed.id_Medicine];
            UIApplication *app = [UIApplication sharedApplication];
            NSArray *eventArray = [app scheduledLocalNotifications];
            for (int i=0; i<[eventArray count]; i++)
            {
                UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
                NSLog(@"%@",oneEvent.userInfo);
                //NSDictionary *userInfoCurrent = oneEvent.userInfo;
                NSString *uid=[NSString stringWithFormat:@"%d",objMed.id_Medicine];
                if ([uid isEqualToString:[NSString stringWithFormat:@"%d",objMed.id_Medicine]])
                {
                    //Cancelling local notification
                    [[UIApplication sharedApplication] cancelLocalNotification:oneEvent];
                    break;
                }
            }
            //[[UIApplication sharedApplication] cancelAllLocalNotifications];
            [self getAllMedicineData];
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


#pragma mark- Mail Delegates Meethods
-(NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);

    return [documentsDirectory stringByAppendingPathComponent:@"Medication.csv"];
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
    for (int i=0; i<[arrMedicineData count]; i++) {
        
        Medicine *objMedi=[arrMedicineData objectAtIndex:i];
        /*NSString *strTime;
        if ([objMedi.time_duration isEqualToString:@"Hourly"]) {
            strTime=DPLocalizedString(@"hourly", nil);
        }else{
            strTime=objMedi.time_duration;
        }*/
        
        NSString *writeStr1=[NSString stringWithFormat:@"%@; %@; %@ \n",objMedi.name,objMedi.qty,objMedi.time_duration];
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
    
    [picker setSubject:DPLocalizedString(@"medication_tab", nil)];
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
    NSLog(@"%@",msg);
    */
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)LocalNotificationType{
   /* UIUserNotificationType types = UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];*/

    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
}

#pragma mark- Schedule Notification Methods

-(void)setLocalnotification:(Medicine *)objMedication
{
    
  //  When “1x”: 12:00, when “2x”: 08:00 and 18:00, when “3x”: 08:00, 12:00, 18:00, when “4x”: 08:00, 12:00, 16:00, 20:00,
    if([objMedication.time_duration isEqualToString:@"1X"])
    {
        NSDate *date = [NSDate date];
        NSCalendar *gregorian = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay: [dateComponents day]];
        [components setMonth: [dateComponents month]];
        [components setYear: [dateComponents year]];
        [components setHour: 12];
        [components setMinute: 0];
        [components setSecond: 0];
        [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
        NSDate *dateToFire = [calendar dateFromComponents:components];
        
        [self LocalNotificationType];
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = dateToFire;
        //   notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody = objMedication.name;
        notif.alertAction = strShowMe;//@"Show";
        notif.soundName = UILocalNotificationDefaultSoundName;
        // notif.applicationIconBadgeNumber = 1;
        notif.repeatInterval = NSCalendarUnitDay;
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:objMedication.name forKey:kRemindMeNotificationDataKey];
        notif.userInfo = userDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }else if ([objMedication.time_duration isEqualToString:@"2X"])
    {
        for(int i = 0 ; i <1;i++)
        {
            NSDate *date = [NSDate date];
            NSCalendar *gregorian = [NSCalendar currentCalendar];
            NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setDay: [dateComponents day]];
            [components setMonth: [dateComponents month]];
            [components setYear: [dateComponents year]];
            if(i==0)
            {
                [components setHour: 8];
            }else
            {
                [components setHour: 18];
                
            }
            
            [components setMinute: 0];
            [components setSecond: 0];
            [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
            NSDate *dateToFire = [calendar dateFromComponents:components];
            
            [self LocalNotificationType];
            UILocalNotification *notif = [[UILocalNotification alloc] init];
            notif.fireDate = dateToFire;
            //   notif.timeZone = [NSTimeZone defaultTimeZone];
            
            notif.alertBody = objMedication.name;
            notif.alertAction = strShowMe;//@"Show";
            notif.soundName = UILocalNotificationDefaultSoundName;
            // notif.applicationIconBadgeNumber = 1;
            notif.repeatInterval = NSCalendarUnitDay;
            
            NSDictionary *userDict = [NSDictionary dictionaryWithObject:objMedication.name forKey:kRemindMeNotificationDataKey];
            notif.userInfo = userDict;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        }
    }else if ([objMedication.time_duration isEqualToString:@"3X"])
    {
        for(int i = 0 ; i <2;i++)
        {
            NSDate *date = [NSDate date];
            NSCalendar *gregorian = [NSCalendar currentCalendar];
            NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setDay: [dateComponents day]];
            [components setMonth: [dateComponents month]];
            [components setYear: [dateComponents year]];
            if(i==0)
            {
                [components setHour: 8];
            }else if(i==1)
            {
                [components setHour: 12];
            }else if(i==2)
            {
                [components setHour: 16];
            }else
            {
                [components setHour: 20];
                
            }
            
            [components setMinute: 0];
            [components setSecond: 0];
            [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
            NSDate *dateToFire = [calendar dateFromComponents:components];
            
            [self LocalNotificationType];
            UILocalNotification *notif = [[UILocalNotification alloc] init];
            notif.fireDate = dateToFire;
            // notif.timeZone = [NSTimeZone defaultTimeZone];
            
            notif.alertBody = objMedication.name;
            notif.alertAction = strShowMe;//@"Show";
            notif.soundName = UILocalNotificationDefaultSoundName;
            // notif.applicationIconBadgeNumber = 1;
            notif.repeatInterval = NSCalendarUnitDay;
            
            NSDictionary *userDict = [NSDictionary dictionaryWithObject:objMedication.name forKey:kRemindMeNotificationDataKey];
            notif.userInfo = userDict;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        }
    }
    else if ([objMedication.time_duration isEqualToString:@"4X"])
    {
        for(int i = 0 ; i <3;i++)
        {
            NSDate *date = [NSDate date];
            NSCalendar *gregorian = [NSCalendar currentCalendar];
            NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setDay: [dateComponents day]];
            [components setMonth: [dateComponents month]];
            [components setYear: [dateComponents year]];
            if(i==0)
            {
                [components setHour: 8];
            }else if(i==1)
            {
                [components setHour: 12];
            }else
            {
                [components setHour: 18];
                
            }
            [components setMinute: 0];
            [components setSecond: 0];
            [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
            NSDate *dateToFire = [calendar dateFromComponents:components];
            
            [self LocalNotificationType];
            UILocalNotification *notif = [[UILocalNotification alloc] init];
            notif.fireDate = dateToFire;
            // notif.timeZone = [NSTimeZone defaultTimeZone];
            
            notif.alertBody = objMedication.name;
            notif.alertAction = strShowMe;//@"Show";
            notif.soundName = UILocalNotificationDefaultSoundName;
            // notif.applicationIconBadgeNumber = 1;
            notif.repeatInterval = NSCalendarUnitDay;
            
            NSDictionary *userDict = [NSDictionary dictionaryWithObject:objMedication.name forKey:kRemindMeNotificationDataKey];
            notif.userInfo = userDict;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        }
    }else
    {
        NSDate *date = [NSDate date];
        NSCalendar *gregorian = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay: [dateComponents day]];
        [components setMonth: [dateComponents month]];
        [components setYear: [dateComponents year]];
        [components setHour: 12];
        [components setMinute: 0];
        [components setSecond: 0];
        [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
        NSDate *dateToFire = [calendar dateFromComponents:components];
        
        
        [self LocalNotificationType];
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = dateToFire;
        // notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody = objMedication.name;
        notif.alertAction = strShowMe;//@"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        
        notif.repeatInterval = NSCalendarUnitHour;
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:txtMedicine.text
                                                             forKey:kRemindMeNotificationDataKey];
        notif.userInfo = userDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
        /*
         NSInteger index = [scheduleControl selectedSegmentIndex];
         switch (index) {
         case 1:
         notif.repeatInterval = NSMinuteCalendarUnit;
         break;
         case 2:
         notif.repeatInterval = NSHourCalendarUnit;
         break;
         case 3:
         notif.repeatInterval = NSDayCalendarUnit;
         break;
         case 4:
         notif.repeatInterval = NSWeekCalendarUnit;
         break;
         default:
         notif.repeatInterval = 0;
         break;
         }
         
         UILocalNotification* localNotification = [[UILocalNotification alloc] init];
         localNotification.fireDate = dateToFire;
         localNotification.alertBody = txtMedicine.text;
         localNotification.alertAction=selectedTimes;
         
         //   localNotification.timeZone = [NSTimeZone defaultTimeZone];
         
         [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
         //[localNotification setFireDate: dateToFire];
         //    [localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
         
         [localNotification setRepeatInterval: NSCalendarUnitDay];
         */
    }
}

@end



