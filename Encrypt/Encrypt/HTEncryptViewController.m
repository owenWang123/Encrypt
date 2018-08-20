//
//  HTEncryptViewController.m
//  Encrypt
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 owen. All rights reserved.
//

#import "HTEncryptViewController.h"
#import "HTEncryptUtil.h"

@interface HTEncryptViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *wordFld;
@property (nonatomic,strong) UIButton *enctrptBtn;
@property (nonatomic,strong) UILabel *enctrptLab;
@property (nonatomic,strong) UIButton *dectrptBtn;
@property (nonatomic,strong) UILabel *dectrptLab;
@property (nonatomic,strong) NSData *encryptData;

@end

#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
@implementation HTEncryptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.titleStr isEqualToString:@"URL Encode"]) {
        // 完整链接： https://www.baidu.com/s?wd=%+&sd &p2=中文
        self.wordFld.text = @"%+&sd &p2=中文";
//        self.wordFld.text = @"https://www.baidu.com/s?wd=%25%2B%26sd+%26p2=%E4%B8%AD%E6%96%87&tn=84053098_3_dg&ie=utf-8";
    }
}
- (void)configUI{
    self.title = self.titleStr;
    
    self.wordFld = [[UITextField alloc]initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH-20, 50)];
    [self.view addSubview:self.wordFld];
    self.wordFld.returnKeyType = UIReturnKeyDone;
    self.wordFld.delegate = self;
    self.wordFld.placeholder = @"keyword";
    self.wordFld.layer.masksToBounds = YES;
    self.wordFld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.wordFld.layer.borderWidth = 0.5;
    
    self.enctrptBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 -50, 90 +10 +50, 100, 40)];
    [self.view addSubview:self.enctrptBtn];
    self.enctrptBtn.backgroundColor = [UIColor redColor];
    [self.enctrptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.enctrptBtn setTitle:@"加密" forState:UIControlStateNormal];
    [self.enctrptBtn addTarget:self action:@selector(encryptAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.enctrptLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 90 +10 +50*2, SCREEN_WIDTH -20, 70)];
    [self.view addSubview:self.enctrptLab];
    self.enctrptLab.numberOfLines = 0;
    self.enctrptLab.backgroundColor = [UIColor lightGrayColor];
    self.enctrptLab.textColor = [UIColor redColor];
    
    self.dectrptBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 -50, 90 +10 +50*3 +30, 100, 40)];
    [self.view addSubview:self.dectrptBtn];
    self.dectrptBtn.backgroundColor = [UIColor redColor];
    [self.dectrptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dectrptBtn setTitle:@"解密" forState:UIControlStateNormal];
    [self.dectrptBtn addTarget:self action:@selector(decryptAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dectrptLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 90 +10 +50*4 +30, SCREEN_WIDTH -20, 70)];
    [self.view addSubview:self.dectrptLab];
    self.dectrptLab.numberOfLines = 0;
    self.dectrptLab.backgroundColor = [UIColor lightGrayColor];
    self.dectrptLab.textColor = [UIColor redColor];
}
#pragma mark- Action
- (void)encryptAction:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSString *resultStr = nil;
    if ([self.titleStr isEqualToString:@"URL Encode"]) {
        resultStr = [HTEncryptUtil ht_urlEncode:self.wordFld.text];
        // 使用时拼接
//        NSString *urlStr = [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@",resultStr];
//        NSLog(@"%@",urlStr);
    }else if ([self.titleStr isEqualToString:@"Base64"]) {
        resultStr = [HTEncryptUtil ht_encodeBase64String:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"MD5"]){
        resultStr = [HTEncryptUtil ht_MD5ForUpper32Bate:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"SHA"]){
        resultStr = [HTEncryptUtil ht_SHA512:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"AES"]){
        self.encryptData = [HTEncryptUtil ht_encryptAESData:self.wordFld.text];
        resultStr = @"转码成功";
    }else if ([self.titleStr isEqualToString:@"DES"]){
        self.encryptData = [HTEncryptUtil ht_encryptDESData:self.wordFld.text];
        resultStr = @"转码成功";
    }else if ([self.titleStr isEqualToString:@"RSA"]){
        
    }
    self.enctrptLab.text = resultStr;
}
- (void)decryptAction:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSString *resultStr = nil;
    if ([self.titleStr isEqualToString:@"URL Encode"]) {
        resultStr = [HTEncryptUtil ht_urlDencode:self.enctrptLab.text];
    }else if ([self.titleStr isEqualToString:@"Base64"]) {
        resultStr = [HTEncryptUtil ht_decodeBase64String:self.enctrptLab.text];
    }else if ([self.titleStr isEqualToString:@"MD5"]){
        resultStr = @"加密不可逆";
    }else if ([self.titleStr isEqualToString:@"SHA"]){
        resultStr = @"加密不可逆";
    }else if ([self.titleStr isEqualToString:@"AES"]){
        resultStr = [HTEncryptUtil ht_decryptAESData:self.encryptData];
    }else if ([self.titleStr isEqualToString:@"DES"]){
        resultStr = [HTEncryptUtil ht_decryptDESData:self.encryptData];
    }else if ([self.titleStr isEqualToString:@"RSA"]){
        
    }
    self.dectrptLab.text = resultStr;
}
#pragma mark-
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
