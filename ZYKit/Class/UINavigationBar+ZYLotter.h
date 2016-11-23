//
//  UINavigationBar+ZYLotter.h
//  ZYLottery
//
//  Created by 何伟东 on 16/5/18.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ZYLotter)
//修改导航条透明度
- (void)zy_setBackgroundColor:(UIColor *)backgroundColor;
- (void)zy_setTranslationY:(CGFloat)translationY;
- (void)zy_setElementsAlpha:(CGFloat)alpha;
@end
