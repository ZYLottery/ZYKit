//
//  UIViewController+ZYLotter.h
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/14.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZYLotter)
/**
 *  添加导航按钮
 *
 *  @param image          常态图片  可以不传  为nil
 *  @param highlightImage 高亮图片  可以不传  为nil
 *  @param title          title    可以不传  为nil
 *  @param isLeft         左边或是右边  Yes为左
 *  @param selector       触发函数
 */
- (UIButton * )addNavBtnNormalImage:(NSString *)image HighlightedImage:(NSString *)highlightImage TItle:(NSString*)title Isleft:(BOOL) isLeft Selector:(SEL)selector;
- (UIButton * )addNavBtnWithTitle:(NSString*)title Isleft:(BOOL) isLeft Selector:(SEL)selector;
- (UIButton * )addNavBtnNormalImage:(NSString *)image HighlightedImage:(NSString *)highlightImage Isleft:(BOOL) isLeft Selector:(SEL)selector;
/**
 *  处理初始高度
 */
-(void)dealViewHeight;
@end
