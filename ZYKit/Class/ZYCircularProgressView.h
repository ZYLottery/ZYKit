//
//  ZYCircularProgressView.h
//  ZYDataCenter
//
//  Created by 何伟东 on 2016/11/14.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma mark - Enums

typedef NS_ENUM(NSUInteger, ZYProgressBackgroundMode) {
    ZYProgressBackgroundModeNone,
    ZYProgressBackgroundModeCircle,
    ZYProgressBackgroundModeCircumference
};

typedef NS_ENUM(NSUInteger, ZYProgressMode) {
    ZYProgressModeFill,
    ZYProgressModeDeplete
};

#pragma mark - Interface

@interface ZYCircularProgressView : UIView

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGFloat percentage;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *progressBackgroundColor;
@property (nonatomic) BOOL centerLabelVisible;
@property (nonatomic) ZYProgressMode progressMode;
@property (nonatomic) ZYProgressBackgroundMode progressBackgroundMode;
@property (nonatomic) BOOL clockwise;

- (id)initWithCenter:(CGPoint)center
              radius:(CGFloat)radius
           lineWidth:(CGFloat)lineWidth
        progressMode:(ZYProgressMode)progressMode
       progressColor:(UIColor *)progressColor
progressBackgroundMode:(ZYProgressBackgroundMode)backgroundMode
progressBackgroundColor:(UIColor *)progressBackgroundColor
          percentage:(CGFloat)percentage;

@end
