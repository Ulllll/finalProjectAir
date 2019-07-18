//
//  NetworkSearch.m
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "NetworkSearch.h"

@implementation NetworkSearch

+ (NSString *)URLForAirTable:(NSString *)event
                 plusStation:(NSString *)station
{
    NSString *APIKey = @"b1f9bae6-848a-42a1-b7cd-3b9790ac360f";
    NSDate *getDateNow = [NSDate date];
    NSDateFormatter *getDateFormatter = [[NSDateFormatter alloc] init];
    [getDateFormatter setDateFormat:@"YYYY-MM-HH"];
    NSString *date = [getDateFormatter stringFromDate:getDateNow];
    NSString *search = [NSString stringWithFormat:@"https://api.rasp.yandex.net/v3.0/schedule/?apikey=%@&station=%@&date=%@&transport_type=plane&event=%@&limit=2200", APIKey, station, date, event];
    NSLog(@"%@", search);
    return search;
    
}

@end


