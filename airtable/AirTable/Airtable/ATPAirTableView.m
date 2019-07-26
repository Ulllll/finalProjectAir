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
@import UserNotifications;

static const CGFloat heightOgRows = 65.f;
static const CGFloat fontSizeForPushButton = 25.f;


@interface ATPAirTableView()<UITableViewDelegate, UITableViewDataSource, NSLayoutManagerDelegate, NetworkServiceOutputProtocol>

@property (nonatomic, strong) ATPAirTableViewCell *customCell;
@property (nonatomic, strong) NSMutableArray *allScheduleForTable;
@property (nonatomic, strong) ATPNetworkService *networkService;
@property (nonatomic, strong) NSString *okGetStation;
@property (nonatomic, strong) NSString *okGetEvent;
@property (nonatomic, strong) UIButton *btn;

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
// кнопка на напоминания
- (void)initBtn
{
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame =CGRectMake(0.f, 0.f, self.customCell.frame.size.width, self.customCell.frame.size.height-5.f);
    
    NSString *textForButton = @"напомнить про рейс";
    textForButton = textForButton.uppercaseString;
    [self.btn setTitle:textForButton forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:fontSizeForPushButton];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn.backgroundColor = [UIColor whiteColor];
    
    [self.btn addTarget:self action:@selector(needPush:) forControlEvents:UIControlEventTouchUpInside];
}
// запрос на уведомление
- (void)needPush: (UIButton *)button
{
    [self sheduleLocalNotification];
    self.btn.hidden = YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.customCell = [tableView cellForRowAtIndexPath:indexPath];
    [self initBtn];
    [self.customCell addSubview:self.btn];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.customCell = [tableView cellForRowAtIndexPath:indexPath];
     self.btn.hidden = YES;
}
// уведомление
- (void)sheduleLocalNotification
{
    NSString *ourEvent;
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Напоминание о рейсе";
    if ([self.okGetEvent isEqualToString:@"arrival"])
    {
        ourEvent = @"прибывает";
        
    } else if ([self.okGetEvent isEqualToString:@"departure"])
            {
                ourEvent = @"отправляется";
            }
    content.body = [NSString stringWithFormat:@"Ваш рейс %@ №\"%@\" %@ в %@", self.customCell.disLabel.text, self.customCell.number.text, ourEvent, self.customCell.dataRightLabel.text];
    content.sound = [UNNotificationSound defaultSound];
    
    UNNotificationTrigger *triggerDate = [self dateTrigger];
    
    NSString *identifier = @"NotificationId";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:triggerDate];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Error:%@",error);
         }
     }];
}
//настройка
- (UNCalendarNotificationTrigger *)dateTrigger
{
    NSDate *getDateNow = [NSDate date];
    NSDateFormatter *getDateFormatter = [[NSDateFormatter alloc] init];
    [getDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date = [getDateFormatter stringFromDate:getDateNow];
    
    //получение одного часа назад
    NSString *getHour = [self.customCell.dataRightLabel.text substringWithRange:NSMakeRange(0, 2)];
    NSInteger subHour = getHour.integerValue;
    subHour--;
    
    // время на час назад
    NSString *final = [self.customCell.dataRightLabel.text substringWithRange:NSMakeRange(3, 5)];
    final = [NSString stringWithFormat:@"%li:%@", subHour, final];
    
    // дата на час назад от времени в ячейке
    date = [NSString stringWithFormat:@"%@T%@", date, final];
    [getDateFormatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss"];
    getDateNow = [getDateFormatter dateFromString:date];
    
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components: NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:getDateNow];
    
    return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
}


@end
