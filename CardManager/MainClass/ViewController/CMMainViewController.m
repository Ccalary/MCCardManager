//
//  CMMainViewController.m
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMMainViewController.h"
#import "CMAddCardVC.h"

@interface CMMainViewController ()

@end

@implementation CMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cm_initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)cm_initView {
    UIButton *bankCard = [self creatButtonWithTitle:@"Bank Card" bgImage:@"card1"];
    [bankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_offset(15);
        make.height.mas_equalTo(165);
    }];
    
    UIButton *idCard = [self creatButtonWithTitle:@"ID Card" bgImage:@"card2"];
    [idCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ScreenWidth/3.0);
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(bankCard.mas_bottom).offset(10);
    }];
    
    UIButton *vipCard = [self creatButtonWithTitle:@"Vip Card" bgImage:@"card3"];
    [vipCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(idCard);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(idCard);
    }];
    
    UIButton *more = [self creatButtonWithTitle:@"E-Card" bgImage:@"card4"];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(idCard);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(idCard);
    }];
    
    UIButton *otherCard = [self creatButtonWithTitle:@"Other Card" bgImage:@"card5"];
    [otherCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(idCard);
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(idCard.mas_bottom).offset(10);
    }];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title bgImage:(NSString *)imageStr{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    [button setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)buttonAction:(UIButton *)button {
    CMAddCardVC *vc = [[CMAddCardVC alloc] init];
    vc.navigationItem.title = button.currentTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
