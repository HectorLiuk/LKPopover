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
 *  提示窗箭头尺寸 默认{10，10},
 */
@property (nonatomic, assign) CGSize arrowSize;
/**
 *  边角弧度 默认6.0f
 */
@property (nonatomic, assign, readonly) CGFloat cornerRadius;
/**
 *  点击提示窗动画持续时间 默认0.5f
 */
@property (nonatomic, assign) CGFloat animationShow;
/**
 *  取消提示窗动画持续时间 默认0.5f
 */
@property (nonatomic, assign) CGFloat animationDismss;
/**
 *  用来控制具体屏幕边缘距离 默认4.0f
 */
@property (nonatomic, assign) CGFloat sideEdge;
/**
 *  开启spring动画效果 默认是开启的
 */
@property (nonatomic, assign, getter = isAnimationSpring) BOOL animationSpring;
/**
 *  提示窗的阴影效果是用它来控制的 默认是开启的 你可以自己去设置它
 */
@property (nonatomic, assign, getter=isApplyShadow) BOOL applyShadow;
/**
 *  这个是用来控制填出提示窗触发视图与提示窗箭头的距离 默认是3.0
 */
@property (nonatomic, assign) CGFloat betweenAtViewAndArrowHeight;
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
/**
 * 提示窗下面的半透明灰色遮罩。 如果你需要它,touch它提示窗就会消失,否则他event(userInterfaceEnabled)就会No
 */
@property (nonatomic, strong, readonly) UIControl *grayOverlay;

@end
