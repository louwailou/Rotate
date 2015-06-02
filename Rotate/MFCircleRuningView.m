//
//  MFCircleRuningView.m
//  Rotate
//
//  Created by Sun on 15/6/1.
//  Copyright (c) 2015年 Sun. All rights reserved.
//
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degrees) ((degrees)*M_PI/180.0)
#import "MFCircleRuningView.h"
#import "MFCircleView.h"

static CGFloat delteRadius = 20;
static CGFloat baseRaduis = 30;
static CGFloat textCircleWidth = 20;


@interface MFCircleRuningView()

@property (nonatomic,strong)MFCircleView *circleView;
@property (nonatomic,strong)MFCircleView *circleViewTwo;
@property (nonatomic,strong)MFCircleView *circleViewThree;
@property (nonatomic,strong)MFCircleView *circleViewFour;
@property (nonatomic,strong)UIImageView *imgForBg;

@property (nonatomic,strong)CAShapeLayer *circleLayerOne;
@property (nonatomic,strong)CAShapeLayer *circleLayerTwo;
@property (nonatomic,strong)CAShapeLayer *circleLayerThree;
@property (nonatomic,strong)CAShapeLayer *circleLayerFour;


@end
@implementation MFCircleRuningView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self )
    {
        
        [self setUp];
       
    }
    return self;
}
- (void)setUp{
    
    self.imgForBg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mine_finding_bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    [self addSubview:self.imgForBg];
    UIColor *strokeColor =[UIColor colorWithRed:1. green:1. blue:1. alpha:.2];
    self.circleLayerOne = [self createLayerWitStrokenColor:strokeColor.CGColor andIndex:0];
    [self.layer addSublayer:self.circleLayerOne];
    self.circleLayerTwo = [self createLayerWitStrokenColor:strokeColor.CGColor andIndex:1];
    [self.layer addSublayer:self.circleLayerTwo];
    self.circleLayerThree = [self createLayerWitStrokenColor:strokeColor.CGColor andIndex:2];
    [self.layer addSublayer:self.circleLayerThree];
    
    self.circleLayerFour = [self createLayerWitStrokenColor:strokeColor.CGColor andIndex:3];
    [self.layer addSublayer:self.circleLayerFour];
    
    /**
     *
     */
    self.circleView =  [self createCircleViewWithIndex:1];
    
    [self addSubview:self.circleView];
   
    self.circleViewTwo =  [self createCircleViewWithIndex:2];
    
    [self addSubview:self.circleViewTwo];
   
    
    self.circleViewThree =  [self createCircleViewWithIndex:3];
    
    [self addSubview:self.circleViewThree];
    
    
    
}
- (CAShapeLayer*)createLayerWitStrokenColor:(CGColorRef)color andIndex:(NSInteger)index{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color;
    layer.lineWidth = 1;
    layer.path = [self circlePathWithRadius:index*delteRadius andIndex:index];
    return layer;
}

- (CGFloat)radiansFromIndex:(NSInteger)index{
   
    
    CGFloat radians = 0;
    switch (index %4) {
        case 0:{
             radians = 1;
            break;
        }
        case 1:{
            radians = M_PI_2 + DEGREES_TO_RADIANS(30);
            break;
        }
        case 2:{
             radians = M_PI + DEGREES_TO_RADIANS(45);
            break;
        }
        case 3:{
            radians = 0;//M_PI_4  + DEGREES_TO_RADIANS(30);
            break;
        }
        default:
            
            break;
    }
    
    return radians;
}
- (MFCircleView*)createCircleViewWithIndex:(NSInteger)index{
    
   CGPoint point =  [self calculateCircleViewPointByIndex:index];
    if (index ==4) {
        index = 2;
    }
    MFCircleView *circle = [[MFCircleView alloc] initWithFrame:CGRectMake(point.x,point.y , textCircleWidth + index %4 * 5, index%4 *5 + textCircleWidth) andIndex:index];
    
    return circle;
}
- (CGPoint)calculateCircleViewPointByIndex:(NSInteger)index{
    CGFloat x = 0;
    CGFloat y = 0;
     CGFloat radius = baseRaduis+delteRadius *index;
    CGFloat width = textCircleWidth + index %4 * 5;
    CGFloat radian = [self radiansFromIndex:index];
    
    x = self.bounds.size.width/2 - radius*sin(radian)  -width/2;
    y = self.bounds.size.height/2 - radius*cos(radian) - width/2;

    return  CGPointMake(x, y);
}
- (CGPathRef)circlePathWithRadius:(CGFloat)delta andIndex:(NSInteger)index{
    CGFloat start = [self radiansFromIndex:index ];
    CGFloat end = [self radiansFromIndex:index ] + M_PI*2;
    if (index == 3) {
        start = 0;
        end = 2*M_PI;
    }
   
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:baseRaduis+delta startAngle:start endAngle:end clockwise:NO];
    return path.CGPath;
}

