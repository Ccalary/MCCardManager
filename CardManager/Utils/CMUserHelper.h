//
//  CMUserHelper.h
//  CardManager
//
//  Created by caohouhong on 2018/7/5.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMUserHelper : NSObject

+ (void)setCardData:(NSArray *)array;
+ (NSArray *)getCardData;

+ (void)setHeaderImageData:(NSData *)data;
+ (NSData *)getHeaderImageData;
@end
