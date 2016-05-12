//
//  UIAlertView+Block.m
//  AlertViewDemo
//
//  Created by Paul on 15/5/8.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static char titleActionBlocks;

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
@implementation UIAlertView (Block)
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    alertView.delegate = alertView;
    return alertView;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandler:(void(^)())cancelHandler {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    alertView.delegate = alertView;
    
    if (cancelButtonTitle) {
        NSMutableArray *array = [NSMutableArray array];
        if (cancelHandler) {
            [array addObject:[cancelHandler copy]];
        } else {
            [array addObject:[NSNull null]];
        }
        objc_setAssociatedObject(alertView, &titleActionBlocks, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return alertView;
}

- (void)addTitle:(NSString *)title handle:(void(^)())handler {
    if (self.delegate) {
        self.delegate = self;
    }
    
    [self addButtonWithTitle:title];
    NSMutableArray *array = [self titleActionBlocks];
    if (handler) {
        [array addObject:[handler copy]];
    } else {
        [array addObject:[NSNull null]];
    }
}

- (NSMutableArray *)titleActionBlocks {
    NSMutableArray *array = objc_getAssociatedObject(self, &titleActionBlocks);
    if (array == nil) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, &titleActionBlocks, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 0) {
        NSMutableArray *array = objc_getAssociatedObject(self, &titleActionBlocks);
        if (array[buttonIndex] != [NSNull null]) {
            void (^block)() = array[buttonIndex];
            block();
        }
    }
}


@end
#endif