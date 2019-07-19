//
//  NetworkService.h
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATPNetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATPNetworkService : NSObject<NetworkServiceIntputProtocol, NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
