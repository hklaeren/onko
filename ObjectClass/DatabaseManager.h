//
//  DatabaseManager.h
//  UniFontis
//
//  Created by Kalpit Gajera on 07/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <Foundation/Foundation.h>
#import "Diary.h"
@interface DatabaseManager : NSObject
{
    NSString *databasePath;
}

+(DatabaseManager*)getSharedInstance;
-(BOOL)CheckDbExist;

-(BOOL)addDiaryInfo:(Diary *)objDiary;
-(NSMutableArray *)getAllDiaryData;
-(void)deleteDiaryInfoWithId:(int )id_diary;
-(BOOL)updateDiaryInfo:(Diary *)objDiary;



-(void)insertMedicationData:(Medicine *)objMedicine;
-(NSMutableArray *)getAllMedicineData;
-(BOOL)updateMedicationInfo:(Medicine *)objMedication;
-(void)deleteMedicationInfoWithId:(int)id_Medication;



-(void)insertFoodData:(FoodClass *)objFood;
-(NSMutableArray *)getAllFoodData;
-(void)deleteFoodDataWithId:(int)id_food;
-(BOOL)updateFoodInfo:(FoodClass *)objFood;


@end
