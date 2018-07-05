//
//  CMSearchResultVC.m
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMSearchResultVC.h"
#import "CMCardInfoVC.h"

@interface CMSearchResultVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CMSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
     [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMCardInfoVC *vc = [[CMCardInfoVC alloc] init];
    vc.dic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


//走了左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){//删除操作
        NSDictionary *resultDic = self.dataArray[indexPath.row];
        NSArray *array = [CMUserHelper getCardData];
        NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
        for (NSDictionary *dic in array){
            if ([dic[@"dateId"] isEqualToString:resultDic[@"dateId"]]){
                [mArray removeObject:dic];
            }
        }
        [CMUserHelper setCardData:[mArray mutableCopy]];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        //删除某行并配有动画
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//更改左滑后的字体显示
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果系统是英文，会显示delete,这里可以改成自己想显示的内容
    return @"delete";
}

- (void)reloadData {
    NSArray *array = [CMUserHelper getCardData];
    [self.dataArray removeAllObjects];
    if (self.searchText.length > 0){
        for (NSDictionary *dic in array){
            if ([[dic objectForKey:@"name"] isEqualToString:_searchText]){
                [self.dataArray addObject:dic];
            }
        }
    }else {
        [self.dataArray addObjectsFromArray:array];
    }
    [self.tableView reloadData];
}
@end
