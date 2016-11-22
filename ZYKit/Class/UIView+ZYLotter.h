//
//  UIView+ZYLotter.h
//  ZYLottery
//
//  Created by 何伟东 on 5/11/16.
//  Copyright © 2016 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYLotter)

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;


// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

/**
 *  移动view
 *
 *  @param point     <#point description#>
 *  @param animation <#animation description#>
 */
- (void) moveToPoint:(CGPoint) point animation:(BOOL)animation;

/**
 *  加圆角
 *
 *  @param corner       <#corner description#>
 *  @param cornerRadius <#cornerRadius description#>
 */
- (void)zy_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;
//边

/**
 * lineView:	   需要绘制成虚线的view
 * lineLength:	 虚线的宽度
 * lineSpacing:	虚线的间距
 * lineColor:	  虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 *  加line  color传nil  有默认的颜色
 *  如果加在cell上  一定要加在cell.contentview上   masnory在某个系统下（记不清了）  加在cell上的masnory会崩溃
 *  @param leftMargin   左边距
 *  @param bottomMargin 下边距
 *  @param height       高度
 */
- (UIView *)addlineViewWithleftMargin:(float)leftMargin bottemMargin:(float)bottomMargin AndHeight:(float)height color:(UIColor *)color;
- (UIView *)addlineViewWithleftMargin:(float)leftMargin rightMargin:(float)rightMargin bottemMargin:(float)bottomMargin AndHeight:(float)height color:(UIColor *)color;
- (UIView *)addlineViewWithleftMargin:(float)leftMargin rightMargin:(float)rightMargin topMargin:(float)topMargin AndHeight:(float)height color:(UIColor *)color;
- (UIView *)addlineViewWithleftMargin:(float)leftMargin topMargin:(float)topMargin AndHeight:(float)height color:(UIColor *)color;

//弹框动画
- (void) shakeToShow:(UIView*)aView bgView:(UIView*)bgView alpha:(CGFloat)alpha;
@end
