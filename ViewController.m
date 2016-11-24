//
//  ViewController.m
//  RZFlowButtonDemo
//
//  Created by Mac on 2016/11/24.
//  Copyright © 2016年 RachalZhou. All rights reserved.
//

#define kScreenW [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "RZFlowButtonView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenW, 30)];
    lblTitle.text = @"热门搜索";
    lblTitle.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lblTitle];
    
    RZFlowButtonView *flowView = [[RZFlowButtonView alloc]init];
    flowView.frame = CGRectMake(0, 50, kScreenW, 0);
    //flowView.backgroundColor = [UIColor yellowColor];
    flowView.words = @[@"李志",@"Fade",@"南山南",@"天空之城",@"We Don't Talk Anymore",@"张国荣",@"不为谁而作的歌",@"王力宏",@"五月天",@"我怀念的",@"刘德华"];
    [self.view addSubview:flowView];
    
    /* 可单独设置样式,不设置则为默认样式
     * words 词汇数组
     * btnColor 按钮背景色
     * titleColor 文字颜色
     * borderColor 按钮边框颜色
     * padding 按钮间隔
     * wordHeight 词汇高度
     * fontSize 字体大小
     */
    
    //按钮点击操作
    [flowView setClickBlock:^(UIButton *btn) {
        NSLog(@"%@",[btn currentTitle]);
        //btn.backgroundColor = [UIColor redColor];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
