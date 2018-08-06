//
//  QCHttpTool.h
//  QCHttpTool
//
//  Created by qiancheng on 2018/8/6.
//  Copyright © 2018年 qiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCHttpClient.h"

@interface QCHttpTool : NSObject

/**
 *  用session发出POST请求
 *
 *  @param url         接口url
 *  @param parameters       接口参数
 *  @param success     成功返回数据
 *  @param failure     返回失败数据
 */
+ (void)postWithSessionClient:(NSString *)url paramters:(id)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpFailureBlock)failure;
+ (void)postWithSessionModel:(NSString *)url paramters:(id)paramters responseClass:(Class)responseClass success:(QCHttpModelSuccessBlock)success failure:(QCHttpFailureBlock)failure;

/**
 *  用session发出Get请求
 *
 *  @param url         接口url
 *  @param parameters       接口参数
 *  @param success     成功返回数据
 *  @param failure     返回失败数据
 */
+ (void)getWithSessionClient:(NSString *)url paramters:(id)parameters success:(QCHttpSuccessBlock)success failure:(QCHttpFailureBlock)failure;
+ (void)getWithSessionModel:(NSString *)url paramters:(id)paramters responseClass:(Class)responseClass success:(QCHttpModelSuccessBlock)success failure:(QCHttpFailureBlock)failure;

@end
