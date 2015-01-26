//
//  BBViewController.h
//  ContainerViewController
//
//  Created by Fulop Barna on 26/01/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@protocol ScrollViewManagerDelegate
- (void)changeScrollViewStateWithOffset:(float)offset;
@end

@interface BBViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ScrollViewManagerDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<MainScrollViewManagerDelegate> delegate;


@end