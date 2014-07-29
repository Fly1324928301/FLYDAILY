//
//  FLYNewsTableViewCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYNewsTableViewCell.h"
#import "UIImageView+WebCache.h"

static const int kLeftSpace = 10;
static const int kTopSpace = 10;
static const int kVerticalSpace = 5;

@interface FLYNewsTableViewCell()
{
    
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_infoLabel;
    
}


@end


@implementation FLYNewsTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleLabel];
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_infoLabel];
        
        
        
    }
    return self;
}




// 设置显示内容
- (void)setNewscellInputViewDataAndFramWithNews:(FLYNews *)news
{
    
    float height = [news.image_real_height floatValue];
    float width = [news.image_real_width floatValue];
    height = height *100 / width;
    _imageView.frame = Rect(kLeftSpace, kTopSpace, 100, height);
    [_imageView setImageWithURL:[NSURL URLWithString:news.image] placeholderImage:[UIImage imageNamed:@"FLYING2X.PNG"]];
    
    _titleLabel.frame = Rect(kLeftSpace*2 + 100, kTopSpace, 190, 16);
    _titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16];
    _titleLabel.text = news.title;
    
    
    _infoLabel.frame = Rect(kLeftSpace*2 + 100, kTopSpace + kVerticalSpace +16, 190, height - 16 - kVerticalSpace);
    _infoLabel.font = [UIFont systemFontOfSize:12];
    _infoLabel.numberOfLines = 0;
    _infoLabel.text = news.info;
    
    
    
}






// cell高度
+ (float)setNewsCellHeigthWithNews:(FLYNews *)news
{
    
    
    float height = [news.image_real_height floatValue];
    float width = [news.image_real_width floatValue];
    height = height *100 / width;
    return (height + kTopSpace*2);
    
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
