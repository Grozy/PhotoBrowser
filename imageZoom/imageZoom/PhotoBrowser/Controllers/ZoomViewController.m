//
//  ZoomViewController.m
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ZoomViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
@interface ZoomViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImageView *thmImageView;
@property (nonatomic,strong) UIScrollView *zoomView;
@property (nonatomic,assign) CGRect translateFrame;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic,copy) finishBlock block;

@end

@implementation ZoomViewController

- (instancetype)initWithImageView:(PhotoItem *)zoomItem finish:(finishBlock)block;
{
    if (self = [super init])
    {
        self.image = [zoomItem.thumImageView.image copy];
        self.thmImageView = zoomItem.thumImageView;
        self.translateFrame = zoomItem.itemFrame;
        self.url = [NSURL URLWithString:[zoomItem.url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
        self.block = block;
        self.view.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self initZoomView];
    
    [self initImageView];
    
}

- (void)initImageView
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.translateFrame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = self.image;
    self.imageView.frame = self.translateFrame;
    [self.imageView.layer setMasksToBounds:YES];
    [self.zoomView addSubview:self.imageView];
}

- (void)initZoomView
{
    self.zoomView = [[UIScrollView alloc] init];
    self.zoomView.delegate = self;
    self.zoomView.frame = self.view.bounds;
    self.zoomView.minimumZoomScale = 1;
    self.zoomView.maximumZoomScale = 3.0;
    self.zoomView.scrollEnabled = YES;
    self.zoomView.showsHorizontalScrollIndicator = NO;
    self.zoomView.showsVerticalScrollIndicator = NO;
    self.zoomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat x = (self.image.size.width / self.image.size.height);
    self.zoomView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / x);
    [self.view addSubview:self.zoomView];
    
    [self addGestureRecognizerTo:self.zoomView];
}

- (void)addGestureRecognizerTo:(UIScrollView *)scrollView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)];
    [scrollView addGestureRecognizer:tap];
    [scrollView setUserInteractionEnabled:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //进入放大界面
    UIView *window = [UIApplication sharedApplication].keyWindow;
    
    CABasicAnimation *center = [CABasicAnimation animationWithKeyPath:@"position"];
    center.fromValue = [NSValue valueWithCGPoint:self.imageView.layer.position];
    center.toValue = [NSValue valueWithCGPoint:CGPointMake(floorf(window.frame.size.width / 2), floorf(window.frame.size.height / 2))];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"bounds"];
    scale.fromValue = [NSValue valueWithCGRect:self.translateFrame];
    scale.toValue = [NSValue valueWithCGRect:[self getFrameByImageSize:self.image.size]];
    
    NSArray *animations = nil;
        animations = @[center,scale];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = animations;
    group.delegate = self;
    group.duration = 0.35;
    [group setValue:@"appear" forKey:@"type-appear"];
    self.imageView.layer.bounds = [scale.toValue CGRectValue];
    self.imageView.layer.cornerRadius = 0;
    self.imageView.layer.position = [center.toValue CGPointValue];
    [self.imageView.layer addAnimation:group forKey:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //将要离开放大界面，将发生缩放动画的UIImageView添加到window中
    //不要放到didDisappear里
    if (self.isCurrentPage)
    {
        self.thmImageView.hidden = YES;
        UIApplication *app = [UIApplication sharedApplication];
        UIWindow *window = [app keyWindow];
        [window addSubview:self.imageView];
    }
    else
    {
//        [self downLoadPage];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"bounds"];
    ;
    scale.fromValue = [NSValue valueWithCGRect:self.imageView.frame];
    scale.toValue = [NSValue valueWithCGRect:self.translateFrame];
    
    CABasicAnimation *center = [CABasicAnimation animationWithKeyPath:@"position"];
    
    center.fromValue = [NSValue valueWithCGPoint:self.imageView.layer.position];
    center.toValue = [NSValue valueWithCGPoint:CGPointMake(self.translateFrame.origin.x + self.translateFrame.size.width / 2, self.translateFrame.origin.y + self.translateFrame.size.height / 2)];
    
    
    NSArray *animations = @[center,scale];

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = animations;
    [group setValue:@"dismiss" forKey:@"type-dismiss"];
    group.delegate = self;
    group.duration = .3;
    self.imageView.layer.position = [center.toValue CGPointValue];
    self.imageView.layer.bounds = [scale.toValue CGRectValue];
    [self.imageView.layer addAnimation:group forKey:nil];
}

- (void)disMiss
{
    if (self.block)
    {
        self.block(YES);
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim valueForKey:@"type-dismiss"])
    {
        [self viewDisAppearAnimate:[anim valueForKey:@"type-dismiss"]];
    }
    else if ([anim valueForKey:@"type-appear"])
    {
        self.view.hidden = NO;
        [self viewAppearAnimate:[anim valueForKey:@"type-appear"]];
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim valueForKey:@"type-dismiss"])
    {
        
        
    }
}

