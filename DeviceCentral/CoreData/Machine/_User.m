// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.email = @"email",
	.initial = @"initial",
	.name = @"name",
};

const struct UserRelationships UserRelationships = {
	.checkedOutDevices = @"checkedOutDevices",
	.history = @"history",
};

const struct UserFetchedProperties UserFetchedProperties = {
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic email;






@dynamic initial;






@dynamic name;






@dynamic checkedOutDevices;

	
- (NSMutableOrderedSet*)checkedOutDevicesSet {
	[self willAccessValueForKey:@"checkedOutDevices"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"checkedOutDevices"];
  
	[self didAccessValueForKey:@"checkedOutDevices"];
	return result;
}
	

@dynamic history;

	
- (NSMutableOrderedSet*)historySet {
	[self willAccessValueForKey:@"history"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"history"];
  
	[self didAccessValueForKey:@"history"];
	return result;
}
	






@end
