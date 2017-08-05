
//
//  TbSegmentBar.m
//  TbSegmentBar
//
//  Created by Tb on 2017/7/30.
//  Copyright © 2017年 Tb. All rights reserved.
//

#define kMinMargin 30


#import "TbSegmentBar.h"
#import "UIView+XMGSegmentBar.h"
@interface TbSegmentBar()

@property (nonatomic, strong)UIScrollView *contentView;

@property (nonatomic, strong)UIButton *itemClickedButton;

@property (nonatomic, strong)UIView *indicatorView;

@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;



@end

@implementation TbSegmentBar

+ (instancetype)segmentBarWithFrame:(CGRect)frame
{
    TbSegmentBar *bar = [[TbSegmentBar alloc] initWithFrame:frame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    [bar addSubview:scrollView];
    bar.contentView = scrollView;
    return bar;
}

- (NSMutableArray<UIButton *> *)itemBtns {
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2, 0, 2)];
        _indicatorView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex < 0 || selectIndex > self.items.count - 1 || self.itemBtns.count == 0) {
        return;
    }
    
    UIButton *btn = self.itemBtns[selectIndex];
    [self buttonClick:btn];
    
  }

- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    
    // 删除之前添加过多额组件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (int i = 0; i < self.items.count; i++) {
        UIButton *itemButton = [[UIButton alloc] init];
        itemButton.tag = i;
        [itemButton setTitle:self.items[i] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
         [itemButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [self.contentView addSubview:itemButton];
        [self.itemBtns addObject:itemButton];
        [itemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    }
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
     self.contentView.frame = self.bounds;
    
    CGFloat totalButtonW = 0.0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalButtonW += btn.width;
    }
    
    CGFloat margain = (self.width - totalButtonW) / (self.items.count + 1);
    
    
    if (margain < kMinMargin) {
        margain = kMinMargin;
    }
    
    
    CGFloat lastX = margain;
    
    for (UIButton *button in self.itemBtns) {
        
        [button sizeToFit];
        button.centerY = self.height * 0.5;
        
        button.x = lastX;
        
        lastX += button.width + margain;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
}

- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(TbSegmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate TbSegmentBar:self didSelectIndex:button.tag fromIndex:self.itemClickedButton.tag];
    }
    
    self.itemClickedButton.selected = NO;
    button.selected = YES;
    self.itemClickedButton = button;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = button.width;
        self.indicatorView.centerX = button.centerX;
    }];

    
    CGFloat scrollX = button.centerX - self.contentView.width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}


@end
