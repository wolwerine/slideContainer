//
//  TableViewCell.m
//  ContainerViewController
//
//  Created by Fulop Barna on 26/01/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import "TableViewCell.h"

#define underLabelWidth 20




@implementation TableViewCell
{
    CGPoint position;
    
    CGPoint refTouchLocation;
    BOOL canRefTouchLocationEdited;
    float relativeLocation;
    
    BOOL isMovingOffset;
    CGPoint lastVelocity;
    
}
@synthesize scrollView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) layoutSubviews
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, underLabelWidth, self.contentView.bounds.size.height)];
    [label setBackgroundColor:[UIColor greenColor]];
    [self.contentView addSubview:label];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
	scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + underLabelWidth, CGRectGetHeight(self.bounds));
	scrollView.delegate = self;
	scrollView.showsHorizontalScrollIndicator = NO;
	
    self.scrollView.backgroundColor = [UIColor orangeColor];
    
	[self.contentView addSubview:scrollView];
	self.scrollView = scrollView;
    
    self.scrollView.delegate = self;
    
    self.scrollView.canCancelContentTouches = NO;
    
    
	UIView *scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
	scrollViewContentView.backgroundColor = [UIColor whiteColor];
	[self.scrollView addSubview:scrollViewContentView];
//	self.scrollViewContentView = scrollViewContentView;
	
//	UILabel *scrollViewLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.scrollViewContentView.bounds, 10.0f, 0.0f)];
//	self.scrollViewLabel = scrollViewLabel;
//	[self.scrollViewContentView addSubview:scrollViewLabel];
    
//    /The setup code (in viewDidLoad in your view controller)
//    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(handleSingleTap:)];
//    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self.scrollView addGestureRecognizer:gestureRecognizer];
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollview
{
    
    CGPoint location = [scrollview.panGestureRecognizer locationInView:scrollview];
    
    CGPoint translation = [scrollview.panGestureRecognizer translationInView:scrollview];
    
    CGPoint velocity = [scrollview.panGestureRecognizer velocityInView:scrollview];
    
    
    NSLog(@" translation: %f velocity: %f", translation.x, velocity.x);

    
    if (velocity.x == 0 && isMovingOffset){
        isMovingOffset = NO;
        refTouchLocation.x = 0;
        
        if (lastVelocity.x >0)
            [_delegate finishScrollWithTurningPage:YES];
        else
            [_delegate finishScrollWithTurningPage:NO];
            
    } else {
    

    
        // defines the allowed direction of the scroll
        if (scrollview.contentOffset.x > 0.0f) {
            scrollview.contentOffset = CGPointZero;
            canRefTouchLocationEdited = YES;
        }
        else{
            if (scrollview.contentOffset.x*-1 > underLabelWidth ) {
                scrollview.contentOffset = CGPointMake(-underLabelWidth, 0);
                
                isMovingOffset = YES;
                
                if (canRefTouchLocationEdited){
                    refTouchLocation = location;
                    canRefTouchLocationEdited = NO;
                }
                
                relativeLocation = location.x-refTouchLocation.x;
                
                
                NSLog(@" origin:%f  relativ:%f", location.x, relativeLocation);
                
                [_delegate changeScrollViewWithOffset:relativeLocation andVelocity:velocity.x];
//            [_delegate changeScrollViewStateWithOffset:relativeLocation];
//            [_delegate changeScrollViewStateWithOffset:velocity.x];
                lastVelocity = velocity;
            }
            else if (isMovingOffset)
            {
                relativeLocation = location.x-refTouchLocation.x;
                NSLog(@" origin:%f  relativ:%f", location.x, relativeLocation);
                
                [_delegate changeScrollViewWithOffset:relativeLocation andVelocity:velocity.x];
//            [_delegate changeScrollViewStateWithOffset:relativeLocation];
//            [_delegate changeScrollViewStateWithOffset:velocity.x];
                lastVelocity = velocity;
            }
        }
    }

        
}



- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scroll ended");
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"scroll finished");
//    isMovingOffset = NO;
//    
//    if (relativeLocation > 75)
//        [_delegate finishScrollWithTurningPage:YES];
//    else
//        [_delegate finishScrollWithTurningPage:NO];
//    
//    refTouchLocation.x = 0;
//    
//}






//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    position = point;
//    return self.scrollView;
//}



@end
