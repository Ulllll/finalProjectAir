//
//  AirViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "AirViewController.h"
//#import "const.strings"
#import "Airtable/AirTableView.h"

@interface AirViewController ()

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) AirTableView *airtable;

@end

@implementation AirViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initHeader];
    [self initAirtable];
    [self setupConstraints];
}

- (void)initHeader
{
    self.header = [UIView new];
    self.header.backgroundColor = [UIColor whiteColor];

    [self createButton];

    [self.view addSubview:self.header];
}

- (void)createButton
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"НАЗАД" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button.layer setBorderWidth:1.5];
    [self.button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    self.button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self.header addSubview:self.button];
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton: (UIButton *)button
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)initAirtable
{
    self.airtable = [AirTableView new];
    
    [self.view addSubview:self.airtable];
}

- (void)setupConstraints
{
    self.header.translatesAutoresizingMaskIntoConstraints = NO;
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    self.airtable.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints =
    @[
      [self.header.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      [self.header.heightAnchor constraintEqualToConstant:100.f],
      
      [self.button.widthAnchor constraintEqualToConstant:(self.view.frame.size.width/2)],
      [self.button.heightAnchor constraintEqualToConstant:50.f],
      [self.button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:self.view.frame.size.width/4],
      [self.button.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:40.f],
      
      [self.airtable.topAnchor constraintEqualToAnchor:self.header.bottomAnchor constant:0.f],
      [self.airtable.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      [self.airtable.heightAnchor constraintEqualToConstant:self.view.frame.size.height-self.header.frame.size.height],
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
