//
//  ViewController.m
//  TbSegmentBar
//
//  Created by Tb on 2017/7/30.
//  Copyright © 2017年 Tb. All rights reserved.
//

#import "ViewController.h"
#import "TbSegmentBar.h"
#import "UIView+XMGSegmentBar.h"
@interface ViewController ()<TbSegmentBarDelegate>

@property (nonatomic, strong)TbSegmentBar *bar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bar = [TbSegmentBar segmentBarWithFrame:CGRectMake(0, 60, self.view.width, 35)];
    self.bar.delegate = self;
    self.bar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bar];
    
    self.bar.items = @[@"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中", @"专辑", @"声音", @"下载中"];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.bar.selectIndex = 2;
}

- (void)TbSegmentBar:(TbSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"from:%zd,to:%zd",fromIndex,toIndex);
}



@end
