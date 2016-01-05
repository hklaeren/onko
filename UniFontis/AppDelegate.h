//
//  AppDelegate.h
//  UniFontis
//
//  Created by Kalpit Gajera on 03/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
+(AppDelegate *)initAppdelegate;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)UITabBarController *tabBarController;
@property (assign,nonatomic)BOOL isAddFood,isAddDiary,isAddMedicine;
-(void)setHomeViewController;
@end

