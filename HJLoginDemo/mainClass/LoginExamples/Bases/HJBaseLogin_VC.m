//
//  HJBaseLogin_VC.m
//  HJLoginDemo
//
//  Created by WHJ on 2018/2/7.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "HJBaseLogin_VC.h"

@interface HJBaseLogin_VC ()

/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;
/** 背景图 */
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation HJBaseLogin_VC

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObservers];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self addBackBtn];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)addBackBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20, 40, 40);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20.f;
    btn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
}


- (void)backAction:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - About UI

#pragma mark - Request Data

#pragma mark - Pravite Method
- (void)addObservers{
    
    //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
#pragma mark - Public Method

#pragma mark - Event response
- (void)keyboardWillShow:(NSNotification *)notif{
    
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat passwordMaxY = CGRectGetMaxY(self.passwordTF.frame);
    CGFloat bgMaxY = CGRectGetMaxY(self.bgImageView.frame);
    CGFloat subHeight = height - (bgMaxY - passwordMaxY)+10;//10为缓冲距离
    
    //获取键盘动画时长
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //键盘遮挡才需上移
    if(subHeight>0){
        [UIView animateWithDuration:dutation animations:^{
            self.bgImageView.transform = CGAffineTransformMakeTranslation(0, - subHeight);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif{
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:dutation animations:^{
        self.bgImageView.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - Delegate methods

#pragma mark - Getters/Setters/Lazy
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}


- (UIButton *)logoBtn{
    if (!_logoBtn) {
        _logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoBtn.enabled = NO;
    }
    return _logoBtn;
}


- (UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[UITextField alloc] init];
    }
    return _accountTF;
}


- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
    }
    return _passwordTF;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _loginBtn;
}


- (UIButton *)registBtn{
    if (!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _registBtn;
}


- (UIButton *)resetPasswordBtn{
    if (!_resetPasswordBtn) {
        _resetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _resetPasswordBtn;
}

@end
