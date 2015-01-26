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
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    isOnFirstPage = false;
    
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


-(void)changeScrollViewWithOffset:(float)offset{
//    if (self.scrollView.isScrollEnabled)
//        [self.scrollView setScrollEnabled:NO];
//    else
        [self.scrollView setScrollEnabled:YES];

    [self.scrollView setUserInteractionEnabled:YES];
    //        self.scrollView.delegate = self;
//    [self gestureRecognizer:self.scrollView.gestureRecognizers shouldRecognizeSimultaneouslyWithGestureRecognizer:self.scrollView.gestureRecognizers];

    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width-offset, 0) animated:YES];
//        [self scrollViewWillBeginDragging: self.scrollView];
    
//    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*0, 0.0f) animated:YES];
    isOnFirstPage = true;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    // disable timer here
//    
//    NSLog(@"main: %f", scrollView.contentOffset.x);
//    
//}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    

    if (page == 1 && isOnFirstPage){
        [scrollView setScrollEnabled:NO];
        isOnFirstPage = false;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    NSLog(@" @%", targetContentOffset);
//    se
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"");
    
    
}


@end
