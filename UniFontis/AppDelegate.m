//
//  AppDelegate.m
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "AppDelegate.h"
#import "InfoVC.h"
#import "SettingsVC.h"
#import "DiaryVC.h"
#import "DashboardVC.h"
#import "FoodVC.h"
#import "MedicationVC.h"
#import "DPLocalizationManager.h"
#import "RNCachingURLProtocol.h"

@interface AppDelegate ()
{
    // Local Notification
    NSMutableArray *arrMedicineData;
    Diary *objDiary_current;
    //NSString *truncatedString;
    
    //Taken Not Taken Local Notification
    UIApplication *app;
    NSArray *eventArray;
    Medicine *objMed;
    UILocalNotification* oneEvent;
    NSString *uid;
    
    //Language change
    NSDictionary *dicNotify;
    
    NSString *strReminder;
    NSString *strTaken;
    NSString *strNotTaken;
    NSString *strMedication;
}
@end

@implementation AppDelegate
@synthesize tabBarController;
@synthesize isAddDiary,isAddFood,isAddMedicine;
+(AppDelegate *)initAppdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

/* - (void) clearNotifications {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
 */

-(void)getAllMedicineData
{
    NSMutableArray *arrData=[[DatabaseManager getSharedInstance]getAllMedicineData];
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id_Medicine" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    arrMedicineData =[[NSMutableArray alloc]initWithArray:[arrData sortedArrayUsingDescriptors:sortDescriptors]];
    NSLog(@"getAllMedicineData: %@",[arrMedicineData valueForKey:@"id_Medicine"]);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // NSLog(@"AppDelegate didReceiveLocalNotification %@", notification.userInfo);
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
    tabBarController.selectedIndex=3;
    dicNotify=notification.userInfo;
    // NSLog(@"Local notification received %@",[dicNotify valueForKey:@"kRemindMeNotificationDataKey"]);
    [self setLangLabels];
    [self LocalNotificationCall:[NSString stringWithFormat:@"%@",[dicNotify valueForKey:@"kRemindMeNotificationDataKey"]]];
}

-(void)setLangLabels
{
    strReminder=DPLocalizedString(@"reminder", nil);
    strTaken=DPLocalizedString(@"taken", nil);
    strNotTaken=DPLocalizedString(@"nottaken", nil);
    strMedication=DPLocalizedString(@"medication", nil);
}

-(void)LocalNotificationCall:(NSString *)message{
    NSLog(@"LocalNotificationCall: %@",message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strReminder
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:strTaken
                                          otherButtonTitles:strNotTaken, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self getAllMedicineData];
    app = [UIApplication sharedApplication];
    eventArray = [app scheduledLocalNotifications];
    
    objMed=[arrMedicineData objectAtIndex:0];
    if(buttonIndex == 0)
    {
        for (int i=0; i<[eventArray count]; i++)
        {
            oneEvent = [eventArray objectAtIndex:i];
            NSLog(@"alertView.objectAtIndex: %d",i);
            NSLog(@"alertView event %@",oneEvent.userInfo);
            
            uid=[NSString stringWithFormat:@"%d",objMed.id_Medicine];
            if ([uid isEqualToString:[NSString stringWithFormat:@"%d",objMed.id_Medicine]])
            {
                //Cancelling local notification
                [[UIApplication sharedApplication] cancelLocalNotification:oneEvent];
                [self addTakenMedicineToDatabase];
                tabBarController.selectedIndex=2;
                break;
            }
        }
    }else
    {
       /* for (int i=0; i<[eventArray count]; i++)
        {
            oneEvent = [eventArray objectAtIndex:i];
            NSLog(@"%@",oneEvent.userInfo);
            
            uid=[NSString stringWithFormat:@"%d",objMed.id_Medicine];
            if ([uid isEqualToString:[NSString stringWithFormat:@"%d",objMed.id_Medicine]])
            {
                //Cancelling local notification
                [[UIApplication sharedApplication] cancelLocalNotification:oneEvent];
                break;
            }
        }*/
    }
}

-(void)addTakenMedicineToDatabase{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy, HH:mm";
    NSString *yourDate = [dateFormatter stringFromDate:[NSDate date]];
    
    Diary *objdiary=[[Diary alloc]init];
    objdiary.date=yourDate;
    objdiary.type=strMedication;
    objdiary.info=[dicNotify valueForKey:@"kRemindMeNotificationDataKey"];
    
    BOOL addInfo=[[DatabaseManager getSharedInstance] addDiaryInfo:objdiary];
    NSLog(@"Taken medicine added to database: %s",addInfo? "Success": "Failure");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[self clearNotifications];
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification)
    {
       tabBarController.selectedIndex = 3;
    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"LangSelect"])
    {
        dp_set_current_language(@"de");
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"LangSelect"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    BOOL isSuccess=[[DatabaseManager getSharedInstance] CheckDbExist];
    NSLog(@"Checking database connection: %s",isSuccess ? "Success" : "Failure");
    // Set app's client ID for |GPPSignIn| and |GPPShare|.
    
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil]];
    }
    
    /* At this place, we could call the application:didRegisterUserNotificationSettings: method to see which
       notifications are actually enabled */
    
    
    [[UINavigationBar appearance]setTintColor:[UIColor redColor]];
    [self setHomeViewController];
    //  self.window.rootViewController =navVC;
