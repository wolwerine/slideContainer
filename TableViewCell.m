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




- (void)scrollViewDidScroll:(UIScrollView *)scrollview {
//    scrollview
    
    CGPoint location = [scrollView.panGestureRecognizer locationInView:scrollView];
//    NSLog(@"%f", location.x);

    
    
    // defines the allowed direction of the scroll
    if (scrollview.contentOffset.x > 0.0f) {
		scrollview.contentOffset = CGPointZero;
        canRefTouchLocationEdited = YES;
	}
    else{
        if (scrollview.contentOffset.x*-1 > underLabelWidth ) {
            scrollview.contentOffset = CGPointMake(-underLabelWidth, 0);
            
            if (canRefTouchLocationEdited){
                refTouchLocation = location;
                canRefTouchLocationEdited = NO;
            }
            
            float relativeLocation = location.x-refTouchLocation.x;
            NSLog(@" %f", relativeLocation);
            
            [_delegate changeScrollViewStateWithOffset:relativeLocation];
            
            scrollview 
            
            
            //            [delegate changeScrollViewStateWithOffset:scrollView.contentOffset.x];
            //            scrollView touchesShouldBegin:<#(NSSet *)#> withEvent:<#(UIEvent *)#> inContentView:<#(UIView *)#>
            //            super.ViewController
        }
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    NSLog(@" %f ", location.x);
    
    //Do stuff here...
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"");
}



//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    position = point;
//    return self.scrollView;
//}



@end
