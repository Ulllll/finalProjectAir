//
//  NetworkService.m
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "ATPNetworkService.h"
#import "ATPNetworkSearch.h"

@interface ATPNetworkService()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSDictionary *dataNow;

@end

@implementation ATPNetworkService

- (void)configureUrlSessionWithParams:(NSDictionary *)params
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    if (params)
    {
        [sessionConfiguration setHTTPAdditionalHeaders:params];
    }
    else
    {
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json" }];
    }
    
    
    self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
}

- (void)getDataForTable:(NSString *)event plusStation:(NSString *)station
{
    NSString *urlString = [ATPNetworkSearch URLForAirTable:event plusStation:station];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *sessionDataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {

                    self.dataNow = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
          
                        [self.output loadingIsDoneWithDataRecieved:self.dataNow];
      
                }
    ];
    [sessionDataTask resume];
}


@end
