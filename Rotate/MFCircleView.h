//
//  MFCircleView.h
//  Rotate
//
//  Created by Sun on 15/5/29.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFCircleView : UIView
@property (nonatomic,setter= setLabelContent:)NSString *labelContent;
- (id)initWithFrame:(CGRect)frame andIndex:(NSInteger)index;
@end
