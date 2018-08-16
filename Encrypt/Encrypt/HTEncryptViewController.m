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
    if ([self.titleStr isEqualToString:@"Base64"]) {
        resultStr = [HTEncryptUtil encodeBase64String:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"MD5"]){
        resultStr = [HTEncryptUtil md5:self.wordFld.text];
//        resultStr = [HTEncryptUtil md5HexDigest:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"SHA"]){
        resultStr = [HTEncryptUtil getSHA512String:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"AES"]){
//        resultStr = [HTEncryptUtil encryptAESData:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"DES"]){
//        resultStr = [HTEncryptUtil encryptDESData:self.wordFld.text];
    }else if ([self.titleStr isEqualToString:@"RSA"]){
        
    }
    self.enctrptLab.text = resultStr;
}
- (void)decryptAction:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSString *resultStr = nil;
    if ([self.titleStr isEqualToString:@"Base64"]) {
        resultStr = [HTEncryptUtil decodeBase64String:self.enctrptLab.text];
    }else if ([self.titleStr isEqualToString:@"MD5"]){
        //DONOTHING
    }else if ([self.titleStr isEqualToString:@"SHA"]){
        //DONOTHING
    }else if ([self.titleStr isEqualToString:@"AES"]){
//        resultStr = [HTEncryptUtil decryptAESData:self.enctrptLab.text];
    }else if ([self.titleStr isEqualToString:@"DES"]){
//        resultStr = [HTEncryptUtil decryptDESData:self.enctrptLab.text];
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
