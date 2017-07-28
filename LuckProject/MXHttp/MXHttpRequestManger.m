//
//  MXHttpRequestManger.m
//  LuckProject
//
//  Created by moxi on 2017/6/30.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MXHttpRequestManger.h"

#ifdef DEBUG
#define ECLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ECLog(...)
#endif

@implementation NSString (MXHttpRequestManger)


// 编码
- (NSString *)encode
{
    NSString *outputString  = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&amp;=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8
                                                                                                    ));
    outputString            = [outputString stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    
    return outputString;
}

// 解码
- (NSString *)decode
{
    NSString *outputString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                                   (__bridge CFStringRef)self,
                                                                                                                   CFSTR(""),
                                                                                                                   kCFStringEncodingUTF8
                                                                                                                   ));
    return outputString;
}

@end



@implementation MXHttpRequestManger

static AFHTTPSessionManager *_manager = nil;
static NSMutableArray *_allSessionTask;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(HttpRequestStatus)httpStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                    case AFNetworkReachabilityStatusUnknown:
                    httpStatus ? httpStatus(ECHttpRequestStatusUnknown) : nil;
                    ECLog(@"未知网络");
                    break;
                    case AFNetworkReachabilityStatusNotReachable:
                    httpStatus ? httpStatus(ECHttpRequestStatusNotReachable) : nil;
                    ECLog(@"无网络");
                    break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                    httpStatus ? httpStatus(ECHttpRequestStatusReachableViaWWAN) : nil;
                    ECLog(@"手机自带网络");
                    break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                    httpStatus ? httpStatus(ECHttpRequestStatusReachableViaWiFi) : nil;
                    ECLog(@"WIFI");
                    break;
            }
        }];
        
        [manager startMonitoring];
    });
}


+ (BOOL)isNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)cancelAllRequest
{
    // 锁操作
    @synchronized(self)
    {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL
{
    if (!URL) { return; }
    @synchronized (self)
    {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}


#pragma mark - GET请求无缓存

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure
{
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - POST请求无缓存

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - GET请求自动缓存

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
            responseCache:(HttpRequestCache)responseCache
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([MXHttpRequestCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [MXHttpRequestCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
        ECLog(@"\nBaseUrl = %@\nParameters = %@\nAllUrl = %@\nResponseObject = %@",URL,parameters?parameters:@"无参数",[MXHttpRequestUrl connectUrl:parameters url:URL],[self jsonToString:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        ECLog(@"\nBaseUrl = %@\nParameters = %@\nAllUrl = %@\nError = %@",URL,parameters?parameters:@"无参数",[MXHttpRequestUrl connectUrl:parameters url:URL],error);
        
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}


#pragma mark - POST请求自动缓存

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(HttpRequestCache)responseCache
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([MXHttpRequestCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [MXHttpRequestCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
        ECLog(@"\nBaseUrl = %@\nParameters = %@\nAllUrl = %@\nResponseObject = %@",URL,parameters?parameters:@"无参数",[MXHttpRequestUrl connectUrl:parameters url:URL],[self jsonToString:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        ECLog(@"\nBaseUrl = %@\nParameters = %@\nAllUrl = %@\nError = %@",URL,parameters?parameters:@"无参数",[MXHttpRequestUrl connectUrl:parameters url:URL],error);
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
    
}

#pragma mark - 上传图片文件

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                              files:(NSArray *)files
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure
{
    NSURLSessionTask *sessionTask = [_manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSDictionary *fileItem in files) {
            id value = [fileItem objectForKey:@"file"];                     //支持四种数据类型：NSData、UIImage、NSURL、NSString
            NSString *name = [fileItem objectForKey:@"name"];               //文件字段的key
            NSString *fileName = [fileItem objectForKey:@"fileName"];       //文件名称
            NSString *mimeType = [fileItem objectForKey:@"mimeType"];       //文件类型
            mimeType = mimeType ? mimeType : @"image/jpeg";
            name = name ? name : @"file";
            
            if ([value isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:value name:name fileName:fileName mimeType:mimeType];
            }else if ([value isKindOfClass:[UIImage class]]) {
                if (UIImagePNGRepresentation(value)) {  //返回为png图像。
                    [formData appendPartWithFileData:UIImagePNGRepresentation(value) name:name fileName:fileName mimeType:mimeType];
                }else {   //返回为JPEG图像。
                    [formData appendPartWithFileData:UIImageJPEGRepresentation(value, 0.5) name:name fileName:fileName mimeType:mimeType];
                }
            }else if ([value isKindOfClass:[NSURL class]]) {
                [formData appendPartWithFileURL:value name:name fileName:fileName mimeType:mimeType error:nil];
            }else if ([value isKindOfClass:[NSString class]]) {
                [formData appendPartWithFileURL:[NSURL URLWithString:value]  name:name fileName:fileName mimeType:mimeType error:nil];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        ECLog(@"上传进度:%.2f%%",100.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        ECLog(@"\nBaseUrl = %@\nParameters = %@\nFiles = %@\nResponseObject = %@",URL,parameters?parameters:@"无参数",files,[self jsonToString:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        ECLog(@"\nBaseUrl = %@\nParameters = %@\nFiles = %@\nError = %@",URL,parameters?parameters:@"无参数",files,error);
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(HttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(HttpRequestFailed)failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
        ECLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        ECLog(@"\nBaseUrl = %@\nDownloadDir = %@",URL,downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
    
}


/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask
{
    if (!_allSessionTask)
    {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}


#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager,原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 *  + (void)initialize该初始化方法在当用到此类时候只调用一次
 */
+ (void)initialize
{
    _manager = [AFHTTPSessionManager manager];
    //设置请求参数的类型:JSON (AFJSONRequestSerializer,AFHTTPRequestSerializer)
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置请求的超时时间
    _manager.requestSerializer.timeoutInterval = 30.f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    _manager.responseSerializer = response;
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    
    //验证服务器证书
    _manager.securityPolicy.allowInvalidCertificates = NO;
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setRequestSerializer:(ECRequestSerializer)requestSerializer
{
    _manager.requestSerializer = requestSerializer==ECRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : nil ;
}

+ (void)setResponseSerializer:(ECResponseSerializer)responseSerializer
{
    _manager.responseSerializer = responseSerializer==ECResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : nil;
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time
{
    _manager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    [_manager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open
{
    !open ? [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO] : nil ;
}

+ (void)setSecurityPolicyAllowInvalidCertificates:(BOOL)isAllow
{
    _manager.securityPolicy.allowInvalidCertificates = isAllow;
}

#pragma mark - 获取Ip地址
+ (NSString *)ipAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}


#pragma mark - Json转换
+ (NSString *)jsonToString:(id)json
{
    if(!json){
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (NSDictionary *)jsonToDictionary:(id)json
{
    NSDictionary *jsonObject = json;
    
    if ([json isKindOfClass:[NSData class]]){
        jsonObject = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
    }
    
    if ([json isKindOfClass:[NSString class]]){
        jsonObject = [json object];
    }
    
    return jsonObject?:json;
}




@end
