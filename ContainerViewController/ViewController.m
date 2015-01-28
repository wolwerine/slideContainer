//
//  ViewController.m
//  ContainerViewController
//
//  Created by Yan Saraev on 11/7/13.
//  Copyright (c) 2013 Yan Saraev. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "BBViewController.h"

@interface ViewController ()
{
    BOOL isOnFirstPage;
    float generatedOffset;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    generatedOffset = 0;
    isOnFirstPage = false;
    
    [self.scrollView setDelegate:self];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    BBViewController *bViewController = [[BBViewController alloc]init];
    bViewController.delegate = self;
    
    CGRect frame = bViewController.view.frame;
    frame.origin.x = 320;
    bViewController.view.frame = frame;
    
    [self addChildViewController:bViewController];
    [self.scrollView addSubview:bViewController.view];
    [bViewController didMoveToParentViewController:self];
    
    CViewController *cViewController = [[CViewController alloc]init];
//    CGRect frame = cViewController.view.frame;
//    frame.origin.x = 320;
//    cViewController.view.frame = frame;
    [self addChildViewController:cViewController];
    [self.scrollView addSubview:cViewController.view];
    [cViewController didMoveToParentViewController:self];
    
    self.scrollView.contentSize = CGSizeMake(640, self.view.frame.size.height);
    self.scrollView.pagingEnabled = YES;

    self.scrollView.bounces = NO;
    self.scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0.0f);
    
    [self.scrollView setScrollEnabled:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark - 

-(void)changeScrollViewWithOffset:(float)offset
{
//    [self.scrollView setScrollEnabled:YES];
//    [self.scrollView setUserInteractionEnabled:YES];

    NSLog(@" %f", self.scrollView.frame.size.width-offset);
    
    if (self.scrollView.frame.size.width-offset < 320){
//        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width-offset, 0)];
        
        if (offset != -100)
            generatedOffset++;
        else
            generatedOffset--;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width-generatedOffset*3, 0)];

        
    }


    isOnFirstPage = true;
}

-(void)finishScrollWithTurningPage:(BOOL)needsTurn
{
    
    generatedOffset = 0;
    if( needsTurn )
    {
//        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.scrollView setContentOffset:CGPointMake(0, 0)];
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
        
        
        [self.scrollView setScrollEnabled:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        [self.scrollView setScrollEnabled:NO];
    }
    
    
    
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    

    if (page == 1 )
        [scrollView setScrollEnabled:NO];
}





@end
