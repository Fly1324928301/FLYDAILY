//
//  FLYHomePageTableViewCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-23.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYHomePageTableViewCell.h"

#import "UIImageView+WebCache.h"
static const int kLeftSpace = 10;
static const int kTopSpace = 10;
static const int kVerticalSpace = 5;

@interface FLYHomePageTableViewCell ()
{
    
    UILabel *_titleLabel;
    UILabel *_authorLabel;
    UIImageView *_imageVw;
    UILabel *_infoLabel;
    UILabel *_tagLabel;
    UILabel *_dateLabel;
    
}
// 通过字符串和字体大小确定label的高度
- (float)p_getLabelHeigthWithLbText:(NSString *)text fontSize:(int)fontsize;

@end

@implementation FLYHomePageTableViewCell


#pragma  mark -- publick methods
// 初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _imageVw = [[UIImageView alloc] initWithFrame:CGRectZero];
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_authorLabel];
        [self.contentView addSubview:_imageVw];
        [self.contentView addSubview:_infoLabel];
        [self.contentView addSubview:_tagLabel];
        [self.contentView addSubview:_dateLabel];
        
    }
    return self;
}


// 设置显示内容
- (void)setcellInputViewDataAndFramWithNews:(FLYNews *)news
{
    // 标题
    NSString *title = news.title;
    float titleHeigth = [self p_getLabelHeigthWithLbText:title fontSize:20];
    _titleLabel.frame = Rect(kLeftSpace, kTopSpace, 300, titleHeigth);
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    _titleLabel.text = title;
    
    // 作者
    float authorHeigth = 0.0;
    if (news.author != nil) {
        authorHeigth = kVerticalSpace + 20;
        _authorLabel.frame = Rect(kLeftSpace, kTopSpace + titleHeigth + kVerticalSpace, 300, 20);
        _authorLabel.font = [UIFont systemFontOfSize:12];
        _authorLabel.text = news.author;
    }
    
    // 图片
    float imgHeigth = [news.image_real_height floatValue];
    float imgWidth = [news.image_real_width floatValue];
    imgHeigth = 300.0 / imgWidth * imgHeigth;
    _imageVw.frame = Rect(kLeftSpace, kTopSpace + kVerticalSpace + titleHeigth + authorHeigth, 300, imgHeigth);
    [_imageVw setImageWithURL:[NSURL URLWithString:news.first_image] placeholderImage:[UIImage imageNamed:@"FLYING2X.png"]];
    
    // 内容
    float infoHeigth = [self p_getLabelHeigthWithLbText:news.info fontSize:14];
    _infoLabel.font = [UIFont systemFontOfSize:14];
    _infoLabel.numberOfLines = 0;
    _infoLabel.frame = Rect(kLeftSpace, kTopSpace + kVerticalSpace*2 + titleHeigth + authorHeigth + imgHeigth, 300, infoHeigth);
    _infoLabel.text = news.info;
    
    //分类
    NSString *tagStr = news.tag;
    tagStr = [tagStr stringByReplacingOccurrencesOfString:@" " withString:@"#"];
    tagStr = [@"#" stringByAppendingString:tagStr];
    _tagLabel.frame = Rect(kLeftSpace, kTopSpace + kVerticalSpace*3 + titleHeigth + authorHeigth + imgHeigth + infoHeigth, 200, 15);
    _tagLabel.textColor = RGB(100, 100, 100);
    _tagLabel.font = [UIFont systemFontOfSize:12];
    _tagLabel.text = tagStr;
    
    // 日期
    _dateLabel.frame = Rect(kLeftSpace + 200, kTopSpace + kVerticalSpace*3 + titleHeigth + authorHeigth + imgHeigth + infoHeigth, 100, 15);
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.textColor = RGB(100, 100, 100);
    _dateLabel.text = news.dateinfo;
}



// cell高度
+ (float)setCellHeigthWithNews:(FLYNews *)news
{
    // 标题
    NSString *title = news.title;
    float titleHeigth = [self p_getheigthofClassWithLbText:title fontSize:20];
    
    float authorHeigth = 0.0;
    if (news.author != nil) {
        authorHeigth = kVerticalSpace + 20;
    }
    
    float imgHeigth = [news.image_real_height floatValue];
    float imgWidth = [news.image_real_width floatValue];
    imgHeigth = 300.0 / imgWidth * imgHeigth;
    
    float infoHeigth = [self p_getheigthofClassWithLbText:news.info fontSize:14];
    
    float cellHeigth = titleHeigth + authorHeigth + imgHeigth + infoHeigth + kTopSpace*2 + kVerticalSpace*3 + 15;
    return cellHeigth;
    
}




#pragma  mark -- private methods
// 通过字符串和字体大小确定label的高度
- (float)p_getLabelHeigthWithLbText:(NSString *)text fontSize:(int)fontsize
{
    
    CGRect contBounds = [text boundingRectWithSize:CGSizeMake(300, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName] context:nil];
    float heigth = CGRectGetHeight(contBounds);
    return heigth;
    
}

+ (float)p_getheigthofClassWithLbText:(NSString *)text fontSize:(int)fontsize
{
    CGRect contBounds = [text boundingRectWithSize:CGSizeMake(300, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName] context:nil];
    float heigth = CGRectGetHeight(contBounds);
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
