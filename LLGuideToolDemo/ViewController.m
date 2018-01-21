//
//  ViewController.m
//  LLGuideToolDemo
//
//  Created by 李璐 on 2018/1/21.
//  Copyright © 2018年 LULI. All rights reserved.
//

#import "ViewController.h"
#import "LLGuideTool.h"
#import "LLGuideModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 40, 40);
    button.backgroundColor = [UIColor blueColor];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button2];
    button2.frame = CGRectMake(250, 400, 40, 40);
    button2.backgroundColor = [UIColor greenColor];
    
    CGRect rect1 = button.frame;
    CGRect rect2 = button2.frame;
    ;
    NSMutableArray<NSValue*>* rectArray = @[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2]];
    NSArray<UIImage*>* imageArray = @[[UIImage imageNamed:@"01_input02"],[UIImage imageNamed:@"01_input01"]];
    NSArray<NSNumber*>* positionArray = @[@(0.5),@(0.5)];
    NSArray<NSString*>* nameArray = @[@"name1",@"name2"];
    LLGuideModel * lastModel;
    LLGuideModel * firstModel;
    for (int i = 0; i < rectArray.count; i++) {
        LLGuideModel * model = [LLGuideModel guideWithTarget:rectArray[i].CGRectValue position:positionArray[i].floatValue image:imageArray[i] name:nameArray[i]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
