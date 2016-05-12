//
//  UIAlertView+Block.h
//  AlertViewDemo
//
//  Created by Paul on 15/5/8.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)

+ (instancetype)alertViewWithTitle:( NSString *)title message:( NSString *)message;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandler:(void(^)())cancelHandler;

- (void)addTitle:(NSString *)title handle:(void(^)())handler;
@end
