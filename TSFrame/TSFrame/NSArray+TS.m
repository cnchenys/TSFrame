//
//  NSArray+TS.m
//  TSFrame
//
//  Created by sen on 16/3/30.
//  Copyright © 2016年 techsen. All rights reserved.
//

#import "NSArray+TS.h"

@implementation NSArray (TS)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for (id delegate; (delegate = [e nextObject]); ) {
        if ([delegate respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector];
#pragma clang diagnostic pop
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector withObject:(id)p1 {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for (id delegate; (delegate = [e nextObject]); ) {
        if ([delegate respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector withObject:p1];
#pragma clang diagnostic pop
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2 {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for (id delegate; (delegate = [e nextObject]); ) {
        if ([delegate respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector withObject:p1 withObject:p2];
        }
#pragma clang diagnostic pop
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3 {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for (id delegate; (delegate = [e nextObject]); ) {
        if ([delegate respondsToSelector:selector]) {
            [delegate performSelector:selector withObject:p1 withObject:p2 withObject:p3];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)makeObjectsPerformSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 {
    for (id delegate in self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [delegate performSelector:selector withObject:p1 withObject:p2];
#pragma clang diagnostic pop
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)makeObjectsPerformSelector: (SEL)selector
                        withObject: (id)p1
                        withObject: (id)p2
                        withObject: (id)p3 {
    for (id delegate in self) {
        [delegate performSelector:selector withObject:p1 withObject:p2 withObject:p3];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectWithValue:(id)value forKey:(id)key {
    for (id object in self) {
        id propertyValue = [object valueForKey:key];
        if ([propertyValue isEqual:value]) {
            return object;
        }
    }
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectWithClass:(Class)cls {
    for (id object in self) {
        if ([object isKindOfClass:cls]) {
            return object;
        }
    }
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)containsObject:(id)object withSelector:(SEL)selector {
    for (id item in self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([[item performSelector:selector withObject:object] boolValue]) {
#pragma clang diagnostic pop
            return YES;
        }
    }
    return NO;
}


@end
