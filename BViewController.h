//
//  BViewController.h
//  ContainerViewController
//
//  Created by Yan Saraev on 11/7/13.
//  Copyright (c) 2013 Yan Saraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class BViewController;
@protocol TLTableViewControllerDelegate <NSObject>

- (void)tableViewController:(BViewController *)viewController didChangeEditing:(BOOL)editing;

@end

@protocol ScrollViewManagerDelegate
- (void)changeScrollViewStateWithOffset:(float)offset;
@end


@interface BViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ScrollViewManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<TLTableViewControllerDelegate, MainScrollViewManagerDelegate> delegate;

@end
