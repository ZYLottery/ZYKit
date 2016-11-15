//
//  ZYCustomAlertView.m
//  ZYLottery
//
//  Created by 何伟东 on 16/6/30.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYCustomAlertView.h"
#import <WDKit/WDKit.h>

@interface ZYCustomAlertView(){
    
    
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

@implementation ZYCustomAlertView

+(void)initWithTitle:(nullable NSString*)title message:(nullable NSString*)message contentView:(nullable UIView*)contentView confirmButtonTitle:(nullable NSString*)confirmButtonTitle cancleButtonTitle:(nullable NSString*)cancleButtonTitle alertBlock:(nullable CustomeAlertBlock)alertBlock otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    ZYCustomAlertView *customAlertView = [[ZYCustomAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if (customAlertView) {
        [customAlertView setBlock:alertBlock];
        va_list args;
        va_start(args, otherButtonTitles); // scan for arguments after firstObject.
        NSMutableArray *argsArray = [NSMutableArray array];
        // get rest of the objects until nil is found
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
            [argsArray addObject:str];
        }
        va_end(args);
        [customAlertView setBackgroundColor:[UIColor clearColor]];
        
        customAlertView.alphaButton = [[UIButton alloc] initWithFrame:customAlertView.bounds];
        [customAlertView.alphaButton setBackgroundColor:[UIColor darkGrayColor]];
        [customAlertView.alphaButton setAlpha:0];
        [customAlertView addSubview:customAlertView.alphaButton];
        
        customAlertView.alertContentView = [[UIView alloc] init];
        [customAlertView.alertContentView setBackgroundColor:[UIColor whiteColor]];
        [customAlertView.alertContentView.layer setCornerRadius:5];
        [customAlertView addSubview:customAlertView.alertContentView];
        
        //根据contentView自适应宽度
        if(contentView != nil){
            [customAlertView.alertContentView setWidth:contentView.width+30];
        }else{
            [customAlertView.alertContentView setWidth:SCREEN_WIDTH*3/4];
        }
        
        CGFloat distanceTop = 10.0f;
        //判断有没有标题
        if(title && [title length]){
            customAlertView.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, customAlertView.alertContentView.width-30, 40)];
            [customAlertView.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [customAlertView.titleLabel setTextColor:[UIColor colorWithHex:0x333333]];
            [customAlertView.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
            [customAlertView.titleLabel setText:title];
            [customAlertView.alertContentView addSubview:customAlertView.titleLabel];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, customAlertView.titleLabel.bottom, customAlertView.alertContentView.width, 1)];
            [lineView setBackgroundColor:RGB(229, 229, 229)];
            [customAlertView.alertContentView addSubview:lineView];
            distanceTop = lineView.bottom+10;
        }
        //判断有没有contentView
        if(contentView != nil){
            [contentView setLeft:15];
            [contentView setTop:distanceTop];
            [customAlertView.alertContentView addSubview:contentView];
            distanceTop = contentView.bottom+10;
        }
        //判断有没有提示信息
        if(message && [message length]){
            customAlertView.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, distanceTop, customAlertView.alertContentView.width-30, 20)];
//            [customAlertView.messageLabel setTextColor:[UIColor darkGrayColor]];
            [customAlertView.messageLabel setTextColor:[UIColor colorWithHex:0x333333]];
