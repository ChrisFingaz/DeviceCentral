//
//  UsersModel.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/24/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

# pragma mark Core Data fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if(!_fetchedResultsController)
    {
        _fetchedResultsController = [self fetchedResultsControllerForEntity:self.entity withSortDescriptors:self.sortDescriptors withPredicate:self.predicate];
    }
    
    return _fetchedResultsController;
}

- (NSFetchedResultsController *)fetchedResultsControllerForEntity: (NSString*) entity withSortDescriptors: (NSArray*) sortDescriptors withPredicate: (NSPredicate*) predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:self.entity];
    fetchRequest.sortDescriptors = sortDescriptors != nil ? sortDescriptors : @[];
    fetchRequest.predicate = predicate;
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    fetchedResultsController.delegate = self;

    return fetchedResultsController;
}

-(NSManagedObjectContext*)managedObjectContext
{
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

-(NSArray*)fetchedObjects
{
    if(!_fetchedObjects){
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        
        NSAssert(!error, @"Error performing fetch request : %@", error);
        
        self.fetchedObjects = self.fetchedResultsController.fetchedObjects;
    }

    return _fetchedObjects;
}


-(NSManagedObject*)fetchWithId:(NSString*)theId
{
    return [[self fetchWithProperty:@"id" value:theId] firstObject];
}

- (NSArray*)fetchWithProperty:(NSString*)property value:(NSString*)value
{
    NSFetchedResultsController *fetchedResultsController = [self fetchedResultsControllerForEntity:self.entity withSortDescriptors:@[] withPredicate:[NSPredicate predicateWithFormat:@"%K = %@", property, value]];
    
    NSError *error;
    [fetchedResultsController performFetch:&error];
    
    NSAssert(!error, @"Error performing fetch request : %@", error);
    
    return fetchedResultsController.fetchedObjects;
}

-(NSManagedObject*)fetchWithURI:(NSURL*)uri
{
    NSManagedObjectID *manId = [self.managedObjectContext.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
    
    if(!manId) return nil;
    
    NSError *error;
    NSManagedObject *object = [self.managedObjectContext existingObjectWithID:manId error:&error];
    
    NSAssert(!error, @"Unable to find managed boject by URI : %@", uri);
    
    return object;
}

-(NSManagedObject*)newObject
{
    return [self newObjectForEntity:self.entity];
}

-(NSManagedObject*)newObjectForEntity:(NSString*)entity
{
    return [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:self.managedObjectContext];
}

-(void)saveContext
{
    [self.managedObjectContext save:nil];
}

-(void)deleteObjectAtIndexPath:(NSIndexPath*)indexPath
{
    self.fetchedObjects = nil;
    [self.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    [self saveContext];
}

# pragma mark Core Data content changed
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    self.fetchedObjects = nil;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(modelDidChangeContent)]){
        [self.delegate performSelector:@selector(modelDidChangeContent)];
    }
}

@end
