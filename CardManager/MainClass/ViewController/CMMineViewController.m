//
//  CMMineViewController.m
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMMineViewController.h"
#import "CMMessageVC.h"
#import "CMSearchResultVC.h"

@interface CMMineViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSString *version;
@end

@implementation CMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"Cards",@"Message",@"Contact",@"Version"];
    self.imageArray = @[@"icon-ka",@"icon-xiaoxi",@"icon-renzheng",@"icon-dingdan"];
    _version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self cm_initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tableView reloadData];
}

- (void)cm_initView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 270*UIRate)];
    [self.view addSubview:topView];
    
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = CGRectMake(0, 0, ScreenWidth, 240*UIRate);
    gradLayer.colors =  @[(__bridge id)[UIColor themeColor].CGColor,(__bridge id)[UIColor colorWithHex:0xffffff].CGColor];
    gradLayer.startPoint = CGPointMake(0.5, 0);
    gradLayer.endPoint = CGPointMake(0.5, 1);
    [self.view.layer addSublayer:gradLayer];
    
    
    NSData *data = [CMUserHelper getHeaderImageData];
    UIImage *headerImage = [UIImage imageNamed:@"header"];
    if (data){
        headerImage = [UIImage imageWithData:data];
    }
    _headerBtn = [[UIButton alloc] init];
    [_headerBtn setBackgroundImage:headerImage forState:UIControlStateNormal];
    _headerBtn.layer.cornerRadius = 37.5*UIRate;
    _headerBtn.layer.masksToBounds = YES;
    [_headerBtn addTarget:self action:@selector(headerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headerBtn];
    [_headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(75*UIRate);
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(topView).offset(-30);
    }];
    
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.text = @"Welcome here!";
    _totalLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_totalLabel];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headerBtn.mas_bottom).offset(20);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[indexPath.row]]];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.detailTextLabel.text = @"";
    if (indexPath.row == 0){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[CMUserHelper getCardData].count];
    }else if (indexPath.row == self.dataArray.count - 1){
        cell.detailTextLabel.text = self.version;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            CMSearchResultVC *vc = [[CMSearchResultVC alloc] init];
            vc.navigationItem.title = @"Cards";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
            [self.navigationController pushViewController:[[CMMessageVC alloc] init] animated:YES];
            break;
        case 2:
            [self phoneCall];
            break;
        default:
            break;
    }
}

// 头像点击事件
- (void)headerAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Change Head Portrait" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
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



- (void)phoneCall {
    //10.0之后好像拨打电话会有两秒的延迟，此方法可以秒打
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
        NSString *phone = [NSString stringWithFormat:@"tel://13773047057"];
        NSURL *url = [NSURL URLWithString:phone];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                NSLog(@"phone success");
            }];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
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
        
        [LCProgressHUD showInfoMsg:@"该设备不支持拍照"];
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
    [self.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        [CMUserHelper setHeaderImageData:data];
    });
}

@end
