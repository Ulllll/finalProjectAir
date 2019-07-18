//
//  NetworkSearch.m
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "NetworkSearch.h"

@implementation NetworkSearch

+ (NSString *)URLForSearchString:(NSString *)searchString
{
    NSString *APIKey = @"b1f9bae6-848a-42a1-b7cd-3b9790ac360f";
    NSString *date = @"2019-07-17";
    NSString *search = [NSString stringWithFormat:@"https://api.rasp.yandex.net/v3.0/schedule/?apikey=%@&station=s9600213&transport_type=plane&event=departure&data=%@&limit=2200", APIKey, date];
    NSLog(@"%@", search);
    return search;
    
}

@end
