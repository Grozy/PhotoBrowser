//
//  MyConnectionOperation.h
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyConnectionOperation : NSOperation

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSRecursiveLock *lock;
@end
