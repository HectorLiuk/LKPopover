//
//  LKPopover.m
//  LKPopover
//
//  Created by lk on 16/3/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPopover.h"
#define RADIANS(degrees) ((3.14159265359 * degrees) / 180)

@interface LKPopover()

@property (nonatomic, assign, readwrite) LKPopoverPositionType positionType;
/**
 *  容器视图 置于哪个视图之上
 */
@property (nonatomic, weak) UIView *containerView;
/**
 *  提示窗背景颜色包括箭头
 */
@property (nonatomic, strong) UIColor *contentColor;

@property (nonatomic, assign) CGPoint arrowShowPoint;

@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, assign) CGRect contentViewFrame;

@property (nonatomic, strong, readwrite) UIControl *grayOverlay;

@property (nonatomic, assign ,getter=isIOS7) BOOL iOS7;
@end



@implementation LKPopover
- (UIControl *)grayOverlay{
    if (!_grayOverlay) {
        _grayOverlay = [[UIControl alloc] init];
        _grayOverlay.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _grayOverlay;
}
- (BOOL)isIOS7{
    if (!_iOS7) {
        _iOS7 = ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending);
    }
    return _iOS7;
}

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
- (void)layoutSubviews {
    [self setUp];
}

- (void)propertyInit{
    self.arrowSize = CGSizeMake(11, 10);
    self.animationShow = 0.5f;
    self.animationDismss = 0.5f;
    self.betweenAtViewAndArrowHeight = 3.0f;
    self.sideEdge = 8.0f;
    self.cornerRadius = 6.0f;
    self.animationSpring = YES;
    self.maskType = LKPopoverMaskTypeGray;
    self.applyShadow = YES;
    self.backgroundColor = [UIColor whiteColor];

}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    //重写父类方法,mask是用贝塞尔曲线绘制,获取到颜色fill使mask背景颜色一致(包括箭头)
    [super setBackgroundColor:[UIColor clearColor]];
    self.contentColor = backgroundColor;
}

- (void)setUp{
    CGRect frame = self.contentViewFrame;
    
    CGFloat frameMidx = self.arrowShowPoint.x - CGRectGetWidth(frame) * 0.5;
    frame.origin.x = frameMidx;
    
    CGFloat sideEdge = 0.0;
    if (CGRectGetWidth(frame) < CGRectGetWidth(self.containerView.frame)) {
        sideEdge = self.sideEdge;
    }
    
    CGFloat outerSideEdge = CGRectGetMaxX(frame) - CGRectGetWidth(self.containerView.bounds);
    if (outerSideEdge > 0) {
        frame.origin.x -= (outerSideEdge + sideEdge);
    } else {
        if (CGRectGetMinX(frame) < 0) {
            frame.origin.x += ABS(CGRectGetMinX(frame)) + sideEdge;
        }
    }
    
    self.frame = frame;
    
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    CGPoint anchorPoint;
    switch (self.positionType) {
        case LKPopoverPositionTypeDown: {
            frame.origin.y = self.arrowShowPoint.y;
            anchorPoint = CGPointMake(arrowPoint.x / CGRectGetWidth(frame), 0);
        } break;
        case LKPopoverPositionTypeUp: {
            frame.origin.y = self.arrowShowPoint.y - CGRectGetHeight(frame) - self.arrowSize.height;
            anchorPoint = CGPointMake(arrowPoint.x / CGRectGetWidth(frame), 1);
        } break;
    }
    
    //控制动画出现 消失位置   默认是以箭头位置为动画起点和消失点
    CGPoint lastAnchor = self.layer.anchorPoint;
    self.layer.anchorPoint = anchorPoint;
    self.layer.position = CGPointMake(
                                      self.layer.position.x + (anchorPoint.x - lastAnchor.x) * self.layer.bounds.size.width,
                                      self.layer.position.y + (anchorPoint.y - lastAnchor.y) * self.layer.bounds.size.height);

    frame.size.height += self.arrowSize.height;
    self.frame = frame;
}
- (void)drawRect:(CGRect)rect {
    //绘制箭头和背景视图
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    UIColor *contentColor = self.contentColor;
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    CGSize arrowSize = self.arrowSize;
    CGFloat cornerRadius = self.cornerRadius;
    CGSize size = self.bounds.size;
    
    switch (self.positionType) {
        case LKPopoverPositionTypeDown: {
            //绘制箭头^ 从左边开始
            [arrow moveToPoint:CGPointMake(arrowPoint.x, 0)];
            [arrow
             addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5, arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, arrowSize.height)];
            //箭头绘制完毕
            
            //绘制弧度
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                                arrowSize.height + cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(270.0)
                           endAngle:RADIANS(0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width, size.height - cornerRadius)];
            [arrow
             addArcWithCenter:CGPointMake(size.width - cornerRadius, size.height - cornerRadius)
             radius:cornerRadius
             startAngle:RADIANS(0)
             endAngle:RADIANS(90.0)
             clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, size.height)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, size.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(90)
                           endAngle:RADIANS(180.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, arrowSize.height + cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, arrowSize.height + cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(180.0)
                           endAngle:RADIANS(270)
                          clockwise:YES];
            [arrow
             addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5, arrowSize.height)];
        } break;
        case LKPopoverPositionTypeUp: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, size.height)];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5,
                                              size.height - arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(cornerRadius, size.height - arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius,
                                                size.height - arrowSize.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(90.0)
                           endAngle:RADIANS(180.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(180.0)
                           endAngle:RADIANS(270.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, 0)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius, cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(270.0)
                           endAngle:RADIANS(0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width,
                                              size.height - arrowSize.height - cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                                size.height - arrowSize.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:RADIANS(0)
                           endAngle:RADIANS(90.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5,
                                              size.height - arrowSize.height)];
        } break;
    }
    [contentColor setFill];
    [arrow fill];
}

