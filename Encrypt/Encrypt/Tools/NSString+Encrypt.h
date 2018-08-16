//
//  NSString+Encrypt.h
//  Encrypt
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)
/**
 *  URL的encode
 **/
+ (NSString *)ht_urlEncode:(NSString *)url;
/**
 *  URL的dencode
 **/
+ (NSString *)ht_urlDencode:(NSString *)url;



@end