//            [customAlertView.messageLabel setFont:[UIFont systemFontOfSize:15]];
            [customAlertView.messageLabel setFont:[UIFont systemFontOfSize:17]];
            [customAlertView.messageLabel setNumberOfLines:0];
            [customAlertView.messageLabel setText:message];
            [customAlertView.messageLabel setTextAlignment:NSTextAlignmentCenter];
            [customAlertView.messageLabel setHeight:customAlertView.messageLabel.textHeight];
            [customAlertView.alertContentView addSubview:customAlertView.messageLabel];
            if(![title length]){
                distanceTop = customAlertView.messageLabel.bottom+40;
                [customAlertView.messageLabel setTop:(distanceTop-customAlertView.messageLabel.height)/2];
            }else{
                distanceTop = customAlertView.messageLabel.bottom+40;
                [customAlertView.messageLabel setTop:(distanceTop-customAlertView.messageLabel.height+customAlertView.titleLabel.height)/2];
            }
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, distanceTop, customAlertView.alertContentView.width, 1)];
//        [lineView setBackgroundColor:RGB(240, 240, 240)];
        [lineView setBackgroundColor:RGB(229, 229, 229)];
        [customAlertView.alertContentView addSubview:lineView];
        distanceTop = lineView.bottom+10;
        
        NSMutableArray *buttonArray  = [NSMutableArray array];
         NSInteger buttonIndex = 0;
        //确认按钮
        if(confirmButtonTitle && [confirmButtonTitle length]){
            customAlertView.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
            [customAlertView.confirmButton setTag:buttonIndex];
            buttonIndex++;
            [customAlertView.confirmButton.layer setCornerRadius:5];
            [customAlertView.confirmButton setClipsToBounds:YES];
            [customAlertView.confirmButton setBackgroundImage:[UIImage imageWithColor:RGB(235, 40,34)] forState:UIControlStateNormal];
            [customAlertView.confirmButton setBackgroundImage:[UIImage imageWithColor:RGB(215, 40,34)] forState:UIControlStateHighlighted];
            [customAlertView.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [customAlertView.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [customAlertView.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [customAlertView.confirmButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
            [buttonArray addObject:customAlertView.confirmButton];
        }
        
        //取消按钮
        if(cancleButtonTitle && [cancleButtonTitle length]){
            customAlertView.cancleButton = [customAlertView creatOtherButton];
            [customAlertView.cancleButton setTag:buttonIndex];
            buttonIndex++;
            [customAlertView.cancleButton.layer setCornerRadius:5];
            [customAlertView.cancleButton setClipsToBounds:YES];
            [customAlertView.cancleButton.layer setBorderWidth:1];
//            [customAlertView.cancleButton.layer setBorderColor:RGB(240, 240, 240).CGColor];
            [customAlertView.cancleButton.layer setBorderColor:RGB(203, 203, 203).CGColor];
            [customAlertView.cancleButton setBackgroundImage:[UIImage imageWithColor:RGB(255, 255,255)] forState:UIControlStateNormal];
            [customAlertView.cancleButton setBackgroundImage:[UIImage imageWithColor:RGB(250, 250,250)] forState:UIControlStateHighlighted];
//            [customAlertView.cancleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [customAlertView.cancleButton setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
//            [customAlertView.cancleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [customAlertView.cancleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [customAlertView.cancleButton setTitle:cancleButtonTitle forState:UIControlStateNormal];
            [buttonArray insertObject:customAlertView.cancleButton atIndex:0];
        }
        
        //其他按钮
        for(NSString *str in argsArray){
            UIButton *button = [customAlertView creatOtherButton];
            [button setTag:buttonIndex];
            buttonIndex++;
            [button.layer setCornerRadius:5];
            [button setClipsToBounds:YES];
            [button.layer setBorderWidth:1];
//            [button.layer setBorderColor:RGB(240, 240, 240).CGColor];
            [button.layer setBorderColor:RGB(229, 229, 229).CGColor];
            [button setBackgroundImage:[UIImage imageWithColor:RGB(255, 255,255)] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:RGB(250, 250,250)] forState:UIControlStateHighlighted];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitle:str forState:UIControlStateNormal];
            [buttonArray addObject:button];
        }
        
        CGFloat doubleWidth = (customAlertView.alertContentView.width-45)/2;
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
                __weak typeof(customAlertView)weakSelf = customAlertView;
                [button handlerTouchUpInsideEvent:^(id sender) {
                    if(weakSelf.block){
                        weakSelf.block(customAlertView,weakButton.tag);
                    }
                    [weakSelf hidden];
                }];
                [button setTop:distanceTop];
                [button setWidth:doubleWidth];
                [button setLeft:left];
                [customAlertView.alertContentView addSubview:button];
                left = button.right+15;
                if(buttonArray.lastObject == button){
                    distanceTop = button.bottom+10;
                }
            }
            
        }else{
            //交换取消确定按钮位置
            if(customAlertView.confirmButton){
                [buttonArray removeObject:customAlertView.confirmButton];
                [buttonArray insertObject:customAlertView.confirmButton atIndex:[buttonArray count]];
            }
            if(customAlertView.cancleButton){
                [buttonArray removeObject:customAlertView.cancleButton];
                [buttonArray insertObject:customAlertView.cancleButton atIndex:[buttonArray count]];
            }
            for(UIButton *button in buttonArray){
                __weak typeof(button)weakButton = button;
                __weak typeof(customAlertView)weakSelf = customAlertView;
                [button handlerTouchUpInsideEvent:^(id sender) {
                    if(weakSelf.block){
                        weakSelf.block(customAlertView,weakButton.tag);
                    }
                    [weakSelf hidden];
                }];
                [button setTop:distanceTop]; 
                [button setLeft:15];
                [button setWidth:customAlertView.alertContentView.width-30];
                [customAlertView.alertContentView addSubview:button];
                distanceTop = button.bottom+10;
            }
        }
        distanceTop+=5;
        [customAlertView.alertContentView setHeight:distanceTop];
        [customAlertView show];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
