//
//  ViewController.m
//  DYSDynamicIcon
//
//  Created by 丁玉松 on 2019/11/20.
//  Copyright © 2019 丁玉松. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)itemClick:(id)sender {
    NSInteger viewTag = 0;
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
        viewTag = tap.view.tag;
    }else{
        UIView *view = (UIView *)sender;
        viewTag = view.tag;
    }
    
    
    switch (viewTag) {
        case 0:
        {//
#if 1
            
            if ([[UIApplication sharedApplication] supportsAlternateIcons]) {
                
                [[UIApplication sharedApplication] setAlternateIconName:@"测试" completionHandler:^(NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"更换app图标发生错误了 ： %@",error);
                    }
                }];
            }
            
#else
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(supportsAlternateIcons)] &&
                     [[UIApplication sharedApplication] supportsAlternateIcons])
                 {
                     NSMutableString *selectorString = [[NSMutableString alloc] initWithCapacity:40];
                     [selectorString appendString:@"_setAlternate"];
                     [selectorString appendString:@"IconName:"];
                     [selectorString appendString:@"completionHandler:"];
                     
                     SEL selector = NSSelectorFromString(selectorString);
                     IMP imp = [[UIApplication sharedApplication] methodForSelector:selector];
                     void (*func)(id, SEL, id, id) = (void *)imp;
                     if (func)
                     {
                         func([UIApplication sharedApplication], selector, @"测试", ^(NSError * _Nullable error) {});
                     }
                 }
#endif
            
        }
            break;
            
        default:
            break;
    }
}


@end
