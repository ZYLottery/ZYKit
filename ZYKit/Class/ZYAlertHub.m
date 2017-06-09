//
//  ZYAlertHub.m
//  ZYLottery
//
//  Created by guanxuhang1234 on 2017/2/23.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import "ZYAlertHub.h"
#import "ZYKit.h"
#import "ZYAlertMessageDataModel.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
static const int defaultDuration = 2;
typedef void (^ ZYAlertClickBlock)(ZYAlertHub *alertView, NSInteger buttonIndex);
typedef void (^ ZYLoadImageSuccessBlock)(BOOL isSuccess);

#define maxWidth ([UIApplication sharedApplication].keyWindow.frame.size.width - 40)
#define small  CGAffineTransformMakeScale(0.5f, 0.5f)
#define large  CGAffineTransformMakeScale(1.5f, 1.5f)
#define middle  CGAffineTransformMakeScale(0.8f, 0.8f)
#define lineColor [UIColor colorWithHex:0xe5e5e5]


static  const float leftMargin = 17;//常用约束
static  const float toastTopMargin = 15;//常用约束
static  NSString  * const  placeImage = @"alertSpace";//toast上占位图
static  const float toastWidthWithicon = 130;//带icon的test是固定的
static const float toastIconWidth = 45;//toast上图片的宽度
#define  toastTextColor  [UIColor colorWithHex:0xffffff]   //toast字体颜色
#define  toastTextFont  [UIFont systemFontOfSize:16] //toast字体大小
#define  alertBtnTextFont  [UIFont systemFontOfSize:SCREEN_WIDTH>320?(SCREEN_WIDTH>375?16:14):12] //alert 按钮字体大小
#define  alertBtnTextColor  [UIColor colorWithHex:0x333333]   //alert 按钮字体颜色
#define  alertTitleFont  [UIFont systemFontOfSize:18] //alert title字体大小
#define  alertTitleTextColor  [UIColor colorWithHex:0x333333] //alert title字体颜色
#define  alertMessageFont  [UIFont systemFontOfSize:14] //alert message字体大小
#define  alertMessageTextColor  [UIColor colorWithHex:0x666666] //alert message字体颜色
static const float alertIconWidth = 90;//alert上小图片图片的宽度


static  const float alertBtnHeight = 35;//alert 的 按钮高度

static  const CGFloat animationTime =0.3f;
@interface ZYAlertHub()
@property(nonatomic,weak)UIView * toastView;//toastView;
@property(nonatomic,weak)UIView * alertView;//alertView
@property(nonatomic,copy)ZYAlertClickBlock  alertClickBlock;//alertView

/**
 关闭按钮
 */
@property(nonatomic,copy) void (^closeblock)(void);
@end

@implementation ZYAlertHub
#pragma  mark  ---------------------  toast ------------------------------------

+ (ZYAlertHub *)showToast:(NSString*)message{
    ZYAlertHub * hub = [[ZYAlertHub alloc] init];
    [hub showToast:message];
    return hub;
}

