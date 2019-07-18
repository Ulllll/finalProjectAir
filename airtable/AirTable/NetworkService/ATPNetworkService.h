//
//  NetworkService.h
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject<NetworkServiceIntputProtocol, NSURLSessionDelegate, NSURLSessionDownloadDelegate, NSURLSessionDataDelegate>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
