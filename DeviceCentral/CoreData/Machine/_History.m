// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to History.m instead.

#import "_History.h"

const struct HistoryAttributes HistoryAttributes = {
	.checkedInDate = @"checkedInDate",
	.checkedOutDate = @"checkedOutDate",
};

const struct HistoryRelationships HistoryRelationships = {
	.device = @"device",
	.user = @"user",
};

const struct HistoryFetchedProperties HistoryFetchedProperties = {
};

@implementation HistoryID
@end

@implementation _History

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"History";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"History" inManagedObjectContext:moc_];
}

- (HistoryID*)objectID {
	return (HistoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic checkedInDate;






@dynamic checkedOutDate;






@dynamic device;

	

@dynamic user;

	






@end
