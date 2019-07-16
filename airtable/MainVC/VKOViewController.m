//
//  VKOViewController.m
//  airtable
//
//  Created by Анастасия Рябова on 15/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

// желтый, белый, голубой

#import "VKOViewController.h"
#import "ButtonViewController.h"

@interface VKOViewController ()

@property (nonatomic, strong) ButtonViewController *btnView;

@end

@implementation VKOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnView = [[ButtonViewController alloc]init];
    [self.btnView getColor:[UIColor colorWithRed:38.0/255.0 green:126.0/255.0 blue:255.0/255.0 alpha:1] plusColor:[UIColor colorWithRed:255.0/255.0 green:198.0/255.0 blue:21.0/255.0 alpha:1]];
    [self.btnView getImgName:@"logoVKO"];
    [self displayButtonController:self.btnView];
}

- (void) displayButtonController: (ButtonViewController*) content;
{
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.btnView.view];
    [content didMoveToParentViewController:self];
}

@end
