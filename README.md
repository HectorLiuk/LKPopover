# LKPopover
A LKPopover mimic Facebook app popover. 

First, he is a lightweight popover, it is flexible. Of course, it is very convenient to use only need to step away from using it , and its function is very powerful , it is like a container of the desired content added to it can be displayed 


## Demo 
<img src="https://raw.github.com/544523660/LKPopover/master/demo.gif" width="500"><br/>
Download to try it.

## Support 
iOS ~> 7.0

## Podfile
platform :ios, '7.0'

target 'TargetName' do

pod 'LKPopover', '~> 1.0.0'

end


## Usage
API

## eg
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


Please tell me problem :lkSnail93@gmail.com

