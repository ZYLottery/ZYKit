//
//  WDAlertView.h
//  Property
//
//  Created by 何伟东 on 16/1/28.
//  Copyright © 2016年 乐家园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define ALERT [WDAlertView shareAlert]

@interface WDAlertView : NSObject<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
+ (WDAlertView *)shareAlert;
/**
 *  加载等待
 *
 *  @param title   标题
 *  @param message 子标题
 *  @param view    所在视图
 */
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view;
/**
 *  加载等待
 *
 *  @param title 标题
 *  @param view  所在视图
 */
-(void)showLoadingWithTitle:(NSString*)title withView:(UIView*)view;
/**
 *  加载等待
 *
 *  @param view <#view description#>
 */
-(void)showLoadingWithView:(UIView*)view;

- (void)hiddenHUD;

- (void)showMessage:(NSString*)message;
- (void)showMessage:(NSString*)message time:(NSInteger)time;

    
@end
