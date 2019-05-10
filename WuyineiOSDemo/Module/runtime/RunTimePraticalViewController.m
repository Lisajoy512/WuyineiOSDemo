//
//  RunTimePraticalViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/5/10.
//  Copyright © 2019年 wuyine. All rights reserved.
//

#import "RunTimePraticalViewController.h"
#import <Masonry.h>
@interface RunTimePraticalViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation RunTimePraticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    }
    return _imageView;
}

@end
