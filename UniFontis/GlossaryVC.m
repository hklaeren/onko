//
//  GloassaryVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "GlossaryVC.h"
#import "Utility.h"
#import "GlossaryDetailVC.h"
#import "DPLocalizationManager.h"
@import MessageUI;

@interface GlossaryVC ()
{
    NSMutableArray *arrData;
    NSMutableArray *detailListArray;
    NSArray *arr;
}
@end

@implementation GlossaryVC
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    self = [super initWithNibName:nibName bundle:bundle];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utility setNavigationBar:self.navigationController];
    self.title= DPLocalizedString(@"info_tab", nil);
    [tblGlosary setBackgroundColor:BG_COLOR];
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"glossary" ofType:@"csv"];
    NSString *strFile = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!strFile) {
        NSLog(@"Error reading file.");
    }
    arrData = [[NSMutableArray alloc] init];
    
    arr=[[NSArray alloc]init];
    arr = [strFile componentsSeparatedByString:@"\n"];
    
    
    [arrData addObjectsFromArray:arr];
    [arrData removeObject:@""];
    [arrData removeObjectAtIndex:0];
        // Do any additional setup after loading the view from its nib.
    [tblGlosary reloadData];
    arrGlossaryData=[[NSMutableArray alloc] init];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSMutableArray *temp2 = [[NSMutableArray alloc] init];
    for(int i = 0; i < arrData.count; i++)
    {
        NSString *string = [arrData objectAtIndex:i];
        NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        NSArray *items = [string componentsSeparatedByString:@";"];   //take the one array for split the string
        [dict1 setObject:[items objectAtIndex:0] forKey:@"Name"];
        [dict1 setObject:[items objectAtIndex:1] forKey:@"Desc"];
        [arrGlossaryData addObject:dict1];
        [dict1 setObject:[NSNumber numberWithInt:i] forKey:@"ID"];

        NSString *firstString = [string substringToIndex:1];
        
        
        if([temp2 containsObject:firstString] == NO || temp2.count == 0)
        {
            if(temp2.count != 0)
            {
                [temp addObject:temp2];
                temp2 = [[NSMutableArray alloc] init];
                
            }
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:firstString forKey:@"Str"];
            
            [temp2 addObject:dic];
        }
        [temp2 addObject:dict1];
    }
    [temp addObject:temp2];
    detailListArray = [[NSMutableArray alloc] initWithArray:temp];
    arrmainData=[[NSArray alloc]initWithArray:temp];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contact-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callButttonPressed)]];
    [self showSearchbar];
   /* UIBarButtonItem *search=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showSearchbar)];
    search.tintColor=BG_COLOR;
    
    [self.navigationItem setLeftBarButtonItem:search];
*/
    // Do any additional setup after loading the view from its nib.
}

-(void)showSearchbar
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0, WIDTH, 40)];
    [view setBackgroundColor:BG_COLOR];
    UIView *txtView=[[UIView alloc]initWithFrame:CGRectMake(5, 5, WIDTH-10, 30)];
    UITextField *txtSearch=[[UITextField alloc]initWithFrame:CGRectMake(30,0, WIDTH-50, 30)];
    txtSearch.delegate=self;
    txtSearch.clearButtonMode = UITextFieldViewModeWhileEditing;

    [txtSearch setFont:[UIFont fontWithName:FONT_LBL_REG size:12.0]];
    txtSearch.placeholder=@"Search";
    [txtView addSubview:txtSearch];
    [view addSubview:txtView];
    [txtView.layer setCornerRadius:4.0];
    [txtView.layer setBorderWidth:1.0];
    [txtView.layer setBorderColor:NAVBARCLOLOR.CGColor];

    UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search.png"]];
    [imgView setFrame: CGRectMake(5, 3, 22, 22)];
    [txtView addSubview:imgView];
    
