//
//  myNetPost.m
//  testView
//
//  Created by XmacZone on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "myNetPost.h"

@implementation myNetPost
@synthesize Conn;
@synthesize Data;
@synthesize ImageView;
#pragma mark 开始

/*! 使用Get方式 同步 取值 错误时返回 "" 指针 */
+(NSString *)Get:(NSString *)surl encoding:(NSStringEncoding)code token:(NSString *)tokens
{
    NSString *s = [[NSString alloc]initWithFormat:@"" ];
    
    NSURL *url = [NSURL URLWithString:surl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   //  [request setValue:tokens forHTTPHeaderField:@"token"];
   // [request setValue:tokens forUndefinedKey:@"token"];
    //[request set];
    //[request setValue:tokens forKey:@"token"];
    NSError* error = nil;
    NSURLResponse* response = nil;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil)
    {
        //NSLog(@"next %d", [data length]);
        s = [[NSString alloc] initWithData:data encoding:code];
    }
    
   // NSLog(@"nextSyn ");
    
    return s;
}
+(NSData *)GetData:(NSString *)surl encoding:(NSStringEncoding)code token:(NSString *)tokens
{
    
    NSURL *url = [NSURL URLWithString:surl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //  [request setValue:tokens forHTTPHeaderField:@"token"];
    // [request setValue:tokens forUndefinedKey:@"token"];
    //[request set];
    //[request setValue:tokens forKey:@"token"];
    NSError* error = nil;
    NSURLResponse* response = nil;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil)
    {
        //NSLog(@"next %d", [data length]);
      NSString *s = [[NSString alloc] initWithData:data encoding:code];
        NSLog(@"s:%@",s);
    }
    
    return data;
}

/*! 使用Get方式 同步 取值 错误时返回 "" 指针 默认为 UTF-8 */
+(NSString *)Get:(NSString *)surl
{
    return[self Get:surl encoding:NSUTF8StringEncoding token:@"Login"];
}
+(NSData *)get_Data:(NSString *)surl
{
    
    NSURL *url = [NSURL URLWithString:surl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //  [request setValue:tokens forHTTPHeaderField:@"token"];
    // [request setValue:tokens forUndefinedKey:@"token"];
    //[request set];
    //[request setValue:tokens forKey:@"token"];
    NSError* error = nil;
    NSURLResponse* response = nil;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    return data;
}
//解决中文乱码
+(NSData *)getCHS:(NSString *)surl token:(NSString *)token
{
    NSLog(@"url:%@",surl);

    NSURL *url=[NSURL URLWithString:surl];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:surl]];
    NSLog(@"surl:%@",surl);
    // Create a mutable copy of the immutable request and add more headers
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest setHTTPMethod:@"GET"];
    [mutableRequest setURL:url];
    NSLog(@"token:%@",token);
    [mutableRequest setValue:token forHTTPHeaderField:@"token"];
    
    request = [mutableRequest copy];
    NSError *errsor;
    
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errsor]; 
  //  NSLog(@"urlData.length:%@",surl);
   
  NSString *data= [NSString stringWithFormat:@"aa%@",[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding] ];
 NSLog(@"urlData.length:%@",data);
    return urlData;
 //   ;

}
/*! 使用Get方式 异步 取值  错误时返回 "" 指针*/
+(void)GetAyn:(NSString *)surl token:(NSString *)token

{    
    NSURL *url = [NSURL URLWithString:surl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [request setValue:token forKey:@"token"];
    //建立一个线程
    NSOperationQueue *thread = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:thread completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSLog(@"AynComplete ");
    }];
    
   // NSLog(@"nextAyn ");
}
/*! 下载一张图片*/
-(void)LoadImage:(NSString *)surl ImageView:(UIImageView *)image
{
    NSURL *url = [NSURL URLWithString:surl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.ImageView = image;
    
    self.Conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
  //  NSLog(@"nextImage");
}
//解决中文乱码
//+(NSString *)Post:(NSString *)surl data:(NSString *) data
//{
//    NSURL *url=[NSURL URLWithString:surl];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//    [request setURL:url];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    NSError *errsor;
//    
//    NSURLResponse *response;
//    
//    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errsor];
//    
//    // NSString *data=[[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding] autorelease];
//    
//    
//    NSString *sReturn=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding] ;
//    
//    return sReturn;
//    
//    
//}
+(NSData *)Post:(NSString *)surl data:(NSData *)pData token:(NSString *)token
{
    NSString *s = @"";
    
    NSError *error = nil;
    NSURLResponse *reponse = nil;
    NSURL *url = [NSURL URLWithString:surl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:token forHTTPHeaderField:@"token"];
    [request setHTTPMethod:@"POST"];
    
    //  [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[pData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:pData];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    
    NSLog(@"%@",request);
    if (error == nil)
    {
        s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        NSLog(@"return %@ ", s);
    }
    else
    {
   
        NSLog(@"return %@ ", [error debugDescription]);
    }
    
    
    return data;
    
}

-(void)StopAndClear
{
    [self.Conn cancel];
    [self Clear];
}
-(void)Clear
{
   // [self.Conn release];
    self.Conn = nil;
    self.Data = nil;
    self.ImageView = nil;
}

#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)
//连接响应成功
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   // NSLog(@"imageHttp");
}
//发生错误时
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self StopAndClear];
    NSLog(@"imageError %@", [error description]);
}
//返回一个数据包时
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self.Data == nil)
    {
        self.Data = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [self.Data appendData:data];
    }
    //NSLog(@"imageData %d", [data length]);
}
//当下载全部完成时
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *imagedata = [UIImage imageWithData:self.Data];
    //NSLog(@"imageWidth %f", imagedata.size.width);
    self.ImageView.image = imagedata;
    
    [self StopAndClear];
   // NSLog(@"imageComplete");
}
+(NSString *)PostImage:(NSString *)surl data:(NSData *)pData
{
    NSString *s = @"";
    
    NSError *error = nil;
    NSURLResponse *reponse = nil;
    NSURL *url = [NSURL URLWithString:surl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:pData];
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    
    if (error == nil)
    {
        //NSLog(@"next %d", [data length]);
        s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        NSLog(@"return %@ ", s);
    }
    else
    {
        s = @"[Worry]";
        NSLog(@"return %@ ", [error debugDescription]);
    }
    
    
    return s;
    
}
+(NSData *)PostImage:(NSString *)surl picData:(NSData *)data token:(NSString *)token
{
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:surl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
 
    //得到图片的data
 
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
 
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"head.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)myRequestData.length] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    [request setValue:token forHTTPHeaderField:@"token"];
    //建立连接，设置代理
     NSURLResponse *reponse = nil;
     NSError *error = nil;
    NSData *datareturn = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    
    NSString *s;
    if (error == nil)
    {
        s = [[NSString alloc] initWithData:datareturn encoding:NSUTF8StringEncoding] ;
        NSLog(@"return %@ ", s);
    }
    else
    {
        
        NSLog(@"return %@ ", [error debugDescription]);
    }
    
    return datareturn;
}
@end
