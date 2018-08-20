//
//  HTEncryptUtil.h
//  Encrypt
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTEncryptUtil : NSObject
#pragma mark -  URL的encode
+ (NSString *)ht_urlEncode:(NSString *)url;
+ (NSString *)ht_urlDencode:(NSString *)url;
#pragma mark - Base64 加密、解密
+ (NSString*)ht_encodeBase64String:(NSString *)input;
+ (NSString*)ht_decodeBase64String:(NSString *)input;
+ (NSString*)ht_encodeBase64Data:(NSData *)data;
+ (NSString*)ht_decodeBase64Data:(NSData *)data;

#pragma mark - MD5 加密
// 32位 大写
+ (NSString *)ht_MD5ForUpper32Bate:(NSString *)str;
// 32位 小写
+ (NSString *)ht_MD5ForLower32Bate:(NSString *)str;
// 16位 大写
+ (NSString *)ht_MD5ForUpper16Bate:(NSString *)str;
// 16位 小写
+ (NSString *)ht_MD5ForLower16Bate:(NSString *)str;

#pragma mark - SHA512加密
//sha1加密方式
+ (NSString *)ht_SHA1:(NSString *)input;
+ (NSString *)ht_SHA512:(NSString*)input;

#pragma mark - AES加密、解密
//将string转成带密码的data
+ (NSData*)ht_encryptAESData:(NSString*)string;
//将带密码的data转成string
+ (NSString*)ht_decryptAESData:(NSData*)data;

#pragma mark - DES加密、解密
+ (NSData *)ht_encryptDESData:(NSString *)string;
+ (NSString *)ht_decryptDESData:(NSData *)data;

@end
