//
//  UIView+ZYLotter.m
//  ZYLottery
//
//  Created by 何伟东 on 5/11/16.
//  Copyright © 2016 章鱼彩票. All rights reserved.
//

#import "UIView+ZYLotter.h"
#import <WDKit/WDKit.h>
#import <Masonry/Masonry.h>

@implementation UIView (ZYLotter)

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}

#pragma mark Middle Point

- (CGPoint)middlePoint{
    return CGPointMake(self.middleX, self.middleY);
}

- (CGFloat)middleX{
    return self.width / 2;
}

- (CGFloat)middleY{
    return self.height / 2;
}


- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}


/**
 *  移动view
 *
 *  @param point     <#point description#>
 *  @param animation <#animation description#>
 */

- (void) moveToPoint:(CGPoint) point animation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.left = point.x;
            self.top = point.y;
        }];
    }else{
        self.left = point.x;
        self.top = point.y;
    }
}

/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    if(lineColor==nil){
        lineColor = [UIColor colorWithHex:0xe6e6e6];
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
/**
 *  加line  color传nil  有默认的颜色
 *  如果加在cell上  一定要加在cell.contentview上   masnory在某个系统下（记不清了）  加在cell上的masnory会崩溃
 *  @param leftMargin   左边距
 *  @param bottomMargin 下边距
 *  @param height       高度
 */
- (UIView *)addlineViewWithleftMargin:(float)leftMargin bottemMargin:(float)bottomMargin AndHeight:(float)height color:(UIColor *)color{
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = color?:[UIColor colorWithHex:0xe5e5e5];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(-leftMargin);
        make.bottom.mas_equalTo(-bottomMargin);
        make.height.mas_equalTo(height);
    }];
    return line;
}

- (UIView *)addlineViewWithleftMargin:(float)leftMargin rightMargin:(float)rightMargin bottemMargin:(float)bottomMargin AndHeight:(float)height color:(UIColor *)color{
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = color?:[UIColor colorWithHex:0xe5e5e5];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(-rightMargin);
        make.bottom.mas_equalTo(-bottomMargin);
        make.height.mas_equalTo(height);
    }];
    return line;
}

- (UIView *)addlineViewWithleftMargin:(float)leftMargin rightMargin:(float)rightMargin topMargin:(float)topMargin AndHeight:(float)height color:(UIColor *)color{
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = color?:[UIColor colorWithHex:0xe5e5e5];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(rightMargin);
        make.top.mas_equalTo(topMargin);
        make.height.mas_equalTo(height);
    }];
    return line;
}


- (UIView *)addlineViewWithleftMargin:(float)leftMargin topMargin:(float)topMargin AndHeight:(float)height color:(UIColor *)color{
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = color?:[UIColor colorWithHex:0xe5e5e5];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(-leftMargin);
        make.top.mas_equalTo(topMargin);
        make.height.mas_equalTo(height);
    }];
    return line;
}
/**
 *  加圆角
 *
 *  @param corner       <#corner description#>
 *  @param cornerRadius <#cornerRadius description#>
 *  @param targetSize   <#targetSize description#>
 */
- (void)zy_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    CGRect frame = CGRectMake(0, 0, targetSize.width, targetSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
}

- (void)zy_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
    [self zy_addCorner:corner cornerRadius:cornerRadius size:self.bounds.size];
}


//弹框动画
- (void) shakeToShow:(UIView*)aView bgView:(UIView*)bgView alpha:(CGFloat)alpha{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
    
    if (bgView!=nil) {
        [UIView animateWithDuration:0.2 animations:^{
            bgView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:alpha];
        }];
    }
}


@end
