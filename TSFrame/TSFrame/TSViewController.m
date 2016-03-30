//
//  TSViewController.m
//  TSFrame
//
//  Created by chenyusen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "TSViewController.h"

@implementation TSViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // TODO:
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    return [self initWithNibName:nil bundle:nil];
}

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (void)dealloc {
    self.autoresizesForKeyboard = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark View Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _isViewAppearing = YES;
    _hasViewAppeared = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _isViewAppearing = NO;
}


- (void)didReceiveMemoryWarning {
    if (_hasViewAppeared && !_isViewAppearing) {
        [super didReceiveMemoryWarning];
        _hasViewAppeared = NO;
    } else {
        [super didReceiveMemoryWarning];
    }
}


#pragma mark -
#pragma mark Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resizeForKeyboard:(NSNotification*)notification appearing:(BOOL)appearing {
    CGRect keyboardEnds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    if (appearing) {
        [self keyboardWillAppear:YES withBounds:keyboardEnds];
        
    } else {
        [self keyboardWillDisappear:YES withBounds:keyboardEnds];
    }
    
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark UIKeyboardNotifications


- (void)keyboardWillShow:(NSNotification*)notification {
    if (self.isViewAppearing) {
        [self resizeForKeyboard:notification appearing:YES];
    }
}

- (void)keyboardDidShow:(NSNotification*)notification {
    CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self keyboardDidAppear:YES withBounds:keyboardBounds];
}


- (void)keyboardDidHide:(NSNotification*)notification {
    if (self.isViewAppearing) {
        CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self keyboardDidDisappear:YES withBounds:keyboardBounds];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification {
    if (self.isViewAppearing) {
        [self resizeForKeyboard:notification appearing:NO];
    }
}

#pragma mark -
#pragma mark Public
- (void)setAutoresizesForKeyboard:(BOOL)autoresizesForKeyboard {
    if (autoresizesForKeyboard != _autoresizesForKeyboard) {
        _autoresizesForKeyboard = autoresizesForKeyboard;
        
        if (_autoresizesForKeyboard) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow:)
                                                         name:UIKeyboardWillShowNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillHide:)
                                                         name:UIKeyboardWillHideNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardDidShow:)
                                                         name:UIKeyboardDidShowNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardDidHide:)
                                                         name:UIKeyboardDidHideNotification
                                                       object:nil];
            
        } else {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardWillShowNotification
                                                          object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardWillHideNotification
                                                          object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardDidShowNotification
                                                          object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardDidHideNotification
                                                          object:nil];
        }
    }
}



- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    // Empty default implementation.
}


- (void)ts_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:animated];
}
- (void)ts_presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    [self presentViewController:viewController animated:animated completion:nil];

}

- (void)ts_popViewControllerAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}
@end
