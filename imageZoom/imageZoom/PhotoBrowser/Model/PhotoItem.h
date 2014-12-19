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

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *thumUrlString;
@property (nonatomic, weak) UIImageView *thumImageView;
@property (nonatomic, assign) CGRect itemFrame;

- (instancetype)initWithImageView:(UIImageView *)thumImageView;

@end