- (void)viewDisAppearAnimate:(NSString *)value
{
    //完成移动image的位置，将之前隐藏的图片显示，从window中移除self.imageView
    if ([value isEqualToString:@"dismiss"])
    {
        if (self.block)
        {
            self.block(nil);
        }
        
        [self.imageView removeFromSuperview];
        self.thmImageView.hidden = NO;
    }
}

- (void)viewAppearAnimate:(NSString *)value
{
    if ([value isEqualToString:@"appear"])
    {
        if (self.imageView.frame.size.height > [UIScreen mainScreen].bounds.size.height)
        {
            [UIView beginAnimations:nil context:nil];
            [UIView animateWithDuration:.55 animations:^{
                self.imageView.frame = CGRectMake(0, 0, self.zoomView.contentSize.width, self.zoomView.contentSize.height);
            }];
            [UIView commitAnimations];
        }
        
        [self.imageView setImage:self.image];
        
        __weak ZoomViewController *weakSelf = self;

        [[SDWebImageManager sharedManager] downloadWithURL:self.url options:SDWebImageRetryFailed progress:^(NSUInteger receivedSize, long long expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if (!error && image)
            {
                //                [weakSelf.progressView setHidden:YES];
                weakSelf.imageView.image = image;
                //                weakSelf.isLoaded = YES;
                CGFloat x = (image.size.width / image.size.height);
                weakSelf.imageView.frame = [weakSelf getFrameByImageSize:image.size];
                weakSelf.zoomView.contentSize = CGSizeMake(weakSelf.view.frame.size.width, weakSelf.view.frame.size.width / x);
            }
        
        }];
        
    }
}

- (CGRect)getFrameByImageSize:(CGSize)size
{
    CGSize viewBoundsSize = self.view.bounds.size;
    if (size.height /size.width > viewBoundsSize.height / viewBoundsSize.width)
    {
        return CGRectMake(0, 0, viewBoundsSize.width, viewBoundsSize.width * size.height / size.width);
    }
    else
    {
        return CGRectMake(0,(viewBoundsSize.height - viewBoundsSize.width * size.height / size.width) / 2, viewBoundsSize.width, viewBoundsSize.width * size.height / size.width);
    }
}

#pragma mark - scrollview delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.zoomView.userInteractionEnabled = YES;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundSize = scrollView.bounds.size;
    CGRect frameToCenter = self.imageView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundSize.width)
        frameToCenter.origin.x = (boundSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0.0;
    
    // center vertically
    if (frameToCenter.size.height < boundSize.height)
        frameToCenter.origin.y = (boundSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0.0;
    
    self.imageView.frame = frameToCenter;
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.zoomView.frame.size.height / scale;
    zoomRect.size.width  = self.zoomView.frame.size.width  / scale;
    zoomRect.origin.x = center.x;
    zoomRect.origin.y = center.y;
    return zoomRect;
}

- (void)resetImageFrame
{
    [self.zoomView setZoomScale:1 animated:NO];
}

@end