+ (ZYAlertHub *)showToast:(NSString*)message  image:(NSString *)image{
    ZYAlertHub * hub = [[ZYAlertHub alloc] init];
    [hub showToast:message image:image];
    return hub;
}
+ (ZYAlertHub *)showToastWithView:(UIView *)view message:(NSString*)message  image:(NSString *)image{
    ZYAlertHub * hub = [[ZYAlertHub alloc] init];
    [hub showToastWithView:view  message:message image:image];
    return hub;
}
- (void)showToast:(NSString*)message{
    if (message == nil||message.length == 0) {
        return;
    }
    [self showToastWithView:nil message:message image:nil duration:defaultDuration withPosition:ZYToastPosionCenter];
}
- (void)showToast:(NSString*)message image:(NSString *)image{
    if (message == nil||message.length == 0) {
        return;
    }
    [self showToastWithView:nil message:message image:image duration:defaultDuration withPosition:ZYToastPosionCenter];
}
- (void)showToastWithView:(UIView *)view message:(NSString*)message image:(NSString *)image {
    if (message == nil||message.length == 0) {
        return;
    }
    [self showToastWithView:view message:message image:image duration:defaultDuration withPosition:ZYToastPosionCenter];
}
- (void)showToastWithView:(UIView *)view message:(NSString*)message image:(NSString*)image duration:(NSInteger)duration withPosition:(ZYToastPosion)position{
    
    if (message == nil||message.length == 0) {
        return;
    }

    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    self.duration = duration;
    self.bounds = view.bounds;
    if(self.addMask){
       self.backgroundColor = [UIColor clearColor];
    }else{
       self.alpha = 0;
    }
    self.center = view.center;
    [view addSubview:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (image) {
            [self createToastViewWithMessage:message image:image];
        }else{
            [self createToastViewWithMessage:message];
        }
        switch (position) {
            case ZYToastPosionCenter:
                self.toastView.center = view.center;
                break;
            case ZYToastPosionTop:
                self.toastView.y = toastTopMargin;
                self.toastView.centerX = view.width/2;
                break;
            case ZYToastPosionBottom:
                self.toastView.y = view.height - toastTopMargin - self.toastView.height;
                self.toastView.centerX = view.width/2;
                break;
            default:
                break;
        }
        [self toastShowOrHiddenWithIsShow:YES];
    });

}
                   
- (void)toastShowOrHiddenWithIsShow:(BOOL)isShow{
    
    if(isShow){
        self.toastView.transform = small;
        self.toastView.alpha = 0.4;
    }
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 || TARGET_OS_TV
   // if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
        [UIView animateWithDuration:animationTime delay:0. usingSpringWithDamping:0.5 initialSpringVelocity:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (isShow) {
                
                self.toastView.transform = CGAffineTransformIdentity;
                self.toastView.alpha = 1;
                
            }else{
                
                self.toastView.transform = small;
                self.toastView.alpha = 0;
            }
         
        } completion:^(BOOL finished) {
            if (finished&&isShow) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self toastShowOrHiddenWithIsShow:NO];
                });
            }else{
                [self.toastView removeFromSuperview];
                [self removeFromSuperview];
            }
        }];
        return;
   // }
/* #endif //spring方法是iOS7以上才有  下面的方法是各系统版本通用的    以下 其实可以忽略  因为本项目支持最低版本是 ios7 所以暂时注释
    dispatch_block_t animations;
    if (isShow) {
        
        animations = ^{
            [UIView addKeyframeWithRelativeStartTime:0
                                    relativeDuration:animationTime/3.0
                                          animations:^{
                                              self.toastView.transform = large;
                                              self.toastView.alpha = 0.6;
                                          }];
            [UIView addKeyframeWithRelativeStartTime:animationTime/3 * 1
                                    relativeDuration:animationTime/3.0
                                          animations:^{
                                              self.toastView.transform = middle;
                                              self.toastView.alpha = 0.8;
                                          }];
            
            [UIView addKeyframeWithRelativeStartTime:animationTime/3 * 2
                                    relativeDuration:animationTime/3.0
                                          animations:^{
                                              self.toastView.transform = CGAffineTransformIdentity;
                                              self.toastView.alpha = 1;
                                          }];
        };
        
    }else{
        animations = ^{
            [UIView addKeyframeWithRelativeStartTime:0
                                    relativeDuration:animationTime/2.0
                                          animations:^{
                                              self.toastView.transform = small;
                                              self.toastView.alpha = 0.6;
                                          }];
        };
    }
    [UIView animateWithDuration:0.3 delay:0. options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:^(BOOL finished) {
        if (finished&&isShow) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self toastShowOrHiddenWithIsShow:NO];
            });
        }else{
            [self.toastView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];

*/

}

