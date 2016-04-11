//
//  PWAlertController.m
//  PWAlertController
//
//  Created by Paul Wang on 16/3/25.
//  Copyright © 2016年 Paul Wang. All rights reserved.
//

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#import "PWAlertController.h"
typedef NS_OPTIONS(NSInteger, PWActionSheetCellStyle) {
    PWActionSheetCellStyleNormal        = 0,
    PWActionSheetCellStyleDestructive   = 1
};

static  NSString    *ideActionSheetTableViewCell = @"PWActionSheetTableViewCellIde";

/**
 *  @author Paul Wang, 16-03-25 16:03:26
 *
 *  @brief action sheet 上的每个点击区块 cell
 */
@interface PWActionSheetTableViewCell : UITableViewCell {
    UIVisualEffectView  *_effectView;
}

@property (nonatomic, strong) UILabel   *contentLabel;

- (void)setText:(NSString *)text withStyle:(PWActionSheetCellStyle)style;

@end

@implementation PWActionSheetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        _effectView.frame = self.bounds;
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        [self.contentView addSubview:_effectView];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.contentLabel.textColor = [UIColor blackColor];
}

- (void)setText:(NSString *)text withStyle:(PWActionSheetCellStyle)style {
    self.contentLabel.text = text;
    if (style == PWActionSheetCellStyleDestructive) {
        self.contentLabel.textColor = [UIColor colorWithRed:0.99 green:0.24 blue:0.23 alpha:1.00];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentLabel sizeToFit];
    self.contentLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0f, self.frame.size.height / 2.0f);
    _effectView.frame = self.bounds;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

@end

@interface PWActionSheet : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray<NSString *>       *textArray;
@property (nonatomic, strong) UITableView   *actionSheetTableView;
@property (nonatomic, copy) NSString        *title;
@property (nonatomic, strong) NSString      *cancelTitle;
@property (nonatomic, assign) BOOL          hasDestruButton;
@property (nonatomic, copy) PWActionSheetEventBlock clickedEventBlock;

@end

@implementation PWActionSheet

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        effectview.frame = self.bounds;
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:effectview];
        [self addSubview:self.actionSheetTableView];
        
    }
    return self;
}

- (void)showInView:(UIView *)view {
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.frame.size.height);
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:0.6f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.frame = CGRectMake(0, SCREEN_HEIGHT - self.frame.size.height, SCREEN_WIDTH, self.frame.size.height);
                     } completion:^(BOOL finished) {
                         
                     }];
}
/**
 *  @author Paul Wang, 16-03-26 00:03:41
 *
 *  @brief
 */
- (void)reloadUI {
    [self.actionSheetTableView reloadData];
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, self.actionSheetTableView.contentSize.width, self.actionSheetTableView.contentSize.height);
    self.actionSheetTableView.frame = CGRectMake(0, 0, self.actionSheetTableView.contentSize.width, self.actionSheetTableView.contentSize.height);

}

#pragma mark - getters 
- (UITableView *)actionSheetTableView {
    if (!_actionSheetTableView) {
        _actionSheetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) style:UITableViewStyleGrouped];
        _actionSheetTableView.delegate = self;
        _actionSheetTableView.dataSource = self;
        [_actionSheetTableView registerClass:[PWActionSheetTableViewCell class] forCellReuseIdentifier:ideActionSheetTableViewCell];
        _actionSheetTableView.backgroundColor = [UIColor clearColor];
        _actionSheetTableView.scrollEnabled = NO;

    }
    return _actionSheetTableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.cancelTitle && self.cancelTitle.length) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.textArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PWActionSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideActionSheetTableViewCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (self.hasDestruButton && indexPath.row == self.textArray.count - 1) {
            [cell setText:[self.textArray objectAtIndex:indexPath.row] withStyle:PWActionSheetCellStyleDestructive];
        }else{
            [cell setText:[self.textArray objectAtIndex:indexPath.row] withStyle:PWActionSheetCellStyleNormal];
        }
    }
    if (indexPath.section == 1) {
        [cell setText:self.cancelTitle withStyle:PWActionSheetCellStyleNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickedEventBlock ) {
        if (indexPath.section == 0) {
            self.clickedEventBlock(indexPath.row);
        }else if (indexPath.section == 1) {
            self.clickedEventBlock(self.textArray.count);
        }
        [[PWAlertController shareAlert] dismissAlertController];
    }
}
/**
 *  @author Paul Wang, 16-03-25 17:03:43
 *
 *  @brief 标题view
 *
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.8];
        return v;
    }
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.96f];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.00];
    headerLabel.text = self.title;
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.title && section == 0) {
        return 50;
    }
    if (section == 1) {
        return 6;
    }
    return 0.05;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end

@interface PWAlertView : UIView <UIAlertViewDelegate>

@end

@implementation PWAlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}

@end

@interface PWAlertController ()

@property (nonatomic, strong) PWActionSheet *actionSheetView;
@property (nonatomic, strong) PWAlertView   *alertView;

@end

@implementation PWAlertController

+ (instancetype)shareAlert {
    static dispatch_once_t once;
    static PWAlertController * alert = nil;
    dispatch_once(&once, ^{
        alert = [[PWAlertController alloc] init];
        alert.automaticallyAdjustsScrollViewInsets = NO;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            
            alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
        }else{
            
            alert.modalPresentationStyle = UIModalPresentationCurrentContext;
            
        }
        alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    });
    return alert;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        [[PWAlertController shareAlert].actionSheetView showInView:[PWAlertController shareAlert].view];
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.actionSheetView];
}

+ (instancetype)sheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttonClicked:(PWActionSheetEventBlock)buttonClicked otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    PWAlertController *alert = [PWAlertController shareAlert];
    alert.actionSheetView.clickedEventBlock = [buttonClicked copy];
    alert.actionSheetView.hasDestruButton = NO;
    alert.actionSheetView.title = title;
    alert.actionSheetView.textArray = nil;
    NSMutableArray *tmpArr = [NSMutableArray array];
    // 遍历参数列表
    va_list otherTitles;
    id eachObject;
    if (otherButtonTitles) {
        va_start(otherTitles, otherButtonTitles);
        [tmpArr addObject:otherButtonTitles];
        while ((eachObject = va_arg(otherTitles, id))) {
            [tmpArr addObject:eachObject];
        }
        va_end(otherTitles);
    }
    if (cancelButtonTitle) {
        alert.actionSheetView.cancelTitle = cancelButtonTitle;
    }
    if (destructiveButtonTitle) {
        [tmpArr addObject:destructiveButtonTitle];
        alert.actionSheetView.hasDestruButton = YES;
    }
    alert.actionSheetView.textArray = tmpArr;
    [alert.actionSheetView reloadUI];
    
    
    return alert;
}

+ (void)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissAlertController];
}


- (void)dismissAlertController {
    
    [UIView animateWithDuration:0.20 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.actionSheetView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)showInViewController:(UIViewController *)viewController {

}

#pragma mark - getters
- (PWActionSheet *)actionSheetView {
    if (!_actionSheetView) {
        _actionSheetView = [[PWActionSheet alloc] init];
    }
    return _actionSheetView;
}

- (PWAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[PWAlertView alloc] init];
    }
    return _alertView;
}

@end
