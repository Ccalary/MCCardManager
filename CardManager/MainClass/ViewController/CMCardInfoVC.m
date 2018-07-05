//
//  CMCardInfoVC.m
//  CardManager
//
//  Created by caohouhong on 2018/7/5.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMCardInfoVC.h"

@interface CMCardInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation CMCardInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Card Info";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    self.frontImageView.image = [UIImage imageWithData:self.dic[@"frontData"]];
    self.backImageView.image = [UIImage imageWithData:self.dic[@"backData"]];
    self.nameLabel.text = self.dic[@"name"];
    self.numberLabel.text = self.dic[@"numbers"];
    self.remarkLabel.text = self.dic[@"remarks"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)rightBarAction {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Delete" message:@"You will lost this message" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteInfo];
    }]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)deleteInfo {
    NSArray *array = [CMUserHelper getCardData];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
    for (NSDictionary *dic in array){
        if ([dic[@"dateId"] isEqualToString:self.dic[@"dateId"]]){
            [mArray removeObject:dic];
        }
    }
    [CMUserHelper setCardData:[mArray mutableCopy]];
    [LCProgressHUD showSuccess:@"Delete Success"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

@end
