//
//  TestView.h
//  LKPopover
//
//  Created by lk on 16/3/29.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^valueBlock)();
typedef int(^ssBlock)(int w, int s);

@interface TestView : UIView

@property (nonatomic, copy) valueBlock vBlock;
@property (nonatomic, copy) ssBlock sBolck;


UIView* MBNoResultView(id target,SEL action,UIView *view);
- (void)blockSting:(void (^)(NSString *str))block;
- (void)blockReturn:(int (^)(int i,int j))block;
@end
