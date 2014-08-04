//
//  FLYAdaptPicTableViewCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYAdaptPicTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FLYAdaptPicTableViewCell
{
    
    UIImageView *_imageView;
    UILabel *_label;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_label];
        
    }
    return self;
}



- (void)setAdaptcellInputViewDataAndFramWithNews:(FLYNews *)news
{
    
    
    float heigth = [news.image_real_height floatValue];
    float width = [news.image_real_width floatValue];
    heigth = heigth * 320 / width;
    
    _imageView.frame = Rect(0, 0, 320, heigth);
    
    [_imageView setImageWithURL:[NSURL URLWithString:news.first_image] placeholderImage:[UIImage imageNamed:@"FLYING2X.PNG"]];
    _label.frame = Rect(0, heigth - 20, 320, 20);
    _label.backgroundColor = RGBA(255, 255, 255, 0.5);
    _label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = news.title;
    
}


+ (float)setAdaptCellHeigthWithNews:(FLYNews *)news
{
    
    float heigth = [news.image_real_height floatValue];
    float width = [news.image_real_width floatValue];
    heigth = heigth * 320 / width;
    return heigth;
    
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
