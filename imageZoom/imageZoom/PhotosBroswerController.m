//
//  ZommViewsController.m
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "PhotosBroswerController.h"
#import "ZoomViewController.h"
#import "ZoomItem.h"

#define KSpace 20   //图片之间的间隙
@interface PhotosBroswerController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation PhotosBroswerController

- (instancetype)initWithImageArr:(NSArray *)imageArr imageIndex:(NSInteger)index;
{
    if (self = [super init])
    {
        self.photos = imageArr;
        self.currentIndex = index;
        self.zoomViewControllers = [@[] mutableCopy];
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark life cycle
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)loadView
{
    [super loadView];
    [self setUp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setUp
{
    CGSize mainScreenSize = [UIScreen mainScreen].bounds.size;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:(CGRect){
        {0  ,0},
        {mainScreenSize.width + KSpace ,mainScreenSize.height}
    }];
    self.mainScrollView.delegate = self;
    self.mainScrollView.backgroundColor = [UIColor blackColor];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.contentSize = CGSizeMake(self.photos.count * (mainScreenSize.width + KSpace), mainScreenSize.height);
    self.mainScrollView.contentOffset = CGPointMake(_currentIndex * (mainScreenSize.width + KSpace), 0);
    
    [self.view addSubview:self.mainScrollView];
    
    [self.photos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIView *zoomView = [[UIView alloc] initWithFrame:CGRectMake(idx * (KSpace + mainScreenSize.width), 0, mainScreenSize.width,mainScreenSize.height)];
        zoomView.backgroundColor = [UIColor blackColor];
        ZoomViewController *viewController = [[ZoomViewController alloc] initWithImageView:obj finish:nil];
        if (idx != _currentIndex)
        {
            [viewController.view setHidden:YES];
            viewController.isCurrentPage = NO;
        }
        else
        {
            viewController.isCurrentPage = YES;
        }
        
        [zoomView addSubview:viewController.view];
        [self addChildViewController:viewController];
        [self.zoomViewControllers addObject:viewController];
        [self.mainScrollView addSubview:zoomView];
    }];
}

#pragma mark ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setCurrentPage:(self.mainScrollView.contentOffset.x + KSpace)/(self.view.frame.size.width + KSpace)];
}

- (void)setCurrentPage:(NSInteger)pageIndex
{
    [self.zoomViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZoomViewController *zoomViewController = obj;
        if (pageIndex == idx)
        {
            zoomViewController.isCurrentPage = YES;
        }
        else
        {
            zoomViewController.isCurrentPage = NO;
            [zoomViewController resetImageFrame];
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
