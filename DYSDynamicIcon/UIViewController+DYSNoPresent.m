//
//  UIViewController+DYSNoPresent.m
//  DYSDynamicIcon
//
//  Created by 丁玉松 on 2019/11/20.
//  Copyright © 2019 丁玉松. All rights reserved.
//

#import "UIViewController+DYSNoPresent.h"

#import <objc/runtime.h>

@implementation UIViewController (DYSNoPresent)

#if 0

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(dys_presentViewController:animated:completion:));
        
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

- (void)dys_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        } else {
            [self dys_presentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self dys_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#endif

@end
