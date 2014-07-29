//
//  FLYLargePicView.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-28.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYLargePicView.h"

@interface FLYLargePicView ()



@end

@implementation FLYLargePicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.largeimgView = [[UIImageView alloc] initWithFrame:Rect(0, 0, 320, 240)];
        self.largeimgView.userInteractionEnabled = YES;
        
        
        self.largeScrollView = [[UIScrollView alloc] initWithFrame:Rect(0, 0, 320, 240)];
        self.largeScrollView.delegate = self;
        self.largeScrollView.contentSize = CGSizeMake(757, 568);
        [self.largeScrollView addSubview:self.largeimgView];
        self.largeScrollView.minimumZoomScale = 0.5;
        self.largeScrollView.maximumZoomScale = 2;
        
        [self addSubview:self.largeScrollView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return self.largeimgView;
    
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
