//
//  AirViewController.h
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirViewController : UIViewController

@property (nonatomic, strong) NSDictionary *lets;
- (void)getStationForUrl: (NSString *)station plusEvent: (NSString *)event;

@end

NS_ASSUME_NONNULL_END
