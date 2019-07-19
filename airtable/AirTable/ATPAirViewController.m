//
//  AirViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "ATPAirViewController.h"
#import "Airtable/ATPAirTableView.h"
#import "Airtable/ATPAirTableForWaitView.h"

static const CGFloat fontSize = 20.f;
static const CGFloat borderWidth = 1.5;
static const CGFloat headerHeight = 100.f;
static const CGFloat buttonHeight = 50.f;
static const CGFloat buttonTop = 40.f;
static const CGFloat tableTop = 0.f;

@interface ATPAirViewController ()

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) ATPAirTableView *airtable;
@property (nonatomic, strong) NSString *stationtForAirTableForThisVC;
@property (nonatomic, strong) NSString *eventForAirTableForThisVC;
@property (nonatomic, strong) NSString *textForBackButton;
@property (nonatomic, strong) ATPAirTableForWaitView *progress;

@end

@implementation ATPAirViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initHeader];
    [self initAirtable];
    [self initWait];
    [self setupConstraints];
}
// создание вьюшки с кнопкой для возможности возвращение к вьюшке с кнопками
- (void)initHeader
{
    self.header = [UIView new];
    self.header.backgroundColor = [UIColor whiteColor];

    [self createButton];

    [self.view addSubview:self.header];
}
// вьюшка "типо" загрузка, отображается 5 секунд
- (void)initWait
{
    self.progress = [ATPAirTableForWaitView new];
    
    [self.view addSubview:self.progress];
}


- (void)createButton
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.textForBackButton = @"назад";
    self.textForBackButton = self.textForBackButton.uppercaseString;
    [self.button setTitle:self.textForBackButton forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    
    self.button.backgroundColor = [UIColor whiteColor];
    
    [self.button.layer setBorderWidth:borderWidth];
    [self.button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    [self.header addSubview:self.button];
    
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}
// переход назад к вьюшке с кнопками
- (void)clickButton: (UIButton *)button
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
// передача в таблицу станции и события, плюс отображение "типо" загрузки и запуск анимации в ней
- (void)getStationForUrl:(NSString *)station plusEvent:(NSString *)event
{
    self.stationtForAirTableForThisVC = [NSString new];
    self.stationtForAirTableForThisVC = station;
    
    self.eventForAirTableForThisVC = [NSString new];
    self.eventForAirTableForThisVC = event;
    
    [self.airtable oneOfTheLastStepToGetStationAndEvent:self.stationtForAirTableForThisVC plusEventOfVC:self.eventForAirTableForThisVC];
    
    if (self.progress.hidden == YES)
    {
        self.progress.hidden = NO;
    }
    
    [self performSelector:@selector(hideWait) withObject:nil afterDelay:5.0];
    
    [self.progress startAnimation];
    
}
// скрытия "типо" загрузки
- (void)hideWait
{
    self.progress.hidden = YES;
}
// создание таблицы
- (void)initAirtable
{
    self.airtable = [ATPAirTableView new];
    
    [self.airtable oneOfTheLastStepToGetStationAndEvent:self.stationtForAirTableForThisVC plusEventOfVC:self.eventForAirTableForThisVC];//передача станции и событий
    
    
    [self.view addSubview:self.airtable];
}

- (void)setupConstraints
{
    self.header.translatesAutoresizingMaskIntoConstraints = NO;
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    self.airtable.translatesAutoresizingMaskIntoConstraints = NO;
    self.progress.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints =
    @[
      [self.header.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      [self.header.heightAnchor constraintEqualToConstant:headerHeight],
      
      [self.button.widthAnchor constraintEqualToConstant:(self.view.frame.size.width/2)],
      [self.button.heightAnchor constraintEqualToConstant:buttonHeight],
      [self.button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:self.view.frame.size.width/4],
      [self.button.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:buttonTop],
      
      [self.airtable.topAnchor constraintEqualToAnchor:self.header.bottomAnchor constant:tableTop],
      [self.airtable.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      [self.airtable.heightAnchor constraintEqualToConstant:self.view.frame.size.height-self.header.frame.size.height],
      
      [self.progress.topAnchor constraintEqualToAnchor:self.header.bottomAnchor constant:tableTop],
      [self.progress.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      [self.progress.heightAnchor constraintEqualToConstant:self.view.frame.size.height-self.header.frame.size.height],
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}





@end

