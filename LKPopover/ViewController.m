//
//  ViewController.m
//  LKPopover
//
//  Created by lk on 16/3/29.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "ViewController.h"
#import "LKPopover.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"Hello" forState:UIControlStateNormal];
    self.btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:self.btn];
    [self.btn addTarget:self
                 action:@selector(showPopover)
       forControlEvents:UIControlEventTouchUpInside];
    [self.btn setBackgroundColor:[UIColor cyanColor]];
    
    
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.label.text = @"xxxx";


}
- (void)showPopover{
    LKPopover *pop = [LKPopover popover];
    CGPoint point = CGPointMake(CGRectGetMidX(self.btn.frame), CGRectGetMaxY(self.btn.frame)+3);
    
    [pop showAtPoint:point popoverPostion:LKPopoverPositionTypeDown withContentView:self.label inView:self.view];
    

}


@end