- (void)createToastViewWithMessage:(NSString *)message image:(NSString *)image{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,toastWidthWithicon,toastWidthWithicon)];
    self.toastView = view;
    self.toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.toastView setCornerRadius:8];
    UILabel * messageView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, 0,toastWidthWithicon-leftMargin*2, 20)];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.textColor = toastTextColor;
    messageView.font = toastTextFont;
    messageView.text = message;
    messageView.numberOfLines = 0;
    messageView.lineBreakMode = NSLineBreakByWordWrapping;
    messageView.textAlignment = NSTextAlignmentCenter;
    messageView.height = messageView.textHeight+5;
    [self.toastView addSubview:messageView];
    
    UIImageView * iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(0,25, toastIconWidth, toastIconWidth);
    iconView.backgroundColor = [UIColor clearColor];
    iconView.contentMode =  UIViewContentModeScaleAspectFill;
    iconView.clipsToBounds = YES;
 
    [self.toastView addSubview:iconView];
    
    UIView * tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor whiteColor];
    UIImageView * spaceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:placeImage]];
    spaceImage.contentMode =  UIViewContentModeScaleAspectFit;
    tempView.frame = iconView.frame;
    [self.toastView addSubview:tempView];
    [self.toastView sendSubviewToBack:tempView];
    spaceImage.bounds = CGRectMake(0, 0, 30, 30);
    spaceImage.center = CGPointMake(tempView.width/2, tempView.height/2);
    
    
    messageView.y =  CGRectGetMaxY(iconView.frame)+15;
    messageView.centerX = self.toastView.width/2;
    iconView.centerX = self.toastView.width/2;
    
    [self loadImageWithImageView:iconView imageName:image withComplete:^(BOOL isSuccess) {
        tempView.hidden = isSuccess;
    }];
    self.toastView.height = MAX(self.toastView.height, CGRectGetMaxY(messageView.frame)+20);
    self.toastView.autoresizesSubviews = YES;
    [self.superview addSubview:self.toastView];
}
- (void)createToastViewWithMessage:(NSString *)message{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,toastWidthWithicon,toastWidthWithicon)];
    self.toastView = view;
    self.toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.toastView setCornerRadius:8];
    
    UILabel * messageView = [[UILabel alloc] initWithFrame:CGRectMake(0,12,0, 20)];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.textColor = toastTextColor;
    messageView.font = toastTextFont;
    messageView.text = message;
    messageView.numberOfLines = 0;
    messageView.lineBreakMode = NSLineBreakByWordWrapping;
    messageView.textAlignment = NSTextAlignmentCenter;
    float messageWidth = messageView.textWidth;
    messageView.width = MIN(messageWidth,maxWidth - 34);
    messageView.height = messageView.textHeight;
    [self.toastView addSubview:messageView];
    
    self.toastView.width = messageView.width + 34;
    self.toastView.height = messageView.height + 24;
    messageView.centerX = self.toastView.width/2;
    self.toastView.autoresizesSubviews = YES;
    [self.superview addSubview:self.toastView];
    
}
#pragma  mark  ---------------------  alert ------------------------------------

+ (ZYAlertHub *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    ZYAlertHub * alert = [[ZYAlertHub alloc] init];
    [alert showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:block];
    return alert;
}

+ (ZYAlertHub *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    ZYAlertHub * alert = [[ZYAlertHub alloc] init];
    [alert showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles bigPic:bigPic bigPicProportion:bigPicProportion hasCloseBtn:hasClossBtn handler:block];
    return alert;
}

+ (ZYAlertHub *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles smallPic:(NSString *)smallPic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    ZYAlertHub * alert = [[ZYAlertHub alloc] init];
    [alert showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles smallPic:(NSString *)smallPic handler:block];
    return alert;
}
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    [self showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles bigPic:nil bigPicProportion:0 smallPic:nil hasCloseBtn:NO handler:block];
}
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    
    [self showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles bigPic:bigPic bigPicProportion:bigPicProportion smallPic:nil hasCloseBtn:hasClossBtn handler:block];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles smallPic:(NSString *)smallPic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    [self showAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles bigPic:nil bigPicProportion:0 smallPic:smallPic hasCloseBtn:NO handler:block];
}
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion smallPic:(NSString *)smallPic hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    
    if (cancelButtonTitle == nil && [otherButtonTitles count] == 0) {
        return;
    }
    UIView *  view = [UIApplication sharedApplication].delegate.window;
    self.duration = defaultDuration;
    self.bounds = view.bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.center = view.center;
    [view addSubview:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createAlertViewWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles bigPic:bigPic bigPicProportion:bigPicProportion smallPic:smallPic hasCloseBtn:hasClossBtn handler:block];
        [self alertShowOrHiddenWithIsShow:YES];
    });

 
}

