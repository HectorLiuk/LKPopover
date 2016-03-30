//
//  LKPopover.h
//  LKPopover
//
//  Created by lk on 16/3/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LKPopoverPositionType) {
    LKPopoverPositionTypeUp = 1,//箭头在content上面
    LKPopoverPositionTypeDown,
    LKPopoverPositionTypeLeft,
    LKPopoverPositionTypeRight,
};
typedef NS_ENUM(NSUInteger, LKPopoverMaskType) {
    LKPopoverMaskTypeGray = 1,//有蒙版效果,支持touch视图消失
    LKPopoverMaskTypeNone,//没有蒙版效果
};
typedef void(^animationBlock)(void);

@interface LKPopover : UIView

+ (instancetype)popover;

/**
 *  提示窗内容位置内边距,默认是zero;
 */
@property (nonatomic, assign) UIEdgeInsets contentInset;
/**
 *  提示窗箭头尺寸 {10，10},
 */
@property (nonatomic, assign) CGSize arrowSize;
/**
 *  边角弧度 默认5.0f
 */
@property (nonatomic, assign) CGFloat cornerRadius;
/**
 *  点击提示窗动画持续时间 默认0.5f
 */
@property (nonatomic, assign) CGFloat animationShow;
/**
 *  取消提示窗动画持续时间 默认0.5f
 */
@property (nonatomic, assign) CGFloat animationDismss;
/**
 *  开启spring动画效果 默认是开启的
 */
@property (nonatomic, assign, getter = isAnimationSpring) BOOL animationSpring;
/**
 *  回调 处理提示窗弹出后事务处理
 */
@property (nonatomic, copy) animationBlock didShowHandler;
/**
 *  回调 处理提示窗消失后事务处理
 */
@property (nonatomic, copy) animationBlock didDismssHandler;
/**
 *  底部蒙版类型,默认是LKPopoverMaskTypeGray
 */
@property (nonatomic, assign) LKPopoverMaskType maskType;
/**
 *  箭头在需要提示窗的位置
 */
@property (nonatomic, assign) LKPopoverPositionType positionType;

@end
