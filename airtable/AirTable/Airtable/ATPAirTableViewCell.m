//
//  AirTableViewCell.m
//  airtable
//
//  Created by Анастасия Рябова on 16/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "AirTableViewCell.h"

static const CGFloat plusHeightLabel = 8.f;
static const CGFloat leadingLabel = 6.f;
static const CGFloat labelFontSize = 17.f;

@implementation AirTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
     
        _dataRightLabel = [UILabel new];
        _dataRightLabel.text  = @"Left";
        _dataRightLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:labelFontSize];
        [self.contentView addSubview:_dataRightLabel];
        
        _number = [UILabel new];
        _number.text  = @"Right";
        _number.font = [UIFont fontWithName:@"Helvetica-Light" size:labelFontSize];
        [self.contentView addSubview:_number];
        
        _disLabel = [UILabel new];
        _disLabel.text  = @"Dis";
        _disLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:labelFontSize];
        [self.contentView addSubview:_disLabel];

        
        [self setupConstraints];
    }
    return self;
}



- (void)setupConstraints
{
    self.number.translatesAutoresizingMaskIntoConstraints = NO;
    self.dataRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.disLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints =
    @[
      [self.disLabel.widthAnchor constraintEqualToConstant:self.frame.size.width/2+self.frame.size.width/4-plusHeightLabel],
      [self.disLabel.heightAnchor constraintEqualToConstant:self.frame.size.height/2+plusHeightLabel],
      [self.disLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:leadingLabel],
      [self.disLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.frame.size.height/4],
      
      [self.number.widthAnchor constraintEqualToConstant:self.frame.size.width/4],
      [self.number.heightAnchor constraintEqualToConstant:self.frame.size.height/2+plusHeightLabel],
      [self.number.leadingAnchor constraintEqualToAnchor:self.disLabel.trailingAnchor constant:leadingLabel],
      [self.number.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.frame.size.height/4],
      
      [self.dataRightLabel.widthAnchor constraintEqualToConstant:self.frame.size.width/4],
      [self.dataRightLabel.heightAnchor constraintEqualToConstant:self.frame.size.height/2+plusHeightLabel],
      [self.dataRightLabel.leadingAnchor constraintEqualToAnchor:self.number.trailingAnchor constant:leadingLabel],
      [self.dataRightLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.frame.size.height/4],
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
