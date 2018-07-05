//
//  CMMessageVC.m
//  CardManager
//
//  Created by caohouhong on 2018/7/5.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMMessageVC.h"

@interface CMMessageVC ()

@end

@implementation CMMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Message";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    label.text = @"Nothing here~";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
