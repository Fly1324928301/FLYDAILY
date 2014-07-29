//
//  FLYlunBoTableViewCell.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-23.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//
#import "FLYlunBoTableViewCell.h"
#import "TFTScrillImageView.h"
#import "FLYNews.h"
#import "SDWebImageManager.h"



@interface FLYlunBoTableViewCell ()

//@property (nonatomic, strong) __block UILabel *_titleLabel;
//@property (nonatomic, strong) __block


@end

@implementation FLYlunBoTableViewCell
{
    TFTScrillImageView *_lunBoView;
    __block UILabel *_titleLabel;
    __block UILabel *_introLabel;
    __block UIPageControl *_page;
    __block NSArray *tempArry;
    
}




// 初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSMutableArray *arry = [NSMutableArray array];
        for (int i = 0; i < 3; i ++) {
        UIImage *image = [UIImage imageNamed:@"FLYING2X.png"];
        [arry addObject:image];
        }
        _lunBoView = [[TFTScrillImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 235) images:arry];
        _titleLabel = [[UILabel alloc]initWithFrame:Rect(10, 245, 300, 30)];
        _introLabel = [[UILabel alloc]initWithFrame:Rect(10, 280, 300, 40)];
        _page = [[UIPageControl alloc]initWithFrame:Rect(80, 200, 160, 20)];
        
        _page.currentPage = 0;
        _page.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self.contentView addSubview:_lunBoView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        [self.contentView addSubview:_page];
    }
    return self;
}


// 设置轮播图
- (void)setLunBoViewWithHeadlineArry:(NSArray *)array
{
    if(array != nil){
        tempArry = array;
        _page.numberOfPages = tempArry.count;
        NSMutableArray *urlArry = [NSMutableArray array];
        NSMutableArray *tempimageArray = [[NSMutableArray alloc]initWithCapacity:1];
        for (FLYNews *news in tempArry) {
            UIImage *imagex = [UIImage imageNamed:@"FLYING2X.png"];
            [urlArry addObject:news.image];
            [tempimageArray addObject:imagex];
        }
        // label
        __weak id tempSelf = self;
        [_lunBoView didRefreshImageBlocks:^(NSInteger currentIndex) {
            
            [tempSelf p_settextInfoWithIndex:currentIndex];
            
        }];
        
        
        // pic
        if (tempArry != nil) {
            [_lunBoView reloadImages:tempimageArray];
        }
        for (NSString *imurl in urlArry) {
            NSURL *url= [NSURL URLWithString:imurl];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                NSInteger index = [urlArry indexOfObject:imurl];
                [_lunBoView replaceImage:image atIndex:index];
            }];
        }
        
        
        [self p_setImageViewCanClick];

    }

}





- (void)p_settextInfoWithIndex:(NSInteger)currentIndex
{
    
    FLYNews *objNews = tempArry[currentIndex];
    _titleLabel.text = [objNews.title copy];
    _titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
    _introLabel.text = [objNews.info copy];
    _introLabel.numberOfLines = 0;
    _introLabel.font = [UIFont systemFontOfSize:14];
    _page.currentPage = currentIndex;
    
    
}





- (void)p_setImageViewCanClick
{
    
    [_lunBoView didTapImageUsingBlock:^(NSInteger currentIndex) {
       
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getindex" object:[NSNumber numberWithInteger:currentIndex]];
        
    }];
    
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
