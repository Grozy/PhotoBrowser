//
//  BaseCell.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageClickDelegate <NSObject>
@optional
- (void)imageClick:(UIImageView *)imageView thumImageArray:(NSArray *)thumArray atIndex:(NSInteger)index;
@end

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *thumImageArray;
@property (nonatomic, weak) id<ImageClickDelegate> delegate;

- (void)setImages:(NSArray *)array;

@end
