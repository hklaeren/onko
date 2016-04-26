//
//  Utility.h
//  Kinderopvang
//
//  Created by NLS17 on 18/07/14.
//  Copyright (c) 2014 NexusLinkServices. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Static.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

@interface Utility : NSObject
+(void)setNavigationBar:(UINavigationController *)navController;
+(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message;
+(void)showAlertWithMessage:(NSString *)message;
+(BOOL)isValidateEmail:(NSString *)emailId;
+ (void)executeRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block ;
+ (void)executeParentRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block;
+(BOOL)isInternetConnected;
+(void)showinternetErrorMessage;
+ (void)executeRequestwithServicetype:(NSString *)serviceType withPostString:(NSString *)postString withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block ;
+ (void)executeRequestwithUrl:(NSString *)urlStr  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block ;
@end
