//
//  PWViewController.m
//  PWAlertController
//
//  Created by 陌上一梦觅琴音 on 03/25/2016.
//  Copyright (c) 2016 陌上一梦觅琴音. All rights reserved.
//

#import "PWViewController.h"
#import "PWAlertController.h"

@interface PWViewController ()

@end

@implementation PWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 200, 50);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(actionSheet:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)actionSheet:(id)sender {
    PWAlertController *alert = [PWAlertController sheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" buttonClicked:^(NSUInteger index) {
        NSLog(@"alert selected at index:%ld", index);
    } otherButtonTitles:@"标题一",@"标题二",@"标题三",nil];
    [alert showInViewController:self];
}

@end