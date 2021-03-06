//
//  TSModel.m
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "TSModel.h"
#import "TSModelDelegate.h"

@implementation TSModel

- (NSMutableArray *)delegates {
    if (!_delegates) {
        _delegates = NICreateNonRetainingMutableArray();
    }
    return _delegates;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TSURLRequestCachePolicy)cachePolicy more:(BOOL)more {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didStartLoad {
    [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFinishLoad {
    [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFailLoadWithError:(NSError*)error {
    [_delegates perform:@selector(model:didFailLoadWithError:) withObject:self
             withObject:error];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didCancelLoad {
    [_delegates perform:@selector(modelDidCancelLoad:) withObject:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)beginUpdates {
    [_delegates perform:@selector(modelDidBeginUpdates:) withObject:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)endUpdates {
    [_delegates perform:@selector(modelDidEndUpdates:) withObject:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    [_delegates perform: @selector(model:didUpdateObject:atIndexPath:)
             withObject: self
             withObject: object
             withObject: indexPath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    [_delegates perform: @selector(model:didInsertObject:atIndexPath:)
             withObject: self
             withObject: object
             withObject: indexPath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    [_delegates perform: @selector(model:didDeleteObject:atIndexPath:)
             withObject: self
             withObject: object
             withObject: indexPath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didChange {
    [_delegates perform:@selector(modelDidChange:) withObject:self];
}

@end
