//
//  ATPNetworkSearchReturnReallyString.m
//  airtableTests
//
//  Created by Анастасия Рябова on 26/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ATPNetworkSearch.h"

@interface ATPNetworkSearchReturnReallyString : XCTestCase

@end

@implementation ATPNetworkSearchReturnReallyString

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testIsDepartureDME
{
    NSString *isRealString = [ATPNetworkSearch URLForAirTable:@"departure" plusStation:@"s9600216"];
    XCTAssertNotNil(isRealString);
}

- (void)testIsArrivalDME
{
    NSString *isRealString = [ATPNetworkSearch URLForAirTable:@"arrival" plusStation:@"s9600216"];
    XCTAssertNotNil(isRealString);
}

- (void)testIsDepartureVKO
{
    NSString *isRealString = [ATPNetworkSearch URLForAirTable:@"departure" plusStation:@"s9600215"];
    XCTAssertNotNil(isRealString);
}

- (void)testIsArrivalVKO
{
    NSString *isRealString = [ATPNetworkSearch URLForAirTable:@"arrival" plusStation:@"s9600215"];
    XCTAssertNotNil(isRealString);
}

- (void)testIsDepartureSVO
{
    NSString *isRealString = [ATPNetworkSearch URLForAirTable:@"departure" plusStation:@"s9600213"];
    XCTAssertNotNil(isRealString);
}

- (void)testIsArrivalSVO
{
    NSString *isRealString = [ATPNetworkSearch URLForAirTable:@"arrival" plusStation:@"s9600213"];
    XCTAssertNotNil(isRealString);
}


@end
