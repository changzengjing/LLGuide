//
//  LLGuideModel.h
//  LLGuideToolDemo
//
//  Created by 李璐 on 2018/1/21.
//  Copyright © 2018年 LULI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum LLGuidePositionType{
    LLGuidePositionType_Top = 0,//目标控件在文字和箭头的上方
    LLGuidePositionType_Right = 1,
    LLGuidePositionType_Bottom = 2,
    LLGuidePositionType_Left = 3,
}LLGuidePositionType;//目标控件相对与文字、箭头的关系


@interface LLGuideModel : NSObject

@property(nonatomic,copy)NSString * name;//引导页面ID，防止重复播放

@property(nonatomic,assign)CGRect targetRect;

@property(nonatomic,strong)LLGuideModel * nextGuide;

@property(nonatomic,assign)CGFloat positionOfImageToTarget;//图片对应目标控件的位置

@property(nonatomic,assign)LLGuidePositionType positionType;

@property(nonatomic,strong)UIImage * image;

+(LLGuideModel*)guideWithTarget:(CGRect)targetRect position:(CGFloat)position image:(UIImage*)image name:(NSString*)name;
@end
