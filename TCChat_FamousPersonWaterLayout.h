//
//  TCChat_FamousPersonWaterLayout.h
//  Lesson-UI-22-3
//
//  Created by chuanbao on 16/6/5.
//  Copyright © 2016年 传保. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCChat_FamousPersonWaterLayoutDelegate <NSObject>

//获取到图片,设置高度返回(用于设置item的frame)
-(CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath;

@end

@interface TCChat_FamousPersonWaterLayout : UICollectionViewLayout

//item的大小
@property (nonatomic,assign)CGSize itemSize;
//内边距(距屏幕边缘的距离)
@property (nonatomic,assign)UIEdgeInsets sectionInsets;
//item的间距
@property (nonatomic,assign)CGFloat insertItemSpacing;
//列数
@property (nonatomic,assign)NSInteger numberOfColumns;
//
@property (nonatomic,weak)id<TCChat_FamousPersonWaterLayoutDelegate> delegate;

@end
