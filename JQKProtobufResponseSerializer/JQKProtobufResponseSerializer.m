//
//  JQKProtobufResponseSerializer.m
//  JQKProtobufResponseSerializer
//
//  Created by Xwoder on 2017/8/1.
//  Copyright © 2017年 Xwoder. All rights reserved.
//

#import "JQKProtobufResponseSerializer.h"
#import <Protobuf/GPBMessage.h>

NSString * const JQKURLResponseSerializationErrorDomain = @"com.xwoder.error.serialization.response";

static BOOL JQKErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return JQKErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    
    return NO;
}

static NSError * JQKErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

@implementation JQKProtobufResponseSerializer

+ (instancetype)serializer {
    JQKProtobufResponseSerializer *serializer = [self serializerWithMessageClass:NULL];
    return serializer;
}

+ (instancetype)serializerWithMessageClass:(Class)messageClass {
    JQKProtobufResponseSerializer *serializer = [[self alloc] initWithMessageClass:messageClass];
    return serializer;
}

- (instancetype)init {
    self = [self initWithMessageClass:NULL];
    return self;
}

- (instancetype)initWithMessageClass:(Class)messageClass {
    self = [super init];
    if (self) {
        _messageClass = messageClass ? : [GPBMessage class];
    }
    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing  _Nullable *)error {
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || JQKErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, JQKURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    
    id responseObject = nil;
    NSError *messageParseError = nil;
    if (data.length > 0) {
        responseObject = [self.messageClass parseFromData:data error:&messageParseError];
    } else {
        return nil;
    }
    
    if (error) {
        *error = JQKErrorWithUnderlyingError(messageParseError, *error);
    }
    
    return responseObject;
}

@end
