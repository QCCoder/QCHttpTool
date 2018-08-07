//
//  AppConfigModel.h
//  QCHttpTool
//
//  Created by qiancheng on 2018/8/7.
//  Copyright © 2018年 qiancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfigModel : NSObject

@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              *appVersion;
@property (nonatomic , copy) NSString              *appNameDesc;
@property (nonatomic , copy) NSString              *appName;
@property (nonatomic , assign) NSInteger              isOpen;

@end
