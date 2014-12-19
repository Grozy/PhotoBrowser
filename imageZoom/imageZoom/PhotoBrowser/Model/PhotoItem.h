//
//  ZoomItem.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoItem : NSObject
/**
 * urlString 存放高清图的url字符串
 */
@property (nonatomic, copy) NSString *urlString;

/**
 * thumUrlString 用于存放缩率图url字符串
 */
@property (nonatomic, copy) NSString *thumUrlString;

/**
 * 用于存放缩略图的UIImageView 用于动画变化用
 */
@property (nonatomic, weak) UIImageView *thumImageView;

/**
 * 获得对象在window中的位置
 */
@property (nonatomic, assign, readonly) CGRect itemFrame;

/**
 * 初始化PhotoItem
 * @param thumImageView 缩略图的UIImageView对象
 * @return PhotoItem* 返回photoItem对象
 */
- (instancetype)initWithImageView:(UIImageView *)thumImageView;

@end
