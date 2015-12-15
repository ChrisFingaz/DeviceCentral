//
//  UsersModel.h
//  DeviceCentral
//
//  Created by Janice Garingo on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

@optional

-(void)modelDidChangeContent;

@end

@interface BaseModel : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSArray *fetchedObjects;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSArray *sortDescriptors;
@property (nonatomic) NSPredicate *predicate;
@property (nonatomic) NSString *entity;
@property (nonatomic) id<ModelDelegate> delegate;

- (NSFetchedResultsController *)fetchedResultsController;
- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString*) entity withSortDescriptors: (NSArray*) sortDescriptors withPredicate: (NSPredicate*) predicate;

- (NSManagedObject*)fetchWithId:(NSString*)theId;
- (NSArray*)fetchWithProperty:(NSString*)property value:(NSString*)value;
- (NSManagedObject*)fetchWithURI:(NSURL*)uri;
- (NSManagedObject*)newObject;
- (NSManagedObject*)newObjectForEntity:(NSString*)entity;
- (void)saveContext;
- (void)deleteObjectAtIndexPath:(NSIndexPath*)indexPath;

@end
