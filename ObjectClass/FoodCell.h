//
//  FoodCell.h
//  UniFontis
//
//  Created by Kalpit Gajera on 04/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface FoodCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (strong,nonatomic)IBOutlet UILabel *name,*quantity,*kcal,*fat,*protein,*carb,*lblDate;
@end
