//
//  HJBaseLogin_VC.h
//  HJLoginDemo
//
//  Created by WHJ on 2018/2/7.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJBaseLogin_VC : UIViewController

/** 背景视图图 */
@property (nonatomic, strong ,readonly) UIImageView *bgImageView;
/** 内容视图 */
@property (nonatomic, strong ,readonly) UIView *containerView;
/** logo */
@property (nonatomic, strong) UIButton *logoBtn;
/** 账号输入 */
@property (nonatomic, strong) UITextField *accountTF;
/** 密码输入 */
@property (nonatomic, strong) UITextField *passwordTF;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;
/** 注册按钮 */
@property (nonatomic, strong) UIButton *registBtn;
/** 重置密码按钮 */
@property (nonatomic, strong) UIButton *resetPasswordBtn;





- (void)keyboardWillShow:(NSNotification *)notif;

- (void)keyboardWillHide:(NSNotification *)notif;

@end
