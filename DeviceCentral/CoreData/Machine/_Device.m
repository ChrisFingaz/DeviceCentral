// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Device.m instead.

#import "_Device.h"

const struct DeviceAttributes DeviceAttributes = {
	.checkedOutDate = @"checkedOutDate",
	.id = @"id",
	.isCheckedOut = @"isCheckedOut",
	.name = @"name",
};

const struct DeviceRelationships DeviceRelationships = {
	.history = @"history",
	.userWithDevice = @"userWithDevice",
};

const struct DeviceFetchedProperties DeviceFetchedProperties = {
};

@implementation DeviceID
@end

@implementation _Device

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Device";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Device" inManagedObjectContext:moc_];
}

- (DeviceID*)objectID {
	return (DeviceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isCheckedOutValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isCheckedOut"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic checkedOutDate;






@dynamic id;






@dynamic isCheckedOut;



- (BOOL)isCheckedOutValue {
	NSNumber *result = [self isCheckedOut];
	return [result boolValue];
}

- (void)setIsCheckedOutValue:(BOOL)value_ {
	[self setIsCheckedOut:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsCheckedOutValue {
	NSNumber *result = [self primitiveIsCheckedOut];
	return [result boolValue];
}

- (void)setPrimitiveIsCheckedOutValue:(BOOL)value_ {
	[self setPrimitiveIsCheckedOut:[NSNumber numberWithBool:value_]];
}





@dynamic name;






@dynamic history;

	
- (NSMutableOrderedSet*)historySet {
	[self willAccessValueForKey:@"history"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"history"];
  
	[self didAccessValueForKey:@"history"];
	return result;
}
	

@dynamic userWithDevice;

	






@end
