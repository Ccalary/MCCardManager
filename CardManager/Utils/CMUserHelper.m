//
//  CMUserHelper.m
//  CardManager
//
//  Created by caohouhong on 2018/7/5.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMUserHelper.h"

@implementation CMUserHelper
+ (void)setCardData:(NSArray *)array {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:array forKey:@"cardsInfo"];
    [defaults synchronize];
}

+ (NSArray *)getCardData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:@"cardsInfo"];
    return array;
}

+ (void)setHeaderImageData:(NSData *)data {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:data forKey:@"header"];
    [defaults synchronize];
}

+ (NSData *)getHeaderImageData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults valueForKey:@"header"];
    return data;
}
@end
