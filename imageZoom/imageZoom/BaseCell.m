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
@implementation BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.thumImageArray = [@[] mutableCopy];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImages:(NSArray *)array
{
    for(int i= 0;i < array.count;i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((10 + 70) * i +10, 10, 50, 50)];
        [imageView setUserInteractionEnabled:YES];
        imageView.image = [UIImage imageNamed:array[i]];
        imageView.tag = KBaseTag + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        PhotoItem *zoomItem = [[PhotoItem alloc] initWithImageView:imageView];
        [self addSubview:imageView];
        [self.thumImageArray addObject:zoomItem];
    }
    
}

- (void)imageViewClick:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(imageClick:thumImageArray:atIndex:)])
    {
        UIImageView *imageView = (UIImageView *)gestureRecognizer.view;
        
        for (PhotoItem *item in self.thumImageArray)
        {
            [item initItemFrame];
        }

        [self.delegate imageClick:imageView thumImageArray:self.thumImageArray atIndex:(imageView.tag - KBaseTag)];
    }
}

@end
