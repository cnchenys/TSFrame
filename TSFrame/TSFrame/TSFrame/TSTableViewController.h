//
//  TSTableViewController.h
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "TSModelViewController.h"

#import <NIMutableTableViewModel.h>
#import <NITableViewActions.h>
#import <NICellFactory.h>

@interface TSTableViewController : TSModelViewController <UITableViewDelegate> {
    UITableView *_tableView;
    UIView *_tableOverlayView;
    UIView *_errorView;
    UIView *_emptyView;
}

@property(nonatomic ,strong) UITableView *tableView;

@property(nonatomic ,strong) UIView *tableOverlayView;

@property(nonatomic ,strong) UIView *emptyView;

@property(assign) UITableViewStyle tableViewStyle;

@property(assign) BOOL clearsSelectionOnViewWillAppear;



@property(nonatomic ,strong) NITableViewActions *tableViewActions;

@property(nonatomic ,strong) NITableViewModel *tableViewModel;

@property(nonatomic ,strong) NICellFactory *cellFactory;

@end
