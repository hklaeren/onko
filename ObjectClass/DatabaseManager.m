//
//  DatabaseManager.m
//  UniFontis
//
//  Created by Kalpit Gajera on 07/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "DatabaseManager.h"
static DatabaseManager *sharedInstance = nil;
static sqlite3 *database = nil;
//static sqlite3_stmt *statement = nil;

@implementation DatabaseManager
{
    sqlite3_stmt *statement;
}
+(DatabaseManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance CheckDbExist];
    }
    return sharedInstance;
}

-(BOOL)CheckDbExist{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent:@"UniFontis.sqlite"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        NSError *error;
        NSString *sqLiteDb = [[NSBundle mainBundle]pathForResource:@"UniFontis"
                                                             ofType:@"sqlite"];
        
        [filemgr copyItemAtPath:sqLiteDb toPath:databasePath error:&error];
        
        
        if(error)
        {
            NSLog(@"Database error %@",error);
        }
        
            if (sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
            isSuccess=false;
        }else
        {
            isSuccess=true;
        }
    }
    return isSuccess;
}

#pragma mark- Diary input Methods
-(BOOL)addDiaryInfo:(Diary *)objDiary;
{
    BOOL success = false;
    statement = NULL;
    
    
     if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
         NSString *insertSQL = [NSString stringWithFormat:
                                @"INSERT INTO Diary_master (Date, Type, information) VALUES (\"%@\", \"%@\", \"%@\")",
                                objDiary.date,
                                objDiary.type,
                                objDiary.info];
         
         const char *insert_stmt = [insertSQL UTF8String];
         sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
         if (sqlite3_step(statement) == SQLITE_DONE)
         {
             success = true;
         }else
         {
             success = false;
         }
     }
         sqlite3_finalize(statement);
         sqlite3_close(database);
    return success;
}
-(NSMutableArray *)getAllDiaryData
{
    NSMutableArray *arrDiary = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    //statement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM Diary_master";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Diary *objDiary = [[Diary alloc] init];
                objDiary.id_diary = sqlite3_column_int(statement, 0);
                objDiary.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                objDiary.type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                objDiary.info = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];

                [arrDiary addObject:objDiary];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return arrDiary;
    
}

-(BOOL)updateDiaryInfo:(Diary *)objDiary;
{
    BOOL success = false;
    statement = NULL;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE Diary_master set Date='%@', Type='%@', information='%@' where id=%d",
                               objDiary.date,
                               objDiary.type,
                               objDiary.info,objDiary.id_diary];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
        }else
        {
            success = false;
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return success;
}


-(void)deleteDiaryInfoWithId:(int)id_diary
{
   
    const char *dbpath = [databasePath UTF8String];
    //sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"DELETE FROM Diary_master where id=%d",id_diary];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Delete diary info: Success");
            }else
            {
                NSLog(@"Delete diary info: Failure");
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
 }

#pragma mark - Medicine Methods
-(void)insertMedicationData:(Medicine *)objMedicine;
{
    statement = NULL;
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Medicine_master (name,quantity,time) VALUES (\"%@\", \"%@\", \"%@\")",
                               objMedicine.name,
                               objMedicine.qty,
                               objMedicine.time_duration];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Insert medication: Success");
        }else
        {
            NSLog(@"Insert medication: Failure");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);

}

-(NSMutableArray *)getAllMedicineData
{
    NSMutableArray *arrDiary = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
//    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM Medicine_master";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Medicine *objDiary = [[Medicine alloc] init];
                objDiary.id_Medicine = sqlite3_column_int(statement, 0);
                objDiary.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                objDiary.qty = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                objDiary.time_duration = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                [arrDiary addObject:objDiary];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return arrDiary;
    
}


-(BOOL)updateMedicationInfo:(Medicine *)objMedication;
{
    BOOL success = false;
    statement = NULL;
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE Medicine_master set name='%@',quantity='%@',time='%@' where id=%d",
                               objMedication.name,
                               objMedication.qty,
                               objMedication.time_duration,objMedication.id_Medicine];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
        }else
        {
            success = false;
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return success;
}


-(void)deleteMedicationInfoWithId:(int)id_Medication
{
    
    const char *dbpath = [databasePath UTF8String];
    //sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"DELETE FROM Medicine_master where id=%d",id_Medication];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Delete medication: Success");
            }else
            {
                NSLog(@"Delete medication: Failure");
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

#pragma mark- Add Food Methods


-(void)insertFoodData:(FoodClass *)objFood;
{
    statement = NULL;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Food_master (name,quantity,unit,kcal,fat,protein,carb,Date) VALUES (\"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",
                               objFood.name,objFood.quantity,objFood.unit,objFood.kcal,objFood.fat,objFood.protein,objFood.carb,objFood.Date
                               ];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Insert food: Success");
        }else
        {
            NSLog(@"Insert food: Failure");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(NSMutableArray *)getAllFoodData
{
    NSMutableArray *arrFood = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    //sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT * FROM Food_master";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                FoodClass *objFood = [[FoodClass alloc] init];
                objFood.id_food = sqlite3_column_int(statement, 0);
                objFood.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                objFood.quantity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                objFood.unit = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                objFood.kcal = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                objFood.fat = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                objFood.protein = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,6)];
                objFood.carb = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                objFood.Date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                
                [arrFood addObject:objFood];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return arrFood;
    
}



-(void)deleteFoodDataWithId:(int)id_food
{
    
    const char *dbpath = [databasePath UTF8String];
    //sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"DELETE FROM Food_master where id=%d",id_food];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Delete food: Success");
            }else
            {
                NSLog(@"Delete food: fail");
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
}


-(BOOL)updateFoodInfo:(FoodClass *)objFood;
{
    BOOL success = false;
    statement = NULL;
    
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE Food_master set name='%@',quantity='%@',unit='%@',kcal='%@',fat='%@',protein='%@',carb='%@',Date='%@' where id=%d ",
                               objFood.name,objFood.quantity,objFood.unit,objFood.kcal,objFood.fat,objFood.protein,objFood.carb,objFood.Date,objFood.id_food
                               ];

        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
        }else
        {
            success = false;
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return success;
}


@end
