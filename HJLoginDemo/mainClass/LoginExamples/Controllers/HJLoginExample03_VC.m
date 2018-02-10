//
//  HJLoginExample03_VC.m
//  HJLoginDemo
//
//  Created by WHJ on 2018/2/9.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "HJLoginExample03_VC.h"

@interface HJLoginExample03_VC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;

@property (nonatomic, strong) UIView *passwordLine;

@end

static const CGFloat kMaxW = 280.f;
static const CGFloat kMarginY10 = 10.f;
static const CGFloat kMarginY20 = 20.f;
static const CGFloat kBtnH = 40.f;
static const CGFloat kTextFieldH = 40.f;
static const CGFloat kLoginFontSize = 16.f;
static const CGFloat kOtherFontSize = 14.f;
static const CGFloat kTFLeftW = 30.f;
static const CGFloat kTFLeftH = 20.f;


@implementation HJLoginExample03_VC

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self hideKeyboard];
}

- (void)dealloc{
    
    [self.bgImageView stopAnimating];
}
#pragma mark - About UI
- (void)setupUI{
    
    /** 设置self.view */
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    /** 设置背景 */
    self.bgImageView.image = [UIImage imageNamed:@"login_bg03.jpg"];
    //UIBlurEffectStyleExtraLight,
    //UIBlurEffectStyleLight,
    //UIBlurEffectStyleDark,
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.view.bounds;
    [self.bgImageView addSubview:effectView];
    [self.view addSubview:self.bgImageView];
    
    /** 设置内容视图 */
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:self.containerView];
    
    /** 设置logo */
    [self.containerView addSubview:self.logoBtn];
    
    /** 设置账号输入 */
    self.accountTF.placeholder = @"账号";
    self.accountTF.tintColor = [UIColor whiteColor];
    self.accountTF.textColor = [UIColor whiteColor];
    self.accountTF.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    self.accountTF.delegate = self;
    [self.accountTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    accountImageV.contentMode = UIViewContentModeLeft;
    accountImageV.image = [UIImage imageNamed:@"login_account"];
    self.accountTF.leftView = accountImageV;
    [self.containerView addSubview:self.accountTF];
    
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = [UIColor whiteColor];
    self.accountLine = accountLine;
    [self.accountTF addSubview:accountLine];
    
    /** 设置密码输入 */
    UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    passwordImageV.contentMode = UIViewContentModeLeft;
    passwordImageV.image = [UIImage imageNamed:@"login_password"];
    self.passwordTF.tintColor = [UIColor whiteColor];
    self.passwordTF.textColor = [UIColor whiteColor];
    self.passwordTF.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = passwordImageV;
    self.passwordTF.placeholder = @"密码";
    self.passwordTF.delegate = self;
    [self.passwordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.containerView addSubview:self.passwordTF];
    
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = [UIColor whiteColor];
    self.passwordLine = passwordLine;
    [self.passwordTF addSubview:passwordLine];
    
    /** 设置登录按钮 */
    self.loginBtn.layer.cornerRadius = 8.f;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.borderWidth = 1.f;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:kLoginFontSize];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.containerView addSubview:self.loginBtn];
    
    /** 设置注册按钮 */
    self.registBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.registBtn];
    
    /** 设置重置密码按钮 */
    self.resetPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.resetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    [self.resetPasswordBtn addTarget:self action:@selector(resetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.resetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.containerView addSubview:self.resetPasswordBtn];
    
    
    /** 布局 */
    [self make_layout];
}


- (void)make_layout{
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.center.mas_equalTo(self.containerView);
    }];
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kTFLeftW);
        make.right.mas_equalTo(-2.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.containerView);
        make.bottom.mas_equalTo(self.passwordTF.mas_top).with.offset(-kMarginY20);
    }];
    
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kTFLeftW);
        make.right.mas_equalTo(-2.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.passwordTF.mas_bottom).with.offset(kMarginY20);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).with.offset(kMarginY10);
        make.height.mas_equalTo(kBtnH);
        make.width.mas_equalTo(kMaxW/2.f);
    }];
    
    
    [self.resetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).with.offset(kMarginY10);
        make.height.mas_equalTo(kBtnH);
        make.width.mas_equalTo(kMaxW/2.f);
    }];
    
}

#pragma mark - Request Data

#pragma mark - Pravite Method
- (void)hideKeyboard{
    
    [self.view endEditing:YES];
}

#pragma mark - Public Method

#pragma mark - Event response
- (void)tapAction{
    
    [self hideKeyboard];
}

- (void)loginAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
}

- (void)registAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
}

- (void)resetPasswordAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
    
}

#pragma mark - Delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self hideKeyboard];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self hideKeyboard];
}
#pragma mark - Getters/Setters/Lazy

@end
