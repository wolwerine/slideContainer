//
//  BViewController.m
//  ContainerViewController
//
//  Created by Yan Saraev on 11/7/13.
//  Copyright (c) 2013 Yan Saraev. All rights reserved.
//

#import "BViewController.h"
#import "TLSwipeForOptionsCell.h"
#import "TLOverlayView.h"

@interface BViewController ()<TLSwipeForOptionsCellDelegate, TLOverlayViewDelegate>
{
    NSArray *tableData;
    NSMutableArray *_objects;
}

// We need to keep track of the most recently selected cell for the action sheet.
@property (nonatomic, weak) UITableViewCell *cellDisplayingMenuOptions;
@property (nonatomic, weak) UITableViewCell *mostRecentlySelectedMoreCell;
@property (nonatomic, strong) TLOverlayView *overlayView;

@end

@implementation BViewController

@synthesize delegate, tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tableData = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.tableView registerClass:[TLSwipeForOptionsCell class] forCellReuseIdentifier:@"Cell"];
    
    //set the table view delegate to the current so we can listen for events
    self.tableView.delegate = self;
    //set the datasource for the table view to the current object
    self.tableView.dataSource = self;
    
    [self.view addSubview: self.tableView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSwipeForOptionsCell *cell = (TLSwipeForOptionsCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//	NSDate *object = _objects[indexPath.row];
	cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
	cell.delegate = self;
	
	return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleNone;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	[[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellShouldHideMenuNotification object:self.tableView];
	[self.delegate tableViewController:self didChangeEditing:editing];
}

#pragma UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellShouldHideMenuNotification object:scrollView];
}

#pragma mark - TLOverlayViewDelegate Methods

- (UIView *)overlayView:(TLOverlayView *)view didHitTest:(CGPoint)point withEvent:(UIEvent *)event {
	BOOL shouldInterceptTouches = YES;
	
    NSLog(@" %f %f", point.x ,point.y);
    
	CGPoint location = [self.view convertPoint:point fromView:view];
	CGRect rect = [self.view convertRect:self.cellDisplayingMenuOptions.frame toView:self.view];
	
	shouldInterceptTouches = CGRectContainsPoint(rect, location);
	if (!shouldInterceptTouches)
		[[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellShouldHideMenuNotification object:self.tableView];
	
	return shouldInterceptTouches?[self.cellDisplayingMenuOptions hitTest:point withEvent:event]:view;
}


#pragma mark - 

- (void)changeScrollViewStateWithOffset:(float)offset{
    [delegate changeScrollViewWithOffset:offset];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@" %@", touches);
}




@end
