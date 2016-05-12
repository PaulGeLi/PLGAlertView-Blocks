//
//  UIActionSheet+Block.h
//  AlertViewDemo
//
//  Created by Paul on 15/5/8.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Block) <UIActionSheetDelegate>
+ (instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandler:(void(^)())cancelHandler destructiveButtonTitle:(NSString *)destructiveButtonTitle destructiveHandler:(void(^)())destructiveHandler;

- (void)addTitle:(NSString *)title handle:(void(^)())handler;
@end
