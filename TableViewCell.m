//
//  TableViewCell.m
//  ContainerViewController
//
//  Created by Fulop Barna on 26/01/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import "TableViewCell.h"

#define underLabelWidth 30




@implementation TableViewCell
{
    CGPoint position;
    
    CGPoint refTouchLocation;
    BOOL canRefTouchLocationEdited;
    float relativeLocation;
    
    BOOL isMovingOffset;
    CGPoint lastVelocity;
    BOOL isTresholReached;
    
}
@synthesize scrollView, mytextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        mytextLabel = [[UILabel alloc] init];
        
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
	
    [mytextLabel setFrame:scrollViewContentView.frame];
    [scrollViewContentView addSubview:mytextLabel];
    
    [self.scrollView addSubview:scrollViewContentView];
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // the user starts to drag the cell
    NSLog(@"scroll began");
    
    isMovingOffset = YES;
    canRefTouchLocationEdited = YES;
    isTresholReached = NO;
    
    [_delegate setTextForLabel:mytextLabel.text];
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollview
{
    
    CGPoint location = [scrollview.panGestureRecognizer locationInView:scrollview];
    
    CGPoint translation = [scrollview.panGestureRecognizer translationInView:scrollview];
    
    CGPoint velocity = [scrollview.panGestureRecognizer velocityInView:scrollview];
    
    
    NSLog(@" translation: %f velocity: %f", translation.x, velocity.x);

    // if the user releases the screen, the velocity turns to "0" but the location value is still changing
    // when the velocity is 0 we should perform the turn-page animation
    if (velocity.x == 0 && isMovingOffset){
        
        NSLog(@"touch finished");
        
        isMovingOffset = NO;
        refTouchLocation.x = 0;
        
        // if the last velocity is >0 then the user was pulling to the right, in this case we need to scroll to the 2nd page
        // otherwise we show the 1st page
        if (lastVelocity.x >= 0){
            [scrollView setContentOffset:CGPointMake(-underLabelWidth, 0)];
            [_delegate finishScrollWithTurningPage:YES];
        } else {
            [_delegate finishScrollWithTurningPage:NO];
        }
    } else {
    

    
        // defines the allowed direction of the scroll
        if (scrollview.contentOffset.x > 0.0f) {
            scrollview.contentOffset = CGPointZero;
//            canRefTouchLocationEdited = YES;
        }
        else{
            if (scrollview.contentOffset.x*-1 > underLabelWidth ) {
                scrollview.contentOffset = CGPointMake(-underLabelWidth, 0);
                
//                isMovingOffset = YES;
                isTresholReached = YES;
                
                if (canRefTouchLocationEdited){
                    refTouchLocation = location;
                    canRefTouchLocationEdited = NO;
                }
                
                relativeLocation = location.x-refTouchLocation.x;
                
                
                NSLog(@" origin:%f  relativ:%f", location.x, relativeLocation);
                [_delegate changeScrollViewWithOffset:relativeLocation andVelocity:velocity.x];
                lastVelocity = velocity;
            }
            else if (isMovingOffset && isTresholReached)
            {
                relativeLocation = location.x-refTouchLocation.x;
                NSLog(@" origin:%f  relativ:%f", location.x, relativeLocation);
                
                [_delegate changeScrollViewWithOffset:relativeLocation andVelocity:velocity.x];
                lastVelocity = velocity;
            }
        }
    }

        
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    NSLog(@"dragging ended");
    [_delegate finishScrollWithTurningPage:NO];
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
