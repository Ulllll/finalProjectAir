//
//  AirTableView.m
//  airtable
//
//  Created by Анастасия Рябова on 16/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "ATPAirTableView.h"
#import "ATPAirTableViewCell.h"
#import "ATPNetworkServiceProtocol.h"
#import "ATPNetworkService.h"

static const CGFloat heightOgRows = 65.f;

@interface ATPAirTableView()<UITableViewDelegate, UITableViewDataSource, NSLayoutManagerDelegate, NetworkServiceOutputProtocol>

@property (nonatomic, strong) ATPAirTableViewCell *customCell;
@property (nonatomic, strong) NSMutableArray *allScheduleForTable;
@property (nonatomic, strong) ATPNetworkService *networkService;
@property (nonatomic, strong) NSString *okGetStation;
@property (nonatomic, strong) NSString *okGetEvent;

@end

@implementation ATPAirTableView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initUI];
    }
    return self;
}
//окончательная передача станции и события
- (void)oneOfTheLastStepToGetStationAndEvent:(NSString *)station plusEventOfVC:(NSString *)event
{
    _okGetStation = [NSString new];
    _okGetStation = station;
    
    _okGetEvent = [NSString new];
    _okGetEvent = event;
    
    [self startLoad];
    
}

- (void)startLoad
{
    _networkService = [ATPNetworkService new];
    _networkService.output = self;
    [_networkService configureUrlSessionWithParams:nil];
    [_networkService getDataForTable:self.okGetEvent plusStation:self.okGetStation];
}

- (void)initUI
{
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[ATPAirTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ATPAirTableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allScheduleForTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.customCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ATPAirTableViewCell class]) forIndexPath:indexPath];
    
    @try {
        NSString *oneToFrom = self.allScheduleForTable[indexPath.row][@"thread"][@"title"];
        [self.customCell.disLabel setText:oneToFrom];
        
        NSString *oneNN = self.allScheduleForTable[indexPath.row][@"thread"][@"number"];
        [self.customCell.number setText:oneNN];
        
        NSString *oneTime = self.allScheduleForTable[indexPath.row][self.okGetEvent];
        NSString *shortTime = [oneTime substringWithRange:NSMakeRange(11, 8)];
        [self.customCell.dataRightLabel setText:shortTime];
    } @catch (NSException *exception)
    {
        
    } @finally
    {
        
    }
    
    return self.customCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightOgRows;
}

- (void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved
{
    NSString *totalString = [[dataRecieved objectForKey:@"pagination"] objectForKey:@"total"];
    NSInteger totalInt = totalString.integerValue;
    
    self.allScheduleForTable = [NSMutableArray new];
    
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"ru_RU"];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"HH"];
    NSString *timeNow = [dateFormatter stringFromDate:dateNow];
    
    for (NSUInteger i = 0; i < totalInt; i++)
    {
        NSMutableDictionary *oneSheduleForGetData = dataRecieved[@"schedule"][i];
        NSString *hourForDiffPlane = oneSheduleForGetData[self.okGetEvent];
        NSString *isHourEqualHourNow = [hourForDiffPlane substringWithRange:NSMakeRange(11, 2)];
        NSInteger hourGo = timeNow.integerValue;
        NSInteger hourNow = isHourEqualHourNow.integerValue;
        if (hourNow >= hourGo)
        {
            //запись только тех рейсов, которые отправляются или прилетают позже часа на телефоне
            [self.allScheduleForTable addObject:oneSheduleForGetData];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
                                                [self reloadData];
                                                }
);

}


@end
