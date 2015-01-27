//
//  ViewController.h
//  ContainerViewController
//
//  Created by Yan Saraev on 11/7/13.
//  Copyright (c) 2013 Yan Saraev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainScrollViewManagerDelegate

- (void)changeScrollViewWithOffset:(float)offset;
- (void)finishScrollWithTurningPage:(BOOL)needsTurn;

@end;


@interface ViewController : UIViewController <MainScrollViewManagerDelegate, UIScrollViewDelegate>

@property (weak) IBOutlet UIScrollView *scrollView;

@end
