//
//  CMCardModel.h
//  CardManager
//
//  Created by caohouhong on 2018/7/5.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCardModel : NSObject
@property (nonatomic, copy) NSString *dateId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *numbers;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSData *frontData;
@property (nonatomic, copy) NSData *backData;
@end
