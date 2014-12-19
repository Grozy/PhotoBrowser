//
//  ZoomItem.m
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem

- (instancetype)initWithImageView:(UIImageView *)thumImageView
{
    if (self = [super init])
    {
        _thumImageView = thumImageView;
    }
    return self;
}

- (void)initItemFrame
{
    _itemFrame = [self.thumImageView.superview convertRect:self.thumImageView.frame toView:[[UIApplication sharedApplication] keyWindow]];
}

@end
