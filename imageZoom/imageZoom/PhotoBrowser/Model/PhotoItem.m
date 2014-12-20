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
//重写get方法 获得itemFrame
- (CGRect)itemFrame
{
    /*
     * 当在init ZoomViewController遍历的过程中 再次调用itemFframe的get方法时，statusBar会隐藏 导致有20pix误差
     */
    if (self.tag > 0 && [UIApplication sharedApplication].statusBarHidden)
    {
        CGRect frame = [self.thumImageView.superview convertRect:self.thumImageView.frame toView:[[UIApplication sharedApplication] keyWindow]];
        return CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 20, CGRectGetWidth(frame), CGRectGetHeight(frame));
    }
    else
        return [self.thumImageView.superview convertRect:self.thumImageView.frame toView:[[UIApplication sharedApplication] keyWindow]];
}

@end
