//
//  LKPopover.m
//  LKPopover
//
//  Created by lk on 16/3/30.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPopover.h"

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

- (void)setUp{
    CGRect contentFrame = self.contentViewFrame;
    
    
    
    
    
    
    
    
    
}


#pragma mark -----外部方法调用----
/**
 *  提示窗显示
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
