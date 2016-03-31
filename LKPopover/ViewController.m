//
//  ViewController.m
//  LKPopover
//
//  Created by lk on 16/3/29.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "LKPopover.h"
@interface ViewController ()
{
    UIView *_ccView;
}
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
    [testView blockSting:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    
    [testView blockReturn:^int(int i, int j) {
        int w;
        w = i +j;
        
        return YES;
    }];
    
    
    [testView setVBlock:^(int w){
        NSLog(@"~~~~~%d",w);
    }];
    
    //把代码放到另外一个页面执行
     testView.vBlock = ^{
         int w ,i;
         w = 0;
         i = 10;
         w = i + w;
         NSLog(@"^^^^^^%d",w);
    };
    
    //又返回值得block
    testView.sBolck = ^(int w, int j){
    
        return w+j;
    };
    
    [testView setStr:@"ss"];
    
    
//    int i =  testView.sBolck;
    
//    [testView setSBolck:^(int w ,int i){
//        return YES;
//    }];
    
    
    [self.view addSubview:testView];
    
    
    
    LKPopover *lk = [LKPopover new];
    NSLog(@"!!!!!%f",lk.cornerRadius);
    
    
    
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    cView.backgroundColor = [UIColor redColor];
    
    if (_ccView) {
        
    }
    
    
    _ccView = MBNoResultView(self, @selector(cc), cView);
    [self.view addSubview:cView];
    if (!_ccView) {
        
    }
    
   
}
- (void)cc{
    
}
- (IBAction)click:(id)sender {

    self.top.constant = 100;
    [self.view layoutIfNeeded];

    [UIView animateWithDuration:1.0f delay:0.3f usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    
    

//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.numLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)  ;
//    } completion:^(BOOL finished) {
//        
//    }];

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
