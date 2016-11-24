//
//  RZFlowButtonView.h
//  RZFlowButtonDemo
//
//  Created by Mac on 2016/11/24.
//  Copyright © 2016年 RachalZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZFlowButtonView : UIView

/* 可单独设置样式,不设置则为默认样式
 * words 词汇数组
 * btnColor 按钮背景色
 * titleColor 文字颜色
 * borderColor 按钮边框颜色
 * padding 按钮间隔
 * wordHeight 词汇高度
 * fontSize 字体大小
 */

@property (nonatomic, strong) NSArray *words;

@property (nonatomic, strong) UIColor *btnColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, assign) CGFloat wordHeight;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, strong) void(^clickBlock)(UIButton *btn);

@end
