//
//  QCHttpClient.m
//  QCHttpTool
//
//  Created by qiancheng on 2018/8/6.
//  Copyright © 2018年 qiancheng. All rights reserved.
//

#import "QCHttpClient.h"
#import "AFNetworking.h"

@interface QCHttpClient ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation QCHttpClient

+ (instancetype)shareClient{
    static QCHttpClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[QCHttpClient alloc] init];
        NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultConfiguration.timeoutIntervalForRequest = 30.0f;
        defaultConfiguration.timeoutIntervalForResource = 30.0f;
        defaultConfiguration.HTTPShouldSetCookies = NO;
        client.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:defaultConfiguration];
        client.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *jsonRes= [AFJSONResponseSerializer serializer];
        jsonRes.removesKeysWithNullValues = YES;
        jsonRes.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        client.manager.responseSerializer = jsonRes;
    });
    return client;
}

-(void)setHttpHeader:(NSDictionary *)dict{
    for (NSString *key in dict) {
        [self.manager.requestSerializer setValue:[dict[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField:key];
    }
}

- (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpErrorBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        [self handlerSuccess:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [self handlerFailureBlock:task error:error failure:failure];
    }];
}

- (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpErrorBlock)failure {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handlerSuccess:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handlerFailureBlock:task error:error failure:failure];
    }];
}

- (void)handlerSuccess:(NSURLSessionDataTask *)task responseObject:(id)responseObject success:(QCHttpSuccessBlock)success{
    //请求结束状态栏隐藏网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    success(responseObject);
}

- (void)handlerFailureBlock:(NSURLSessionDataTask *)task error:(NSError *)error failure:(QCHttpErrorBlock)failure{
    //请求结束状态栏隐藏网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    failure(error);
}

@end

@implementation QCHttpError

@end
