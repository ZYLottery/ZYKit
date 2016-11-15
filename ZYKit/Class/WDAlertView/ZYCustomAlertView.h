//
//  ZYCustomAlertView.h
//  ZYLottery
//
//  Created by 何伟东 on 16/6/30.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZYCustomAlertView : UIView
typedef void(^CustomeAlertBlock)( ZYCustomAlertView * _Nonnull customAlertView ,NSInteger index);
@property(nonatomic,copy) _Nonnull CustomeAlertBlock block;

+(void)initWithTitle:(nullable NSString*)title message:(nullable NSString*)message contentView:(nullable UIView*)contentView confirmButtonTitle:(nullable NSString*)confirmButtonTitle cancleButtonTitle:(nullable NSString*)cancleButtonTitle alertBlock:(nullable CustomeAlertBlock)alertBlock otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
