//
//  ATPAirTableForWaitView.m
//  airtable
//
//  Created by Анастасия Рябова on 19/07/2019.
//  Copyright © 2019 Анастасия Рябова. All rights reserved.
//

#import "ATPAirTableForWaitView.h"

static const CGFloat heightPlusWidthForImg = 150.f;
static const CGFloat subWidth = 20.f;
static const CGFloat fontSizeForLabel = 19.f;
static const CGFloat heightForLabel = 70.f;
static const CGFloat subHeightForLabel = 180.f;
static const CGFloat startForImg = 0.f;
static const CGFloat endForAnimation = 50.f;
static const CGFloat timeForAnimation = 2.f;
static const CGFloat plusForAnimationWidth = 70.f;

@interface ATPAirTableForWaitView()

@property (nonatomic, strong) UIImageView *planeImgView;
@property (nonatomic, strong) UIImage *planeImg;
@property (nonatomic, strong) UILabel *pleaseWait;

@end

@implementation ATPAirTableForWaitView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _pleaseWait = [UILabel new];
        _pleaseWait.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSizeForLabel];
        [_pleaseWait setText:@"Пожалуйста, подождите. Идет загрузка"];
        
        
        _planeImg = [UIImage new];
        _planeImg = [UIImage imageNamed:@"plane"];
        
        _planeImgView = [[UIImageView alloc]initWithImage:_planeImg];
        
        [self setupImgView];
        [self startAnimation];
        
 //       [self setupConstraints];
    }
    return self;
}

- (void)setupImgView
{
    self.planeImgView.frame = CGRectMake(startForImg, [UIScreen mainScreen].bounds.size.height, heightPlusWidthForImg, heightPlusWidthForImg);
    
    [self addSubview:self.planeImgView];
    
    self.pleaseWait.frame = CGRectMake(subWidth/2, [UIScreen mainScreen].bounds.size.height/2-subHeightForLabel, [UIScreen mainScreen].bounds.size.width-subWidth, heightForLabel);
    
    [self addSubview:self.pleaseWait];
}

- (void)startAnimation
{
    CGFloat xNow = startForImg;
    CGFloat yNow = [UIScreen mainScreen].bounds.size.height;
    
    NSArray * pathArray = @[ [NSValue valueWithCGPoint:CGPointMake(xNow, yNow)], [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width+plusForAnimationWidth, endForAnimation)], ];
    
    CAKeyframeAnimation *animation;
    
    animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = timeForAnimation;
    [animation setRepeatCount:INFINITY];
    animation.values = pathArray;
    [self.planeImgView.layer addAnimation:animation forKey:@"animatePosition"];
}


@end
