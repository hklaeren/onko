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
+(UIColor*)getColor:(NSString*)colorcode;
+(UIImage *)getBackgroundImage;
+(void)setHomeLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)setTextFieldProperties:(UITextField *)textField withPlaceHolder:(NSString *)placeHolder;
+(void)setEnrolmentLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message;
+(void)showAlertWithwithMessage:(NSString *)message;
+(void)setRadioButtonProperties:(UIButton *)buttton withTitle:(NSString *)title;
+(void)setEnrolmentQuestionLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)setEnrolmantHeaderLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)setDayLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)setDayButtonProperties:(UIButton *)buttton withTitle:(NSString *)title;
+(void)setParentsLabelProperties:(UILabel *)label withText:(NSString *)string withColor:(UIColor *)color;
+(void)setThemeLabelheaderProperties:(UILabel *)label withText:(NSString *)string withColor:(UIColor *)color;
+(UIImage *)changeImageColorWithColor:(UIColor *)color withImageName:(NSString *)imageName;
+(void)setContactusLabelProperties:(UILabel *)label withText:(NSString *)string withColor:(UIColor *)color;
+(void)setCellLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)setLoginButtonProperties:(UIButton *)buttton withTitle:(NSString *)title;
+(BOOL)isValidateEmail:(NSString *)emailId;
+(void)setPaymentLabelProperties:(UILabel *)label withText:(NSString *)string;
+(void)setPaymentTextFieldProperties:(UITextField *)textField withPlaceHolder:(NSString *)placeHolder;

+ (void)executeRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block ;
+ (void)executeParentRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block;
+(NSString *)uploadImage:(NSString*)requestURL image:(UIImage*)image;
+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;
+(BOOL)isInternetConnected;
+(void)showinternetErrorMessage;
+ (UIImage*)resizeImageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(BOOL)isRecordFound:(NSMutableDictionary *)dictresponce;
+(UIImage *)changeImageColorWithColor:(UIColor *)color withImage:(UIImage *)image;
+(void)setTextEnrolmentFieldProperties:(UITextField *)textField withPlaceHolder:(NSString *)placeHolder;
+ (void)executeRequestwithServicetype:(NSString *)serviceType withPostString:(NSString *)postString withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block ;
+ (UIImage *)imageWithColor:(NSString *)colorcode;
+ (void)executeRequestwithUrl:(NSString *)urlStr  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block ;
@end
