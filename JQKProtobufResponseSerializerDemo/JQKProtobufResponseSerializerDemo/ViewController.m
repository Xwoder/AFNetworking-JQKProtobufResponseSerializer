//
//  ViewController.m
//  JQKProtobufResponseSerializerDemo
//
//  Created by Xwoder on 2017/8/5.
//  Copyright © 2017年 Xwoder. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "Person.pbobjc.h"
#import "Dog.pbobjc.h"
#import "JQKProtobufResponseSerializer.h"

#define DocumentDirectory NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 200, 200);
    label.center = self.view.center;
    label.textColor = [UIColor blackColor];
    label.text = @"Tap here";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JQKDog *d = [JQKDog new];
    d.name = @"Wangwang";
    
    JQKPerson *p = [JQKPerson new];
    p.name = @"Xwoder";
    p.sex = JQKSex_Female;
    p.loc = JQKLocation_NorthAmerica;
    p.dog = d;
    
    NSLog(@"p = %@", p);
    
    NSData *pDataProtobuf = [p data];
    NSLog(@"pData = %@, pData.length = %tu, p.serializedSize = %zu", pDataProtobuf, pDataProtobuf.length, p.serializedSize);
    
    NSString *protoDataFilePath = [DocumentDirectory stringByAppendingPathComponent:@"p.proto.data"];
    NSURL *protoDataFileUrl = [NSURL fileURLWithPath:protoDataFilePath];
    [pDataProtobuf writeToURL:protoDataFileUrl atomically:YES];
    NSLog(@"protoDataFileUrl = %@", protoDataFileUrl);
    
    AFHTTPSessionManager *protobufManager = [AFHTTPSessionManager manager];
    
    JQKProtobufResponseSerializer *protobufResponseSerializer = [JQKProtobufResponseSerializer serializerWithMessageClass:[JQKPerson class]];
    protobufManager.responseSerializer = protobufResponseSerializer;
    
    [protobufManager GET:protoDataFileUrl.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, JQKPerson * _Nullable p) {
        NSLog(@"p = %@", p);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
    }];
}

@end
