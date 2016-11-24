//
//  RZFlowButtonView.m
//  RZFlowButtonDemo
//
//  Created by Mac on 2016/11/24.
//  Copyright © 2016年 RachalZhou. All rights reserved.
//

#import "RZFlowButtonView.h"

@interface RZFlowButtonView ()

@end

@implementation RZFlowButtonView

//初始化:默认设置
- (instancetype)init {
    if (self = [super init]) {
        self.btnColor = [UIColor whiteColor];
        self.titleColor = [UIColor blackColor];
        self.borderColor = [UIColor lightGrayColor];
        self.padding = 10;
        self.wordHeight = 25;
        self.fontSize = 15;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self loadButtons];
}

- (void)loadButtons {
    for (int i = 0; i < self.words.count; i++) {
        NSString *name = self.words[i];
        
        static UIButton *btnPrev = nil;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = self.btnColor;
        
        //标题自适应
        CGRect rect = [name boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), self.wordHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:btn.titleLabel.font} context:nil];
        
        if (i == 0) {
            btn.frame = CGRectMake(self.padding, self.padding, rect.size.width + 15, rect.size.height + 15);
        }else {
            CGFloat leftWidth = CGRectGetWidth(self.frame) - btnPrev.frame.origin.x - btnPrev.frame.size.width - self.padding * 2;
            if (leftWidth > rect.size.width) {
                btn.frame = CGRectMake(CGRectGetMaxX(btnPrev.frame) + self.padding, btnPrev.frame.origin.y, rect.size.width + 15, rect.size.height + 15);
            }else {
                btn.frame = CGRectMake(self.padding, CGRectGetMaxY(btnPrev.frame) + self.padding, rect.size.width + 15, rect.size.height + 15);
            }
        }
        
        btn.tag = i;
        
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = self.borderColor.CGColor;
        
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btnPrev = btn;
        
        //最后一个按钮时设置视图高度
        if (i == self.words.count - 1) {
            CGRect aRect = self.frame;
            aRect.size.height = CGRectGetMaxY(btn.frame) + 10;
            self.frame = aRect;
        }
    }
}

- (void)onBtnClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(btn);
    }
}

@end
