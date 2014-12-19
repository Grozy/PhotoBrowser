//
//  ZoomViewController.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ViewController.h"
#import "PhotoItem.h"

//判读a的size是不是大于b的 如果为真 返回YES 否者为NO
static inline bool isBigger(const CGSize a,const CGSize b)
{
    if ((a.height > b.height)||(a.width > b.width))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

typedef void (^finishBlock)(BOOL isCurrent);

@interface ZoomViewController : UIViewController

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isCurrentPage;

- (instancetype)initWithImageView:(PhotoItem *)zoomItem finish:(finishBlock)block;
- (void)resetImageFrame;
@end
