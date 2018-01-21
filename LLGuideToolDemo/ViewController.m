//
//  ViewController.m
//  LLGuideToolDemo
//
//  Created by 李璐 on 2018/1/21.
//  Copyright © 2018年 LULI. All rights reserved.
//

#import "ViewController.h"
#import "LLGuideTool.h"

@interface ViewController ()

@property(nonatomic,strong)UIButton * topButton;

@property(nonatomic,strong)UIButton * bottomButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(replay)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}

-(void)replay
{
    CGRect rect1 = self.topButton.frame;
    CGRect rect2 = self.bottomButton.frame;
    
    NSMutableArray<NSValue*>* rectArray = @[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2]];//目标控件在key window坐标系下的位置
    NSArray<UIImage*>* imageArray = @[[UIImage imageNamed:@"01_input02"],[UIImage imageNamed:@"01_input01"]];//提示箭头及文字图片
    NSArray<NSNumber*>* positionArray = @[@(0.05),@(0.6)];//箭头相对于图片的比例位置
    NSArray<NSString*>* nameArray = @[@"name1",@"name2"];//每个guide的名字，防止重复播放
    NSArray<NSNumber*>* positionType = @[@(LLGuidePositionType_Top),@(LLGuidePositionType_Bottom)];//目标控件相对于提示文字图片的位置
    LLGuideModel * lastModel;
    LLGuideModel * firstModel;
    for (int i = 0; i < rectArray.count; i++) {
        LLGuideModel * model = [LLGuideModel guideWithTarget:rectArray[i].CGRectValue position:positionArray[i].floatValue image:imageArray[i] name:nameArray[i]];
        model.positionType = (LLGuidePositionType)positionType[i].intValue;
        if (lastModel) {
            lastModel.nextGuide = model;
        }
        if (i == 0) {
            firstModel = model;
        }
        lastModel = model;
    }
    
    [LLGuideTool showGuide:firstModel];
}

-(void)initUI
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(20, 40, 40, 40);
    [button setTitle:@"嗨" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.topButton = button;
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(200, [UIScreen mainScreen].bounds.size.height - 100, 40, 40);
    [button1 setTitle:@"你好" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.bottomButton = button1;
}
@end
