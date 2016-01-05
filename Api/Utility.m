                  //
//  Utility.m
//  Kinderopvang
//
//  Created by NLS17 on 18/07/14.
//  Copyright (c) 2014 NexusLinkServices. All rights reserved.
//

#import "Utility.h"
#import "AppDelegate.h"
@implementation Utility
+(void)setNavigationBar:(UINavigationController *)navController
{
    
    [navController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:NAV_FONT_COLOR,NSForegroundColorAttributeName,
      [UIFont fontWithName:FONT_NAV_NAME size:22.0],
      NSFontAttributeName, nil]];
    navController.navigationBar.translucent=NO;
    [navController.navigationBar setTintColor:[UIColor whiteColor]];
    navController.navigationBar.barTintColor=NAVBARCLOLOR;
         // navController.navigationBar.shadowImage=[[UIImage alloc] init];
    //[navController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //navController.navigationBar.shadowImage = [[UIImage alloc] init];



}

+ (UIImage *)imageWithColor:(NSString *)colorcode {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[self getColor:colorcode] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIColor*)getColor:(NSString*)colorcode
{
    NSString *cString = [[colorcode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(UIImage *)getBackgroundImage{
    if(IS_IPHONE){
    if(IS_IPHONE_5) return [UIImage imageNamed:@"bg_iphone5.png"];
    else return [UIImage imageNamed:@"bg_iphone4.png"];
    }else
        return [UIImage imageNamed:@"bg_ipad.png"];
    
}
+(void)setHomeLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?17.0:22.0]];
    [label setTextColor:NAVBARCLOLOR];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setShadowColor:[UIColor lightGrayColor]];
    label.numberOfLines=2;
    UIColor *glowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    label.layer.shadowColor = [glowColor CGColor];
    label.layer.shadowRadius = 30.0;
    label.layer.shadowOpacity = 0.9;
    label.layer.shadowOffset = CGSizeMake(20.0,30.0);
    label.layer.masksToBounds = NO;
}

+(void)setTextFieldProperties:(UITextField *)textField withPlaceHolder:(NSString *)placeHolder
{
    [textField setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?16.0:20.0]];
    [textField setTextColor:[UIColor blackColor]];
    [textField setPlaceholder:placeHolder];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textField setBackgroundColor:[UIColor whiteColor]];
    
}
+(void)setTextEnrolmentFieldProperties:(UITextField *)textField withPlaceHolder:(NSString *)placeHolder
{
    [textField setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?16.0:20.0]];
    [textField setTextColor:[UIColor blackColor]];
    [textField setPlaceholder:placeHolder];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textField setBackgroundColor:[UIColor whiteColor]];
    
}
+(void)setPaymentTextFieldProperties:(UITextField *)textField withPlaceHolder:(NSString *)placeHolder
{
    [textField setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?16.0:20.0]];
    [textField setTextColor:[UIColor lightGrayColor]];
    [textField setPlaceholder:placeHolder];
    [textField setTextAlignment:NSTextAlignmentCenter];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textField setBackgroundColor:[UIColor whiteColor]];
    
}



+(void)setEnrolmentLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?17.0:20.0]];
    [label setTextColor:NAVBARCLOLOR];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentLeft];
    
}

+(void)setPaymentLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?15.0:18.0]];
    [label setTextColor:NAVBARCLOLOR];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentLeft];
}

+(void)setEnrolmentQuestionLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?15.0:18.0]];
    label.numberOfLines=2;
    [label setTextColor:NAVBARCLOLOR];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentLeft];
    
}

+(void)setContactusLabelProperties:(UILabel *)label withText:(NSString *)string withColor:(UIColor *)color
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?17.0:27.0]];
    if(IS_IPHONE){
        label.adjustsFontSizeToFitWidth=true;
    }
    [label setTextColor:color];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentLeft];
    
}
+(void)setDayLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?14.0:18.0]];
    label.numberOfLines=1;
    [label setTextColor:NAVBARCLOLOR];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
    
}
+(void)setCellLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?15.0:18.0]];
    label.numberOfLines=1;
    [label setTextColor:[UIColor darkGrayColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
}
+(void)setEnrolmantHeaderLabelProperties:(UILabel *)label withText:(NSString *)string
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?15.0:18.0]];
    label.numberOfLines=1;
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:NAVBARCLOLOR];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
}

