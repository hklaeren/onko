//
//  HomeVC.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "HomeVC.h"
#import "AppDelegate.h"
#import "Static.h"
#import "DPLocalizationManager.h"
#import "PersonalSetting.h"
@interface HomeVC ()
{
    AppDelegate *delegate;
}
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate=[AppDelegate initAppdelegate];
    [btnAddDiary.layer setBorderWidth:1.0];
    [btnAddMedication.layer setBorderWidth:1.0];
    [btnChangeLang.layer setBorderWidth:1.0];
    [btnFood.layer setBorderWidth:1.0];
    [btnPSetting.layer setBorderWidth:1.0];

    [btnAddDiary.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
    [btnAddMedication.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
    [btnChangeLang.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
    [btnFood.layer setBorderColor:BTN_BORDER_COLOR.CGColor];
  
    [btnPSetting.layer setBorderColor:BTN_BORDER_COLOR.CGColor];

    [btnChangeLang setTitle:DPLocalizedString(@"change_lang", nil) forState:UIControlStateNormal];
    [btnAddMedication setTitle:DPLocalizedString(@"add_med", nil) forState:UIControlStateNormal];
    
    [btnFood setTitle:DPLocalizedString(@"add_food", nil) forState:UIControlStateNormal];
    
    [btnAddDiary setTitle:DPLocalizedString(@"add_diary", nil) forState:UIControlStateNormal];
    [btnPSetting setTitle:DPLocalizedString(@"pers_sett", nil) forState:UIControlStateNormal];

    // Do any additional setup after loading the view from its nib.
}


-(void)setLanglabels
{
    [btnChangeLang setTitle:DPLocalizedString(@"change_lang", nil) forState:UIControlStateNormal];
    [btnAddMedication setTitle:DPLocalizedString(@"add_med", nil) forState:UIControlStateNormal];

    [btnFood setTitle:DPLocalizedString(@"add_food", nil) forState:UIControlStateNormal];

    [btnAddDiary setTitle:DPLocalizedString(@"add_diary", nil) forState:UIControlStateNormal];
    [btnPSetting setTitle:DPLocalizedString(@"pers_sett", nil) forState:UIControlStateNormal];
    [delegate setHomeViewController];

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

- (IBAction)addMedication:(id)sender {
    delegate.isAddMedicine=true;

    [delegate.tabBarController setSelectedIndex:3];
    

}

- (IBAction)addDiary:(id)sender {
   /* [[NSNotificationCenter defaultCenter]
     postNotificationName:@"Adddiary"
     object:self];*/
    delegate.isAddDiary=true;
    [delegate.tabBarController setSelectedIndex:1];
    
}

- (IBAction)addFood:(id)sender {
    
    delegate.isAddFood=true;

    [delegate.tabBarController setSelectedIndex:4];
    
}

- (IBAction)goToPersonalSettings:(id)sender {
    [self.navigationController pushViewController:[[PersonalSetting alloc]initWithNibName:@"PersonalSetting" bundle:nil] animated:YES];
}

- (IBAction)changelanguage:(id)sender {
    if ([dp_get_current_language() isEqualToString:@"en"]) {
        dp_set_current_language(@"de");
    }
    else if ([dp_get_current_language() isEqualToString:@"de"]) {
        dp_set_current_language(@"en");
    }
    [self setLanglabels];
}
@end
