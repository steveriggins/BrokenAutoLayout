//
//  SRTableViewCell.m
//  AutoLayout
//
//  Created by Steven W. Riggins on 3/11/14.
//  Copyright (c) 2014 Steve Riggins. All rights reserved.
//

#import "SRTableViewCell.h"

@interface SRTableViewCell()
@property (nonatomic, strong) UILabel *stockStatusLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation SRTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self p_addViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self p_addViews];
    }
    return self;
}


- (void)p_addViews
{
    self.contentView.backgroundColor = [UIColor yellowColor];
    
    self.stockStatusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.stockStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.stockStatusLabel];
    
    // INCOMPLETE - need real icon
    UIImage *image = [UIImage imageNamed:@"box"];
    self.iconImageView = [[UIImageView alloc] initWithImage:image];
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.iconImageView];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.messageLabel];
    self.messageLabel.text = @"This is placeholder text for this demo";
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSArray *constraints;
    
    NSDictionary *views = @{@"icon" : self.iconImageView,
                            @"message" : self.messageLabel,
                            @"stock" : self.stockStatusLabel};
    
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[stock]->=20-|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self.contentView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[icon]-10-[message]->=20-|"
                                                          options:NSLayoutFormatAlignAllCenterY
                                                          metrics:nil
                                                            views:views];
    [self.contentView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[stock]"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self.contentView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[stock]-10-[icon]"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self.contentView addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[message]-20-|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self.contentView addConstraints:constraints];
    
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)setStockStatusMessage:(NSString *)message
{
    self.stockStatusLabel.text = message;
}
@end