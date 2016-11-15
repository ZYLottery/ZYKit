//
//  ZYNoticeAlertView.h
//  ZYLottery
//
//  Created by 何伟东 on 2016/10/27.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNoticeAlertView : UIView
typedef void(^NoticeAlertBlock)( ZYNoticeAlertView * _Nonnull noticeAlertView ,NSInteger index);
@property(nonatomic,copy) _Nonnull NoticeAlertBlock block;


+(void)initWithTitle:(nullable NSString*)title message:(nullable NSString*)message contentView:(nullable UIView*)contentView confirmButtonTitle:(nullable NSString*)confirmButtonTitle cancleButtonTitle:(nullable NSString*)cancleButtonTitle alertBlock:(nullable NoticeAlertBlock)alertBlock otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
