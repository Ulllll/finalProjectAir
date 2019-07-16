//
//  AirTableView.m
//  airtable
//
//  Created by Анастасия Рябова on 16/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "AirTableView.h"
#import "AirTableViewCell.h"

@interface AirTableView()<UITableViewDelegate, UITableViewDataSource, NSLayoutManagerDelegate>

@property (nonatomic, strong) AirTableViewCell *customCell;

@end

@implementation AirTableView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[AirTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AirTableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.customCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AirTableViewCell class]) forIndexPath:indexPath];
    
    return self.customCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
