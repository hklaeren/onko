//
//  FoodCell.m
//  UniFontis
//
//  Created by Kalpit Gajera on 04/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell
@synthesize name,quantity,kcal,fat,protein,carb,lblDate;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
