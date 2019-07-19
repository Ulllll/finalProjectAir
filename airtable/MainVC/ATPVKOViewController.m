//
//  VKOViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

// желтый, белый, голубой

#import "ATPVKOViewController.h"
#import "ATPButtonViewController.h"

@interface ATPVKOViewController ()

@property (nonatomic, strong) ATPButtonViewController *btnView;

@end

@implementation ATPVKOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnView = [[ATPButtonViewController alloc]init];
    [self.btnView getColor:[UIColor colorWithRed:38.0/255.0 green:126.0/255.0 blue:255.0/255.0 alpha:1] plusColor:[UIColor colorWithRed:255.0/255.0 green:198.0/255.0 blue:21.0/255.0 alpha:1] plusStation:@"s9600215"];
    [self.btnView getImgName:@"logoVKO"];
    [self displayButtonController:self.btnView];
}

- (void) displayButtonController: (ATPButtonViewController*) content;
{
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.btnView.view];
    [content didMoveToParentViewController:self];
}

@end
