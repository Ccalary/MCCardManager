//
//  UIColor+CMColor.m
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "UIColor+CMColor.h"

@implementation UIColor (CMColor)
//MARK:- Theme
+ (UIColor *)themeColor{
    return [UIColor colorWithHex:0x02b7dd];
}

//MARK:- Method
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)randomColor
{
    return [UIColor colorWithRed:(arc4random()%255)*1.0f/255.0
                           green:(arc4random()%255)*1.0f/255.0
                            blue:(arc4random()%255)*1.0f/255.0 alpha:1.0];
}
@end
