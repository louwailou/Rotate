//
//  ViewController.m
//  Rotate
//
//  Created by Sun on 15/5/29.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

#import "ViewController.h"
#import "MFCircleRuningView.h"
@interface ViewController ()
@property (nonatomic,strong)MFCircleRuningView *rote;
@end
static int timevalues = 0;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rote = [[MFCircleRuningView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 231)];
    [self.view addSubview:self.rote];
    [self.rote startAnimation];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"pasuse" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action ) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(100, 300, 50, 40)];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)action{
    timevalues ++;
    if (timevalues %2==1) {// 如果连续stop两次，应为间隔很小就看不出resume的效果
        [self.rote stopAnimation];
    }else{
        [self.rote  restart];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
