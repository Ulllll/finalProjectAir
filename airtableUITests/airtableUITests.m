//
//  airtableUITests.m
//  airtableUITests
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ATPButtonViewController.h"

@interface airtableUITests : XCTestCase

@end

@implementation airtableUITests

- (void)setUp
{
    [super setUp];
    
    self.continueAfterFailure = NO;

    [[[XCUIApplication alloc] init] launch];

}

- (void)tearDown
{
    [super tearDown];
}

- (void)testVKONotNull
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *vkoButton = tabBarsQuery.buttons[@"VKO"];
    [vkoButton tap];

}

- (void)testDMENotNull
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *dmeButton = tabBarsQuery.buttons[@"DME"];
    [dmeButton tap];

}

- (void)testSVONotNull
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *svoButton = tabBarsQuery.buttons[@"SVO"];
    [svoButton tap];
    
}

@end