- (void)createAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion smallPic:(NSString *)smallPic hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,maxWidth,120)];
    self.alertView = view;
    view.backgroundColor = [UIColor whiteColor];
    [view setCornerRadius:8];
    float alertViewHeight;
    
    if (bigPic||smallPic) {
        alertViewHeight = 15;
    }else{
        alertViewHeight = 40;
    }
    
    self.alertClickBlock = block;
    
    //图片部分
    if (bigPic||smallPic) {
        UIView * tempView = [[UIView alloc] init];
        tempView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
        UIImageView * spaceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:placeImage]];
        spaceImage.contentMode =  UIViewContentModeScaleAspectFit;
        [tempView addSubview:spaceImage];
        if (bigPic) {
            UIImageView * bigView = [[UIImageView alloc] init];
            bigView .frame = CGRectMake(0,0,self.alertView.width,self.alertView.width/(bigPicProportion==0?2:bigPicProportion));
            bigView.backgroundColor = [UIColor clearColor];
            bigView.contentMode =  UIViewContentModeScaleAspectFill;
            bigView.clipsToBounds = YES;
            [self loadImageWithImageView:bigView imageName:bigPic withComplete:^(BOOL isSuccess) {
                tempView.hidden = isSuccess;
            }];
            [self.alertView addSubview:bigView];
            
            alertViewHeight = CGRectGetMaxY(bigView.frame) + 20;
            
            tempView.frame = bigView.frame;
            [self.alertView addSubview:tempView];
            [self.alertView sendSubviewToBack:tempView];
            spaceImage.bounds = CGRectMake(0, 0, 65, 65);
            spaceImage.center = CGPointMake(tempView.width/2, tempView.height/2);
            
        }else{
            UIImageView * smallView = [[UIImageView alloc] init];
            smallView.frame = CGRectMake(0,alertViewHeight,alertIconWidth,alertIconWidth);
            smallView.centerX = self.alertView.width/2;
            smallView.backgroundColor = [UIColor clearColor];
            smallView.contentMode =  UIViewContentModeCenter;
            smallView.clipsToBounds = YES;
            [self loadImageWithImageView:smallView imageName:smallPic withComplete:^(BOOL isSuccess) {
                tempView.hidden = isSuccess;
            }];
            [self.alertView addSubview:smallView];
            
            
            alertViewHeight = CGRectGetMaxY(smallView.frame) + 15;
            
            tempView.frame = smallView.frame;
            [self.alertView addSubview:tempView];
            [self.alertView sendSubviewToBack:tempView];
            spaceImage.bounds = CGRectMake(0, 0, 45, 45);
            spaceImage.center = CGPointMake(tempView.width/2, tempView.height/2);
        }
    }
    
    // title 部分
    if (title) {
        
        UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, alertViewHeight,maxWidth-leftMargin*2, 20)];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textColor = alertTitleTextColor;
        titleView.font = alertTitleFont;
        titleView.text = title;
        titleView.numberOfLines = 0;
        titleView.lineBreakMode = NSLineBreakByWordWrapping;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.height = titleView.textHeight+1;
        [self.alertView addSubview:titleView];
        alertViewHeight = CGRectGetMaxY(titleView.frame);
        
    }
    
    // message 部分
    if (message) {
        if (title) {
            if (bigPic||smallPic) {
                alertViewHeight += 15;
            }else{
                alertViewHeight += 20;
            }
        }
        
        UILabel * messageView = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,alertViewHeight,maxWidth-leftMargin*2, 20)];
        messageView.backgroundColor = [UIColor clearColor];
        messageView.textColor = alertMessageTextColor;
        messageView.font = alertMessageFont;
        messageView.text = message;
        messageView.numberOfLines = 0;
        messageView.lineBreakMode = NSLineBreakByWordWrapping;
        messageView.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributedString = [messageView.attributedText mutableCopy];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [messageView.text length])];
        messageView.attributedText = attributedString;
        [messageView sizeToFit];
        messageView.centerX = self.alertView.width/2;
        [self.alertView addSubview:messageView];
        alertViewHeight = CGRectGetMaxY(messageView.frame);
    }
    if (bigPic||smallPic) {
        alertViewHeight += 15;
    }else{
        alertViewHeight += 30;
    }
    // 分割线 部分
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, alertViewHeight, self.alertView.width, 0.5)];
    line.backgroundColor = lineColor;
    [self.alertView addSubview:line];
    alertViewHeight = CGRectGetMaxY(line.frame);
    
    
    // 按钮 部分
    NSMutableArray * btnTitlesArray = [[NSMutableArray alloc] init];
    if (cancelButtonTitle) {
        [btnTitlesArray addObject:cancelButtonTitle];
    }
    if (otherButtonTitles) {
        [btnTitlesArray addObjectsFromArray:otherButtonTitles];
    }
    __weak typeof(self) tempSelf = self;
    
    float btnTopMargin = 12;
    
    UIColor * redBtnNormalColor = [UIColor colorWithHex:0xe82c2c];
    UIColor * redBtnHignLightColor = [UIColor colorWithHex:0xd81e1e];
    UIColor * redBtnHignDisableColor = [UIColor colorWithHex:0xcccccc];
    
    UIColor * whiteBtnNormalColor = [UIColor colorWithHex:0xffffff];
    UIColor * whiteBtnHignLightColor = [UIColor colorWithHex:0xf7f7f7];
    UIColor * whiteBtnHignDisableColor = [UIColor colorWithHex:0xcccccc];
    
    if (btnTitlesArray.count == 1) {
        
        UIButton * btn = [UIButton zy_buttonWithTitle:btnTitlesArray[0] font:alertBtnTextFont titleColor:toastTextColor withBlock:^(id sender) {
            [tempSelf alertShowOrHiddenWithIsShow:NO];
            tempSelf.alertClickBlock(tempSelf,0);
        }];
        btn.frame = CGRectMake(0,alertViewHeight + btnTopMargin, 140, alertBtnHeight);
        btn.centerX = self.alertView.width/2;
        [btn setCornerRadius:4];
        [btn setBackgroundColor:redBtnNormalColor forState:UIControlStateNormal];
        [btn setBackgroundColor:redBtnHignLightColor forState:UIControlStateHighlighted];
        [btn setBackgroundColor:redBtnHignDisableColor forState:UIControlStateDisabled];
        [self.alertView addSubview:btn];
        
        alertViewHeight = CGRectGetMaxY(btn.frame);
        
    }else if (btnTitlesArray.count == 2){
        for (int i = 0; i < btnTitlesArray.count; i++) {
            UIButton * btn = [UIButton zy_buttonWithTitle:btnTitlesArray[i] font:alertBtnTextFont titleColor:i==0?alertBtnTextColor:toastTextColor withBlock:^(id sender) {
                [tempSelf alertShowOrHiddenWithIsShow:NO];
                tempSelf.alertClickBlock(tempSelf,i);
            }];
            float spacing = SCREEN_WIDTH == 320?20:40;
            float width = ( self.alertView.width -  3 * spacing ) / 2;
            btn.frame = CGRectMake((width + spacing) * i + spacing,alertViewHeight + btnTopMargin, width, alertBtnHeight);
            [btn setCornerRadius:4];
            if (i == 0) {
                
                [btn setBorderWidth:0.5 color:lineColor];
                [btn setBackgroundColor:whiteBtnNormalColor forState:UIControlStateNormal];
                [btn setBackgroundColor:whiteBtnHignLightColor forState:UIControlStateHighlighted];
                [btn setBackgroundColor:whiteBtnHignDisableColor forState:UIControlStateDisabled];
                
            }else{
                [btn setBackgroundColor:redBtnNormalColor forState:UIControlStateNormal];
                [btn setBackgroundColor:redBtnHignLightColor forState:UIControlStateHighlighted];
                [btn setBackgroundColor:redBtnHignDisableColor forState:UIControlStateDisabled];
            }
            [self.alertView addSubview:btn];
            if (i==1) {
                alertViewHeight = CGRectGetMaxY(btn.frame);
            }
            
        }
    }else{
        
        btnTitlesArray = [[NSMutableArray alloc] init];
        if (otherButtonTitles) {
            [btnTitlesArray addObjectsFromArray:otherButtonTitles];
        }
        if (cancelButtonTitle) {
            [btnTitlesArray addObject:cancelButtonTitle];
        }
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,alertViewHeight,self.alertView.width,MIN(4, btnTitlesArray.count)*(alertBtnHeight+5+0.5))];
        scrollView.contentSize = CGSizeMake(self.alertView.width, btnTitlesArray.count *(alertBtnHeight+0.5+5));
        [self.alertView addSubview:scrollView];
        for (int i = 0; i < btnTitlesArray.count; i++) {
            UIButton * btn = [UIButton zy_buttonWithTitle:btnTitlesArray[i] font:alertBtnTextFont titleColor:alertBtnTextColor withBlock:^(id sender) {
                [tempSelf alertShowOrHiddenWithIsShow:NO];
                if (cancelButtonTitle) {
                    if (i == (btnTitlesArray.count - 1)) {
                        tempSelf.alertClickBlock(tempSelf,0);
                    }else{
                        tempSelf.alertClickBlock(tempSelf,i+1);
                    }
                }else{
                    tempSelf.alertClickBlock(tempSelf,i);
                }
            }];
            btn.frame = CGRectMake(0,i * (alertBtnHeight+0.5+5),self.alertView.width, alertBtnHeight+5);
            [btn setBackgroundColor:whiteBtnNormalColor forState:UIControlStateNormal];
            [btn setBackgroundColor:whiteBtnHignLightColor forState:UIControlStateHighlighted];
            [btn setBackgroundColor:whiteBtnHignDisableColor forState:UIControlStateDisabled];
            [scrollView  addSubview:btn];
            alertViewHeight = CGRectGetMaxY(btn.frame);
            
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(btn.frame), self.alertView.width, 0.5)];
            line.backgroundColor = lineColor;
            [scrollView addSubview:line];
        }
        alertViewHeight = CGRectGetMaxY(scrollView.frame);
    }
    self.buttonNumbers = btnTitlesArray.count;
    
    alertViewHeight += btnTopMargin;
    self.alertView.height = alertViewHeight;
    [self addSubview:self.alertView];
    self.alertView.center = self.center;
    if (hasClossBtn) {
        
        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.alertView.frame)-25.0/2,self.alertView.y-25.0/2, 25, 25)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"alertClose"] forState:UIControlStateNormal];
        [self addSubview:closeButton];
        [closeButton handlerTouchUpInsideEvent:^(id sender) {
            [tempSelf alertShowOrHiddenWithIsShow:NO];
            if (tempSelf.closeblock) {
                tempSelf.closeblock();
            }
            
        }];
    }
    
}

