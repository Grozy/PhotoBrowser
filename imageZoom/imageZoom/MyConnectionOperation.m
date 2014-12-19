//
//  MyConnectionOperation.m
//  imageZoom
//
//  Created by 孙国志 on 14/11/5.
//  Copyright (c) 2014年 孙国志. All rights reserved.
//

#import "MyConnectionOperation.h"

static NSString * const kNetworkingLockName = @"com.alamofire.networking.operation.lock";

@implementation MyConnectionOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.lock = [[NSRecursiveLock alloc] init];
    self.lock.name = kNetworkingLockName;
    
    self.request = urlRequest;

    return self;
}
@end
