//
//  BBViewController.m
//  ContainerViewController
//
//  Created by Fulop Barna on 26/01/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import "BBViewController.h"
#import "TableViewCell.h"

@interface BBViewController ()
{
    NSArray *tableData;
    NSMutableArray *_objects;
}
@end

@implementation BBViewController
@synthesize delegate;

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
    // Do any additional setup after loading the view.
    
    tableData = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"ScrollCell"];
    
    //set the table view delegate to the current so we can listen for events
    self.tableView.delegate = self;
    //set the datasource for the table view to the current object
    self.tableView.dataSource = self;
    
    self.tableView.bounces = NO;
    
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
    static NSString *cellIdentifier = @"ScrollCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, 320, 25)];
//        scroller.showsHorizontalScrollIndicator = NO;
//        
//        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320*4, 25)];
//        contentLabel.backgroundColor = [UIColor blackColor];
//        contentLabel.textColor = [UIColor whiteColor];
//        NSMutableString *str = [[NSMutableString alloc] init];
//        for (NSUInteger i = 0; i < 100; i++) { [str appendFormat:@"%i ", i]; }
//        contentLabel.text = str;
//        
//        [scroller addSubview:contentLabel];
//        scroller.contentSize = contentLabel.frame.size;
//        [cell addSubview:scroller];
//    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell #%i", indexPath.row];
    
    
    
    
    return cell;
}


- (void)changeScrollViewWithOffset:(float)offset andVelocity:(float)velocity;
{
    [delegate changeScrollViewWithOffset:offset andVelocity:velocity];
}

- (void)finishScrollWithTurningPage:(BOOL)needsTurn
{
    [delegate finishScrollWithTurningPage:needsTurn];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