- (void)alertShowOrHiddenWithIsShow:(BOOL)isShow{
    
    if(isShow){
        self.alertView.transform = small;
        self.alertView.alpha = 0.4;
    }
    
    [UIView animateWithDuration:animationTime delay:0. usingSpringWithDamping:isShow?0.5:1 initialSpringVelocity:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (isShow) {
            
            self.alertView.transform = CGAffineTransformIdentity;
            self.alertView.alpha = 1;
            
        }else{
            
            self.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.alpha = 0;
        }
        
    } completion:^(BOOL finished) {
        if (finished&&isShow) {
   
        }else{
            [self.alertView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
    return;
    
}

+ (ZYAlertHub *)showToastWithLevel:(NSInteger)messageLevel messageData:(NSDictionary *)messageDataDic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block closeBlock:(void (^)(void))closeblock{
    ZYAlertHub * alert  = [self showToastWithLevel:messageLevel messageData:messageDataDic handler:block];
    alert.closeblock = closeblock;
    return alert;
}

+ (ZYAlertHub *)showToastWithLevel:(NSInteger)messageLevel messageData:(NSDictionary *)messageDataDic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block{
    if (messageDataDic==nil) {
        return nil;
    }
    ZYAlertMessageDataModel * messageData = [ZYAlertMessageDataModel mj_objectWithKeyValues:messageDataDic];
        ZYAlertHub *  alertHub;
        NSString * pic = messageData.picUrl;
        if (messageData.picKey&&[UIImage imageNamed:messageData.picKey]) {
            pic = messageData.picKey;
        }

        switch (messageLevel) {
            case ZYNoShowMessage:
            {
                //什么都不做
            }
                break;
            case ZYRedirectMessage:
            {
                //重定向 什么都不做
            }
                break;
            case ZYToastOnlyText:
            {
                //Toast:文字
               alertHub = [self showToast:messageData.title?:messageData.content];
            }
                break;
            case ZYToastTextAndIcon:
            {
                //Toast:图标+文字
               alertHub = [self showToast:messageData.title?:messageData.content image:pic];
            }
                break;
            case ZYAlertOneButton:
            {
                //Dialog:单按钮(无图)
               alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] handler:block];
            }
                break;
            case ZYAlertTwoButton:
            {
                //Dialog:双按钮(无图)
                alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] handler:block];
            }
                break;
            case ZYAlertTwoButtonWithTwoAction:
            {
                //Dialog:双按钮(无图)
               alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] handler:block];
            }
                break;
            case ZYAlertOneButtonAndBigPic:
            {
                //Dialog:单按钮+大图+关闭按钮
               alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] bigPic:pic bigPicProportion:messageData.picWidth/messageData.picHeight hasCloseBtn:messageData.closable handler:block];
            }
                break;
            case ZYAlertTwoButtonAndBigPic:
            {
                //Dialog:双按钮+大图+关闭按钮
                alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] bigPic:pic bigPicProportion:messageData.picWidth/messageData.picHeight hasCloseBtn:messageData.closable handler:block];
            }
                break;
            case ZYAlertTwoButtonAndBigPicWithTwoAction:
            {
                //Dialog:双按钮+大图+关闭按钮
               alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] bigPic:pic bigPicProportion:messageData.picWidth/messageData.picHeight hasCloseBtn:messageData.closable handler:block];
            }
                break;
            case ZYAlertOneButtonAndIcon:
            {
                //Dialog:单按钮+图标
               alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] smallPic:pic handler:block];
            }
                break;
            case ZYAlertTwoButtonAndIcon:
            {
                //Dialog:双按钮+图标
                alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] smallPic:pic handler:block];
            }
                break;
            case ZYAlertTwoButtonAndIconWithTwoAction:
            {
                //Dialog:双按钮+图标
               alertHub = [self showAlertViewWithTitle:messageData.title message:messageData.content cancelButtonTitle:messageData.secondaryButton otherButtonTitles:@[messageData.primaryButton?:@""] smallPic:pic handler:block];
            }
                break;
            default:
                break;
        }
    
    return nil;
}
- (void)loadImageWithImageView:(UIImageView *)imageView imageName:(NSString *)imageName withComplete:(ZYLoadImageSuccessBlock)successBlock{
    if ([imageName rangeOfString:@"http"].location != NSNotFound) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            successBlock(image?YES:NO);
        }];
        
    }else{
        imageView.image = [UIImage imageNamed:imageName];
        successBlock(imageView.image?YES:NO);
    }
}
@end
