//
//  PersonalSetting.m
//  UniFontis
//
//  Created by Kalpit Gajera on 14/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "PersonalSetting.h"
#import "DPLocalizationManager.h"
#import "Utility.h"
@interface PersonalSetting ()

@end

@implementation PersonalSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utility setNavigationBar:self.navigationController];
    self.title=DPLocalizedString(@"pers_sett", nil);
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=false;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)]];
    [scrollView setContentSize:CGSizeMake(WIDTH, HEIGHT_IPHONE_5+200)];

    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    dob.inputView=view_datePicker;
    [datePicker setMaximumDate:[NSDate date]];
    
    
    [firstName setPlaceholder:DPLocalizedString(@"firstname", nil)];
    [lastName setPlaceholder:DPLocalizedString(@"lastname", nil)];
    [dob setPlaceholder:DPLocalizedString(@"dob", nil)];

    [mobile setPlaceholder:DPLocalizedString(@"mob", nil)];
    [email setPlaceholder:DPLocalizedString(@"email", nil)];
    [add1 setPlaceholder:DPLocalizedString(@"add1", nil)];
    [add2 setPlaceholder:DPLocalizedString(@"add2", nil)];
    [city setPlaceholder:DPLocalizedString(@"city", nil)];
    [zip setPlaceholder:DPLocalizedString(@"zip", nil)];
    [weight setPlaceholder:DPLocalizedString(@"btn_weight", nil)];
    [height setPlaceholder:DPLocalizedString(@"height", nil)];

    [btnSave setTitle:DPLocalizedString(@"save", nil) forState:UIControlStateNormal];
    
    
    
    if([def valueForKey:@"firstName"])
    {
        firstName.text=[def valueForKey:@"firstName"];
    }

    if([def valueForKey:@"lastName"])
    {
        lastName.text=[def valueForKey:@"lastName"];
    }

    if([def valueForKey:@"dob"])
    {
        dob.text=[def valueForKey:@"dob"];
    }

    if([def valueForKey:@"mobile"])
    {
        mobile.text=[def valueForKey:@"mobile"];
    }

    if([def valueForKey:@"add1"])
    {
        add1.text=[def valueForKey:@"add1"];
    }
    
    if([def valueForKey:@"add2"])
    {
        add2.text=[def valueForKey:@"add2"];
    }

    if([def valueForKey:@"city"])
    {
        city.text=[def valueForKey:@"city"];
    }
    
    if([def valueForKey:@"zip"])
    {
        zip.text=[def valueForKey:@"zip"];
    }
    

    if([def valueForKey:@"weight"])
    {
        weight.text=[def valueForKey:@"weight"];
    }

    if([def valueForKey:@"height"])
    {
        height.text=[def valueForKey:@"height"];
    }
    
    if([def valueForKey:@"email"])
    {
        email.text=[def valueForKey:@"email"];
    }

    



    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated; // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{
    self.navigationController.navigationBarHidden=true;
    [super viewWillDisappear:YES];
}
-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:true];
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
#pragma mark- Textfield Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textField resignFirstResponder];
    return true;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{        if(textField==firstName)
        {
            [scrollView setContentOffset:CGPointMake(0, 30) animated:true];
        }else if (textField==lastName){
            
            [scrollView setContentOffset:CGPointMake(0, 50) animated:true];
        }else if (textField==dob){
            
            [scrollView setContentOffset:CGPointMake(0, 70) animated:true];
        }else if (textField==mobile){
            
            [scrollView setContentOffset:CGPointMake(0, 90) animated:true];
        }
        else if (textField==email){
            
            [scrollView setContentOffset:CGPointMake(0, 110) animated:true];
        }
        else if (textField==add1){
            
            [scrollView setContentOffset:CGPointMake(0, 130) animated:true];
        }else if (textField==add2){
            
            [scrollView setContentOffset:CGPointMake(0, 150) animated:true];
        }
        else if (textField==city){
            
            [scrollView setContentOffset:CGPointMake(0, 170) animated:true];
        }
        else if (textField==zip){
            
            [scrollView setContentOffset:CGPointMake(0, 190) animated:true];
        }
        else if (textField==weight){
            
            [scrollView setContentOffset:CGPointMake(0, 210) animated:true];
        }
        else if (textField==height){
            
            [scrollView setContentOffset:CGPointMake(0, 230) animated:true];
        }
    
}


- (IBAction)saveData:(id)sender {
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if(firstName.text.length>0)
    {
        [def setValue:firstName.text forKey:@"firstName"];
    }  if (lastName.text.length>0){
        [def setValue:lastName.text forKey:@"lastName"];

    }  if ( dob.text.length>0){
        [def setValue:dob.text forKey:@"dob"];
 
    }  if ( mobile.text.length>0){
        
        [def setValue:mobile.text forKey:@"mobile"];
        
    }
      if ( email.text.length>0){
        
          if(![Utility isValidateEmail:email.text])
          {
              [Utility showAlertWithwithMessage:@"Invalid email please enter valid email"];
              return;
          }
        [def setValue:email.text forKey:@"email"];
    }
      if ( add1.text.length>0){
        
        [def setValue:add1.text forKey:@"add1"];


    }  if ( add2.text.length>0){
        
        [def setValue:add2.text forKey:@"add2"];

    }
      if ( city.text.length>0){
        
        [def setValue:city.text forKey:@"city"];

    }
      if ( weight.text.length>0){
        
        [def setValue:weight.text forKey:@"weight"];

    }
      if ( height.text.length>0){
        
        [def setValue:height.text forKey:@"height"];
    }

    
    
    if ( zip.text.length>0){
        
        [def setValue:zip.text forKey:@"zip"];
    }
    

    [def synchronize];
    [self.navigationController popViewControllerAnimated:true];
    
}
- (IBAction)hideAPicker:(id)sender {
    [dob resignFirstResponder];
}
- (IBAction)pickDOb:(id)sender {
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setDateFormat:@"dd-MMM-YYYY"];
    [dob setText:[form stringFromDate:datePicker.date]];
    [dob resignFirstResponder];
    
}

@end
