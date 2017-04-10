//
//  ZYAlertHub.h
//  ZYLottery
//
//  Created by guanxuhang1234 on 2017/2/23.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ZYToastPosion){
    ZYToastPosionBottom,
    ZYToastPosionCenter,
    ZYToastPosionTop
};
typedef NS_ENUM(NSInteger,ZYMessageLevel){
    ZYNoShowMessage = 0,//不显示
    ZYRedirectMessage = 1,//重定向
    ZYToastOnlyText = 1000,//Toast:文字
    ZYToastTextAndIcon = 1100,//Toast:图标+文字
    ZYAlertOneButton = 2000,//Dialog:单按钮(无图)
    ZYAlertTwoButton = 2100,//Dialog:双按钮(无图)+单按钮事件
    ZYAlertTwoButtonWithTwoAction = 2101,//双按钮(无图)+双按钮事件
    ZYAlertOneButtonAndBigPic = 2210,//Dialog:单按钮+大图+关闭按钮
    ZYAlertTwoButtonAndBigPic = 2220,//Dialog:双按钮+大图+关闭按钮+单按钮事件
    ZYAlertTwoButtonAndBigPicWithTwoAction = 2221,//Dialog:双按钮+大图+关闭按钮+双按钮事件
    ZYAlertOneButtonAndIcon = 2310,//Dialog:单按钮+图标
    ZYAlertTwoButtonAndIcon = 2320,//双按钮+图标+单按钮事件
    ZYAlertTwoButtonAndIconWithTwoAction = 2321//Dialog:双按钮+图标+双按钮事件
};
@interface ZYAlertHub : UIView

/**
  持续时间  默认3秒
 */
@property(nonatomic,assign) CGFloat duration;


/**
 <#Description#>

 @param messageLevel 类型
 @param messageDataDic 信息
 @param block 点击按钮回调
 @return <#return value description#>
 */
+ (ZYAlertHub *)showToastWithLevel:(NSInteger)messageLevel messageData:(NSDictionary *)messageDataDic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;

/**
 <#Description#>

 @param messageLevel <#messageLevel description#>
 @param messageDataDic <#messageDataDic description#>
 @param block <#block description#>
 @param closeblock 关闭按钮回调
 @return <#return value description#>
 */
+ (ZYAlertHub *)showToastWithLevel:(NSInteger)messageLevel messageData:(NSDictionary *)messageDataDic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block closeBlock:(void (^)(void))closeblock;

#pragma  mark  ---------------------  toast ------------------------------------
/**
 是否加蒙版 toast默认不加 alert默认加
 */
@property(nonatomic,assign) BOOL addMask;
+ (ZYAlertHub *)showToast:(NSString*)message;
+ (ZYAlertHub *)showToast:(NSString*)message  image:(NSString *)image;
+ (ZYAlertHub *)showToastWithView:(UIView *)view message:(NSString*)message  image:(NSString *)image;
/**
 显示
 @param view     显示所在视图
 @param message  文字
 @param image 图片 http 图片地址  或者是  本地图片名
 @param duration 持续时间
 @param position 位置
 */
- (void)showToastWithView:(UIView *)view message:(NSString*)message image:(NSString*)image duration:(NSInteger)duration withPosition:(ZYToastPosion)position;
- (void)showToastWithView:(UIView *)view message:(NSString*)message image:(NSString *)image;
- (void)showToast:(NSString*)message image:(NSString *)image;
- (void)showToast:(NSString*)message;

#pragma  mark  ---------------------  alert ------------------------------------


@property(nonatomic,assign) NSInteger buttonNumbers;
+ (ZYAlertHub *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;
+ (ZYAlertHub *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;

+ (ZYAlertHub *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles smallPic:(NSString *)smallPic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;



- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles smallPic:(NSString *)smallPic handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;
/**
 <#Description#>

 @param title             title 可空
 @param message           message  可空
 @param cancelButtonTitle  取消按钮titie 可空
 @param otherButtonTitles  其他按钮title 可空
 @param bigPic             大图（http 图片地址  或者是  本地图片名） 可空
 @param bigPicProportion   大图比例
 @param smallPic           小图（http 图片地址  或者是  本地图片名） 可空
 @param hasClossBtn        是否有关闭键
 @param block             点击按钮block
 */
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles bigPic:(NSString *)bigPic bigPicProportion:(float)bigPicProportion smallPic:(NSString *)smallPic hasCloseBtn:(BOOL)hasClossBtn handler:(void (^)(ZYAlertHub *alertView, NSInteger buttonIndex))block;
@end
