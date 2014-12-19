//
//  ZommViewsController.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ViewController.h"
typedef void (^finishBlock)(BOOL isCurrent);

@interface PhotosBrowserController : UIViewController
/**
 * 用于存放滚动视图中的viewController
 */
@property (nonatomic, strong) NSMutableArray *zoomViewControllers;

/**
 * 用于存放PhotoItem对象的数组
 */
@property (nonatomic, strong) NSArray *photos;

/**
 * 用于创建并初始化一个PhotoBrowserController
 * @param imageArr 一个存放PhotoItem的数组
 * @param index 当前打开的是第几张图片的放大图
 * @param block 回调
 */
- (instancetype)initWithImageArr:(NSArray *)imageArr imageIndex:(NSInteger)index finish:(finishBlock)block;

@end
