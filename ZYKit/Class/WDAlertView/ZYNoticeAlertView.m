//
//  ZYNoticeAlertView.m
//  ZYLottery
//
//  Created by 何伟东 on 2016/10/27.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYNoticeAlertView.h"
#import <WDKit/WDKit.h>

@interface ZYNoticeAlertView(){
    
}

@property (nonatomic,weak) UIView *contentView;

@property (nonatomic,strong) UIButton *alphaButton;
@property (nonatomic,strong) UIView *alertContentView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,strong) UIButton *cancleButton;
@property (nonatomic,strong) NSMutableArray *otherButtons;


@end

@implementation ZYNoticeAlertView

+(void)initWithTitle:(nullable NSString*)title message:(nullable NSString*)message contentView:(nullable UIView*)contentView confirmButtonTitle:(nullable NSString*)confirmButtonTitle cancleButtonTitle:(nullable NSString*)cancleButtonTitle alertBlock:(nullable NoticeAlertBlock)alertBlock otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    ZYNoticeAlertView *noticeAlertView = [[ZYNoticeAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if (noticeAlertView) {
        [noticeAlertView setBlock:alertBlock];
        va_list args;
        va_start(args, otherButtonTitles); // scan for arguments after firstObject.
        NSMutableArray *argsArray = [NSMutableArray array];
        // get rest of the objects until nil is found
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
            [argsArray addObject:str];
        }
        va_end(args);
        [noticeAlertView setBackgroundColor:[UIColor clearColor]];
        
        noticeAlertView.alphaButton = [[UIButton alloc] initWithFrame:noticeAlertView.bounds];
        [noticeAlertView.alphaButton setBackgroundColor:[UIColor darkGrayColor]];
        [noticeAlertView.alphaButton setAlpha:0];
        [noticeAlertView addSubview:noticeAlertView.alphaButton];
        
        noticeAlertView.alertContentView = [[UIView alloc] init];
        [noticeAlertView.alertContentView setBackgroundColor:[UIColor whiteColor]];
        [noticeAlertView.alertContentView.layer setCornerRadius:5];
        [noticeAlertView addSubview:noticeAlertView.alertContentView];
        
        //根据contentView自适应宽度
        if(contentView != nil){
            [noticeAlertView.alertContentView setWidth:contentView.width+30];
        }else{
            [noticeAlertView.alertContentView setWidth:SCREEN_WIDTH*3/4];
        }
        
        CGFloat distanceTop = 10.0f;
        //判断有没有标题
        if(title && [title length]){
            noticeAlertView.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, noticeAlertView.alertContentView.width-30, 40)];
            [noticeAlertView.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [noticeAlertView.titleLabel setTextColor:RGB(50, 50, 50)];
            [noticeAlertView.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
            [noticeAlertView.titleLabel setText:title];
            [noticeAlertView.alertContentView addSubview:noticeAlertView.titleLabel];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, noticeAlertView.titleLabel.bottom, noticeAlertView.alertContentView.width, 1)];
            //            [lineView setBackgroundColor:RGB(240, 240, 240)];
            [lineView setBackgroundColor:RGB(229, 229, 229)];
            [noticeAlertView.alertContentView addSubview:lineView];
            distanceTop = lineView.bottom+10;
        }
        //判断有没有contentView
        if(contentView != nil){
            [contentView setLeft:15];
            [contentView setTop:distanceTop];
            [noticeAlertView.alertContentView addSubview:contentView];
            distanceTop = contentView.bottom+10;
        }
        //判断有没有提示信息
        if(message && [message length]){
            noticeAlertView.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, distanceTop, noticeAlertView.alertContentView.width-30, 20)];
            [noticeAlertView.messageLabel setTextColor:RGB(100, 100, 100)];
            [noticeAlertView.messageLabel setFont:[UIFont systemFontOfSize:17]];
            [noticeAlertView.messageLabel setNumberOfLines:0];
            [noticeAlertView.messageLabel setText:message];
            [noticeAlertView.messageLabel setTextAlignment:NSTextAlignmentLeft];
            [noticeAlertView.messageLabel setHeight:noticeAlertView.messageLabel.textHeight];
            [noticeAlertView.alertContentView addSubview:noticeAlertView.messageLabel];
            if(![title length]){
                distanceTop = noticeAlertView.messageLabel.bottom+40;
                [noticeAlertView.messageLabel setTop:(distanceTop-noticeAlertView.messageLabel.height)/2];
            }else{
                distanceTop = noticeAlertView.messageLabel.bottom+40;
                [noticeAlertView.messageLabel setTop:(distanceTop-noticeAlertView.messageLabel.height+noticeAlertView.titleLabel.height)/2];
            }
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, distanceTop, noticeAlertView.alertContentView.width, 1)];
        //        [lineView setBackgroundColor:RGB(240, 240, 240)];
        [lineView setBackgroundColor:RGB(229, 229, 229)];
        [noticeAlertView.alertContentView addSubview:lineView];
        distanceTop = lineView.bottom+10;
        
        NSMutableArray *buttonArray  = [NSMutableArray array];
        NSInteger buttonIndex = 0;
        //确认按钮
        if(confirmButtonTitle && [confirmButtonTitle length]){
            noticeAlertView.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
            [noticeAlertView.confirmButton setTag:buttonIndex];
            buttonIndex++;
            [noticeAlertView.confirmButton.layer setCornerRadius:5];
            [noticeAlertView.confirmButton setClipsToBounds:YES];
            [noticeAlertView.confirmButton setBackgroundImage:[UIImage imageWithColor:RGB(235, 40,34)] forState:UIControlStateNormal];
            [noticeAlertView.confirmButton setBackgroundImage:[UIImage imageWithColor:RGB(215, 40,34)] forState:UIControlStateHighlighted];
            [noticeAlertView.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [noticeAlertView.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [noticeAlertView.confirmButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
            [buttonArray addObject:noticeAlertView.confirmButton];
        }
        
        //取消按钮
        if(cancleButtonTitle && [cancleButtonTitle length]){
            noticeAlertView.cancleButton = [noticeAlertView creatOtherButton];
            [noticeAlertView.cancleButton setTag:buttonIndex];
            buttonIndex++;
            [noticeAlertView.cancleButton.layer setCornerRadius:5];
            [noticeAlertView.cancleButton setClipsToBounds:YES];
            [noticeAlertView.cancleButton.layer setBorderWidth:1];
            [noticeAlertView.cancleButton.layer setBorderColor:RGB(203, 203, 203).CGColor];
            [noticeAlertView.cancleButton setBackgroundImage:[UIImage imageWithColor:RGB(255, 255,255)] forState:UIControlStateNormal];
            [noticeAlertView.cancleButton setBackgroundImage:[UIImage imageWithColor:RGB(250, 250,250)] forState:UIControlStateHighlighted];
            [noticeAlertView.cancleButton setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
            [noticeAlertView.cancleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [noticeAlertView.cancleButton setTitle:cancleButtonTitle forState:UIControlStateNormal];
            [buttonArray insertObject:noticeAlertView.cancleButton atIndex:0];
        }
        
        //其他按钮
        for(NSString *str in argsArray){
            UIButton *button = [noticeAlertView creatOtherButton];
            [button setTag:buttonIndex];
            buttonIndex++;
            [button.layer setCornerRadius:5];
            [button setClipsToBounds:YES];
            [button.layer setBorderWidth:1];
            [button.layer setBorderColor:RGB(229, 229, 229).CGColor];
            [button setBackgroundImage:[UIImage imageWithColor:RGB(255, 255,255)] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:RGB(250, 250,250)] forState:UIControlStateHighlighted];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitle:str forState:UIControlStateNormal];
            [buttonArray addObject:button];
        }
        
        CGFloat doubleWidth = (noticeAlertView.alertContentView.width-45)/2;
        CGFloat maxWidth = 0.0f;
        for(UIButton *button in buttonArray){
            CGFloat width = button.titleLabel.textWidth+20;
            if(width > maxWidth){
                maxWidth = width;
            }
        }
        
        //判断一排显示几个
        if([buttonArray count] == 2 && maxWidth <= doubleWidth){//一排显示2个
            CGFloat left = 15;
            for(UIButton *button in buttonArray){
                __weak typeof(button)weakButton = button;
                __weak typeof(noticeAlertView)weakSelf = noticeAlertView;
                [button handlerTouchUpInsideEvent:^(id sender) {
                    if(weakSelf.block){
                        weakSelf.block(noticeAlertView,weakButton.tag);
                    }
                    [weakSelf hidden];
                }];
                [button setTop:distanceTop];
                [button setWidth:doubleWidth];
                [button setLeft:left];
                [noticeAlertView.alertContentView addSubview:button];
                left = button.right+15;
                if(buttonArray.lastObject == button){
                    distanceTop = button.bottom+10;
                }
            }
            
        }else{
            //交换取消确定按钮位置
            if(noticeAlertView.confirmButton){
                [buttonArray removeObject:noticeAlertView.confirmButton];
                [buttonArray insertObject:noticeAlertView.confirmButton atIndex:[buttonArray count]];
            }
            if(noticeAlertView.cancleButton){
                [buttonArray removeObject:noticeAlertView.cancleButton];
                [buttonArray insertObject:noticeAlertView.cancleButton atIndex:[buttonArray count]];
            }
            for(UIButton *button in buttonArray){
                __weak typeof(button)weakButton = button;
                __weak typeof(noticeAlertView)weakSelf = noticeAlertView;
                [button handlerTouchUpInsideEvent:^(id sender) {
                    if(weakSelf.block){
                        weakSelf.block(noticeAlertView,weakButton.tag);
                    }
                    [weakSelf hidden];
                }];
                [button setTop:distanceTop];
                [button setLeft:15];
                [button setWidth:noticeAlertView.alertContentView.width-30];
                [noticeAlertView.alertContentView addSubview:button];
                distanceTop = button.bottom+10;
            }
        }
        distanceTop+=5;
        [noticeAlertView.alertContentView setHeight:distanceTop];
        [noticeAlertView show];
    }
}

-(UIButton*)creatOtherButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
    [button.layer setCornerRadius:3];
    //    [button.layer setBorderColor:RGB(240, 240, 240).CGColor];
    [button.layer setBorderColor:RGB(229, 229, 229).CGColor];
    [button.layer setBorderWidth:1];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    return button;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.alphaButton setAlpha:0];
    [self.alertContentView setCenterX:self.width/2];
    [self.alertContentView setCenterY:self.height/2];
    [self.alertContentView setAlpha:0];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self.alertContentView setTransform:transform];
    
    [UIView animateWithDuration:0.15 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.1, 1.1);
        [self.alertContentView setTransform:transform];
        [self.alertContentView setAlpha:1];
        [self.alphaButton setAlpha:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(0.9, 0.9);
            [self.alertContentView setTransform:transform];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
                [self.alertContentView setTransform:transform];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

-(void)hidden{
    [UIView animateWithDuration:0.15 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.1, 1.1);
        [self.alertContentView setTransform:transform];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(0.2, 0.2);
            [self.alertContentView setTransform:transform];
            [self.alertContentView setAlpha:0];
            [self.alphaButton setAlpha:0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}



@end
