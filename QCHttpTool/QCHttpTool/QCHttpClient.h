//
//  QCHttpClient.h
//  QCHttpTool
//
//  Created by qiancheng on 2018/8/6.
//  Copyright © 2018年 qiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCHttpError : NSObject

@property (nonatomic,copy) NSString *message;

// <0 表示系统报错，如超时，无网络
@property (nonatomic,assign) NSInteger status;

@end

typedef void (^QCHttpSuccessBlock)(id json);
typedef void (^QCHttpFailureBlock)(QCHttpError *error);
typedef void (^QCHttpErrorBlock)(NSError *error);
typedef void (^QCHttpModelSuccessBlock)(id model);

@interface QCHttpClient : NSObject

/**
 *  创建请求单利类
 *  需要添加三方依赖AFNetworking
 */
+ (instancetype)shareClient;

/**
 * 设置请求头
 */
- (void)setHttpHeader:(NSDictionary *)dict;

/**
 *  post请求
 *
 *  @param url        接口地址
 *  @param parameters 参数
 *  @param success    请求成功，返回数据
 *  @param failure    请求失败，code < 0 系统错误，code > 0 服务器返回错误
 */
- (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpErrorBlock)failure;

/**
 *  get请求
 *
 *  @param url        接口地址
 *  @param parameters 参数
 *  @param success    请求成功，返回数据
 *  @param failure    请求失败，code < 0 系统错误，code > 0 服务器返回错误
 */
- (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpErrorBlock)failure;

@end
