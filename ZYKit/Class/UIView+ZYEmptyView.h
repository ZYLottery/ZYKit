//
//  UIView+ZYEmptyView.h
//  ZYLottery
//
//  Created by 何伟东 on 16/5/30.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYEmptyView)
/**
 *  显示空view
 *
 *  @param text <#text description#>
 */
-(void)showEmptyViewWithText:(NSString*)text;
/**
 *  隐藏空view
 */
-(void)hiddenEmptyView;

/**
 *  获取空view
 */
-(UIView*)emptyView;

/**
 *  点击空视图回调
 *
 *  @param handleBlock <#handleBlock description#>
 */
-(void)emptyViewHandle:(void (^)(void))handleBlock;

/**
 显示没登录或者
 
 @param text <#text description#>
 @param buttonTitle <#buttonTitle description#>
 @param loginOrEmpty loginOrEmpty 如果为登录则为YES，如果是空视图则为NO
 @param completeBlock <#completeBlock description#>
 */
-(void)showTempViewWithText:(NSString*)text  withButtonTitle:(NSString*)buttonTitle  loginOrEmpty:(BOOL)loginOrEmpty buttonTitleWithBlock:(void (^)(void))completeBlock;

@end
