
//
//  NSString+Encrypt.m
//  Encrypt
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 owen. All rights reserved.
//

#import "NSString+Encrypt.h"

@implementation NSString (Encrypt)
//URL的encode
+ (NSString *)ht_urlEncode:(NSString *)url{
    NSString *encodeURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithRange:NSMakeRange(0, url.length)]];
    
    return encodeURL;
}
//URL的dencode
+ (NSString *)ht_urlDencode:(NSString *)url{
    NSString *dencodeURL = [url stringByRemovingPercentEncoding];
    
    return dencodeURL;
}



@end