#pragma mark -----外部方法调用----
/**
 *  灵活的视图显示 箭头位置直接确定
 *
 *  @param point         箭头位置
 *  @param position      箭头方向
 *  @param contentView   需要显示的视图
 *  @param containerView 置于哪个视图之上
 */
- (void)showAtPoint:(CGPoint)point
     popoverPostion:(LKPopoverPositionType)position
    withContentView:(UIView *)contentView
             inView:(UIView *)containerView{
    CGFloat contentWidth = CGRectGetWidth(contentView.bounds);
    CGFloat contentHeight = CGRectGetHeight(contentView.bounds);
    CGFloat containerWidth = CGRectGetWidth(containerView.bounds);
    CGFloat containerHeight = CGRectGetHeight(containerView.bounds);
    //条件不满足提示
    NSAssert(contentWidth > 0 && contentHeight > 0,
             @"LKPopover内容视图bounds.size不能为0,必须给他设置不为0的宽高");
    NSAssert(containerWidth > 0 && containerHeight > 0,
             @"LKPopover container视图bounds.size不能为0,必须给他设置不为0的宽高");
    NSAssert(containerWidth >= (contentWidth + self.contentInset.left + self.contentInset.right),
             @"LKPopover contentView!>containerView");
    
    self.grayOverlay.frame = containerView.bounds;

    UIColor *maskColor;
    switch (self.maskType) {
        case LKPopoverMaskTypeGray:{
            maskColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }break;
        case LKPopoverMaskTypeNone:{
            maskColor = [UIColor clearColor];
            self.grayOverlay.userInteractionEnabled = NO;
        }break;
        default:
            break;
    }
    
    self.grayOverlay.backgroundColor = maskColor;
    
    [containerView addSubview:self.grayOverlay];
    
    [self.grayOverlay addTarget:self
                         action:@selector(dismiss)
               forControlEvents:UIControlEventTouchUpInside];
    
    self.containerView = containerView;
    self.positionType = position;
    self.contentView = contentView;
    self.arrowShowPoint = point;
    
    CGRect contentViewFrame = [containerView convertRect:contentView.frame toView:containerView];//坐标转换
    BOOL isEdgeZero = UIEdgeInsetsEqualToEdgeInsets(self.contentInset, UIEdgeInsetsZero);
    if (isEdgeZero) {
        self.contentView.layer.cornerRadius = self.cornerRadius;
        self.contentView.layer.masksToBounds = YES;
    } else {
        contentViewFrame.size.width += self.contentInset.left + self.contentInset.right;
        contentViewFrame.size.height += self.contentInset.top + self.contentInset.bottom;
    }
    
    self.contentViewFrame = contentViewFrame;
    [self show];
    
}
/**
 *  方便的视图显示   箭头居于atView中间
 *
 *  @param atView        触发点击视图
 *  @param position      箭头方向
 *  @param contentView   提示窗内容
 *  @param containerView 位于哪个遮罩视图
 */
