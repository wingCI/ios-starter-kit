//
// Created by Hammer on 1/18/16.
// Copyright (c) 2016 奇迹空间. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Overcoat/OVCManagedStore.h>

@interface SKManaged : NSObject

@property(nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong, readonly) OVCManagedStore *store;

+ (SKManaged *)sharedInstance;

+ (NSFetchRequest *)fetchRequestEntityName:(NSString *)entityName;

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate
                                   entityName:(NSString *)entityName;

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate
                                   entityName:(NSString *)entityName
                               fetchBatchSize:(NSUInteger)fetchBatchSize;

- (NSNumber *)firstModelIdentifier:(NSString *)entityName;

- (NSNumber *)lastModelIdentifier:(NSString *)entityName;

@end