//    NSLog(@"%@",[UIFont fontNamesForFamilyName:@"Helvetica"]);
    //  [[UILabel appearance]setFont:[UIFont fontWithName:@"HelveticaNeue" size:[UIFont systemFontSize]]];
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)setHomeViewController
{
    if(!tabBarController){
        tabBarController = [[UITabBarController alloc] init];
    }
    tabBarController.tabBar.translucent=NO;
    tabBarController.tabBar.barTintColor=NAVBARCOLOR;
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
    NSDictionary *dictTitleAttributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:FONT_LBL_REG size:12.0],NSFontAttributeName, nil];
    
    SettingsVC *objHomeView;
    UINavigationController *homeNavBar;
    if(!objHomeView){
        objHomeView = [[SettingsVC alloc]initWithNibName:@"SettingsVC" bundle:nil];
        homeNavBar=[[UINavigationController alloc]initWithRootViewController:objHomeView];
        [Utility setNavigationBar:homeNavBar];
    }
    homeNavBar.navigationBarHidden=true;
    homeNavBar.tabBarItem.title=DPLocalizedString(@"settings_tab", nil);
    homeNavBar.tabBarItem.image=[[UIImage imageNamed:@"personal_settings.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeNavBar.tabBarItem setSelectedImage:[UIImage imageNamed:@"personal_settings.png"]];
    [homeNavBar.tabBarItem setTitleTextAttributes:dictTitleAttributes forState:UIControlStateNormal];
    
    
    
    InfoVC *objGlos;
    UINavigationController *glosBar;
    if(!objGlos){
        objGlos = [[InfoVC alloc]initWithNibName:@"InfoVC" bundle:nil];
        glosBar=[[UINavigationController alloc]initWithRootViewController:objGlos];
        [Utility setNavigationBar:glosBar];
    }
    glosBar.tabBarItem.title=DPLocalizedString(@"info_tab",nil);
    glosBar.tabBarItem.image=[[UIImage imageNamed:@"tab_glossery.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [glosBar.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_glossery.png"]];
    [glosBar.tabBarItem setTitleTextAttributes:dictTitleAttributes forState:UIControlStateNormal];
    
    
    DiaryVC *objmessages;
    UINavigationController *diaryNavBar;
    if(!objmessages){
        objmessages= [[DiaryVC alloc]initWithNibName:@"DiaryVC" bundle:nil];
        diaryNavBar=[[UINavigationController alloc]initWithRootViewController:objmessages];
        [Utility setNavigationBar:diaryNavBar];
    }
    diaryNavBar.tabBarItem.title=DPLocalizedString(@"diary_tab",nil);
    diaryNavBar.tabBarItem.image=[[UIImage imageNamed:@"tab_diary.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [diaryNavBar.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_diary.png"]];
    [diaryNavBar.tabBarItem setTitleTextAttributes:dictTitleAttributes forState:UIControlStateNormal];
    
    MedicationVC *medicationVC;
    UINavigationController *medicationNavBar;
    if(!medicationVC){
        medicationVC= [[MedicationVC alloc]initWithNibName:@"MedicationVC" bundle:nil];
        medicationNavBar=[[UINavigationController alloc]initWithRootViewController:medicationVC];
        medicationNavBar.tabBarItem.title=DPLocalizedString(@"medication_tab",nil);
        [Utility setNavigationBar:medicationNavBar];
    }
    medicationNavBar.tabBarItem.image=[[UIImage imageNamed:@"tab_medication.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [medicationNavBar.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_medication.png"]];
    [medicationNavBar.tabBarItem setTitleTextAttributes:dictTitleAttributes forState:UIControlStateNormal];
    
    FoodVC *foodVC;
    UINavigationController *foodNavBar;
    if(!foodVC){
        foodVC= [[FoodVC alloc]initWithNibName: @"FoodVC" bundle:nil];
        foodNavBar=[[UINavigationController alloc]initWithRootViewController:foodVC];
        [Utility setNavigationBar:foodNavBar];
    }
    foodNavBar.tabBarItem.title=DPLocalizedString(@"food_tab",nil);
    foodNavBar.tabBarItem.image=[[UIImage imageNamed:@"tab_food.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [foodNavBar.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_food.png"]];
    [foodNavBar.tabBarItem setTitleTextAttributes:dictTitleAttributes forState:UIControlStateNormal];
    
    tabBarController.viewControllers =[NSArray arrayWithObjects:glosBar,diaryNavBar,medicationNavBar,foodNavBar,homeNavBar, nil] ;
    if([[NSUserDefaults standardUserDefaults]integerForKey:@"badgeValue"] >0)
    {
        // [[tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"badgeValue"]]];
    }
    self.window.rootViewController=tabBarController;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/*- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

#ifdef __IPHONE_8_0

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
        NSLog(@"Decline For Notification");
    }
    else if ([identifier isEqualToString:@"answerAction"]){
        
        NSLog(@"Notification has been answered");
    }
}
#endif
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Device token content---%@", token);
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Error For Notification %@",err);
    
}

-(void)application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    int idmess=[[[userInfo valueForKey:@"aps"]valueForKey:@"id"] intValue];
  
    if([app applicationState] == UIApplicationStateInactive)
    {
        //If the application state was inactive, this means the user pressed an action button
        // from a notification.
        NSLog(@"in active");
        //Handle notification
    }
    if([app applicationState] == UIApplicationStateActive)
    {
        NSLog(@"Active");
    }
    if([app applicationState] == UIApplicationStateBackground)
    {
        NSLog(@"background");
    }
    
}
- (void)showAlarm:(NSString *)text {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alarm"
                                                        message:text delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}*/
@end
