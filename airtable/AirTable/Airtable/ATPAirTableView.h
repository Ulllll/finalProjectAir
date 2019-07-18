//
//  AirTableView.h
//  airtable
//
//  Created by Анастасия Рябова on 16/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirTableView : UITableView

- (void)oneOfTheLastStepToGetStationAndEvent: (NSString *)station plusEventOfVC: (NSString *)event;

@end

NS_ASSUME_NONNULL_END
