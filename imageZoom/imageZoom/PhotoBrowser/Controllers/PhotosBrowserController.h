//
//  ZommViewsController.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ViewController.h"

@interface PhotosBrowserController : UIViewController

@property (nonatomic, strong) NSMutableArray *zoomViewControllers;
@property (nonatomic, strong) NSArray *photos;

- (instancetype)initWithImageArr:(NSArray *)imageArr imageIndex:(NSInteger)index;

@end