+(void)setParentsLabelProperties:(UILabel *)label withText:(NSString *)string withColor:(UIColor *)color
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?19.0:30.0]];
    label.numberOfLines=1;
    [label setTextColor:color];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
}
+(void)setThemeLabelheaderProperties:(UILabel *)label withText:(NSString *)string withColor:(UIColor *)color
{
    [label setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?14.0:17.0]];
    label.numberOfLines=1;
    [label setTextColor:color];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentLeft];
}
+(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message
{
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
}

+(void)showAlertWithwithMessage:(NSString *)message;
{
    [[[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
}

+(void)setRadioButtonProperties:(UIButton *)buttton withTitle:(NSString *)title
{
    [buttton setTitle:title forState:UIControlStateNormal];
    [buttton setTitle:title forState:UIControlStateSelected];

    [buttton setImage:[UIImage imageNamed:@"btn_Unselected.png"] forState:UIControlStateNormal];
    [buttton setImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    [buttton.titleLabel setFont:[UIFont fontWithName:FONT_LBL_REG size: 15.0]];
    [buttton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttton setTitleEdgeInsets:UIEdgeInsetsMake(0, 19, 0, 0)];
    [buttton setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];

}

+(void)setLoginButtonProperties:(UIButton *)buttton withTitle:(NSString *)title
{
    [buttton setTitle:title forState:UIControlStateNormal];
    [buttton setTitle:title forState:UIControlStateSelected];
    [buttton.titleLabel setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?15.0:20.0]];
    [buttton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttton setBackgroundColor:NAVBARCLOLOR];
    [buttton setImage:nil forState:UIControlStateNormal];
    [buttton.layer setCornerRadius:10.0];
    
}

+(void)setDayButtonProperties:(UIButton *)buttton withTitle:(NSString *)title
{
    [buttton setTitle:title forState:UIControlStateNormal];
    [buttton setTitle:title forState:UIControlStateSelected];
    [buttton.titleLabel setFont:[UIFont fontWithName:FONT_LBL_REG size:IS_IPHONE?13.0:16.0]];
    [buttton setTitleColor:NAVBARCLOLOR forState:UIControlStateNormal];
    [buttton setImage:nil forState:UIControlStateNormal];
    
}

+(UIImage *)changeImageColorWithColor:(UIColor *)color withImageName:(NSString *)imageName;{
    
    UIImage *image=[UIImage imageNamed:imageName];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage scale:1.0 orientation: UIImageOrientationDownMirrored];
    return flippedImage;
}


+(UIImage *)changeImageColorWithColor:(UIColor *)color withImage:(UIImage *)image;{
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage scale:1.0 orientation: UIImageOrientationDownMirrored];
    return flippedImage;
}


+(BOOL)isValidateEmail:(NSString *)emailId {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailId];
}

+(BOOL)isInternetConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
+(void)showinternetErrorMessage
{
    [Utility showAlertWithTitle:@"error" withMessage:@"internet_msg"];
}

+ (void)executeRequestwithServicetype:(NSString *)serviceType withPostString:(NSString *)postString withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block {
    NSString *urlStr=[NSString stringWithFormat:@"%@?api=%@",WEBSERVICE_URL,serviceType];
    NSLog(@"url %@  post string %@",urlStr,postString);
    NSURL *url1=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
    
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60.0];
  //  NSString *postLength = [NSString stringWithFormat:@"%d",[postString length]];

    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *error1;
                               if(data==nil){
                                   NSLog(@"Error Responce : %@",error);
                                   block(nil,error);
                               }else{
                                   
                                   NSMutableDictionary * innerJson = [NSJSONSerialization                                                JSONObjectWithData:data options:kNilOptions error:&error1];
                                   block(innerJson,error); // Call back the block passed into your method
                               }
                           }];
    
}

