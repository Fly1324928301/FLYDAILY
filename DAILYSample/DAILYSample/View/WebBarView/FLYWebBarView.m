//
//  FLYWebBarView.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-25.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYWebBarView.h"

static const int kLeftSpace = 24;
static const int kFramHeigth = 40;
static const int kTopSpace = 0;
static const int kFramWidth = 50;
//static const int kVerticalSpace = 24;
@implementation FLYWebBarView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.backView = [[UIImageView alloc] initWithFrame:Rect(kLeftSpace, kTopSpace, kFramWidth, kFramHeigth)];
        self.backView.image = [UIImage imageNamed:@"BackIMG@2x.png"];
        self.backView.userInteractionEnabled = YES;
        [self addSubview:self.backView];
        
        self.previewView = [[UIImageView alloc] initWithFrame:Rect(kLeftSpace*2+kFramWidth, kTopSpace, kFramWidth, kFramHeigth)];
        self.previewView.image = [UIImage imageNamed:@"IMGSamll@2x.png"];
        self.previewView.userInteractionEnabled = YES;
        [self addSubview:self.previewView];
        
        self.shareView = [[UIImageView alloc] initWithFrame:Rect(kLeftSpace*3+kFramWidth*2, kTopSpace, kFramWidth, kFramHeigth)];
        self.shareView.image = [UIImage imageNamed:@"toolbar_share_btn@2x.png"];
        self.shareView.userInteractionEnabled = YES;
        [self addSubview:self.shareView];
        
        self.reloadView = [[UIImageView alloc] initWithFrame:Rect(kLeftSpace*4+kFramWidth*3, kTopSpace, kFramWidth, kFramHeigth)];
        self.reloadView.image = [UIImage imageNamed:@"refreshBtn@2x.png"];
        self.reloadView.userInteractionEnabled = YES;
        [self addSubview:self.reloadView];
        
        UIImageView *imageSepView = [[UIImageView alloc] initWithFrame:Rect(0, -4, 320, 5)];
        imageSepView.image = [UIImage imageNamed:@"tool_footersep.png"];
        [self addSubview:imageSepView];
        
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
