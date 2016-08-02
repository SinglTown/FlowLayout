//
//  CollectionFlowLayout.m
//  自定义一个瀑布流
//
//  Created by 冷求慧 on 15/12/5.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import "CollectionFlowLayout.h"
#import "TCChat_FoundGroupBarFamousPerModel.h"
@interface CollectionFlowLayout (){
    
}
// 所有item的属性的数组
@property (nonatomic, strong) NSArray *layoutAttributesArray;
@end
@implementation CollectionFlowLayout

/**
 *  布局准备方法 当collectionView的布局发生变化时 会被调用
 *  通常是做布局的准备工作 itemSize.....
 *  UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的
 */
-(void)prepareLayout{
    CGFloat contentWidth = self.collectionView.bounds.size.width-self.sectionInset.left-self.sectionInset.right; //除去边距,每一行所有图片内容的宽度
    CGFloat itemDistance = self.minimumInteritemSpacing;//每一个Item之间的距离
    CGFloat eachItemW = (contentWidth-itemDistance*(self.columnCount - 1))/self.columnCount; //单个图片Item的宽度
    
    [self calculateLayout:eachItemW];// 计算布局属性
    
    
}

/**
 *  根据itemWidth计算布局属性
 */
-(void)calculateLayout:(CGFloat)itemW{
    
    CGFloat columnHeight [self.columnCount];// 定义一个列高数组 记录每一列的总高度
    CGFloat columnItemCount [self.columnCount];// 定义一个记录每一列的总item个数的数组
    
    //初始化
    for(int i = 0; i < self.columnCount;i++){
        columnHeight[i] = self.sectionInset.top;
        columnItemCount[i] = 0;
    }
    
    // 遍历 ShopModel数组 (通过模型数据计算出item的Frame)
    NSInteger index = 0;
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:self.shopList.count]; //设置数组的最大容量

    for (TCChat_FoundGroupBarFamousPerModel *shop in self.shopList) {
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *collectionViewAttributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]; //设置布局属性
        
        NSInteger column = [self shortestColumn:columnHeight];
        columnItemCount[column]++; // 数据追加在最短列
        CGFloat itemX = (itemW+self.minimumInteritemSpacing)*column+self.sectionInset.left; // X值
        CGFloat itemY = columnHeight[column]; // Y值
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:shop.recPic]];
        UIImage *image = [UIImage imageWithData:data];
        CGFloat ratio = image.size.height/image.size.width;
        CGFloat itemH = itemW*ratio+60;// 等比例缩放 计算item的高度 按照原来图片(Plist文件中的W和H)的比例来进行缩放的
        collectionViewAttributes.frame = CGRectMake(itemX, itemY, itemW, itemH);  // 设置frame
        [attributesArray addObject:collectionViewAttributes]; // 添加布局属性
        
        columnHeight[column] += itemH + self.minimumLineSpacing; // 累加列高
        
        index++;
    }
    // 找出最高列列号
    NSInteger column = [self highestColumn:columnHeight];
    // 根据最高列设置itemSize 使用总高度的平均值
    CGFloat itemH = (columnHeight[column] - self.minimumLineSpacing * columnItemCount[column]) / columnItemCount[column];
    self.itemSize = CGSizeMake(itemW, itemH);
    
    // 添加页脚属性
    NSIndexPath *footerIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerIndexPath];
    footerAttr.frame = CGRectMake(0, columnHeight[column], self.collectionView.bounds.size.width, 50);
    [attributesArray addObject:footerAttr];
    
    // 给属性数组设置数值
    self.layoutAttributesArray = attributesArray.copy;
}
/**
 *  找出columnHeight数组中最短列号 追加数据的时候追加在最短列中
 */
- (NSInteger)shortestColumn:(CGFloat *)columnHeight {
    CGFloat max = CGFLOAT_MAX; //float的最大值
    NSInteger column = 0;
    for (int i =0; i < self.columnCount; i++) {
        if (columnHeight[i] < max) {
            max=columnHeight[i];
            column=i;
        }
    }
    return column;
}
/**
 *  找出columnHeight数组中最高列号
 */
- (NSInteger)highestColumn:(CGFloat *)columnHeight {
    CGFloat min = CGFLOAT_MIN;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeight[i] > min) {
            min = columnHeight[i];
            column = i;
        }
    }
    return column;
}
/**
 *  跟踪效果：当到达要显示的区域时 会计算所有显示item的属性
 *           一旦计算完成 所有的属性会被缓存 不会再次计算
 *  @return 返回布局属性(UICollectionViewLayoutAttributes)数组
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
    
}
@end
