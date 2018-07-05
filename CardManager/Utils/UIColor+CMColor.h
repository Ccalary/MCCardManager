//
//  UIColor+CMColor.h
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CMColor)
/** 主题颜色 02b7dd 橘绿色*/
+ (UIColor *)themeColor;


#pragma mark - 方法
/** 十六进制颜色  eg:0xffffff*/
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
/** 十六进制颜色  eg:0xffffff, 1*/
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
/** 随机颜色 */
+ (UIColor*)randomColor;
@end
