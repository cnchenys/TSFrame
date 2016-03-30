//
//  TSModelViewController.m
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "TSModelViewController.h"

@implementation TSModelViewController


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _flags.isViewInvalid = YES;
    }
    return self;
}

- (void)dealloc {

}

@end
