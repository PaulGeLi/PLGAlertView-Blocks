//
//  UIActionSheet+Block.m
//  AlertViewDemo
//
//  Created by Paul on 15/5/8.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "UIActionSheet+Block.h"
#import <objc/runtime.h>

static char titleActionBlocks;

@implementation UIActionSheet (Block)
+ (instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandler:(void(^)())cancelHandler destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle destructiveHandler:(void(^)())destructiveHandler {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    sheet.delegate = sheet;
    
    NSMutableArray *array = [NSMutableArray array];
    if (destructiveButtonTitle) {
        if (destructiveHandler) {
            [array addObject:[destructiveHandler copy]];
        } else {
            [array addObject:[NSNull null]];
        }
    }
    if (cancelButtonTitle) {
        if (cancelHandler) {
            [array addObject:[cancelHandler copy]];
        } else {
            [array addObject:[NSNull null]];
        }
    }
    objc_setAssociatedObject(sheet, &titleActionBlocks, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return sheet;
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

#pragma mark - UIActionSheetDelegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 0) {
        NSMutableArray *array = objc_getAssociatedObject(self, &titleActionBlocks);
        void (^block)() = array[buttonIndex];
        if (array[buttonIndex] != [NSNull null]) {
            block();
        }
    }
}

@end
