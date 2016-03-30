//
//  LKPopover.m
//  LKPopover
//
//  Created by lk on 16/3/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPopover.h"

@interface LKPopover()
/**
 *  提示窗背景颜色包括箭头
 */
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign, readwrite) CGFloat cornerRadius;

@end



@implementation LKPopover

+ (instancetype)popover{
    return [[LKPopover alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        [self propertyInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    //CGRectZero 1>设计时考虑到根据显示的内容尺度画出mask
    //           2>设置CGRectZero 创建时不会调用drawRect,保证设置属性有效果,也有点考虑性能防止反复绘制
    if (self = [super initWithFrame:CGRectZero]) {
        [self propertyInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self propertyInit];
    }
    return self;
}

- (void)propertyInit{
    self.arrowSize = CGSizeMake(10, 10);
    self.animationShow = 0.5f;
    self.animationDismss = 0.5f;
    self.betweenAtViewAndArrowHeight = 3.0f;
    self.sideEdge = 4.0f;
    self.cornerRadius = 6.0f;
    self.animationSpring = YES;
    self.maskType = LKPopoverMaskTypeGray;
    self.applyShadow = YES;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    //重写父类方法,mask是用贝塞尔曲线绘制,获取到颜色fill使mask背景颜色一致(包括箭头)
    [super setBackgroundColor:[UIColor clearColor]];
    self.contentColor = backgroundColor;
}


@end
