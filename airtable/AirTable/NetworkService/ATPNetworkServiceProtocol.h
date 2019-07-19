//
//  NetworkServiceProtocol.h
//  airtable
//
//  Created by Анастасия Рябова on 17/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved;

@end

@protocol NetworkServiceIntputProtocol <NSObject>
@optional

- (void)configureUrlSessionWithParams:(NSDictionary *)params;

- (void)getDataForTable: (NSString *)event
                  plusStation:(NSString *)station;

@end
