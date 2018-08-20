//
//  HTEncryptUtil.m
//  Encrypt
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 owen. All rights reserved.
//

#import "HTEncryptUtil.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>// MD5、SHA
#import "NSData+AES.h"
#import "NSData+DES.h"

#define APP_PASSWORDKEY     @"0363b3e377d42bd919fbd28084ca9c67"
@implementation HTEncryptUtil
#pragma mark - URL的encode
+ (NSString *)ht_urlEncode:(NSString *)url{
    // 下面方法可把 ?%& 转换为UTF-8格式
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:url] invertedSet];
    NSString *encodeURL = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    return encodeURL;
}
+ (NSString *)ht_urlDencode:(NSString *)url{
    NSString *dencodeURL = [url stringByRemovingPercentEncoding];
    
    return dencodeURL;
}
#pragma mark - base64
+ (NSString*)ht_encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)ht_decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)ht_encodeBase64Data:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)ht_decodeBase64Data:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - MD5 加密
// 32位 大写
+ (NSString *)ht_MD5ForUpper32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}
// 32位 小写
+ (NSString *)ht_MD5ForLower32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
// 16位 大写
+ (NSString *)ht_MD5ForUpper16Bate:(NSString *)str{
    NSString *md5Str = [self ht_MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
// 16位 小写
+ (NSString *)ht_MD5ForLower16Bate:(NSString *)str{
    NSString *md5Str = [self ht_MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - SHA加密
//sha1加密方式。严格来说，sha1（安全[哈希算法]）只是叫做一种算法，用于检验数据完整性，并不能叫做加密～
+ (NSString *)ht_SHA1:(NSString *)input{
    // 适用无中文的情况
    //const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
//SHA512加密，类似还有SHA224、SHA256、SHA384
+ (NSString *)ht_SHA512:(NSString*)input{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma mark - AES加密
//将string转成带密码的data
+ (NSData*)ht_encryptAESData:(NSString*)string {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES256EncryptWithKey:APP_PASSWORDKEY];
    return encryptedData;
}

//将带密码的data转成string
+ (NSString*)ht_decryptAESData:(NSData*)data {
    //使用密码对data进行解密
    NSData *decryData = [data AES256DecryptWithKey:APP_PASSWORDKEY];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

#pragma makr - DES加密、解密
+ (NSData *)ht_encryptDESData:(NSString *)string {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data DESEncryptWithKey:APP_PASSWORDKEY];
    return encryptedData;
}

+ (NSString *)ht_decryptDESData:(NSData *)data {
    //使用密码对data进行解密
    NSString *decryptJsonString = [data DESDecryptWithKey:APP_PASSWORDKEY];
    //将解了密码的nsdata转化为nsstring
    //    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return decryptJsonString;
}

@end
