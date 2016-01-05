//
//  MedicineCell.h
//  UniFontis
//
//  Created by Kalpit Gajera on 06/04/15.
//  Copyright (c) 2015 NexusLinkServices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;

@end
