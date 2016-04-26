//
//  FoodVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "FoodVC.h"
#import "Utility.h"
#import "FoodCell.h"
#import "DXPopover.h"
#import "DatabaseManager.h"
#import "DPLocalizationManager.h"
#import "AppDelegate.h"
@import MessageUI;
@interface FoodVC () <MFMailComposeViewControllerDelegate,SWTableViewCellDelegate>
{
    DXPopover *popover;
    AppDelegate *delegate;
    FoodCell *cell;
    UIToolbar* numberToolbar;
}
@end

@implementation FoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self DoneButtonOnKeyboard];
    delegate=[AppDelegate initAppdelegate];
    [Utility setNavigationBar:self.navigationController];
    self.navigationItem.title=DPLocalizedString(@"food_tab", nil);
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_message_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(mailButtonPressed)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_add_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonpressed)]];
    [self getAllFoodData];
    /*[scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    if(HEIGHT <700)
    {
        [scrollview setContentSize:CGSizeMake(300, 550)];
    }*/
    strUnit=@"g";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [tatName becomeFirstResponder];
    [scrollview setContentOffset:CGPointMake(0, 0) animated:true];
    [scrollview setContentSize:CGSizeMake(280, 500)];
    [self setLanglabels];
    if(delegate.isAddFood==true)
    {
        [self addButtonpressed];
        delegate.isAddFood=false;
    }
    [super viewWillAppear:YES];
}
-(void)setLanglabels
{
    lblQty.text=DPLocalizedString(@"qty", nil);
    lblFat.text=[NSString stringWithFormat:@"%@ (g)",DPLocalizedString(@"fat", nil)];
    lblFood.text=DPLocalizedString(@"food_tab", nil);
    lblgram.text=DPLocalizedString(@"gram", nil);
    lblKcal.text=DPLocalizedString(@"cal", nil);
    lblPiece.text=DPLocalizedString(@"piece", nil);
    lblProt.text=[NSString stringWithFormat:@"%@ (g)",DPLocalizedString(@"Protein", nil)];
    lblUnit.text=DPLocalizedString(@"unit", nil);
    lblCarb.text=[NSString stringWithFormat:@"%@ (g)",DPLocalizedString(@"carb", nil)];
    lblCup.text=DPLocalizedString(@"cup", nil);
    [btnCancel setTitle:DPLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [btnOk setTitle:DPLocalizedString(@"ok", nil) forState:UIControlStateNormal];
    
}

-(void)getAllFoodData
{
    NSMutableArray *arrData=[[DatabaseManager getSharedInstance]getAllFoodData];
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id_food" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    arrFoodData =[[NSMutableArray alloc]initWithArray:[arrData sortedArrayUsingDescriptors:sortDescriptors]];
    //arrFoodData=[[DatabaseManager getSharedInstance]getAllFoodData];
    [tblFood reloadData];
}
-(void)addButtonpressed
{
    if(objFood_Current==nil)
    {
        txtQty.text=@"";
        tatName.text=@"";
        cal.text=@"";
        carb.text=@"";
        protein.text=@"";
        fat.text=@"";
        
        btnG.selected=true;
        btnML.selected=false;
        btnCup.selected=false;
        btnPiece.selected=false;
        strUnit=@"g";

    }
    popover = [DXPopover popover];
    popover.arrowSize=CGSizeMake(0, 0);
    [popover showAtPoint:CGPointMake((WIDTH)/2, HEIGHT/2) popoverPostion:0 withContentView:view_addFood inView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TABLE VIEW DELEGATE METHODS
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  arrFoodData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    cell = (FoodCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    cell.leftUtilityButtons = nil;
    cell.delegate=self;
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:30.0f];
    if (arrFoodData > 0) {
        FoodClass *objFood=[arrFoodData objectAtIndex:indexPath.row];
        cell.name.text=objFood.name;
        cell.quantity.text=objFood.quantity;
        cell.type.text=objFood.unit;
        cell.lblDate.text=objFood_Current.Date;
        if([objFood.unit isEqualToString:@"g"])
        {
            cell.type.text=DPLocalizedString(@"gram", nil);
        }else if ([objFood.unit isEqualToString:@"ml"])
        {
            cell.type.text=DPLocalizedString(@"ml", nil);
        }else if ([objFood.unit isEqualToString:@"Cup"])
        {
            cell.type.text=DPLocalizedString(@"cup", nil);
        }else if ([objFood.unit isEqualToString:@"Piece"])
        {
            cell.type.text=DPLocalizedString(@"piece", nil);
        }
        
        // Check Food Category is blank or not
        
        cell.lblDate.text=objFood.Date;
        if ([objFood.kcal isEqual:@""]) {
            cell.kcal.text=@"-";
        }else{
            cell.kcal.text=[NSString stringWithFormat:@"%@ %@",objFood.kcal,DPLocalizedString(@"cal", nil)];
        }
        if ([objFood.fat isEqual:@""]){
            cell.fat.text=@"-";
        }else{
            cell.fat.text=[NSString stringWithFormat:@"%@g %@",objFood.fat,DPLocalizedString(@"fat", nil)];
        }
        
        if ([objFood.protein isEqual:@""]){
            cell.protein.text=@"-";
        }else{
            cell.protein.text=[NSString stringWithFormat:@"%@g %@",objFood.protein,DPLocalizedString(@"Protein", nil)];
        }
        
        if ([objFood.carb isEqual:@""]){
            cell.carb.text=@"-";
        }else{
            cell.carb.text=[NSString stringWithFormat:@"%@g %@",objFood.carb,DPLocalizedString(@"carb", nil)];
        }
        
        if (![objFood.kcal isEqual:@""] && ![objFood.fat isEqual:@""] && ![objFood.protein isEqual:@""] && ![objFood.carb isEqual:@""]) {
            cell.kcal.text=[NSString stringWithFormat:@"%@ %@",objFood.kcal,DPLocalizedString(@"cal", nil)];
            cell.fat.text=[NSString stringWithFormat:@"%@g %@",objFood.fat,DPLocalizedString(@"fat", nil)];
            cell.protein.text=[NSString stringWithFormat:@"%@g %@",objFood.protein,DPLocalizedString(@"Protein", nil)];
            cell.carb.text=[NSString stringWithFormat:@"%@g %@",objFood.carb,DPLocalizedString(@"carb", nil)];
        }
    }
    return cell;
}


- (IBAction)hideAddFoodview:(id)sender {
    objFood_Current=nil;
    [popover dismiss];
}
-(IBAction)selectUnitForFood:(UIButton *)btn;

{
    if(btn==btnG)
    {
        btnG.selected=true;
        btnML.selected=false;
        btnCup.selected=false;
        btnPiece.selected=false;
                strUnit=@"g";
    }
    else if(btn==btnML)
    {
        btnG.selected=false;
        btnML.selected=true;
        btnCup.selected=false;
        btnPiece.selected=false;
                strUnit=@"ml";
    }
    else if(btn==btnCup)
    {
        btnG.selected=false;
        btnML.selected=false;
        btnCup.selected=true;
        btnPiece.selected=false;
                strUnit=@"Cup";
    }else if(btn==btnPiece)
    {
        btnG.selected=false;
        btnML.selected=false;
        btnCup.selected=false;
        btnPiece.selected=true;
        strUnit=@"Piece";
    }
    
}
- (IBAction)enterFoodInfoInDatabase:(id)sender {
    [tatName becomeFirstResponder];
    if(tatName.text.length ==0)
    {
        [Utility showAlertWithMessage:DPLocalizedString(@"msg_enter_food", nil)];
        return;
    }
    else if(txtQty.text.length == 0)
    {
        [Utility showAlertWithMessage:DPLocalizedString(@"msg_enter_qty", nil)];
        return;
    }
   /*else if(cal.text.length == 0)
   {
       [Utility showAlertWithMessage:DPLocalizedString(@"msg_enter_cal", nil)];
       return;
   }
    else if (fat.text.length==0)
    {
        [Utility showAlertWithMessage:DPLocalizedString(@"msg_enter_fat", nil)];
        return;
    }
    else if (protein.text.length==0)
    {
        [Utility showAlertWithMessage:DPLocalizedString(@"msg_enter_prot", nil)];
        return;
    }
    else if (carb.text.length==0)
    {
        [Utility showAlertWithMessage:@"Enter carb"];
        return;
    }*/
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy, HH:mm";
    NSString *yourDate = [dateFormatter stringFromDate:[NSDate date]];
    if(objFood_Current)
    {
        objFood_Current.Date=yourDate;
        objFood_Current.name=tatName.text;
        objFood_Current.quantity=txtQty.text;
        objFood_Current.kcal=cal.text;
        objFood_Current.carb=carb.text;
        objFood_Current.protein=protein.text;
        objFood_Current.fat=fat.text;
        objFood_Current.unit=strUnit;
        BOOL succ=[[DatabaseManager getSharedInstance]updateFoodInfo:objFood_Current];
        if(succ==true)
        {
            objFood_Current=nil;
        }
    }else
    {
        FoodClass *objFood=[[FoodClass alloc]init];
        objFood.Date=yourDate;
        objFood.name=tatName.text;
        objFood.quantity=txtQty.text;
        objFood.kcal=cal.text;
        objFood.carb=carb.text;
        objFood.protein=protein.text;
        objFood.fat=fat.text;
        objFood.unit=strUnit;
        [[DatabaseManager getSharedInstance]insertFoodData:objFood];
    }
    [popover dismiss];
    [self getAllFoodData];
}
-(void)DoneButtonOnKeyboard{
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    NSString *str=DPLocalizedString(@"cancel", nil);
    numberToolbar.items = [NSArray arrayWithObjects:
                          [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          // [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(NextWithNumberPad:)],
                           nil];
    [numberToolbar sizeToFit];
}
-(void)TextfieldTag{
    txtQty.tag=1;
    cal.tag=2;
    fat.tag=3;
}
-(void)cancelNumberPad{
    [txtQty resignFirstResponder];
    [cal resignFirstResponder];
    [fat resignFirstResponder];
    [protein resignFirstResponder];
    [carb resignFirstResponder];
    //carb.text = @"";
}
#pragma mark- Textfield Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField==tatName) {
        [tatName resignFirstResponder];
        [txtQty becomeFirstResponder];
    }
    [scrollview setContentOffset:CGPointMake(0, 0) animated:true];
    [scrollview setContentSize:CGSizeMake(280, 500)];
    return true;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    if(HEIGHT < 700)
    {
        if (textField==tatName) {
            [scrollview setContentOffset:CGPointMake(0, 0) animated:true];
            [scrollview setContentSize:CGSizeMake(280, 500)];
        }else if(textField==txtQty){
            txtQty.inputAccessoryView = numberToolbar;
            [scrollview setContentOffset:CGPointMake(0, 40) animated:true];
        }else if(textField==cal){
            cal.inputAccessoryView = numberToolbar;
            [scrollview setContentOffset:CGPointMake(0, 80) animated:true];
        }else if (textField==fat){
            fat.inputAccessoryView = numberToolbar;
            [scrollview setContentOffset:CGPointMake(0, 120) animated:true];
        }else if (textField==protein){
            protein.inputAccessoryView = numberToolbar;
            [scrollview setContentOffset:CGPointMake(0, 150) animated:true];
        }else if (textField==carb){
            carb.inputAccessoryView = numberToolbar;
            [scrollview setContentOffset:CGPointMake(0, 190) animated:true];
        }
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

- (void)swipeableTableViewCell:(SWTableViewCell *)cell1 didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    [cell1 hideUtilityButtonsAnimated:YES];
    NSIndexPath *indexPath = [tblFood indexPathForCell:cell1];
    FoodClass *objFood=[arrFoodData objectAtIndex:indexPath.row];

    switch (index) {
        case 0:
        {
            objFood_Current=objFood;
            txtQty.text=objFood.quantity;
            tatName.text=objFood.name;
            cal.text=objFood.kcal;
            carb.text=objFood.carb;
            protein.text=objFood.protein;
            fat.text=objFood.fat;
            
            if([objFood.unit isEqualToString:@"g"])
            {
                btnG.selected=true;
                btnML.selected=false;
                btnCup.selected=false;
                btnPiece.selected=false;
                strUnit=@"g";
            }
            else if([objFood.unit isEqualToString:@"ml"])
            {
                btnG.selected=false;
                btnML.selected=true;
                btnCup.selected=false;
                btnPiece.selected=false;
                strUnit=@"ml";
            }
            else if([objFood.unit isEqualToString:@"Cup"])
            {
                btnG.selected=false;
                btnML.selected=false;
                btnCup.selected=true;
                btnPiece.selected=false;
                strUnit=@"Cup";
            }else if([objFood.unit isEqualToString:@"Piece"])
            {
                btnG.selected=false;
                btnML.selected=false;
                btnCup.selected=false;
                btnPiece.selected=true;
                strUnit=@"Piece";
            }
            [self addButtonpressed];
           /* cell.name.text=objFood.name;
            cell.quantity.text=objFood.quantity;
            cell.type.text=objFood.unit;
            cell.kcal.text=[NSString stringWithFormat:@"%@ kCal",objFood.kcal];
            cell.fat.text=[NSString stringWithFormat:@"%@g Fat",objFood.fat];
            cell.protein.text=[NSString stringWithFormat:@"%@g Protein",objFood.protein];
            cell.carb.text=[NSString stringWithFormat:@"%@g Carb",objFood.carb];*/
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            [[DatabaseManager getSharedInstance]deleteFoodDataWithId:objFood.id_food];
            [self getAllFoodData];
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

    return [documentsDirectory stringByAppendingPathComponent:@"Food.csv"];
}

-(void)mailButtonPressed
{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
        NSLog(@"Route create");
    }else
    {
        [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
        [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
        
    }
    
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0]; //don't worry about the capacity, it will expand as necessary
    for (int i=0; i<[arrFoodData count]; i++) {
        
        FoodClass *objFood=[arrFoodData objectAtIndex:i];
        NSString *strKcal;
        NSString *strFat;
        NSString *strProtein;
        NSString *strCarb;
        
        NSLog(@"strKcal:- %@ strFat:- %@ strProtein:- %@ strCarb:- %@",strKcal,strFat,strProtein,strCarb);
        if ([objFood.kcal isEqual:@""]) {
            strKcal=@"";
        }else{
            strKcal=[NSString stringWithFormat:@"%@ kCal;",objFood.kcal];
        }
        if ([objFood.fat isEqual:@""]){
            strFat=@"";
        }else{
            strFat=[NSString stringWithFormat:@"%@g Fat;",objFood.fat];
        }
        
        if ([objFood.protein isEqual:@""]){
            strProtein=@"";
        }else{
            strProtein=[NSString stringWithFormat:@"%@g Protein;",objFood.protein];
        }
        
        if ([objFood.carb isEqual:@""]){
            strCarb=@"";
        }else{
            strCarb=[NSString stringWithFormat:@"%@g Carb;",objFood.carb];
        }
        
        NSString *writeStr1=[NSString stringWithFormat:@"%@; %@; %@; %@ %@ %@ %@ %@ \n",objFood.name,objFood.quantity,objFood.unit,strKcal,strFat,strProtein,strCarb,[NSString stringWithFormat:@"%@",objFood.Date]];
        
        [writeString appendString:writeStr1];
        
    }
    //writeString =[writeStr mutableCopy]; //the \n will put a newline in
    
    //Moved this stuff out of the loop so   that you write the complete string once and only once.
    NSLog(@"writeString :%@",writeString);
    
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath] ];
    //say to handle where's the file fo write
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    //position handle cursor to the end of file
    [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
        [picker setSubject:DPLocalizedString(@"food_tab", nil)];
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
    
    NSString *msg;
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
               default:
            msg = @"Result: Mail not sent";
            break;
    }
    NSLog(@"%@",msg);
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
