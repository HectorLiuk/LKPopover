//
//  APopoverDisplayViewController.m
//  LKPopover
//
//  Created by lk on 16/4/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "APopoverDisplayViewController.h"
#import "LKPopover.h"
@interface APopoverDisplayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LKPopover *lkPopover;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@end

@implementation APopoverDisplayViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 300) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor cyanColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    }
    return _arrayData;
}
- (LKPopover *)lkPopover{
    if (!_lkPopover) {
        _lkPopover = [LKPopover popover];
    }
    return _lkPopover;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"customShow";

    UIButton *titleLb = [[UIButton alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(100, 40)}];
    titleLb.titleLabel.font = [UIFont systemFontOfSize:20];
    [titleLb setTitle:@"Tap me" forState:UIControlStateNormal];
    [titleLb addTarget:self
                action:@selector(titleShowPopover)
      forControlEvents:UIControlEventTouchUpInside];
    [titleLb setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleLb;
    
    
    

    
    
    
}
- (void)titleShowPopover{
    UIView *titleView = self.navigationItem.titleView;
    CGPoint startPoint =
    CGPointMake(CGRectGetMidX(titleView.frame), CGRectGetMaxY(titleView.frame) + 20);
    self.lkPopover.backgroundColor = [UIColor redColor];
    self.lkPopover.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
    self.lkPopover.maskType = LKPopoverMaskTypeNone;
    [self.lkPopover showAtPoint:startPoint
               popoverPostion:LKPopoverPositionTypeDown
              withContentView:self.tableView
                       inView:self.tabBarController.view];
    __weak typeof (self) weakSelf = self;
    self.lkPopover.didDismssHandler = ^{
        [weakSelf bounceTargetView:titleView];
    };
    
}
- (IBAction)bottomBtn:(id)sender {
    [self.lkPopover showAtView:sender withContentView:self.tableView];
    __weak typeof (self) weakSelf = self;
    self.lkPopover.didDismssHandler = ^{
        [weakSelf bounceTargetView:sender];
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.arrayData[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.lkPopover dismiss];
}
- (void)bounceTargetView:(UIView *)targetView {
    targetView.transform = CGAffineTransformMakeScale(0.8, 0.8);
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
@end
