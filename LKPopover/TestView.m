//
//  TestView.m
//  LKPopover
//
//  Created by lk on 16/3/29.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "TestView.h"

@implementation TestView

UIView* MBNoResultView(id target,SEL action,UIView *view){
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(20, 20, 30, 30);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
    return view;
}


- (void)blockSting:(void (^)(NSString *str))block{
    block(@"sssssssss");
}


- (void)blockReturn:(int (^)(int i,int j))block{
    block(2,4);
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
//         [self blockReturn:^int(int i, int j) {
//             
//        }];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(40, 20, 30, 30);
        [btn addTarget:self action:@selector(www) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        
    }
    return self;
}
- (void)www{
    if (self.vBlock) {
        self.vBlock();
    }
    
    NSLog(@"@@@@@%d",self.sBolck(5,7));
}


- (void)setSBolck:(ssBlock)sBolck{
    _sBolck = sBolck;
    
    NSLog(@"####%d",self.sBolck(7,7));

    
    NSLog(@"set==%@",sBolck);
}

- (void)setStr:(NSString *)str{
    _str = str;
    
    
}
/**
 *
 Core Graphics
 *
 */
/*
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
 */


/**
 *  贝塞尔曲线 画直线
 *
 */
//- (void)drawRect:(CGRect)rect{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    
//    [path moveToPoint:CGPointMake(200, 10)];
//    
//    [path addLineToPoint:CGPointMake(200, 100)];
//    
//    
//    CGContextAddPath(ctx, path.CGPath);
//    
//    //绘制完成后再设置颜色
//    [[UIColor redColor] set];
//
//    CGContextStrokePath(ctx);
//    
//    
//}

/**
 *  弧形
 */
//- (void)drawRect:(CGRect)rect {
//    //1、获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    //2、绘制内容拼接路径，绘制的内容都会路径  UIBezierPath是UIKit中的
//    
//    //为UIView的中心点
//    CGPoint center =   CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
//    CGFloat radius = 50;
//    //center       圆心
//    //radius       半径
//    //startAngle   开始角度
//    //endAngle     结束角度
//    //clockwise    Yes为顺时针  NO为逆势针
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    
//    //3、给上下文添加路径
//    CGContextAddPath(ctx, path.CGPath);
//    //4.渲染（绘制出一条空心的线，线条不能为实心，只有图型可为实心）
//    CGContextStrokePath(ctx);//   空心
//    //    CGContextFillPath(ctx);  实心
//}


/**
 
 *  画饼  其实饼图就是在弧的两端以及和中心点加了两条线，成为了饼图
 */
//- (void)drawRect:(CGRect)rect {
//    //1、获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    //2、绘制内容拼接路径，绘制的内容都会路径  UIBezierPath是UIKit中的
//    
//    //为UIView的中心点
//    CGPoint center =   CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
//    CGFloat radius = 50;
//    //center       圆心
//    //radius       半径
//    //startAngle   开始角度
//    //endAngle     结束角度
//    //clockwise    Yes为顺时针  NO为逆势针
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
//    
//    //上面代码为给路径添加了一条弧，现在我们在弧的两端以及和中心点加了两条线  为饼图
//    //这里的话  我们之间添加到坐标点为中心
//    [path addLineToPoint:center];
//    //这里直接闭合路径  则一条饼图的路径就添加完成了
//    [path closePath];
//    
//    //3、给上下文添加路径
//    CGContextAddPath(ctx, path.CGPath);
//    
//    //4.渲染（绘制出一条空心的线，线条不能为实心，只有图型可为实心）
//    CGContextStrokePath(ctx);//   空心
//    //    CGContextFillPath(ctx);  实心
//}


/**
 *  另外一种贝塞尔曲线创建方式
 *
 */
- (void)drawRect:(CGRect)rect{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:layer];
    
//    if (self.vBlock) {
//        self.vBlock(3);
//    }
    
//   int i = self.sBolck(4,5);
    
    
}



@end
