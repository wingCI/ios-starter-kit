//
// Created by Hammer on 1/23/16.
// Copyright (c) 2016 奇迹空间. All rights reserved.
//

#import "PageFeedViewController.h"
#import <StarterKit/SKTableViewControllerBuilder.h>
#import "FeedTableViewCell.h"
#import "Feed.h"
#import "SKManagedHTTPSessionManager+Network.h"
#import <libextobjc/EXTScope.h>

@implementation PageFeedViewController

- (id)init {
  if (self = [super init]) {
    [self createWithBuilder:^(SKTableViewControllerBuilder *builder) {
      builder.cellClass = [FeedTableViewCell class];
      builder.cellIdentifier = [FeedTableViewCell cellIdentifier];
      builder.entityName = @"Feed";
      builder.modelOfClass = [Feed class];
      @weakify(self);
      builder.paginateBlock = ^(NSDictionary *parameters) {
        @strongify(self)
        return [self.httpSessionManager fetchFeeds:parameters];
      };
    }];
  }
  return self;
}

@end