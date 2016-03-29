//
//  TestView.m
//  LKPopover
//
//  Created by lk on 16/3/29.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)drawRect:(CGRect)rect {
    //1、获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、设置开始画线的点
    CGContextMoveToPoint(ctx, 20, 100);
    
    //3、设置结束画线的点
    CGContextAddLineToPoint(ctx, 200, 100);
    
    //4、设置线条的宽度
    CGContextSetLineWidth(ctx, 5);
    
    //5、设置线条起点和终点的样式为圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //6、设置线条的转角的样式为圆角
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    //7、设置绘图的颜色
    [[UIColor redColor] set];
    
    //8设置第二条线的终点(自动把上一条直线的终点当做起点)
     CGContextAddLineToPoint(ctx, 300, 200);
    
    //9.渲染（绘制出一条空心的线，线条不能为实心，只有图型可为实心）
    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
}
@end
