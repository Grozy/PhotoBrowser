//
//  ZoomViewController.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ViewController.h"
#import "PhotoItem.h"

typedef void (^finishBlock)(BOOL isCurrent);

@interface ZoomViewController : UIViewController

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isCurrentPage;

- (instancetype)initWithImageView:(PhotoItem *)zoomItem finish:(finishBlock)block;
- (void)resetImageFrame;
@end
