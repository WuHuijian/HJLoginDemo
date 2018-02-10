//
//  ViewController.m
//  HJLoginDemo
//
//  Created by WHJ on 2018/2/7.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJLoginExample01_VC.h"
#import "HJLoginExample02_VC.h"
#import "HJLoginExample03_VC.h"
#import "HJLoginExample04_VC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - About UI
- (void)setupUI{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 0.f;
    tableView.estimatedSectionHeaderHeight = 0.f;
    tableView.estimatedSectionFooterHeight = 0.f;
    [self.view addSubview:tableView];
    
}

#pragma mark - Request Data

#pragma mark - Pravite Method

#pragma mark - Public Method

#pragma mark - Event response

#pragma mark - Delegate methods

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"HJLoginExample01_VC";
        cell.detailTextLabel.text = @"普通背景登录页";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"HJLoginExample02_VC";
        cell.detailTextLabel.text = @"Gif背景登录页";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"HJLoginExample03_VC";
        cell.detailTextLabel.text = @"模糊背景登录页";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"HJLoginExample04_VC";
        cell.detailTextLabel.text = @"重力感应背景登录页";
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            HJLoginExample01_VC *login01VC = [[HJLoginExample01_VC alloc] init];
            [self.navigationController pushViewController:login01VC animated:YES];
            
        }
            break;
        case 1:{
            HJLoginExample02_VC *login02VC = [[HJLoginExample02_VC alloc] init];
            [self.navigationController pushViewController:login02VC animated:YES];
        }
            break;
        case 2:{
            HJLoginExample03_VC *login03VC = [[HJLoginExample03_VC alloc] init];
            [self.navigationController pushViewController:login03VC animated:YES];
            
        }
            break;
        case 3:{
            HJLoginExample04_VC *login04VC = [[HJLoginExample04_VC alloc] init];
            [self.navigationController pushViewController:login04VC animated:YES];
            
        }
            break;
        default:
            break;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}

#pragma mark - Getters/Setters/Lazy
@end
