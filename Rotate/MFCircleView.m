//
//  MFCircleView.m
//  Rotate
//
//  Created by Sun on 15/5/29.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

// .获得RGB颜色
#define YYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define YYColorA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MFColorFromRGB(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#import "MFCircleView.h"

static CGFloat basyFont = 7;

@interface MFCircleView()
@property (nonatomic,strong)UILabel *labelForText;
//@property (nonatomic,strong)UIImageView *imgForBg;
@property (nonatomic,assign)NSInteger index;
@end;
@implementation MFCircleView


- (id)initWithFrame:(CGRect)frame andIndex:(NSInteger)index{
    _index = index;
    self = [self initWithFrame:frame];
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUP];
    }
    return self;
}
-(void)setUP{
    self.labelForText = [[UILabel alloc] initWithFrame:CGRectZero];

    [self.labelForText setNumberOfLines:0];
    [self.labelForText setFont:[UIFont systemFontOfSize:basyFont + self.index%3]];
    [self.labelForText setTextColor:UIColorFromRGB(0xf13838)];
    [self.labelForText setTextAlignment:NSTextAlignmentCenter];
    [self.labelForText setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.labelForText];

}
//- (void)setLabelContent:(NSString *)labelContent{
//    
//    [self.labelForText setText:labelContent];
//}
-(void)layoutSubviews{
    [super layoutSubviews];
 
    [self.labelForText setFrame:CGRectMake(2, 2, self.bounds.size.width -4, self.bounds.size.height -4)];

}

- (void)drawRect:(CGRect)rect {
    
    
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
       // 画出色背景色
    CGContextSaveGState(context);
    CGContextAddArc(context, rect.size.width/2, rect.size.width/2, rect.size.width/2, 0, M_PI*2, YES);
    UIColor *color= [UIColor colorWithRed:1. green:1. blue:1. alpha:self.index % 3 *.2 + .3] ;
    CGContextSetFillColorWithColor(context,  color.CGColor);
    
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
    
    // 画出背景色
    CGContextDrawPath(context, kCGPathFill);
    
//
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:basyFont + self.index%3],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    [self.labelContent drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    
   
    
}

@end
