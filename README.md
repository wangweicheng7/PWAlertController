# PWAlertController

![logo](https://github.com/wangweicheng7/blog/blob/gh-pages/images/logo.png)

[![CI Status](http://img.shields.io/travis/陌上一梦觅琴音/PWAlertController.svg?style=flat)](https://travis-ci.org/陌上一梦觅琴音/PWAlertController)
[![Version](https://img.shields.io/cocoapods/v/PWAlertController.svg?style=flat)](http://cocoapods.org/pods/PWAlertController)
[![License](https://img.shields.io/cocoapods/l/PWAlertController.svg?style=flat)](http://cocoapods.org/pods/PWAlertController)
[![Platform](https://img.shields.io/cocoapods/p/PWAlertController.svg?style=flat)](http://cocoapods.org/pods/PWAlertController)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.
easy to use

``` Objective-C
PWAlertController *alert = [PWAlertController sheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" buttonClicked:^(NSUInteger index) {
    NSLog(@"alert selected at index:%ld", index);
} otherButtonTitles:@"标题一",@"标题二",@"标题三",nil];
[self presentViewController:alert animated:YES completion:^{

}];

```

> iOS 7 下， `[self presentViewController:alert animation:YES completion:nil];` 前面要写一句  `self.modalPresentationStyle = UIModalPresentationCurrentContext;` 



## Requirements

## Installation

PWAlertController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PWAlertController"
```

## Author

Paul Wang, wangwc@putao.com

## License

PWAlertController is available under the MIT license. See the LICENSE file for more info.
