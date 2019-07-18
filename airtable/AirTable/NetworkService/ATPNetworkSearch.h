//
//  NetworkSearch.h
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATPNetworkSearch : NSObject

+ (NSString *)URLForAirTable:(NSString *)event
                 plusStation:(NSString *)station;

@end

NS_ASSUME_NONNULL_END
