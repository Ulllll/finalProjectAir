//
//  ButtonViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//
// вью с кнопками, кнопки создаются по функции в которую передаются цвета

#import "ButtonViewController.h"
#import "AirViewController.h"
#import "const.strings"
//#import "const.plist"

@interface ButtonViewController ()

@property (nonatomic, strong) UIButton *upButton;
@property (nonatomic, strong) UIButton *downButton;
@property (nonatomic, strong) UIColor *upColor;
@property (nonatomic, strong) UIColor *downColor;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) AirViewController *airtable;


@end

@implementation ButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLogo];
    [self createButton:self.upColor plusColor:self.downColor];
    
    self.airtable = [[AirViewController alloc]init];
    
    [self setupConstraints];
}

- (void)getColor:(UIColor *)upColor
       plusColor:(UIColor *)downColor
{
    self.upColor = [UIColor new];
    self.upColor = upColor;
    
    self.downColor = [UIColor new];
    self.downColor = downColor;
    
}

- (void)getImgName: (NSString *)name
{
    self.imgName = [NSString new];
    self.imgName = name;
}

- (void)createButton: (UIColor *)upButtonColor
           plusColor: (UIColor *)downButtonColor
{
    self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.upButton setTitle:@"ТАБЛО ВЫЛЕТА" forState:UIControlStateNormal];
    self.upButton.backgroundColor = upButtonColor;
    self.upButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [self.view addSubview:self.upButton];
    [self.upButton addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchDown];
    [self.upButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downButton setTitle:@"ТАБЛО ПРИЛЕТА" forState:UIControlStateNormal];
    self.downButton.backgroundColor = downButtonColor;
    self.downButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [self.view addSubview:self.downButton];
    [self.downButton addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchDown];
    [self.downButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createLogo
{
    self.logo = [UIImageView new];

    self.logo.image = [UIImage imageNamed:self.imgName];
    
    [self.view addSubview:self.logo];
}

- (void)pushButton: (UIButton *)button
{
    [UIView animateWithDuration:0.3f
                     animations:^
     {
         button.transform = CGAffineTransformMakeScale(0.9, 0.9);
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3f
                          animations:^
          {
              button.transform = CGAffineTransformMakeScale(1.0, 1.0);
          }
          ];
     }
     ];
}

- (void)clickButton: (UIButton *)button
{
    
//    [self pushViewController:self.airtable animated:YES];
    [self displayAirTable:self.airtable];
    
    NSLog(@"KKK");
}

- (void) displayAirTable: (AirViewController*) content;
{
//    [self willMoveToParentViewController:nil];
//    [self.view removeFromSuperview];
//    [self removeFromParentViewController];
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.airtable.view];
    [content didMoveToParentViewController:self];
}

- (void)setupConstraints
{
    self.upButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.downButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.logo.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints =
    @[
      [self.upButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:(self.view.frame.size.height/2)-upFromCenterView],
      [self.upButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:(self.view.frame.size.width/2)-(self.view.frame.size.width/2)/2],
      [self.upButton.widthAnchor constraintEqualToConstant:(self.view.frame.size.width/2)],
      [self.upButton.heightAnchor constraintEqualToConstant:heightButton],
      
      [self.downButton.topAnchor constraintEqualToAnchor:self.upButton.bottomAnchor constant:spacingBetweenButton],
      [self.downButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:(self.view.frame.size.width/2)-(self.view.frame.size.width/2)/2],
      [self.downButton.widthAnchor constraintEqualToConstant:(self.view.frame.size.width/2)],
      [self.downButton.heightAnchor constraintEqualToConstant:heightButton],
      
      [self.logo.widthAnchor constraintEqualToConstant:self.view.frame.size.width-subForWidthForImage],
      [self.logo.heightAnchor constraintEqualToConstant:imgHeight],
      [self.logo.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:upFromTopForImage],
      [self.logo.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:subForLeadingForImage],
      
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}




@end
