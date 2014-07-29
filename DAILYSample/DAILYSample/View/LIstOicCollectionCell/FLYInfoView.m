//
//  FLYInfoView.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-28.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYInfoView.h"

@interface FLYInfoView ()

@property (nonatomic, strong) UILabel *breifLabel;
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation FLYInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.breifLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.breifLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}




- (void) setlabelInfoWithPicModel:(FLYPicStoryPicModel *)picModel
{

    self.breifLabel.frame = CGRectZero;
    self.titleLabel.frame = CGRectZero;
    NSString *breifStr = picModel.breif;
    float x = 0;
    if (![breifStr  isEqual: @""]) {
        x = 40;
        self.breifLabel.frame = Rect(0, 0, 320, 40);
        self.breifLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
        self.breifLabel.text = breifStr;
    }
    
    
    
    NSString *infoStr = picModel.title;
    float height = [self p_getLabelHeigthWithLbText:infoStr fontSize:14];
    self.titleLabel.frame = Rect(0, 10 + x, 320, height);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = infoStr;
    
    
}


#pragma  mark -- private methods
// 通过字符串和字体大小确定label的高度
- (float)p_getLabelHeigthWithLbText:(NSString *)text fontSize:(int)fontsize
{
    
    CGRect contBounds = [text boundingRectWithSize:CGSizeMake(320, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName] context:nil];
    float heigth = CGRectGetHeight(contBounds);
    return heigth;
    
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
