//
//  TSModelDelegate.h
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSModel;

@protocol TSModelDelegate <NSObject>

@optional

- (void)modelDidStartLoad:(id<TSModel>)model;

- (void)modelDidFinishLoad:(id<TSModel>)model;

- (void)model:(id<TSModel>)model didFailLoadWithError:(NSError*)error;

- (void)modelDidCancelLoad:(id<TSModel>)model;

/**
 * Informs the delegate that the model has changed in some fundamental way.
 *
 * The change is not described specifically, so the delegate must assume that the entire
 * contents of the model may have changed, and react almost as if it was given a new model.
 */
- (void)modelDidChange:(id<TSModel>)model;

- (void)model:(id<TSModel>)model didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (void)model:(id<TSModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (void)model:(id<TSModel>)model didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Informs the delegate that the model is about to begin a multi-stage update.
 *
 * Models should use this method to condense multiple updates into a single visible update.
 * This avoids having the view update multiple times for each change.  Instead, the user will
 * only see the end result of all of your changes when you call modelDidEndUpdates.
 */
- (void)modelDidBeginUpdates:(id<TSModel>)model;

/**
 * Informs the delegate that the model has completed a multi-stage update.
 *
 * The exact nature of the change is not specified, so the receiver should investigate the
 * new state of the model by examining its properties.
 */
- (void)modelDidEndUpdates:(id<TSModel>)model;


@end
