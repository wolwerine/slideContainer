//
//  TableViewCell.h
//  ContainerViewController
//
//  Created by Fulop Barna on 26/01/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBViewController.h"

@interface TableViewCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, weak) id<ScrollViewManagerDelegate> delegate;

@end
