//
//  ButtonViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

// вью с кнопками, кнопки создаются по функции в которой передаются цвета

#import "ATPButtonViewController.h"
#import "ATPAirViewController.h"

static const CGFloat heightButton = 100.f;
static const CGFloat spacingBetweenButton = 20.f;
static const CGFloat upFromCenterView = 110.f;
static const CGFloat fontSize = 20.f;
static const CGFloat imgHeight = 150.f;
static const CGFloat upFromTopForImage = 70.f;
static const CGFloat subForLeadingForImage = 10.f;
static const CGFloat subForWidthForImage = 20.f;
static const CGFloat timeForAnimationForButton = 0.3;
static const CGFloat transformButtonIn = 0.9;
static const CGFloat transformButtonOut = 1.0;

@interface ATPButtonViewController ()

@property (nonatomic, strong) UIButton *upButton;
@property (nonatomic, strong) UIButton *downButton;
@property (nonatomic, strong) UIColor *upColor;
@property (nonatomic, strong) UIColor *downColor;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) ATPAirViewController *airtable;
@property (nonatomic, strong) NSString *station;
@property (nonatomic, strong) NSString *eventForAirTable;
@property (nonatomic, strong) NSString *textForButtonTo;
@property (nonatomic, strong) NSString *textForButtonFrom;

@end

@implementation ATPButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLogo];
    [self createButton:self.upColor plusColor:self.downColor];

    self.airtable = [[ATPAirViewController alloc]init];
    
    [self setupConstraints];
}
// функция для получения цветов основного vc и необходимой станции
- (void)getColor:(UIColor *)upColor plusColor:(UIColor *)downColor plusStation:(NSString *)station
{
    self.upColor = [UIColor new];
    self.upColor = upColor;
    
    self.downColor = [UIColor new];
    self.downColor = downColor;
    
    self.station = [NSString new];
    self.station = station;
    
    self.eventForAirTable = [NSString new];
    
}
//получение названия нужного изображения
- (void)getImgName: (NSString *)name
{
    self.imgName = [NSString new];
    self.imgName = name;
}
//создание кнопок
- (void)createButton: (UIColor *)upButtonColor
           plusColor: (UIColor *)downButtonColor
{
    self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.textForButtonTo = @"табло вылета";
    self.textForButtonTo = self.textForButtonTo.uppercaseString;
    [self.upButton setTitle:self.textForButtonTo forState:UIControlStateNormal];
    self.upButton.backgroundColor = upButtonColor;
    self.upButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [self.view addSubview:self.upButton];
    
    
    [self.upButton addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchDown];//нужно в случае долгого нажатия
    [self.upButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];// для перехода к другому vc
    
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.textForButtonFrom = @"табло прилета";
    self.textForButtonFrom = self.textForButtonFrom.uppercaseString;
    [self.downButton setTitle:self.textForButtonFrom forState:UIControlStateNormal];
    self.downButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [self.view addSubview:self.downButton];
    
    self.downButton.backgroundColor = downButtonColor;
    
    [self.downButton addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchDown];
    [self.downButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
//логотип аэропорта
- (void)createLogo
{
    self.logo = [UIImageView new];

    self.logo.image = [UIImage imageNamed:self.imgName];
    
    [self.view addSubview:self.logo];
    
    self.logo.translatesAutoresizingMaskIntoConstraints = NO;
    
}
// анимация для долгого нажатия
- (void)pushButton: (UIButton *)button
{
    [UIView animateWithDuration:timeForAnimationForButton
                     animations:^{
                         button.transform = CGAffineTransformMakeScale(transformButtonIn, transformButtonIn);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:timeForAnimationForButton
                                          animations:^{
                                              button.transform = CGAffineTransformMakeScale(transformButtonOut, transformButtonOut);
                          }];
                     }];
}
// переход к новому vc
- (void)clickButton: (UIButton *)button
{   //для получения события (отправление или прибытие)
    if ([button.titleLabel.text isEqualToString:self.textForButtonTo])
    {
        self.eventForAirTable = @"departure";
    } else if ([button.titleLabel.text isEqualToString:self.textForButtonFrom])
    {
        self.eventForAirTable = @"arrival";
    }

    [self displayAirTable:self.airtable plusEvent:self.eventForAirTable];
}
// переход к vc с передачей нужного события (отправление или прибытие) и станции
- (void) displayAirTable: (ATPAirViewController*)content
               plusEvent: (NSString *)event;
{
    [content getStationForUrl:self.station plusEvent:event];
    
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
