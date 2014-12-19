//
//  BrowserToolbar.h
//  imageZoom
//
//  Created by 孙国志 on 14/12/19.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserToolbar : UIView

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, assign) NSInteger totoalPage;

- (void)setCurrentPageNumber:(NSInteger)page;
- (void)firstPage:(NSInteger)page;
- (void)setCurrentPageNumber:(NSInteger)page andTotoal:(NSInteger)totoalPage;
- (void)hidden:(NSTimeInterval)duration;
- (void)show:(NSTimeInterval)duration;
@end
