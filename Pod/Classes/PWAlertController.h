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

/**
 *  @author Paul Wang, 16-03-26 00:03:46
 *
 *  @brief 单例弹框
 *
 *  @return 单例方法
 */
+ (PWAlertController *)shareAlert;
/**
 *  @author Paul Wang, 16-03-26 00:03:50
 *
 *  @brief UIActionSheet 弹框，block 点击事件回调
 *
 *  @param title                  标题，可为空
 *  @param cancelButtonTitle      取消按钮，可为空
 *  @param destructiveButtonTitle 红色按钮
 *  @param buttonClicked          回调 block
 *  @param otherButtonTitles      其他按钮参数，支持多参数传递
 *
 *  @return 单例
 */
+ (instancetype)sheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttonClicked:(PWActionSheetEventBlock)buttonClicked otherButtonTitles:(NSString *)otherButtonTitles, ...;
/**
 *  @author Paul Wang, 16-03-26 00:03:14
 *
 *  @brief dis miss 弹框
 */
- (void)dismissAlertController;

@end
