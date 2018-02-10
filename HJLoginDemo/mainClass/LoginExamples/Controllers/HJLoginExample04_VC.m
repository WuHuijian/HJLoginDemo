//
//  HJLoginExample04_VC.m
//  HJLoginDemo
//
//  Created by WHJ on 2018/2/9.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "HJLoginExample04_VC.h"
#import <CoreMotion/CoreMotion.h>

@interface HJLoginExample04_VC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;

@property (nonatomic, strong) UIView *passwordLine;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, assign) CGFloat preLeft;

@property (nonatomic, assign) CGFloat preTop;

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
static const CGFloat kBGOffsetW = 60.f;//可移动偏移量


@implementation HJLoginExample04_VC

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self startUpdateAccelerometerResult];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self hideKeyboard];
}

- (void)dealloc
{
    _motionManager = nil;
}

#pragma mark - About UI
- (void)setupUI{
    
    /** 设置self.view */
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    /** 设置背景 */
    [self.bgImageView setImage:[UIImage imageNamed:@"login_bg02.jpg"]];
    [self.view addSubview:self.bgImageView];
    
    /** 设置内容视图 */
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.containerView];
    
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
        make.top.mas_equalTo(-kBGOffsetW);
        make.left.mas_equalTo(-kBGOffsetW);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width+2*kBGOffsetW, self.view.bounds.size.height+2*kBGOffsetW));
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


- (void)stopUpdate
{
    if ([self.motionManager isAccelerometerActive] == YES)
    {
        [self.motionManager stopAccelerometerUpdates];
    }
}

- (void)startUpdateAccelerometerResult{
    
    __weak typeof(self) weakSelf = self;
    if ([self.motionManager isAccelerometerAvailable] == YES) {
        [self.motionManager setAccelerometerUpdateInterval:0.06];
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             double x = accelerometerData.acceleration.x;
             double y = accelerometerData.acceleration.y;
             CGFloat left = weakSelf.bgImageView.frame.origin.x+x;
             CGFloat top = weakSelf.bgImageView.frame.origin.y-y;
             
             left = (left > 0 || left < -kBGOffsetW) ? weakSelf.preLeft : left;
             top = (top > 0 || top < -kBGOffsetW) ? weakSelf.preTop : top;
             
             [weakSelf.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.left.mas_equalTo(left);
                 make.top.mas_equalTo(top);
             }];
             
             weakSelf.preLeft = left;
             weakSelf.preTop = top;
         }];
    
    }
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

- (void)keyboardWillShow:(NSNotification *)notif{
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat passwordMaxY = CGRectGetMaxY(self.passwordTF.frame);
    CGFloat bgMaxY = CGRectGetMaxY(self.containerView.frame);
    CGFloat subHeight = height - (bgMaxY - passwordMaxY)+10;//10为缓冲距离
    
    //获取键盘动画时长
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //键盘遮挡才需上移
    if(subHeight>0){
        [UIView animateWithDuration:dutation animations:^{
            self.containerView.transform = CGAffineTransformMakeTranslation(0, - subHeight);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif{
    
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:dutation animations:^{
        self.containerView.transform = CGAffineTransformIdentity;
    }];
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
- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

@end
