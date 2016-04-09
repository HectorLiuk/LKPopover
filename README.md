# LKPopover
A LKPopover mimic Facebook app popover. LKPopover模仿Facebookpopover.

First, he is a lightweight popover, it is flexible. Of course, it is very convenient to use only need to step away from using it , and its function is very powerful , it is like a container of the desired content added to it can be displayed 

首先他是一个轻量级的popover,它是灵活的。当然它的使用是非常方便的只需要一步就可以使用它，同时它的功能也非常强大，它就好比是一个容器把需要的内容添加进去就可以显示出来。


##Demo 
<img src="https://raw.github.com/544523660/LKPopover/master/demo.gif" width="500"><br/>
Download to try it.

##Support 
iOS ~> 6.0

##Usage
API的描述非常详细，你可以很方便的使用,可以详细的去阅读当然你也可以提出问题到Issues。
希望可以帮助到你.

##Attention
1. 请设置好你显示视图的大小。
2. 懒显示可以自动判断显示的箭头方向。

##eg
```objc
UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
image.image = [UIImage imageNamed:@"222"];
LKPopover *popover = [LKPopover popover];
[popover showAtView:sender withContentView:image];
```
```objc
UIButton *btn = [[UIButton alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(100, 40)}];
[btn setTitle:@"I an btn" forState:UIControlStateNormal];
btn.backgroundColor = [UIColor redColor];
LKPopover *lk = [LKPopover popover];
CGPoint point = CGPointMake(CGRectGetMidX(senderBtn.frame), CGRectGetMidY(senderBtn.frame));
[lk showAtPoint:point popoverPostion:LKPopoverPositionTypeUp withContentView:btn inView:self.view];
```
```objc
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
```



##ToDo
1. //API
2. //Demo
3. //test
4. **support CocoaPods**

Please tell me problem :lkSnail93@gmail.com

