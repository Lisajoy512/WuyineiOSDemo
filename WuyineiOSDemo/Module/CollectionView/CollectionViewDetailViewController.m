//
//  CollectionViewDetailViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/6/6.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "CollectionViewDetailViewController.h"

@interface CollectionViewDetailViewController ()

@end

@implementation CollectionViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView";
    self.dataArray = @[@"普通collectionView",
                       @"estimatedItemSize-Controller",
                       @"自适应String的layout",
                       @"WaterFallController-瀑布流",
                       @"collectionView区头"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            
            break;
        }
    }
}

@end
