//
//  FLYMyView.m
//  DrawWithFire
//
//  Created by fenglianyi on 14-7-16.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYMyView.h"
#import <QuartzCore/QuartzCore.h>
@implementation FLYMyView

//{
//    CAEmitterLayer* _fireEmitter;
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setView];
        
    }
    return self;
}



- (void)setView
{
    self.backgroundColor = [UIColor clearColor];
    self.fireEmitter = (CAEmitterLayer*)self.layer;
    // 发射粒子坐标
    self.fireEmitter.emitterPosition = CGPointMake(160, -30);
    // 发射粒子的范围
    self.fireEmitter.emitterSize = CGSizeMake(160, 0);
    
    self.fireEmitter.shadowOpacity = 1.0;
    self.fireEmitter.shadowRadius = 0.0;
    self.fireEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
	  self.fireEmitter.shadowColor  = [[UIColor whiteColor] CGColor];
    // 好像是用来调整粒子的显示状态
//    kCAEmitterLayerOldestFirst
    _fireEmitter.renderMode = kCAEmitterLayerOutline;
    _fireEmitter.emitterShape = kCAEmitterLayerLine;
    // 粒子基本设置
    CAEmitterCell* cell = [CAEmitterCell emitterCell];
    // 产生的个数
    cell.birthRate = 1.0;
    cell.lifetime = 120.0;
    cell.lifetimeRange = 0.5;
    cell.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    cell.contents = (id)[[UIImage imageNamed:@"DazFlake.png"] CGImage];
    cell.name = @"cell";
    
    
    // 粒子移动速度  移动范围  和移动的角度
    cell.velocity = -10;
    cell.velocityRange = 10;
    cell.yAcceleration = 2;
    cell.emissionRange = 0.5*M_PI;
    // 粒子旋转速度
    cell.spinRange = 0.25* M_PI;
    
    
    // 粒子变大速度
    //    fire.scaleSpeed = 0.3;
    // 粒子旋转速度
    //    fire.spin = 5;
    
    
    // 添加粒子

    self.fireEmitter.emitterCells = [NSArray arrayWithObject:cell];
    
    

    
}








+ (Class) layerClass
{
    
    return [CAEmitterLayer class];
}










//Birthrate(出生率)：每秒发射的粒子数量，一个好的火焰或者瀑布你最少需要几百个粒子，所以我们设置为200
//lifetime(生命时间):一个粒子几秒后消失，我们设置为3.0
//liftetimeRange(生命时间变化范围)：你可以用这个东西使粒子的lifetime产生少许变化。粒子系统会随机在这个区间中取一个lifetime出来(lifetime – lifetimeRange, lifetime + lifetimeRange) 在我们的程序中，粒子会存活2.5~3.5秒
//Color(颜色)：粒子内容的颜色，我们这里选择橙色
//Contents(内容):用于cell的内容，一般是一个CGImage. 我们把它赋值给粒子图像。
//Name(名称):你可以给你的cell取一个名字，用来在之后的时间里查找和修改它的属性。
//velocity(速度): 粒子每秒移动的像素数. 这里我们让cell发射的粒子向屏幕的右边沿移动这里我们设置如下的新属性在CAEimtterCell中：
//velocityRange(速度范围): 速度变化范围，和lifetimeRange相似
//emissionRange(发射角度):这是一个cell发射的角度范围(弧度制).M_PI_2(pi/2)是45度(也就是说生成范围会+-45度)
//ScaleSpeed(变大速度)：每秒修改粒子大小的百分比。我们设置0.3让粒子随着时间则推移变大 这里我们设置如下的新属性在CAEimtterCell中
//Spin(旋转):每个粒子的旋转速率。我们设置0.5来给粒子一个漂亮的旋转


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
