//
//  TSModelViewController.m
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "TSModelViewController.h"
#import "TSModel.h"

@implementation TSModelViewController {
    id<TSModel> _model;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _flags.isViewInvalid = YES;
    }
    return self;
}

- (void)dealloc {
    [_model.delegates removeObject:self];
}

#pragma mark -
#pragma mark Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetViewStates {
    if (_flags.isShowingLoading) {
        [self showLoading:NO];
        _flags.isShowingLoading = NO;
    }
    if (_flags.isShowingModel) {
        [self showModel:NO];
        _flags.isShowingModel = NO;
    }
    if (_flags.isShowingError) {
        [self showError:NO];
        _flags.isShowingError = NO;
    }
    if (_flags.isShowingEmpty) {
        [self showEmpty:NO];
        _flags.isShowingEmpty = NO;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateViewStates {
    if (_flags.isModelDidRefreshInvalid) {
        [self didRefreshModel];
        _flags.isModelDidRefreshInvalid = NO;
    }
    if (_flags.isModelWillLoadInvalid) {
        [self willLoadModel];
        _flags.isModelWillLoadInvalid = NO;
    }
    if (_flags.isModelDidLoadInvalid) {
        [self didLoadModel:_flags.isModelDidLoadFirstTimeInvalid];
        _flags.isModelDidLoadInvalid = NO;
        _flags.isModelDidLoadFirstTimeInvalid = NO;
        _flags.isShowingModel = NO;
    }
    
    BOOL showModel = NO, showLoading = NO, showError = NO, showEmpty = NO;
    
    if (_model.isLoaded || ![self shouldLoad]) {
        if ([self canShowModel]) {
            showModel = !_flags.isShowingModel;
            _flags.isShowingModel = YES;
            
        } else {
            if (_flags.isShowingModel) {
                [self showModel:NO];
                _flags.isShowingModel = NO;
            }
        }
        
    } else {
        if (_flags.isShowingModel) {
            [self showModel:NO];
            _flags.isShowingModel = NO;
        }
    }
    
    if (_model.isLoading) {
        showLoading = !_flags.isShowingLoading;
        _flags.isShowingLoading = YES;
        
    } else {
        if (_flags.isShowingLoading) {
            [self showLoading:NO];
            _flags.isShowingLoading = NO;
        }
    }
    
    if (_modelError) {
        showError = !_flags.isShowingError;
        _flags.isShowingError = YES;
        
    } else {
        if (_flags.isShowingError) {
            [self showError:NO];
            _flags.isShowingError = NO;
        }
    }
    
    if (!_flags.isShowingLoading && !_flags.isShowingModel && !_flags.isShowingError) {
        showEmpty = !_flags.isShowingEmpty;
        _flags.isShowingEmpty = YES;
        
    } else {
        if (_flags.isShowingEmpty) {
            [self showEmpty:NO];
            _flags.isShowingEmpty = NO;
        }
    }
    
    if (showModel) {
        [self showModel:YES];
        [self didShowModel:_flags.isModelDidShowFirstTimeInvalid];
        _flags.isModelDidShowFirstTimeInvalid = NO;
    }
    if (showEmpty) {
        [self showEmpty:YES];
    }
    if (showError) {
        [self showError:YES];
    }
    if (showLoading) {
        [self showLoading:YES];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createInterstitialModel {
    self.model = [[TSModel alloc] init];
}

#pragma mark -
#pragma mark View Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    _isViewAppearing = YES;
    _hasViewAppeared = YES;
    
    [self updateView];
    [super viewWillAppear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    if (_hasViewAppeared && !_isViewAppearing) {
        [super didReceiveMemoryWarning];
        [self refresh];
        
    } else {
        [super didReceiveMemoryWarning];
    }
}

#pragma mark -
#pragma mark TSModelDelegate
- (void)modelDidStartLoad:(id<TSModel>)model {
    if (model == _model) {
        _flags.isModelWillLoadInvalid = YES;
        _flags.isModelDidLoadFirstTimeInvalid = YES;
        [self invalidateView];
    }
}

- (void)modelDidFinishLoad:(id<TSModel>)model {
    if (model == _model) {
        _modelError = nil;
        _flags.isModelDidLoadInvalid = YES;
        [self invalidateView];
    }
}

- (void)model:(id<TSModel>)model didFailLoadWithError:(NSError *)error {
    if (model == _model) {
        self.modelError = error;
    }
}

- (void)modelDidCancelLoad:(id<TSModel>)model {
    if (model == _model) {
        [self invalidateView];
    }
}

- (void)modelDidChange:(id<TSModel>)model {
    if (model == _model) {
        [self refresh];
    }
}

- (void)model:(id<TSModel>)model didUpdateObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
}


- (void)model:(id<TSModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
}


- (void)model:(id<TSModel>)model didDeleteObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
}


- (void)modelDidBeginUpdates:(id<TSModel>)model {
    if (model == _model) {
        [self beginUpdates];
    }
}


- (void)modelDidEndUpdates:(id<TSModel>)model {
    if (model == _model) {
        [self endUpdates];
    }
}

#pragma mark
#pragma mark Public

- (id<TSModel>)model {
    if (!_model) {
        [self createModel];
    }
    if (!_model) {
        [self createInterstitialModel];
    }
    return _model;
}

- (void)setModel:(id<TSModel>)model {
    if (_model != model) {
        [_model.delegates removeObject:self];
        _model = model;
        [_model.delegates addObject:self];
        _modelError = nil;
        
        if (_model) {
            _flags.isModelWillLoadInvalid = NO;
            _flags.isModelDidLoadInvalid = NO;
            _flags.isModelDidLoadFirstTimeInvalid = NO;
            _flags.isModelDidShowFirstTimeInvalid = YES;
        }
        
        [self refresh];
    }
}

- (void)setModelError:(NSError*)error {
    if (error != _modelError) {
        _modelError = error;
        
        [self invalidateView];
    }
}

- (void)createModel {
}

- (void)invalidateModel {
    BOOL wasModelCreated = self.isModelCreated;
    [self resetViewStates];
    [_model.delegates removeObject:self];
    _model = nil;
    
    if (wasModelCreated) {
        [self model];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isModelCreated {
    return !!_model;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldLoad {
    return !self.model.isLoaded;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldReload {
    return !_modelError && self.model.isOutdated;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldLoadMore {
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canShowModel {
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reload {
    _flags.isViewInvalid = YES;
    [self.model load:TSURLRequestCachePolicyNetwork more:NO];
}

- (void)reloadIfNeeded {
    if ([self shouldReload] && !self.model.isLoading) {
        [self reload];
    }
}

- (void)refresh {
    _flags.isViewInvalid = YES;
    _flags.isModelDidRefreshInvalid = YES;
    
    BOOL loading = self.model.isLoading;
    BOOL loaded = self.model.isLoaded;
    
    // 刷新?
    // 如果没有加载过，则more = NO
    // 如果加载过，则按照PolicyNetwork来处理Cache
    //
    if (!loading && !loaded && [self shouldLoad]) {
        [self.model load:TSURLRequestCachePolicyDefault more:NO];
        
    } else if (!loading && loaded && [self shouldReload]) {
        [self.model load:TSURLRequestCachePolicyNetwork more:NO];
        
    } else if (!loading && [self shouldLoadMore]) {
        [self.model load:TSURLRequestCachePolicyDefault more:YES];
        
    } else {
        _flags.isModelDidLoadInvalid = YES;
        if (self.isViewAppearing) {
            [self updateView];
        }
    }
}

- (void)beginUpdates {
    _flags.isViewSuspended = YES;
}

- (void)endUpdates {
    _flags.isViewSuspended = NO;
    [self updateView];
}


- (void)invalidateView {
    _flags.isViewInvalid = YES;
    if (_isViewAppearing) {
        [self updateView];
    }
}

- (void)updateView {
    if (_flags.isViewInvalid && !_flags.isViewSuspended && !_flags.isUpdatingView) {
        _flags.isUpdatingView = YES;
        
        // Ensure the model is created
        [self model];
        // Ensure the view is created
        [self view];
        
        [self updateViewStates];
        
        _flags.isViewInvalid = NO;
        _flags.isUpdatingView = NO;
        
        [self reloadIfNeeded];
    }
}

- (void)didRefreshModel {
}

- (void)willLoadModel {
}

- (void)didLoadModel:(BOOL)firstTime {
}

- (void)didShowModel:(BOOL)firstTime {
}

- (void)showLoading:(BOOL)show {
}

- (void)showModel:(BOOL)show {
}

- (void)showEmpty:(BOOL)show {
}

- (void)showError:(BOOL)show {
}




@end
