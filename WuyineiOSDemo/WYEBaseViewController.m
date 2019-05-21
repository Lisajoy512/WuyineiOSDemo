//
//  WYEBaseViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/4/29.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "WYEBaseViewController.h"
#import "Masonry.h"

@interface WYEBaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation WYEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_tableView reloadData];
}

- (void)setTableViewBackColor:(UIColor *)tableViewBackColor {
    _tableViewBackColor = tableViewBackColor;
    [_tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = self.tableViewBackColor;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(IsCopy== 1) {
        return 60;
    }
    else {
        return 44;
    }
}

@end
