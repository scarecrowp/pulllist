//
//  myNetPost.h
//  testView
//
//  Created by XmacZone on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myNetPost : NSObject;

@property (nonatomic, retain) NSURLConnection *Conn;
@property (nonatomic, retain) NSMutableData *Data;
@property (nonatomic, retain) UIImageView *ImageView;

-(void)StopAndClear;

-(void)Clear;

/*! 使用Get方式 同步 取值 错误时返回 "" 指针 */
+(NSString *)Get:(NSString *)surl encoding:(NSStringEncoding)code token:(NSString *)token;
/*! 使用Get方式 同步 取值 错误时返回 "" 指针 默认为 UTF-8 */
+(NSString *)Get:(NSString *)surl;
//解决中文显示的问题
+(NSData *)getCHS:(NSString *)surl token:(NSString *)token;
/*! 使用Get方式 异步 取值  错误时返回 "" 指针*/
/*! 下载一张图片*/
-(void)LoadImage:(NSString *)surl ImageView:(UIImageView *)image;
+(NSData *)Post:(NSString *)surl data:(NSData *)pData token:(NSString *)token;
+(NSData *)PostImage:(NSString *)surl picData:(NSData *)data token:(NSString *)token;
+(NSData *)get_Data:(NSString *)surl;
+(NSData *)GetData:(NSString *)surl encoding:(NSStringEncoding)code token:(NSString *)tokens;
@end
