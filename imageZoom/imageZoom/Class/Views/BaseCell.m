//
//  BaseCell.m
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "BaseCell.h"
#define KBaseTag 10000
#import "PhotoItem.h"
#import "UIImageView+WebCache.h"
@implementation BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.thumImageArray = [@[] mutableCopy];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setImages:(NSArray *)array
{
    for(int i= 0;i < array.count;i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((10 + 80) * i +10, 10, 80, 80)];
        [imageView setUserInteractionEnabled:YES];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView.layer setMasksToBounds:YES];
        imageView.image = [UIImage imageNamed:array[i]];
        [imageView setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"0"]];
        
        imageView.tag = KBaseTag + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        
        PhotoItem *zoomItem = [[PhotoItem alloc] initWithImageView:imageView];
        zoomItem.thumUrlString = array[i];
        zoomItem.urlString = [array[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];;
        //曾经尝试在这里获得imageView的frame 但是
        [self addSubview:imageView];
        [self.thumImageArray addObject:zoomItem];
    }
    
}

- (void)imageViewClick:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(imageClick:thumImageArray:atIndex:)])
    {
        UIImageView *imageView = (UIImageView *)gestureRecognizer.view;
        [self.delegate imageClick:imageView thumImageArray:self.thumImageArray atIndex:(imageView.tag - KBaseTag)];
    }
}

@end
