//
//  FLYImageTableViewCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYImageTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface FLYImageTableViewCell ()

{
    
    UIImageView *_imageView;
    UILabel *_label;
    
}


@end

@implementation FLYImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] initWithFrame:Rect(0, 0, 320, 175)];
        [self.contentView addSubview:_imageView];
        
        
        _label = [[UILabel alloc] initWithFrame:Rect(10, 155, 300, 20)];
        [self.contentView addSubview:_label];
        
        
        
    }
    return self;
}



- (void)setcellInputViewDataAndFramWithFLYimage_textModel:(FLYimage_textModel *)imageModel
{
    
    [_imageView setImageWithURL:[NSURL URLWithString:imageModel.first_image] placeholderImage:[UIImage imageNamed:@"FLYING2X.PNG"]];
    _label.backgroundColor = RGBA(255, 255, 255, 0.5);
    _label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = imageModel.title;
    
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