- (void)showAtView:(UIView *)atView
    popoverPostion:(LKPopoverPositionType)position
   withContentView:(UIView *)contentView
            inView:(UIView *)containerView{
    CGFloat betweenArrowAndAtView = self.betweenAtViewAndArrowHeight;
    CGFloat contentViewHeight = CGRectGetHeight(contentView.bounds);
    CGRect atViewFrame = [containerView convertRect:atView.frame toView:containerView];
    
    
    BOOL upCanContain = CGRectGetMinY(atViewFrame) >= contentViewHeight + betweenArrowAndAtView;//小于说明超过距离屏幕边缘（弹窗超出屏幕）所以要转换箭头位置
    BOOL downCanContain =
    (CGRectGetHeight(containerView.bounds) -
     (CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView)) >= contentViewHeight;

    
    NSAssert((upCanContain || downCanContain),@"LKPopover 没有空间不能被展示出来"
             );
    
    CGPoint atPoint = CGPointMake(CGRectGetMidX(atViewFrame), 0);
    
    LKPopoverPositionType popoverPosition;
    if (upCanContain) {
        popoverPosition = LKPopoverPositionTypeUp;
        atPoint.y = CGRectGetMinY(atViewFrame) - betweenArrowAndAtView;
    } else {
        popoverPosition = LKPopoverPositionTypeDown;
        atPoint.y = CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView;
    }
    
    if (upCanContain && downCanContain) {
        CGFloat upHeight = CGRectGetMinY(atViewFrame);
        CGFloat downHeight = CGRectGetHeight(containerView.bounds) - CGRectGetMaxY(atViewFrame);
        BOOL useUp = upHeight > downHeight;
        
        if (position != 0) {
            useUp = position == LKPopoverPositionTypeUp ? YES : NO;
        }
        if (useUp) {
            popoverPosition = LKPopoverPositionTypeUp;
            atPoint.y = CGRectGetMinY(atViewFrame) - betweenArrowAndAtView;
        } else {
            popoverPosition = LKPopoverPositionTypeDown;
            atPoint.y = CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView;
        }
    }
    
    [self showAtPoint:atPoint popoverPostion:popoverPosition withContentView:contentView inView:containerView];
    
    
    
    
    
    
}










/**
 *  显示
 */
- (void)show{
    
    [self setNeedsDisplay];
    
    CGRect contentViewFrame = self.contentView.frame;
    CGFloat originY = 0.0;
    if (self.positionType == LKPopoverPositionTypeDown) {
        originY = self.arrowSize.height;
    }
    
    contentViewFrame.origin.x = self.contentInset.left;
    contentViewFrame.origin.y = originY + self.contentInset.top;
    
    self.contentView.frame = contentViewFrame;
    
    [self addSubview:self.contentView];
    [self.containerView addSubview:self];
    
    
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    if (self.animationSpring && self.isIOS7) {
        [UIView animateWithDuration:self.animationShow
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             if (self.didShowHandler) {
                                 self.didShowHandler();
                             }
                             
                         }];
    } else {
        [UIView animateWithDuration:self.animationShow
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             if (self.didShowHandler) {
                                 self.didShowHandler();
                             }
                            
                         }];
    }
 
}
/**
 *  提示窗消失
 */
- (void)dismiss{
    if (self.superview) {
        [UIView animateWithDuration:self.animationDismss
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                         }
                         completion:^(BOOL finished) {
                             [self.contentView removeFromSuperview];
                             [self.grayOverlay removeFromSuperview];
                             [self removeFromSuperview];
                             if (self.didDismssHandler) {
                                 self.didDismssHandler();
                             }
                         }];
    }
}


@end
