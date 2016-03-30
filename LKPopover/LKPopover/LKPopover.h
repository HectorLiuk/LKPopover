//
//  LKPopover.h
//  LKPopover
//
//  Created by lk on 16/3/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKPopover : UIView

+ (instancetype)popover;

/**
 *  提示窗内容位置内边距,默认是zero;
 */
@property (nonatomic, assign) UIEdgeInsets contentInset;
/**
 *  提示窗箭头尺寸,
 */
@property (nonatomic, assign) CGSize arrowSize;
/**
 *  边角弧度
 */
@property (nonatomic, assign) CGFloat cornerRadius;
/**
 *  点击提示窗动画持续时间
 */
@property (nonatomic, assign) CGFloat animationShow;
/**
 *  取消提示窗动画持续时间
 */
@property (nonatomic, assign) CGFloat animationDismss;

@end
