//
//  FLYExhibitPicViewCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-26.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYExhibitPicViewCell.h"

@implementation FLYExhibitPicViewCell

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
    UIImage *image = self.cellImageView.image;
    CGSize size = image.size;
    float width = 145;
    float heigth = size.height * 145 / size.width;
    [self.cellImageView setFrame:Rect(0, 0, width, heigth)];
    
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