//
//  ViewsViewController.m
//  LKPopover
//
//  Created by lk on 16/4/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "ViewsViewController.h"
#import "LKPopover.h"
@interface ViewsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *showImage;
@property (weak, nonatomic) IBOutlet UIButton *showView;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIButton *showOutView;
@property (weak, nonatomic) IBOutlet UIButton *shouwWebView;
@property (strong, nonatomic) UIView *redView;
@property (nonatomic, assign) CGRect rect;
@end

@implementation ViewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"lazyShow";
    self.rect = CGRectMake(180, 120, 100, 100);
    self.redView = [[UIView alloc] initWithFrame:self.rect];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)label:(id)sender {
    UIButton *btn = (UIButton *)sender;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    textLabel.text = @"I am label";
    textLabel.backgroundColor = [UIColor whiteColor];
    
    LKPopover *lk = [LKPopover popover];
    __weak typeof(self) weakSelf = self;
    lk.didShowHandler = ^{
        [weakSelf alphaView:sender];
    };
    [lk showAtView:sender withContentView:textLabel];
    lk.didDismssHandler = ^{
        btn.alpha = 1;
        [weakSelf bounceTargetView:sender];
    };
}
- (IBAction)image:(id)sender {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    image.image = [UIImage imageNamed:@"222"];
    LKPopover *popover = [LKPopover popover];
    [popover showAtView:sender withContentView:image];
    
    __weak typeof(self) weakSelf = self;
    popover.didDismssHandler = ^{
        [weakSelf bounceTargetView:sender];
    };
}
- (IBAction)view:(id)sender {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor cyanColor];
    LKPopover *popover = [LKPopover popover];
    popover.backgroundColor = [UIColor cyanColor];
    [popover showAtView:self.showImage popoverPostion:LKPopoverPositionTypeUp withContentView:view inView:self.view];
}

- (IBAction)button:(id)sender {
    UIButton *senderBtn = (UIButton *)sender;
    UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(100, 40)}];
    [btn setTitle:@"I an btn" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    LKPopover *lk = [LKPopover popover];
    CGPoint point = CGPointMake(CGRectGetMidX(senderBtn.frame), CGRectGetMidY(senderBtn.frame));
    [lk showAtPoint:point popoverPostion:LKPopoverPositionTypeUp withContentView:btn inView:self.view];
}
- (IBAction)showOutView:(id)sender {
    LKPopover *lk = [LKPopover popover];
    [lk showAtView:sender withContentView:self.redView];
    __weak typeof (self) weakSelf = self;
    lk.didDismssHandler = ^{
        weakSelf.redView.layer.cornerRadius = 0.0;
        weakSelf.redView.layer.masksToBounds = YES;
        weakSelf.redView.frame = weakSelf.rect;
        [weakSelf.view addSubview:weakSelf.redView];
    };

}
- (IBAction)WebView:(id)sender {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(300, 400)}];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [webView loadRequest:request];
    LKPopover *lk = [LKPopover popover];
    [lk showAtView:sender withContentView:webView];
    
}
- (void)bounceTargetView:(UIView *)targetView {
    targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         targetView.transform = CGAffineTransformIdentity;
                     }
                     completion:nil];
}
- (void)alphaView:(UIView *)targetView {
    [UIView animateWithDuration:0.5 animations:^{
        targetView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}


@end
