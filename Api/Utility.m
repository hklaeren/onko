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
    navController.navigationBar.barTintColor=NAVBARCOLOR;
         // navController.navigationBar.shadowImage=[[UIImage alloc] init];
    //[navController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //navController.navigationBar.shadowImage = [[UIImage alloc] init];



}

+(void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message
{
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
}

+(void)showAlertWithMessage:(NSString *)message;
{
    [[[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
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
                                   NSLog(@"executeRequestwithServicetype: %@",error);
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
                                   NSLog(@"executeRequestwithUrl: %@",error);
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
    /* NSData* responseData = nil; *** not used */
    NSURL *url1=[NSURL URLWithString:[WEBSERVICE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    /* responseData = [NSMutableData data] ; ***never read! */
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
                               NSLog(@"executeRequestwithServicetype: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
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
    /* NSData* responseData = nil; *** not used */
    NSURL *url1=[NSURL URLWithString:[WEBSERVICE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    /* responseData = [NSMutableData data] ; *** never read */
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

@end
