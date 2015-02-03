//
//  ViewController.h
//  ContainerViewController
//
//  Created by Yan Saraev on 11/7/13.
//  Copyright (c) 2013 Yan Saraev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideScrollViewManagerDelegate

- (void)changeScrollViewWithOffset:(float)offset andVelocity:(float)velocity;
- (void)finishScrollWithTurningPage:(BOOL)needsTurn;
- (void) setTextForLabel:(NSString*)text;


@end;


@interface ViewController : UIViewController <SlideScrollViewManagerDelegate, UIScrollViewDelegate>

@property (weak) IBOutlet UIScrollView *scrollView;

@end
