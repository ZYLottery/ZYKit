//
//  UIView+ZYEmptyView.m
//  ZYLottery
//
//  Created by 何伟东 on 16/5/30.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "UIView+ZYEmptyView.h"
#import <WDKit/WDKit.h>
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import "UIButton+ZYLotter.h"
#import "ZYMainTheme.h"

typedef void (^ActionBlock)();
@implementation UIView (ZYEmptyView)
static char emptyViewKey;

/**
 *  显示空view
 *
 *  @param text <#text description#>
 */
-(void)showEmptyViewWithText:(NSString*)text{
    [self hiddenEmptyView];
    
    UIView *emptyView = [[UIView alloc] initWithFrame:self.bounds];
    [emptyView setTag:5463156];
    [emptyView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:emptyView];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_empty_icon"]];
    [emptyView addSubview:iconImageView];
    [iconImageView setCenter:CGPointMake(emptyView.width/2, emptyView.height/2-15-14)];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.bottom+15, emptyView.width, 14)];
    [textLabel setTextColor:[UIColor colorWithHex:0x333333]];
    [textLabel setFont:[UIFont systemFontOfSize:14]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setText:text];
    [emptyView addSubview:textLabel];
    
    UIButton *reloadButton = [[UIButton alloc] initWithFrame:emptyView.bounds];
    [reloadButton setBackgroundColor:[UIColor clearColor]];
    [emptyView addSubview:reloadButton];
    __weak typeof(self)weakSelf = self;
    [reloadButton handlerTouchUpInsideEvent:^(id sender) {
        ActionBlock block = (ActionBlock)objc_getAssociatedObject(weakSelf, &emptyViewKey);
        if (block) {
            block();
        }
    }];
    
    [self layoutIfNeeded];
}
/**
 *  隐藏空view
 */
-(void)hiddenEmptyView{
    UIView *emptyView = [self viewWithTag:5463156];
    if (emptyView) {
        [emptyView removeFromSuperview];
        emptyView = nil;
    }
}

/**
 *  获取空view
 */
-(UIView*)emptyView{
    return [self viewWithTag:5463156];
}


/**
 *  点击空视图回调
 *
 *  @param handleBlock <#handleBlock description#>
 */
-(void)emptyViewHandle:(void (^)(void))handleBlock{
    objc_setAssociatedObject(self, &emptyViewKey, handleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 *  显示没登录
 *
 *  @param text          <#text description#>
 *  @param completeBlock <#completeBlock description#>
 */



/**
 显示没登录或者
 
 @param text <#text description#>
 @param buttonTitle <#buttonTitle description#>
 @param loginOrEmpty loginOrEmpty 如果为登录则为YES，如果是空视图则为NO
 @param completeBlock <#completeBlock description#>
 */
-(void)showTempViewWithText:(NSString*)text  withButtonTitle:(NSString*)buttonTitle  loginOrEmpty:(BOOL)loginOrEmpty buttonTitleWithBlock:(void (^)(void))completeBlock{
    [self hiddenEmptyView];
    UIView *emptyView = [[UIView alloc] initWithFrame:self.bounds];
    [emptyView setTag:5463156];
    [emptyView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:emptyView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:loginOrEmpty?[UIImage imageNamed:@"user_nologin"]:[UIImage imageNamed:@"nodatas_Img"]];
    [emptyView addSubview:iconImageView];
    
    if (loginOrEmpty) {
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(155) ;
            make.height.mas_equalTo(195.0/2);
            make.centerY.mas_equalTo(-125.0/2);
            make.centerX.mas_equalTo(0);
        }];
    }else{
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(72) ;
            make.height.mas_equalTo(61);
            make.centerY.mas_equalTo(-80);
            make.centerX.mas_equalTo(0);
        }];
    }
    
    UIView * topView = iconImageView;
    if (text) {
        UILabel *textLabel = [[UILabel alloc] init];
        [textLabel setTextColor:[UIColor colorWithHex:0x999999]];
        [textLabel setFont:[UIFont systemFontOfSize:14]];
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [textLabel setText:text];
        [emptyView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(iconImageView.mas_bottom).with.offset(15);
            
        }];
        topView = textLabel;
    }
    
    if (loginOrEmpty) {
        
        __block UIButton *login = [UIButton zy_buttonWithTitle:loginOrEmpty?@"登录/注册":buttonTitle font:[UIFont systemFontOfSize:16] titleColor:[UIColor whiteColor] withBlock:^(id sender) {
            completeBlock();
        }];
        
        [login setCornerRadius:20];
        login.backgroundColor = [UIColor colorWithHex:0xff4a1b];
        [emptyView addSubview:login];
        [login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(40);
            make.top.equalTo(topView.mas_bottom).with.offset(15);
            make.centerX.mas_equalTo(0);
        }];
        
    }else{
        __block UIButton *login = [UIButton zy_buttonWithTitle:loginOrEmpty?@"登录/注册":buttonTitle font:[UIFont systemFontOfSize:12] titleColor:[UIColor whiteColor] withBlock:^(id sender) {
            completeBlock();
        }];
        
        [login setCornerRadius:5];
        login.backgroundColor = [ZYMainTheme mainColor];
        [emptyView addSubview:login];
        [login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
            make.top.equalTo(topView.mas_bottom).with.offset(15);
            make.centerX.mas_equalTo(0);
        }];
    }
}

@end
