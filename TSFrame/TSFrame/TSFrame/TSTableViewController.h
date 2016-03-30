//
//  TSTableViewController.h
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "TSModelViewController.h"

@interface TSTableViewController : TSModelViewController <UITableViewDelegate> {
    UITableView *_tableView;
    UIView *_tableOverlayView;
    UIView *_errorView;
    UIView *_emptyView;
}

@end
