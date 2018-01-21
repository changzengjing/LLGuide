//
//  LLGuideTool.m
//  LLGuideToolDemo
//
//  Created by 李璐 on 2018/1/21.
//  Copyright © 2018年 LULI. All rights reserved.
//

#import "LLGuideTool.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

#define ScaleWith KScreenWidth/750.0
#define ScaleHeight KScreenHeight/1336.0

@interface LLGuideTool()
@property(nonatomic,strong)LLGuideModel * currentGuide;

@property(nonatomic, assign)CGFloat redius;

@property(nonatomic,strong)UIButton * dismissButton;

@property(nonatomic,strong)UIImageView * tipImageView;

@property(nonatomic, assign)CGRect tipIVFrame;

@property(nonatomic,strong)UIImage * tipImage;

@property(nonatomic,strong)CAShapeLayer * shapeLayer;

@property(nonatomic, assign)CGFloat scaleWidthOfTool;

@property(nonatomic, assign)CGFloat scaleHeightOfTool;

@property(nonatomic, assign)BOOL isShow;

@end

@implementation LLGuideTool

+(instancetype)share
{
    static LLGuideTool * tool;
    if (!tool) {
        tool = [[LLGuideTool alloc] init];
        [tool initUI];
    }
    return tool;
}

+(void)showGuide:(LLGuideModel*)guide
{
    LLGuideTool * tool = [LLGuideTool share];
    if (!tool.isShow) {
        BOOL haveShowed = [LLGuideTool checkIfGuideHaveShowed1:guide.name];
        if (!haveShowed) {
            tool.currentGuide = guide;
            [tool prepareParameter];
            [tool refreshUI];
            [tool show];
        }
    }
}

-(void)show
{
    self.isShow = YES;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

+(BOOL)checkIfGuideHaveShowed1:(NSString*)guideName
{
    id haveShowedObj = [[NSUserDefaults standardUserDefaults] objectForKey:guideName];
    if (haveShowedObj) {
        BOOL haveShowed = [[NSUserDefaults standardUserDefaults] boolForKey:guideName];
        if (haveShowed) {
            return YES;
        }
    }
    return NO;
}

-(void)prepareParameter
{
    self.redius = 0;
    
    BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    if (isLandscape) {
        self.scaleWidthOfTool = KScreenWidth/1336;
        self.scaleHeightOfTool = KScreenHeight/750;
    }
    else
    {
        self.scaleWidthOfTool = ScaleWith;
        self.scaleHeightOfTool = ScaleHeight;
    }
    
    self.redius = self.currentGuide.targetRect.size.width/2;
    self.tipImage = self.currentGuide.image;
    
    CGFloat width = self.tipImage.size.width;
    CGFloat height = self.tipImage.size.height;
    self.tipIVFrame = CGRectMake(self.currentGuide.targetRect.origin.x - self.currentGuide.positionOfImageToTarget * width, self.currentGuide.targetRect.origin.y + self.currentGuide.targetRect.size.height, width, height);
}

-(void)refreshUI
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    //背景
    UIBezierPath * targetPath = [UIBezierPath bezierPathWithRect:window.bounds];
    if (self.redius) {
        UIBezierPath * path2 = [[UIBezierPath bezierPathWithRoundedRect:self.currentGuide.targetRect cornerRadius:self.redius] bezierPathByReversingPath];
        [targetPath appendPath:path2];
    }
    self.shapeLayer.path = targetPath.CGPath;
    
    //内容
    self.tipImageView.image = self.tipImage;
    
    //位置
    self.tipImageView.frame = self.tipIVFrame;
}

-(void)initUI
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    [self.layer addSublayer:_shapeLayer];
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.dismissButton];
    self.dismissButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.dismissButton addTarget:self action:@selector(dismissOrNext) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dismissOrNext
{
    if (self.currentGuide.nextGuide) {
        [self nextAction];
    }
    else
    {
        [self dismiss];
    }
}

-(void)nextAction
{
    self.currentGuide = self.currentGuide.nextGuide;
    [self prepareParameter];
    [self refreshUI];
}

-(void)dismiss
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:self.currentGuide.name];
    self.isShow = NO;
}
@end
