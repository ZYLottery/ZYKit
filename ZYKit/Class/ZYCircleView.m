//
//  ZYCircleView.m
//  ZYLottery
//
//  Created by 赵鹏 on 16/5/24.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYCircleView.h"


@interface ZYCircleView ()
@property (nonatomic, assign) double lineWidth;
@property (nonatomic, assign) double radius;
@end



@implementation ZYCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    double total = 0;
    
    NSArray *numArray=[[NSArray alloc]init];
    
    
    if ([self.numbers isEqualToArray:@[@(0),@(0),@(0)]]) {
        numArray=@[@(1),@(1),@(1)];
    }else{
        numArray=self.numbers;
    }
    
    
    
    for(id num in numArray) {
        total += [num doubleValue];
    }
    if (total == 0) {
        return;
    }
    
    _lineWidth = 3;
    _radius = rect.size.width/2 - 5;
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    CGContextSetLineWidth(ref, _lineWidth);
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    double start = -M_PI_2;
    double interval = 0.01*M_PI;
    CGRect titleRect = CGRectMake(center.x-20, center.y-15 , 25, 25);
    for(int i=0; i< numArray.count; i++){
        CGContextSetStrokeColorWithColor(ref, [UIColor whiteColor].CGColor);
        CGContextAddArc(ref, center.x, center.y, _radius, start , interval+start, NO);
        CGContextStrokePath(ref);
        CGContextSaveGState(ref);
        start =  start + interval;
        
        double part1 = [numArray[i] doubleValue] / total * (M_PI*2 - interval*3);
        CGContextSetStrokeColorWithColor(ref, ((UIColor *)self.colors[i]).CGColor);
        CGContextAddArc(ref, center.x, center.y, _radius, start, part1+start, NO);
        CGContextStrokePath(ref);
        CGContextSaveGState(ref);
        start = start + part1;
        
        NSString *title = self.titles[i];
        [title drawInRect:titleRect withAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1],NSBackgroundColorAttributeName:[UIColor clearColor],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        
        NSString *numStr = [NSString stringWithFormat:@"%@",self.numbers[i]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(titleRect.origin.x-1, titleRect.origin.y+16, titleRect.size.width-13, titleRect.size.height-13)];
        label.text = numStr;
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = self.colors[i];
        [self addSubview:label];
        //        NSString *numStr = [NSString stringWithFormat:@"%@",self.numbers[i]];
        //        [numStr drawInRect:CGRectMake(titleRect.origin.x, titleRect.origin.y+20, titleRect.size.width, titleRect.size.height) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:self.colors[i],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        
        
        titleRect = CGRectMake(titleRect.origin.x +titleRect.size.width-10, titleRect.origin.y, titleRect.size.width, titleRect.size.height);
        
        
    }
}


@end
