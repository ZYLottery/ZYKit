//
//  WDAlertView.m
//  Property
//
//  Created by 何伟东 on 16/1/28.
//  Copyright © 2016年 乐家园. All rights reserved.
//

#import "WDAlertView.h"
#import <WDKit/WDKit.h>


static WDAlertView *defaultAlert = nil;
@implementation WDAlertView

+ (WDAlertView *)shareAlert{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAlert = [[WDAlertView alloc] init];
    });
    return defaultAlert;
}

/**
 *  加载等待
 *
 *  @param title   标题
 *  @param message 子标题
 *  @param view    所在视图
 */
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view{
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!view) {
            HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] delegate].window];
            [[[UIApplication sharedApplication] delegate].window addSubview:HUD];
        }else{
            if (HUD) {
                [HUD hide:YES];
            }
            HUD = [[MBProgressHUD alloc] initWithView:view];
            [view addSubview:HUD];
        }
        HUD.delegate = self;
        HUD.labelText = title;
        HUD.detailsLabelText = message;
        HUD.square = YES;
        [HUD show:YES];
    });
}
/**
 *  加载等待
 *
 *  @param title 标题
 *  @param view  所在视图
 */
-(void)showLoadingWithTitle:(NSString*)title withView:(UIView*)view{
    [self showLodingWithTitle:title message:nil withView:view];
}

/**
 *  加载等待
 *
 *  @param view <#view description#>
 */
-(void)showLoadingWithView:(UIView*)view{
    [self showLodingWithTitle:nil message:nil withView:view];
}

- (void)hiddenHUD{
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        if (HUD) {
            [HUD hide:YES];
        }
    });
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)showMessage:(NSString*)message{
    if (message == nil||message.length == 0) {
        return;
    }
    [self showMessage:message time:1];
}

- (void)showMessage:(NSString*)message time:(NSInteger)time{
    //移除上次的
    for (UIView *view in [KEY_WINDOW subviews]) {
        if (view.tag == 10000) {
            [view removeFromSuperview];
        }
    }
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *mianView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].delegate.window.bounds];
        [mianView setTag:10000];
        UIView *contentView = [[UIView alloc] init];
        [contentView.layer setMasksToBounds:YES];
        [contentView.layer setCornerRadius:5.0];
        [contentView setBackgroundColor:[UIColor clearColor]];
        [mianView addSubview:contentView];
        
        UIView *blackBackView = [[UIView alloc] init];
        [blackBackView setBackgroundColor:[UIColor blackColor]];
        [blackBackView setAlpha:0.7];
        [contentView addSubview:blackBackView];
        
        UILabel *messageLabel = [[UILabel alloc] init];
        [messageLabel setTextColor:[UIColor whiteColor]];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setTextAlignment:NSTextAlignmentCenter];
        [messageLabel setFont:[UIFont systemFontOfSize:14]];
        [messageLabel setText:message];
        [contentView addSubview:messageLabel];
        
        [messageLabel setWidth:messageLabel.textWidth];
        [messageLabel setHeight:messageLabel.textHeight];
        
        [contentView setWidth:messageLabel.textWidth+25];
        [contentView setHeight:messageLabel.textHeight+15];
        [contentView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
        [blackBackView setFrame:contentView.bounds];
        [messageLabel setCenter:CGPointMake(contentView.frame.size.width/2, contentView.frame.size.height/2)];
        
        [[UIApplication sharedApplication].delegate.window addSubview:mianView];
        
        [UIView animateWithDuration:0.2 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(1.1, 1.1);
            [contentView setTransform:transform];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.0);
                [contentView setTransform:transform];
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.2 animations:^{
                        CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
                        [contentView setTransform:transform];
                        [contentView setAlpha:0];
                    } completion:^(BOOL finished) {
                        [mianView removeFromSuperview];
                    }];
                });
            }];
        }];
    });
}

@end
