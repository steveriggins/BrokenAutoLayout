//
//  SRViewController.m
//  AutoLayout
//
//  Created by Steven W. Riggins on 3/11/14.
//  Copyright (c) 2014 Steve Riggins. All rights reserved.
//

#import "SRViewController.h"
#import "SRTableViewCell.h"

NSString * const CellIdentifier = @"DemoCellIdentifier";


@interface SRViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView                   *tableView;
@end

@implementation SRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[SRTableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];

    NSDictionary *viewsDictionary = @{@"tableView" : self.tableView};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                                                               options:0
                                                               metrics:nil
                                                                 views:viewsDictionary];
    [self.view addConstraints:constraints];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [self configureCell:cell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static SRTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[SRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    });
    
    [self configureCell:sizingCell];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGFloat cellHeight = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return cellHeight;

}

- (void)configureCell:(SRTableViewCell *)cell
{
    [cell setStockStatusMessage:@"Sample Status"];
}
@end
