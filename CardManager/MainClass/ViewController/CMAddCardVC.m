//
//  CMAddCardVC.m
//  CardManager
//
//  Created by caohouhong on 2018/7/5.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMAddCardVC.h"
#import "CMCardModel.h"

@interface CMAddCardVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UITextField *remarkText;
@property (weak, nonatomic) IBOutlet UIButton *frontBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSMutableDictionary *mDictionary;
@property (strong, nonatomic) CMCardModel *model;

@end

@implementation CMAddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[CMCardModel alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)frontViewAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.type = 1;
    [self photoViewActionWithTitle:@"Front View"];
}

- (IBAction)backViewAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.type = 2;
    [self photoViewActionWithTitle:@"Back View"];
}

// Done
- (void)rightBarAction {
    if (self.nameText.text.length <= 0){
        [LCProgressHUD showFailure:@"Please enter name"];
        return;
    }
    
    if (self.numberText.text.length <= 0){
        [LCProgressHUD showFailure:@"Please enter number"];
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHMMss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    self.model.dateId = dateStr;
    self.model.name = self.nameText.text;
    self.model.numbers = self.numberText.text;
    self.model.remarks = self.remarkText.text;
    self.model.type = self.navigationItem.title;
    
    _mDictionary = [NSMutableDictionary dictionary];
    [_mDictionary setValue:self.model.dateId forKey:@"dateId"];
    [_mDictionary setValue:self.model.type forKey:@"type"];
    [_mDictionary setValue:self.model.name forKey:@"name"];
    [_mDictionary setValue:self.model.numbers forKey:@"numbers"];
    [_mDictionary setValue:self.model.remarks forKey:@"remarks"];
    [_mDictionary setValue:self.model.frontData forKey:@"frontData"];
    [_mDictionary setValue:self.model.backData forKey:@"backData"];
    
    NSArray *cardArray = [CMUserHelper getCardData];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:cardArray];
    [mArray addObject:[_mDictionary mutableCopy]];
    [CMUserHelper setCardData:[mArray mutableCopy]];
    [LCProgressHUD showSuccess:@"Add Success!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

// 点击事件
- (void)photoViewActionWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/** 相机 */
- (void)openCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        [LCProgressHUD showInfoMsg:@"Can not take photo!"];
    }
}

/** 相册 */
- (void)openPhotoLibrary
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.type == 1){
        [self.frontBtn setTitle:@"" forState:UIControlStateNormal];
        self.frontImageView.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        self.model.frontData = data;
    }else {
        [self.backBtn setTitle:@"" forState:UIControlStateNormal];
        self.backImageView.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        self.model.backData = data;
    }
}
@end
