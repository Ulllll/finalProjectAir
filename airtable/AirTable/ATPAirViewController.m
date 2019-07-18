//
//  AirViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "ATPAirViewController.h"
#import "Airtable/ATPAirTableView.h"

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

@end

@implementation ATPAirViewController

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
    self.textForBackButton = @"назад";
    self.textForBackButton = self.textForBackButton.uppercaseString;
    [self.button setTitle:self.textForBackButton forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button.layer setBorderWidth:borderWidth];
    [self.button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    self.button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [self.header addSubview:self.button];
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton: (UIButton *)button
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)getStationForUrl:(NSString *)station plusEvent:(NSString *)event
{
    self.stationtForAirTableForThisVC = [NSString new];
    self.stationtForAirTableForThisVC = station;
    
    self.eventForAirTableForThisVC = [NSString new];
    self.eventForAirTableForThisVC = event;
    
    [self.airtable oneOfTheLastStepToGetStationAndEvent:self.stationtForAirTableForThisVC plusEventOfVC:self.eventForAirTableForThisVC];
    
}

- (void)initAirtable
{
    self.airtable = [ATPAirTableView new];
    
    [self.airtable oneOfTheLastStepToGetStationAndEvent:self.stationtForAirTableForThisVC plusEventOfVC:self.eventForAirTableForThisVC];
    
    
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
      [self.header.heightAnchor constraintEqualToConstant:headerHeight],
      
      [self.button.widthAnchor constraintEqualToConstant:(self.view.frame.size.width/2)],
      [self.button.heightAnchor constraintEqualToConstant:buttonHeight],
      [self.button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:self.view.frame.size.width/4],
      [self.button.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:buttonTop],
      
      [self.airtable.topAnchor constraintEqualToAnchor:self.header.bottomAnchor constant:tableTop],
      [self.airtable.widthAnchor constraintEqualToConstant:self.view.frame.size.width],
      [self.airtable.heightAnchor constraintEqualToConstant:self.view.frame.size.height-self.header.frame.size.height],
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)loadingContinuesWithProgress:(double)progress
{
    
}




@end

//schedule =     (
//                {
//                    arrival = "<null>";
//                    days = "17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31\U00a0\U0438\U044e\U043b\U044f, 1, 2, 3, 4, 5\U00a0\U0430\U0432\U0433\U0443\U0441\U0442\U0430, \U2026";
//                    departure = "2019-07-17T00:05:00+03:00";//время отправления
//                    "except_days" = "<null>";
//                    "is_fuzzy" = 0;
//                    platform = "";
//                    stops = "";
//                    terminal = "<null>";
//                    thread =             {
//                        carrier =                 {
//                            code = 26;
//                            codes =                     {
//                                iata = SU;
//                                icao = AFL;
//                                sirena = "\U0421\U0423";
//                            };
//                            title = "\U0410\U044d\U0440\U043e\U0444\U043b\U043e\U0442";//направление
//                        };
//                        "express_type" = "<null>";
//                        number = "SU 1424";// номер рейса
//                        "short_title" = "\U041c\U043e\U0441\U043a\U0432\U0430 \U2014 \U0427\U0435\U043b\U044f\U0431\U0438\U043d\U0441\U043a";//тоже направление
//                        title = "\U041c\U043e\U0441\U043a\U0432\U0430 \U2014 \U0427\U0435\U043b\U044f\U0431\U0438\U043d\U0441\U043a";
//                        "transport_subtype" =                 {
//                            code = "<null>";
//                            color = "<null>";
//                            title = "<null>";
//                        };
//                        "transport_type" = plane;
//                        uid = "SU-1424_2_c26_547";
//                        vehicle = "Airbus A320";
//                    };
//                },
