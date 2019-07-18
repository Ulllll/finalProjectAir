//
//  DMEViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//
//серо-коричневы, зелено-коричневый, белый

#import "ATPDMEViewController.h"
#import "ATPButtonViewController.h"

@interface ATPDMEViewController ()

@property (nonatomic, strong) ATPButtonViewController *btnView;

@end

@implementation ATPDMEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnView = [[ATPButtonViewController alloc]init];
    [self.btnView getColor:[UIColor colorWithRed:78.0/255.0 green:120.0/255.0 blue:126.0/255.0 alpha:1] plusColor:[UIColor colorWithRed:112.0/255.0 green:92.0/255.0 blue:92.0/255.0 alpha:1] plusStation:@"s9600216"];
    [self.btnView getImgName:@"logoDME"];
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
