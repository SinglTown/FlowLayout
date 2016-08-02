//
//  MyLayout.h
//  Practice001
//
//  Created by Mac on 16/6/21.
//  Copyright © 2016年 Lukas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyLayoutDelegate <NSObject>
//获取到图片,设置高度返回(用于设置item的frame)
-(CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath;
@end
@interface MyLayout : UICollectionViewFlowLayout

@property (assign,nonatomic) int itemCount;
@property (nonatomic,weak)id<MyLayoutDelegate> delegate;
@end
