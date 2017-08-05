//
//  JQKProtobufResponseSerializer.h
//  JQKProtobufResponseSerializer
//
//  Created by Xwoder on 2017/8/1.
//  Copyright © 2017年 Xwoder. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JQKProtobufResponseSerializer : AFHTTPResponseSerializer

@property (nonatomic, assign, readonly) Class messageClass;

+ (instancetype)serializerWithMessageClass:(Class)messageClass;

@end
