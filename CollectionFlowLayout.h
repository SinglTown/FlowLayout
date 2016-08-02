//
//  CollectionFlowLayout.h
//  自定义一个瀑布流
//
//  Created by 冷求慧 on 15/12/5.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionFlowLayout : UICollectionViewFlowLayout
// 总列数
@property (nonatomic, assign) NSInteger columnCount;
// 商品数据数组
@property (nonatomic, strong) NSArray *shopList;
@end
