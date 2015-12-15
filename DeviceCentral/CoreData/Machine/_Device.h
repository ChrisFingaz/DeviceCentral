// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Device.h instead.

#import <CoreData/CoreData.h>


extern const struct DeviceAttributes {
	__unsafe_unretained NSString *checkedOutDate;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *isCheckedOut;
	__unsafe_unretained NSString *name;
} DeviceAttributes;

extern const struct DeviceRelationships {
	__unsafe_unretained NSString *history;
	__unsafe_unretained NSString *userWithDevice;
} DeviceRelationships;

extern const struct DeviceFetchedProperties {
} DeviceFetchedProperties;

@class History;
@class User;






@interface DeviceID : NSManagedObjectID {}
@end

@interface _Device : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DeviceID*)objectID;





@property (nonatomic, strong) NSDate* checkedOutDate;



//- (BOOL)validateCheckedOutDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* id;



//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isCheckedOut;



@property BOOL isCheckedOutValue;
- (BOOL)isCheckedOutValue;
- (void)setIsCheckedOutValue:(BOOL)value_;

//- (BOOL)validateIsCheckedOut:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet *history;

- (NSMutableOrderedSet*)historySet;




@property (nonatomic, strong) User *userWithDevice;

//- (BOOL)validateUserWithDevice:(id*)value_ error:(NSError**)error_;





@end

@interface _Device (CoreDataGeneratedAccessors)

- (void)addHistory:(NSOrderedSet*)value_;
- (void)removeHistory:(NSOrderedSet*)value_;
- (void)addHistoryObject:(History*)value_;
- (void)removeHistoryObject:(History*)value_;

@end

@interface _Device (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCheckedOutDate;
- (void)setPrimitiveCheckedOutDate:(NSDate*)value;




- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;




- (NSNumber*)primitiveIsCheckedOut;
- (void)setPrimitiveIsCheckedOut:(NSNumber*)value;

- (BOOL)primitiveIsCheckedOutValue;
- (void)setPrimitiveIsCheckedOutValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableOrderedSet*)primitiveHistory;
- (void)setPrimitiveHistory:(NSMutableOrderedSet*)value;



- (User*)primitiveUserWithDevice;
- (void)setPrimitiveUserWithDevice:(User*)value;


@end
