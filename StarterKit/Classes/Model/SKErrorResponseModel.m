//
// Created by Hammer on 1/18/16.
// Copyright (c) 2016 奇迹空间. All rights reserved.
//

#import "SKErrorResponseModel.h"
#import <Overcoat/OVCResponse.h>

@implementation SKErrorResponseModel

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
      @"statusCode" : @"status_code",
      @"message" : @"message",
  };
}

+ (NSString *)buildMessageWithNetworkError:(NSError *)error {
  NSDictionary *userInfo = [error userInfo];
  if (userInfo[@"NSUnderlyingError"]) {
    return userInfo[@"NSLocalizedDescription"];
  }
  OVCResponse *response = userInfo[@"OVCResponse"];
  SKErrorResponseModel *errorModel = response.result;
  return errorModel.message;
}
@end