- (void)animationForLayer:(MFCircleView*)animationView andIndex:(NSInteger)index{
    CAKeyframeAnimation *animatioinCir = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSInteger otehrIndex = index;
    if (index == 4) {
        otehrIndex = 2;
    }
    CGPathRef path1 = [self circlePathWithRadius:delteRadius*otehrIndex andIndex:index];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point = [self calculateCircleViewPointByIndex:index];
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, point.x, point.y);
    CGPathAddPath(path, &CGAffineTransformIdentity, path1);
    
    [animatioinCir setPath:path];
    [animatioinCir setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animatioinCir.duration = 10 ;
    animatioinCir.removedOnCompletion = NO;
    animatioinCir.repeatCount =  CGFLOAT_MAX;
    [animationView.layer addAnimation:animatioinCir forKey:@"pos"];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgForBg setFrame:self.bounds];
}

- (void)stopAnimation{
    
    [self pauseLayer:self.circleView.layer];
    [self pauseLayer:self.circleViewTwo.layer];
    
    [self pauseLayer:self.circleViewThree.layer];
    [self pauseLayer:self.circleViewFour.layer];
    return;
    [self.circleView removeFromSuperview];
    [self.circleView.layer removeAnimationForKey:@"pos"];
    
    CALayer* presentLayer = self.circleView.layer.presentationLayer;
    NSLog(@"%@",(NSValue *)[presentLayer valueForKeyPath:@"position"]);
    NSLog(@"%@",NSStringFromCGRect(self.circleView.frame));
    
    [self.circleViewThree.layer  removeAnimationForKey:@"pos"];
    [self.circleViewThree removeFromSuperview];
    
    [self.circleViewTwo .layer removeAnimationForKey:@"pos"];
    [self.circleViewTwo removeFromSuperview];
    
    [self.circleViewFour.layer removeAnimationForKey:@"pos"];
    [self.circleViewFour removeFromSuperview];
}

- (void)restart{
    [self resumeLayer:self.circleView.layer];
    [self resumeLayer:self.circleViewTwo.layer];
    
    [self resumeLayer:self.circleViewThree.layer];
    [self resumeLayer:self.circleViewFour.layer];
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


- (void)setTextData:(NSString*)str{
    
}
- (void)startAnimation{
   
    self.circleView.labelContent = @"200人约标";
    [self addSubview:self.circleView];
    [self animationForLayer:self.circleView andIndex:1];
    

    self.circleViewTwo.labelContent = @"5人大家";
    [self addSubview:self.circleViewTwo];
    [self animationForLayer:self.circleViewTwo andIndex:2];
    
    
    self.circleViewThree.labelContent = @"50人大家";
    [self addSubview:self.circleViewThree];
    [self animationForLayer:self.circleViewThree andIndex:3];
    
    
    
    //    self.circleViewFour =  [self createCircleViewWithIndex:4];
    //    self.circleViewFour.labelContent = @"500人大家";
    //    [self addSubview:self.circleViewFour];
    //    [self animationForLayer:self.circleViewFour andIndex:4];
}

@end
