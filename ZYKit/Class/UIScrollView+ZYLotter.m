//
//  UIScrollView+ZYLotter.m
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/15.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "UIScrollView+ZYLotter.h"
#import <MJRefresh/MJRefresh.h>
#import <WDKit/WDKit.h>

@implementation UIScrollView (ZYLotter)
/**
 *  添加上下滑刷新   样式只是暂定   随时更换
 *
 *  @param headerAction 头部刷新的触发事件   没有不添加刷新
 *  @param footerAction 尾部刷新的触发事件   没有不添加刷新
 *  @param target       target对象
 */
- (void)addRefreshWithheaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target{
    [self addRefreshWithheaderSel:headerAction andFooterSel:footerAction andTarget:target beginRefresh:YES];
}
- (void)addRefreshWithheaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target beginRefresh:(BOOL)isRefresh{
    if (headerAction) {
        MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        //        // 设置文字
        //        [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
        //        [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
        //        [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
        //
        //        // 设置字体
        //        header.stateLabel.font = [UIFont systemFontOfSize:15];
        //        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
        //
        //        // 设置颜色
        //        header.stateLabel.textColor = [UIColor redColor];
        //        header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
        self.mj_header = header;
        if (isRefresh) {
            [self.mj_header beginRefreshing];
        }
    }
    if (footerAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
}
- (void)addRefreshWithheaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target WithignoredScrollViewContentInsetTop:(float)ignoredScrollViewContentInsetTop{
    if (headerAction) {
        MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        //        // 设置文字
        //        [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
        //        [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
        //        [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
        //
        //        // 设置字体
        //        header.stateLabel.font = [UIFont systemFontOfSize:15];
        //        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
        //
        //        // 设置颜色
        //        header.stateLabel.textColor = [UIColor redColor];
        //        header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
        self.mj_header = header;
        self.mj_header.ignoredScrollViewContentInsetTop = ignoredScrollViewContentInsetTop;
        [self.mj_header beginRefreshing];
    }
    if (footerAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
}
- (void)addRefreshForAnimationWithHeaderSel:(SEL)headerAction andFooterSel:(SEL)footerAction andTarget:(id)target{
    if (headerAction) {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        // 设置普通状态的动画图片
        [header setImages:@[] forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:@[] forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:@[] forState:MJRefreshStateRefreshing];
        self.mj_header = header;
        [self.mj_header beginRefreshing];
    }
    if (footerAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
}
#pragma mark - 开始刷新
- (void)beginHeaderRefresh{
    if ([self.mj_header isRefreshing]==NO) {
        [self.mj_header beginRefreshing];
    }
}
#pragma mark - 结束刷新
- (void)endHeaderRefresh{
    if ([self.mj_header isRefreshing]==YES) {
        [self.mj_header endRefreshing];
    }
}
- (void)endFooterRefresh{
    if ([self.mj_footer isRefreshing]==YES) {
        [self.mj_footer endRefreshing];
    }
}


/**
 *  根据视图尺寸获取视图截屏（一屏无法显示完整）,适用于UIScrollView UITableviewView UICollectionView UIWebView
 *
 *  @return UIImage 截取的图片
 */
- (UIImage *)scrollViewCutter{
    //保存
    CGPoint savedContentOffset = self.contentOffset;
    CGRect savedFrame = self.frame;
    
    self.contentOffset = CGPointZero;
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    
    UIImage *image = [self convertToImage];
    
    //还原数据
    self.contentOffset = savedContentOffset;
    self.frame = savedFrame;
    return image;
}


@end
