//
//  FLYStoryViewInfoCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-28.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYStoryViewInfoCell.h"

@implementation FLYStoryViewInfoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        self.cellImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.cellImageView];
        
    }
    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];

    [self.cellImageView setFrame:Rect(0, 0, 320, 240)];
    
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
