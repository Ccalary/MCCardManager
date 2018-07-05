//
//  CMSearchVC.m
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMSearchVC.h"
#import "CMSearchResultVC.h"

@interface CMSearchVC ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation CMSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cm_initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)cm_initView {
    
    UITapGestureRecognizer *atap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(atapAction)];
    [self.view addGestureRecognizer:atap];
    
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgImageView.image = [UIImage imageNamed:@"search_bg"];
    [self.view addSubview:bgImageView];
    
    UIView *searchHoldView = [[UIView alloc] init];
    searchHoldView.backgroundColor = [UIColor whiteColor];
    searchHoldView.layer.cornerRadius = 5.0;
    searchHoldView.layer.masksToBounds = YES;
    [self.view addSubview:searchHoldView];
    searchHoldView.clipsToBounds = YES;
    [searchHoldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.height.mas_equalTo(45);
        make.centerY.mas_equalTo(self.view).offset(-20);
    }];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"Search" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithHex:0xF6A623]];
    [searchHoldView addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.height.mas_equalTo(searchHoldView);
        make.width.mas_equalTo(80);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"Please enter the content";
    textField.textColor = [UIColor grayColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchHoldView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.height.mas_equalTo(searchHoldView);
        make.right.mas_equalTo(searchBtn.mas_left).offset(-10);
    }];
    self.textField = textField;
}


static CMSearchResultVC * extracted() {
    return [CMSearchResultVC alloc];
}

- (void)searchAction {
    CMSearchResultVC *vc = [extracted() init];
    vc.navigationItem.title = @"Search Result";
    vc.searchText = self.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)atapAction {
    [self.view endEditing:YES];
}
@end
