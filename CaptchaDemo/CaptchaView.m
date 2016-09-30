//
//  CaptchaView.m
//  CaptchaDemo
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 ChangChang. All rights reserved.
//

#import "CaptchaView.h"

//随机的背景颜色
#define kRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]

//干扰线条的条数
#define kLineCount 6
//干扰线条的宽度
#define kLineWidth 0.5
//验证码字符的个数
#define kCharCount 4
//验证码字符显示的字体大小
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 20]

@implementation CaptchaView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius =5;
        self.layer.masksToBounds =YES;
        self.backgroundColor = kRandomColor;
        [self showCaptcha];
    }
    return self;
}

- (void)showCaptcha
{
    //准备数据源  52个大小写字母和 0-9 10个数字
    [self prepareDataSources];
    //随机数据源中的字符
    [self getCaptcha];
}

#pragma mark 绘制界面

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //设置验证码view的背景颜色
    self.backgroundColor = kRandomColor;
    
    //计算单个字符显示的位置
    CGSize cSize = [@" " sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    // 宽度
    int width = rect.size.width/self.changeStr.length-cSize.width;
    //高度
    int height =rect.size.height -cSize.height;
    
    //写入字符
    CGPoint point ;
    float x;
    float y;
    for (int i=0; i<self.changeStr.length; i++) {
        x = arc4random()%width+rect.size.width/self.changeStr.length*i;
        y = arc4random()%height;
        point =CGPointMake(x, y);
        unichar ch = [self.changeStr characterAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%C",ch];
        [str drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }
    
    //干扰线条
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kLineWidth);
    for (int i=0; i<kLineCount; i++)
    {
        UIColor *color =kRandomColor;
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        // 起点
        x = arc4random()%(int)rect.size.width;
        y = arc4random()%(int)rect.size.height;
        
        CGContextMoveToPoint(context, x, y);
        
        //终点
        x = arc4random()%(int)rect.size.width;
        y = arc4random()%(int)rect.size.height;
        
        CGContextAddLineToPoint(context, x, y);
        CGContextStrokePath(context);
    }

    
}

#pragma  mark  点击验证码图片 切换别的验证 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self getCaptcha];
    [self setNeedsDisplay];
}




#pragma mark 随机显示的四个字符
- (void)getCaptcha
{
    NSMutableString *mStr = [[NSMutableString alloc]init];
    NSString *getStr = [[NSString alloc]init];
    
    for (NSInteger i =0; i<kCharCount; i++)
    {
        NSInteger index =arc4random()%(self.changeArr.count -1);
        getStr = [self.changeArr objectAtIndex:index];
       [mStr appendString:getStr];
    }
    self.changeStr = [[NSMutableString alloc]initWithString:mStr];
    NSLog(@"%@",self.changeStr);
}


#pragma mark 数据源
- (void)prepareDataSources
{
    for (int i=0; i<26; i++)
    {
        unichar ch = 'a';
        NSString *str = [NSString stringWithFormat:@"%c",ch+i];
        [self.changeArr addObject:str];
        
        unichar ch1 = 'A';
        NSString *str1 = [NSString stringWithFormat:@"%c",ch1+i];
        [self.changeArr addObject:str1];
    }
    NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    [self.changeArr addObjectsFromArray:arr];
    
}


#pragma mark 懒加载
- (NSArray *)changeArr
{
    if (!_changeArr) {
        _changeArr = [[NSMutableArray alloc]init];
    }
    return _changeArr;
}
@end
