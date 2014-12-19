//
//  ViewController.m
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "ViewController.h"
#import "PhotosBroswerController.h"
#import "AFNetworking.h"
#import "ZoomItem.h"
#import "BaseCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,ImageClickDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.array = @[@"0",@"1",@"2",@"3"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell)
    {
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.delegate = self;
    }
    [cell setImages:self.array];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (void)imageClick:(UIImageView *)imageView thumImageArray:(NSArray *)thumArray atIndex:(NSInteger)index
{
    PhotosBroswerController *zoomViewsViewController = [[PhotosBroswerController alloc] initWithImageArr:thumArray imageIndex:index];
    [self presentViewController:zoomViewsViewController animated:NO completion:nil];
}
@end
