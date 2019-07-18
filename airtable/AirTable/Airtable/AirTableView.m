//
//  AirTableView.m
//  airtable
//
//  Created by Анастасия Рябова on 16/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "AirTableView.h"
#import "AirTableViewCell.h"
#import "NetworkServiceProtocol.h"
#import "NetworkService.h"

@interface AirTableView()<UITableViewDelegate, UITableViewDataSource, NSLayoutManagerDelegate, NetworkServiceOutputProtocol>

@property (nonatomic, strong) AirTableViewCell *customCell;
@property (nonatomic, strong) NSMutableArray *allScheduleForTable;
@property (nonatomic, strong) NetworkService *networkService;

@end

@implementation AirTableView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _networkService = [NetworkService new];
        _networkService.output = self;
        [_networkService configureUrlSessionWithParams:nil];
        [_networkService getDataForTable:@"NN"];
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[AirTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AirTableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allScheduleForTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.customCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AirTableViewCell class]) forIndexPath:indexPath];
    
    @try {
        NSString *oneToFrom = self.allScheduleForTable[indexPath.row][@"thread"][@"title"];
        [self.customCell.disLabel setText:oneToFrom];
        
        NSString *oneNN = self.allScheduleForTable[indexPath.row][@"thread"][@"number"];
        [self.customCell.number setText:oneNN];
        
        NSString *oneTime = self.allScheduleForTable[indexPath.row][@"departure"];
        NSString *shortTime = [oneTime substringWithRange:NSMakeRange(11, 8)];
        [self.customCell.dataRightLabel setText:shortTime];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return self.customCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved
{
    NSString *totalString = [[dataRecieved objectForKey:@"pagination"] objectForKey:@"total"];
    NSInteger totalInt = totalString.integerValue;
    //NSLog(@"%@", dataRecieved);
    
    //    self.fromTo = [NSMutableArray new];
    //    self.timeTo = [NSMutableArray new];
    //    self.NN = [NSMutableArray new];
    self.allScheduleForTable = [NSMutableArray new];
    
    
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"ru_RU"];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"HH"];
    NSString *timeNow = [dateFormatter stringFromDate:dateNow];
    NSLog(@"timeNow %@", timeNow);
    
    for (NSUInteger i = 0; i < totalInt; i++)
    {
        NSMutableDictionary *oneSheduleForGetData = dataRecieved[@"schedule"][i];
        //       NSLog(@"%@", oneSheduleForGetData);
        NSString *hourForDiffPlane = oneSheduleForGetData[@"departure"];
        NSLog(@"hourFor %@", hourForDiffPlane);
        NSString *isHourEqualHourNow = [hourForDiffPlane substringWithRange:NSMakeRange(11, 2)];
        NSLog(@"letsTime %@", isHourEqualHourNow);
        NSInteger hourGo = timeNow.integerValue;
        NSInteger hourNow = isHourEqualHourNow.integerValue;
        if (hourNow >= hourGo)
        {
            [self.allScheduleForTable addObject:oneSheduleForGetData];
        }
        
        //        NSString *oneFromTo = [NSString new];
        //        oneFromTo = [[oneSheduleForGetData objectForKey:@"thread"] objectForKey:@"title"];
        //        [self.fromTo addObject: oneFromTo];
        //
        //        NSString *oneTimeTo = [NSString new];
        //        oneTimeTo = [oneSheduleForGetData objectForKey:@"departure"];
        //        [self.timeTo addObject:oneTimeTo];
        //
        //        NSString *oneNN = [NSString new];
        //        oneNN = [[oneSheduleForGetData objectForKey:@"thread"] objectForKey:@"number"];
        //        [self.NN addObject:oneNN];
    }
    
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:totalInt inSection:0];
    //    [self.airtable reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationTop];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(5) inSection:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
                    }
);
//    dispatch_main(
//                  {
//                      [self reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationTop]
//                  }
//    );
    //NSLog(@"%@", self.allScheduleForTable);
}


@end
