//
//  BrowserToolbar.m
//  imageZoom
//
//  Created by 孙国志 on 14/12/19.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "BrowserToolbar.h"

@implementation BrowserToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageLabel = [[UILabel alloc] init];
        [_pageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_pageLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)firstPage:(NSInteger)page
{
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",page,_totoalPage];
}

- (void)setCurrentPageNumber:(NSInteger)page
{
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",page,_totoalPage];
}

- (void)setCurrentPageNumber:(NSInteger)page andTotoal:(NSInteger)totoalPage
{
    _totoalPage = totoalPage;
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",page,_totoalPage];
}

- (void)hidden:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    }];
}

- (void)show:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = .8f;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
