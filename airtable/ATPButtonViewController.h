//
//  ButtonViewController.h
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATPButtonViewController : UIViewController

- (void)getColor:(UIColor *)upColor plusColor: (UIColor *)downColor plusStation: (NSString *)station;//передача с основного vc 
- (void)getImgName: (NSString *)name;

@end

NS_ASSUME_NONNULL_END
