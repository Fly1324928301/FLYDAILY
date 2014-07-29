//
//  TFTGlobalMacro.h
//  TFTDevelopmentKit
//
//  Created by SongXiaobo on 14-5-26.
//  Copyright (c) 2014年 SongXiaobo. All rights reserved.
//
//  全局宏 V1.0
//      -（由 SongXiaobo 更新于 14-5-26）
//      - 提供了 CGRect CGSize CGPoint 的便利生成
//      - 提供了指定范围内随机数的便利生成
//      - 提供了 UIFont 的便利创建
//      - 提供了获取屏幕宽度和高度的宏
//      - 基于 RGB 和 RGBA 颜色的便利创建
//      - 随机颜色
//      - 获取 UIColor 对象中 R、G、B、A 的值
//      - 判断一个 UIColor 对象是否是浅色，是否没有颜色
//

#define Rect(X, Y, W, H) (CGRectMake((X), (Y), (W), (H)))
#define Size(W, H) (CGSizeMake((W), (H)))
#define Point(X, Y) (CGPointMake((X), (Y)))

#define RandomNumber(A, B) (arc4random() % ((B) - (A) + 1) + (A))

#define Font(N, S) ([UIFont fontWithName:(N) size:(S)])

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define RGBA(R, G, B, A) ([UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:(A) / 1.0])
#define RGB(R, G, B) ([UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:1.0])
#define RandomColor (RGB(RandomNumber(0, 255), RandomNumber(0, 255), RandomNumber(0, 255)))
#define NumberOfRed(Color) (CGColorGetComponents((Color).CGColor)[0])
#define NumberOfGreen(Color) (CGColorGetComponents((Color).CGColor)[1])
#define NumberOfBlue(Color) (CGColorGetComponents((Color).CGColor)[2])
#define NumberOfAlpha(Color) (CGColorGetAlpha((Color).CGColor))
#define IsLighterColor(Color) ((NumberOfRed(Color) + NumberOfGreen(Color) + NumberOfBlue(Color)) / 3 >= 0.5)
#define IsClearColor(Color) ([(Color) isEqual:[UIColor clearColor]])