/*    UIButton *btnSearch=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnSearch setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    txtSearch.rightView=btnSearch;
    txtSearch.rightViewMode=UITextFieldViewModeAlways;*/
    
    UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, WIDTH, 0.5)];
    sepView.backgroundColor=NAVBARCLOLOR;
    [view addSubview:sepView];
    
    [self.view addSubview:view];
}
-(void)callButttonPressed
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Question"];
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"kontakt@unifontis.net"];
    
    [picker setToRecipients:toRecipients];
    
    
    
    [self presentViewController:picker animated:YES completion:NULL];
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
    
   /* NSString *msg;
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
#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.backgroundColor=BG_COLOR;
}


- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    int i = 0;
    for(NSArray *array in detailListArray)
    {
        
//        NSString *string = [array objectAtIndex:0];

        NSMutableDictionary *dic=[array objectAtIndex:0];
     //   [dic setObject:firstString forKey:@"Str"];

        
        NSString *string =[dic valueForKey:@"Str"];
        if([string compare:title] == NSOrderedSame)
            break;
        i++;
    }
    return i;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return detailListArray.count;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *array = [detailListArray objectAtIndex:section];
    return [array objectAtIndex:0];
}
*/
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *titleArray = [NSMutableArray array];
    [titleArray addObject:@"A"];
    [titleArray addObject:@"B"];
    [titleArray addObject:@"C"];
    [titleArray addObject:@"D"];
    [titleArray addObject:@"E"];
    [titleArray addObject:@"F"];
    [titleArray addObject:@"G"];
    [titleArray addObject:@"H"];
    [titleArray addObject:@"I"];
    [titleArray addObject:@"J"];
    [titleArray addObject:@"K"];
    [titleArray addObject:@"L"];
    [titleArray addObject:@"M"];
    [titleArray addObject:@"N"];
    [titleArray addObject:@"O"];
    [titleArray addObject:@"P"];
    [titleArray addObject:@"Q"];
    [titleArray addObject:@"R"];
    [titleArray addObject:@"S"];
    [titleArray addObject:@"T"];
    [titleArray addObject:@"U"];
    [titleArray addObject:@"V"];
    [titleArray addObject:@"W"];
    [titleArray addObject:@"X"];
    [titleArray addObject:@"Y"];
    [titleArray addObject:@"Z"];
    return titleArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [detailListArray objectAtIndex:section];
    return (array.count - 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:@"CELL"] ;
    NSArray *array = [detailListArray objectAtIndex:indexPath.section];
    NSDictionary *dict1 = [array objectAtIndex:indexPath.row + 1];
    cell.textLabel.text = [dict1 objectForKey:@"Name"];
    
    

    cell.textLabel.font=[UIFont fontWithName:FONT_LBL_REG size:13.0];
    UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, WIDTH, 0.5)];
    sepView.backgroundColor=SEP_COLOR;
    [cell addSubview:sepView];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *array = [detailListArray objectAtIndex:indexPath.section];
    NSDictionary *dict1 = [array objectAtIndex:indexPath.row + 1];
    //int entryID = [[dict1 objectForKey:@"ID"] intValue];
    GlossaryDetailVC *objdet=[[GlossaryDetailVC alloc]initWithNibName:@"GlossaryDetailVC" bundle:nil];
    objdet.dict=[[NSMutableDictionary alloc]initWithDictionary:dict1];
    objdet.arrAllGlossary=arrGlossaryData;
    [self.navigationController pushViewController:objdet animated:YES];
    // Do what ever you want to do with the selected row here....
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark- Tableview Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  arrData.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.backgroundColor=BG_COLOR;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.font=[UIFont fontWithName:FONT_LBL_REG size:13.0];
    NSString *str=[arrData objectAtIndex:indexPath.row];
    NSArray *items = [str componentsSeparatedByString:@";"];   //take the one array for split the string

    cell.textLabel.text=[NSString stringWithFormat:@"%@",[items objectAtIndex:0]];
       UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, WIDTH, 0.5)];
    sepView.backgroundColor=SEP_COLOR;
    [cell addSubview:sepView];
    
    return cell;
}
*/

#pragma mark- textfield delegete methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    detailListArray=[[NSMutableArray alloc]initWithArray:arrmainData];
    [tblGlosary reloadData];
    [textField resignFirstResponder];
       [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
{
    detailListArray=[[NSMutableArray alloc]initWithArray:arrmainData];
    
    
    [tblGlosary reloadData];
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSLog(@"%@",searchStr);
  /*   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Name contains[c] %@ ",searchStr];
    
    NSArray *filteredArr = [arrmainData filteredArrayUsingPredicate:predicate];
    detailListArray=[[NSMutableArray alloc]initWithArray:filteredArr];*/
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY SELF contains[c] %@ OR ANY self.Name contains[c] %@",searchStr, searchStr];
    NSArray *filteredArr = [arrmainData filteredArrayUsingPredicate:predicate];
    detailListArray=[[NSMutableArray alloc]initWithArray:filteredArr];
    
    
   /*
    NSIndexSet *matches = [arrmainData indexesOfObjectsPassingTest:BOOL^(id obj, NSUInteger idx, BOOL stop) {
        NSString *stringToCompare = searchStr;
        
        if ([obj isKindOfClass:[NSString class]]) {
            stringToCompare = (NSString *)obj;
        } else {
            NSDictionary *dict = (NSDictionary *)obj;
            stringToCompare = dict["Name"];
        }
        
        return [stringToCompare rangeOfString:searchString].location != NSNotFound;
    }];
    
    NSArray *filteredArray = [arrmainData objectsAtIndexes:matches];

*/
    [tblGlosary reloadData];

    return true;
}


@end
