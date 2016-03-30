//
//  TSModel.h
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,TSURLRequestCachePolicy) {
    TSURLRequestCachePolicyNone    = 0,
    TSURLRequestCachePolicyMemory  = 1,
    TSURLRequestCachePolicyDisk    = 2,
    TSURLRequestCachePolicyNetwork = 4,
    TSURLRequestCachePolicyNoCache = 8,
    TSURLRequestCachePolicyEtag    = 16 | TSURLRequestCachePolicyDisk,
    TSURLRequestCachePolicyLocal
    = (TSURLRequestCachePolicyMemory | TSURLRequestCachePolicyDisk),
    TSURLRequestCachePolicyDefault
    = (TSURLRequestCachePolicyMemory | TSURLRequestCachePolicyDisk
       | TSURLRequestCachePolicyNetwork),
};

@protocol TSModelDelegate;
#pragma mark -
#pragma mark <TSModel>

@protocol TSModel <NSObject>

/**
 * An array of objects that conform to the TSModelDelegate protocol.
 */
- (NSMutableArray*)delegates;

/**
 * Indicates that the data has been loaded.
 *
 * Default implementation returns YES.
 */
- (BOOL)isLoaded;

/**
 * Indicates that the data is in the process of loading.
 *
 * Default implementation returns NO.
 */
- (BOOL)isLoading;

/**
 * Indicates that the data is in the process of loading additional data.
 *
 * Default implementation returns NO.
 */
- (BOOL)isLoadingMore;

/**
 * Indicates that the model is of date and should be reloaded as soon as possible.
 *
 * Default implementation returns NO.
 */
-(BOOL)isOutdated;

/**
 * Loads the model.
 *
 * Default implementation does nothing.
 */
- (void)load:(TSURLRequestCachePolicy)cachePolicy more:(BOOL)more;

/**
 * Cancels a load that is in progress.
 *
 * Default implementation does nothing.
 */
- (void)cancel;

/**
 * Invalidates data stored in the cache or optionally erases it.
 *
 * Default implementation does nothing.
 */
- (void)invalidate:(BOOL)erase;

@end

#pragma mark -
#pragma mark TSModel
@interface TSModel : NSObject <TSModel> {
    NSMutableArray<TSModelDelegate>* _delegates;
}

/**
 * Notifies delegates that the model started to load.
 */
- (void)didStartLoad;

/**
 * Notifies delegates that the model finished loading
 */
- (void)didFinishLoad;

/**
 * Notifies delegates that the model failed to load.
 */
- (void)didFailLoadWithError:(NSError*)error;

/**
 * Notifies delegates that the model canceled its load.
 */
- (void)didCancelLoad;

/**
 * Notifies delegates that the model has begun making multiple updates.
 */
- (void)beginUpdates;

/**
 * Notifies delegates that the model has completed its updates.
 */
- (void)endUpdates;

/**
 * Notifies delegates that an object was updated.
 */
- (void)didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Notifies delegates that an object was inserted.
 */
- (void)didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Notifies delegates that an object was deleted.
 */
- (void)didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Notifies delegates that the model changed in some fundamental way.
 */
- (void)didChange;

@end
