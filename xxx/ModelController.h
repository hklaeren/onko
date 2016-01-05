//
//  ModelController.h
//  xxx
//
//  Created by Herbert Klaeren on 04.01.16.
//  Copyright © 2016 Herbert Klaeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

