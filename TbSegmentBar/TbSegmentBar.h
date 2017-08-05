//
//  TbSegmentBar.h
//  TbSegmentBar
//
//  Created by Tb on 2017/7/30.
//  Copyright © 2017年 Tb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TbSegmentBar;

@protocol TbSegmentBarDelegate <NSObject>

- (void)TbSegmentBar:(TbSegmentBar *)segmentBar didSelectIndex:(NSInteger )toIndex fromIndex: (NSInteger)fromIndex;

@end


@interface TbSegmentBar : UIView

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

@property (nonatomic, strong)NSArray<NSString *> *items;

@property (nonatomic, assign)NSInteger selectIndex;

@property (nonatomic, weak)id<TbSegmentBarDelegate>delegate;
@end