+ (void)executeRequestwithUrl:(NSString *)urlStr  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block {
    
       NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
   
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *error1;
                               if(data==nil){
                                   NSLog(@"Error Responce : %@",error);
                                   block(nil,error);
                               }else{
                                   
                                   NSMutableDictionary * innerJson = [NSJSONSerialization                                                JSONObjectWithData:data options:kNilOptions error:&error1];
                                   block(innerJson,error); // Call back the block passed into your method
                               }
                           }];
    
}

+ (void)executeRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block {
 
    NSError *error = Nil;
    NSMutableDictionary *requestdict=[[NSMutableDictionary alloc]init];
    [requestdict setObject:serviceType forKey:@"name"];
    if (![serviceType isEqualToString:LOGIN_Key])
    {
        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"daycare_id"] forKey:@"daycare_id"];
    }
    [requestdict setObject:dict forKey:@"body"];
   NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestdict options:kNilOptions error:&error];
     NSString *str=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"json body: %@",str);
    NSData* responseData = nil;
    NSURL *url1=[NSURL URLWithString:[WEBSERVICE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
    NSString *bodydata=[NSString stringWithFormat:@"json=%@",str];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60.0];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
        [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *error1;
                             if(data==nil){
                                   block(nil,error);
                               }else{
                               NSLog(@"Responce : %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                               NSMutableDictionary * innerJson = [NSJSONSerialization                                                JSONObjectWithData:data options:kNilOptions error:&error1];
                               block(innerJson,error); // Call back the block passed into your method
                               }
}];

}


+ (void)executeParentRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block {
    
    NSError *error = Nil;
    NSMutableDictionary *requestdict=[[NSMutableDictionary alloc]init];
    [requestdict setObject:serviceType forKey:@"name"];
    [requestdict setObject:dict forKey:@"body"];
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestdict options:kNilOptions error:&error];
    NSString *str=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
   // NSLog(@"json body: %@",str);
    NSData* responseData = nil;
    NSURL *url1=[NSURL URLWithString:[WEBSERVICE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
    NSString *bodydata=[NSString stringWithFormat:@"json=%@",str];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60.0];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *error1;
                               if(data==nil){
                                   block(nil,error);
                               }else{
                               //    NSLog(@"Responce : %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                                   NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                      JSONObjectWithData:data options:kNilOptions error:&error1];
                                   block(innerJson,error); // Call back the block passed into your method
                               }
                           }];
    
}

+(NSString *)uploadImage:(NSString*)requestURL image:(UIImage*)image
{
  
    image=[UIImage imageNamed:@"apple1.jpg"];    NSData *imageData = [UIImagePNGRepresentation(image) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageString=[[NSString alloc]initWithData:imageData encoding:NSUTF8StringEncoding];
    
    NSError *error = Nil;
    NSMutableDictionary *requestdict=[[NSMutableDictionary alloc]init];
     //   [requestdict setObject:@"save_image" forKey:@"name"];

    [requestdict setObject:imageString forKey:@"content"];
    [requestdict setObject:@"apple1.jpg" forKey:@"name"];
  //  [requestdict setObject:dicData forKey:@"body"];

    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestdict options:kNilOptions error:&error];
    NSString *str=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSData* responseData = nil;
    NSString *mainurl=@"http://kinderopvangapp.eu/api/uploadimg.php";
    NSURL *url1=[NSURL URLWithString:[mainurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
    NSString *bodydata=[NSString stringWithFormat:@"json=%@",str];
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
     [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                             //  NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                  JSONObjectWithData:data options:kNilOptions error:&error1];
                               NSLog(@"Responce %@   Error %@",innerJson,error);
                               // Call back the block passed into your method
                           }];

    return nil;
}
+(void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

+ (UIImage*)resizeImageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



+(BOOL)isRecordFound:(NSMutableDictionary *)dictresponce;
{
    NSMutableArray *arrRecords=[dictresponce objectForKey:@"records"];
    if(arrRecords.count==0)
    {
        [Utility showAlertWithwithMessage:@"No records found"];
        return false;
    }else
        return true;
}

@end
