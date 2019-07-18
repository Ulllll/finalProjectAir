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




static const CGFloat ATEfdfs = 20.f;

@interface AirViewController () 

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) AirTableView *airtable;
@property (nonatomic, strong) NSMutableArray<NSString *> *fromTo;
@property (nonatomic, strong) NSMutableArray<NSString *> *timeTo;
@property (nonatomic, strong) NSMutableArray<NSString *> *NN;



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
