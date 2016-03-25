//
//  PWAlertController.h
//  PWAlertController
//
//  Created by Paul Wang on 16/3/25.
//  Copyright © 2016年 Paul Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PWActionSheetEventBlock)(NSUInteger index);

@interface PWAlertController : UIViewController

+ (PWAlertController *)shareAlert;
//+ (void)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;
+ (instancetype)sheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttonClicked:(PWActionSheetEventBlock)buttonClicked otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)dismissAlertController;

@end
