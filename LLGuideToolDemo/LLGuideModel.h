//
//  LLGuideModel.h
//  LLGuideToolDemo
//
//  Created by 李璐 on 2018/1/21.
//  Copyright © 2018年 LULI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLGuideModel : NSObject

@property(nonatomic,copy)NSString * name;//用于表示导航，防止重复播放

@property(nonatomic,assign)CGRect targetRect;

@property(nonatomic,strong)LLGuideModel * nextGuide;

@property(nonatomic,assign)CGFloat positionOfImageToTarget;

@property(nonatomic,strong)UIImage * image;

+(LLGuideModel*)guideWithTarget:(CGRect)targetRect position:(CGFloat)position image:(UIImage*)image name:(NSString*)name;
@end
