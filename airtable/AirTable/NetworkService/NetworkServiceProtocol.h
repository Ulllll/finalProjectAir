//
//  NetworkServiceProtocol.h
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingContinuesWithProgress:(double)progress;
- (void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved;
//- (void)loadToFrom:(NSString *)toFrom;
//- (void)loadTimeTo:(NSString *)timeTo;
//- (void)loadTimeFrom:(NSString *)timeFrom;


@end

@protocol NetworkServiceIntputProtocol <NSObject>
@optional

- (void)configureUrlSessionWithParams:(NSDictionary *)params;
- (void)startImageLoading;

- (BOOL)resumeNetworkLoading;
- (void)suspendNetworkLoading;

- (void)getDataForTable :(NSString *)searchSrting;

@end
