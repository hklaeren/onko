//
//  Diary.h
//  UniFontis
//
//  Created by Kalpit Gajera on 07/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diary : NSObject
@property (assign,nonatomic)int id_diary;
@property (strong,nonatomic)NSString *date,*type,*info;
@end

@interface Medicine : NSObject
@property (assign,nonatomic)int id_Medicine;
@property (strong,nonatomic)NSString *name,*qty,*time_duration;
@end

@interface FoodClass : NSObject
@property (assign,nonatomic)int id_food;
@property (strong,nonatomic)NSString *name,*quantity,*unit,*kcal,*fat,*protein,*carb,*Date;

@end