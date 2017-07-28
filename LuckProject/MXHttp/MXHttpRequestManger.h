//
//  MXHttpRequestManger.h
//  LuckProject
//
//  Created by moxi on 2017/6/30.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - ECHttpRequestManager扩展
@interface NSString (ECHttpRequestManager)

// 编码
- (NSString *)encode;

// 解码
- (NSString *)decode;

@end


typedef NS_ENUM(NSUInteger, ECHttpRequestStatus) {
    /** 未知网络*/
    ECHttpRequestStatusUnknown,
    /** 无网络*/
    ECHttpRequestStatusNotReachable,
    /** 手机网络*/
    ECHttpRequestStatusReachableViaWWAN,
    /** WIFI网络*/
    ECHttpRequestStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, ECRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    ECRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    ECRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, ECResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    ECResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    ECResponseSerializerHTTP,
};


/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

/** 缓存的Block */
typedef void(^HttpRequestCache)(id responseCache);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^HttpRequestStatus)(ECHttpRequestStatus status);

///** 请求任务 */
//typedef NSURLSessionTask ECURLSessionTask;

#pragma mark - 网络数据请求类

@interface MXHttpRequestManger : NSObject



/**
 *  实时获取网络状态回调
 */
+ (void)networkStatusWithBlock:(HttpRequestStatus)httpStatus;

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;

/**
 取消所有HTTP请求
 */
+ (void)cancelAllRequest;

/**
 取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;


/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

/**
 *  上传图片文件
 *

 */
+ (__kindof NSURLSessionTask *)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters files:(NSArray *)files progress:(HttpProgress)progress success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(HttpProgress)progress success:(void(^)(NSString *filePath))success failure:(HttpRequestFailed)failure;


#pragma mark - 重置AFHTTPSessionManager相关属性
/**
 *  设置网络请求参数的格式:默认为JSON格式
 *
 *  @param requestSerializer ECRequestSerializerJSON(JSON格式),ECRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(ECRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer ECResponseSerializerJSON(JSON格式),ECResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(ECResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

/**
 *  是否验证服务器证书:默认否
 *
 *  @param isAllow YES(否),NO(是)
 */
+ (void)setSecurityPolicyAllowInvalidCertificates:(BOOL)isAllow;


#pragma mark - 获取Ip地址
/**
 *  获取IpAddress
 *
 *  @return IpAddress
 */
+ (NSString *)ipAddress;


#pragma mark - Json转字符串
/**
 *  Json转字符串
 *
 
 *
 *  @return 字符串
 */
+ (NSString *)jsonToString:(id)json;


/**
 *  Json转字典
 *
 *  @param json Json字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)jsonToDictionary:(id)json;

@end
