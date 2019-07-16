//
//  AirTableViewCell.m
//  airtable
//
//  Created by Анастасия Рябова on 16/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "AirTableViewCell.h"

@implementation AirTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
     
        _dataLeftLabel = [UILabel new];
        _dataLeftLabel.text  = @"Left";
        _dataLeftLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:25];
        [self.contentView addSubview:_dataLeftLabel];
        
        _dataRightLabel = [UILabel new];
        _dataRightLabel.text  = @"Right";
        _dataRightLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:25];
        [self.contentView addSubview:_dataRightLabel];
        
        _disLabel = [UILabel new];
        _disLabel.text  = @"Dis";
        _disLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:25];
        [self.contentView addSubview:_disLabel];

        
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    self.dataLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dataRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.disLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints =
    @[
      [self.disLabel.widthAnchor constraintEqualToConstant:self.frame.size.width/4],
      [self.disLabel.heightAnchor constraintEqualToConstant:self.frame.size.height/2+8.f],
      [self.disLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.f],
      [self.disLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.frame.size.height/4],
      
      [self.dataLeftLabel.widthAnchor constraintEqualToConstant:self.frame.size.width/4],
      [self.dataLeftLabel.heightAnchor constraintEqualToConstant:self.frame.size.height/2+8.f],
      [self.dataLeftLabel.leadingAnchor constraintEqualToAnchor:self.disLabel.trailingAnchor constant:self.frame.size.width/4-10.f],
      [self.dataLeftLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.frame.size.height/4],
      
      [self.dataRightLabel.widthAnchor constraintEqualToConstant:self.frame.size.width/4],
      [self.dataRightLabel.heightAnchor constraintEqualToConstant:self.frame.size.height/2+8.f],
      [self.dataRightLabel.leadingAnchor constraintEqualToAnchor:self.dataLeftLabel.trailingAnchor constant:10.f],
      [self.dataRightLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.frame.size.height/4],
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
