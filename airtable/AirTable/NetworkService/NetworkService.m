//
//  NetworkService.m
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "NetworkService.h"
#import "NetworkSearch.h"

@interface NetworkService()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;

@end

@implementation NetworkService

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

- (void) getDataForTable :(NSString *)searchSrting
{
    NSString *urlString = [NetworkSearch URLForSearchString:searchSrting];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSessionDataTask *sessionDataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {
                    NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    NSLog(@"%@", temp);
                }
    ];
    [sessionDataTask resume];
}

@end
