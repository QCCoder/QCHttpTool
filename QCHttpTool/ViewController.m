//
//  ViewController.m
//  QCHttpTool
//
//  Created by qiancheng on 2018/8/6.
//  Copyright © 2018年 qiancheng. All rights reserved.
//

#import "ViewController.h"
#import "QCHttpTool.h"
#import "AppConfigModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[QCHttpClient shareClient] setHttpHeader:@{@"ga-appname":@"xxx"}];
    [QCHttpTool getWithSessionClient:@"https://www.xxx.com/apppush-service/appConfig/get" paramters:nil success:^(id json) {
        NSLog(@"%@",json);
    } failure:^(QCHttpError *error) {
        NSLog(@"%@",error.message);
    }];
    
    [QCHttpTool getWithSessionModel:@"https://www.xxx.com/apppush-service/appConfig/get" paramters:nil responseClass:[AppConfigModel class] success:^(AppConfigModel *model) {
        NSLog(@"%@",model.appName);
    } failure:^(QCHttpError *error) {
        NSLog(@"%@",error.message);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
