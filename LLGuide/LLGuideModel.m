//
//  LLGuideModel.m
//  LLGuideToolDemo
//
//  Created by 李璐 on 2018/1/21.
//  Copyright © 2018年 LULI. All rights reserved.
//

#import "LLGuideModel.h"

@implementation LLGuideModel

+(LLGuideModel*)guideWithTarget:(CGRect)targetRect position:(CGFloat)position image:(UIImage*)image name:(NSString *)name
{
    LLGuideModel * model = [[LLGuideModel alloc]init];
    model.targetRect = targetRect;
    model.positionOfImageToTarget = position;
    model.image = image;
    model.name = name;
    return model;
}

@end
