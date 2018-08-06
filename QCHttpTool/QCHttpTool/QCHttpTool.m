//
//  QCHttpTool.m
//  QCHttpTool
//
//  Created by qiancheng on 2018/8/6.
//  Copyright © 2018年 qiancheng. All rights reserved.
//

#import "QCHttpTool.h"
#import "YYModel.h"

@implementation QCHttpTool

/**
 *  session发送get
 *
 *  @param url     接口url
 *  @param parameters  接口参数
 *  @param success 成功返回
 *  @param failure 失败返回
 */
+ (void)getWithSessionClient:(NSString *)url paramters:(id)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpFailureBlock)failure{
    [[QCHttpClient shareClient] getWithUrl:url parameters:parameters success:^(id JSON) {
        [self handlerSuccess:JSON success:success failure:failure];
    } failure:^(NSError *error) {
        [self handlerFailureBlock:error failure:failure];
    }];
}

+(void)getWithSessionModel:(NSString *)url paramters:(id)paramters responseClass:(__unsafe_unretained Class)responseClass success:(QCHttpModelSuccessBlock)success failure:(QCHttpFailureBlock)failure{
    [self getWithSessionClient:url paramters:[self dealWithParams:paramters] success:^(id JSON) {
        [self handlerModelSuccess:JSON success:success responseClass:responseClass];
    } failure:^(QCHttpError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  session发送post
 *
 *  @param url     接口url
 *  @param parameters  接口参数
 *  @param success 成功返回
 *  @param failure 失败返回
 */
+ (void)postWithSessionClient:(NSString *)url paramters:(id)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpFailureBlock)failure {
    __weak __typeof__(self) weakSelf = self;
    [[QCHttpClient shareClient] postWithUrl:url parameters:parameters success:^(id json) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [strongSelf handlerSuccess:json success:success failure:failure];
    } failure:^(NSError *error) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [strongSelf handlerFailureBlock:error failure:failure];
    }];
}

+ (void)postWithSessionModel:(NSString *)url paramters:(id)paramters responseClass:(Class)responseClass success:(QCHttpModelSuccessBlock)success failure:(QCHttpFailureBlock)failure {
    [self postWithSessionClient:url paramters:[self dealWithParams:paramters] success:^(id JSON) {
        [self handlerModelSuccess:JSON success:success responseClass:responseClass];
    } failure:^(QCHttpError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)handlerSuccess:(id)JSON success:(QCHttpSuccessBlock)success failure:(QCHttpFailureBlock)failure {
    success(JSON);
}

+ (void)handlerModelSuccess:(id)JSON success:(QCHttpSuccessBlock)success responseClass:(Class)responseClass{
    if (responseClass != nil){
        success([responseClass yy_modelWithJSON:JSON]);
    }else{
        success(JSON);
    }
}

+(void)handlerFailureBlock:(NSError *)error failure:(QCHttpFailureBlock)failure{
    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    QCHttpError *errorModel = [[QCHttpError alloc] init];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        errorModel = [QCHttpError yy_modelWithJSON:dict];
    } else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"身份过期，请重新登录" forKey:[NSString stringWithFormat:@"%d",kCFURLErrorUserAuthenticationRequired]];
        [dic setValue:@"请求的地址不存在" forKey:[NSString stringWithFormat:@"%d",kCFURLErrorBadServerResponse]];
        [dic setValue:@"请求超时" forKey:[NSString stringWithFormat:@"%d",kCFURLErrorTimedOut]];
        [dic setValue:@"请检查您的网络连接！" forKey:[NSString stringWithFormat:@"%d",kCFURLErrorNotConnectedToInternet]];
        [dic setValue:@"请检查您的网络连接！" forKey:[NSString stringWithFormat:@"%d",kCFURLErrorCannotDecodeContentData]];
        [dic setValue:@"服务器正在处理问题.." forKey:[NSString stringWithFormat:@"%d",kCFURLErrorCannotFindHost]];
        
        NSError *detailError = error.userInfo[@"NSUnderlyingError"];
        NSInteger code = detailError.code;
        NSString *message = dic[[NSString stringWithFormat:@"%ld",(long)code]];
        errorModel.message = message.length > 0 ? message : @"请求失败";
        errorModel.status = code;
    }
    failure(errorModel);
}

+(NSDictionary *)dealWithParams:(id)paramters{
    if (paramters == nil) {
        return [NSDictionary dictionary];
    }
    if ([paramters isKindOfClass:[NSDictionary class]] || [paramters isKindOfClass:[NSMutableDictionary class]]) {
        return paramters;
    }else{
        return [paramters yy_modelToJSONObject];
    }
}

@end
