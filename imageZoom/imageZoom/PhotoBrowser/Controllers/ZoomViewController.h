//
//  ZoomViewController.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ViewController.h"
#import "PhotoItem.h"

/**
 * 创建一个block用于返回是进行回调
 */
typedef void (^finishBlock)(BOOL isCurrent);

/**
 * 判读a的size是不是大于b的 如果为真 返回YES 否者为NO
 */
static inline bool isBigger(const CGSize a,const CGSize b)
{
    if ((a.height > b.height)||(a.width > b.width))
        return YES;
    else
        return NO;
}
/**
 * 获得高度和宽度的比例
 * @param a 要处理的size
 */
static inline CGFloat scale(const CGSize a){return a.width / a.height;}

/**
 * ZoomViewController : UIViewController, 
 * 用于容纳放大的图片，图片在ZoomViewController中可以进行放大、缩放保存
 */
@interface ZoomViewController : UIViewController
/**
 * 查看的加载完成的UIImageView
 */
@property (nonatomic,strong) UIImageView *imageView;

/**
 * 是否浏览的为当前页
 */
@property (nonatomic, assign) BOOL isCurrentPage;

/**
 * 创建返回一个实例instance
 * @return ZoomViewController*
 * @param photoItem 通过photoItem将url和UIImageView传递到ZoomViewController
 * @param block 作为返回的回调
 */
- (instancetype)initWithImageView:(PhotoItem *)photoItem finish:(finishBlock)block;

/**
 * 翻页后重置放大过后的frame
 */
- (void)resetImageFrame;
@end
