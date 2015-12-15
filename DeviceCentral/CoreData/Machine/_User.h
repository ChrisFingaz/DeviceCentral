// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>


extern const struct UserAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *initial;
	__unsafe_unretained NSString *name;
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *checkedOutDevices;
	__unsafe_unretained NSString *history;
} UserRelationships;

extern const struct UserFetchedProperties {
} UserFetchedProperties;

@class Device;
@class History;





@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserID*)objectID;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* initial;



//- (BOOL)validateInitial:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet *checkedOutDevices;

- (NSMutableOrderedSet*)checkedOutDevicesSet;




@property (nonatomic, strong) NSOrderedSet *history;

- (NSMutableOrderedSet*)historySet;





@end

@interface _User (CoreDataGeneratedAccessors)

- (void)addCheckedOutDevices:(NSOrderedSet*)value_;
- (void)removeCheckedOutDevices:(NSOrderedSet*)value_;
- (void)addCheckedOutDevicesObject:(Device*)value_;
- (void)removeCheckedOutDevicesObject:(Device*)value_;

- (void)addHistory:(NSOrderedSet*)value_;
- (void)removeHistory:(NSOrderedSet*)value_;
- (void)addHistoryObject:(History*)value_;
- (void)removeHistoryObject:(History*)value_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveInitial;
- (void)setPrimitiveInitial:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableOrderedSet*)primitiveCheckedOutDevices;
- (void)setPrimitiveCheckedOutDevices:(NSMutableOrderedSet*)value;



- (NSMutableOrderedSet*)primitiveHistory;
- (void)setPrimitiveHistory:(NSMutableOrderedSet*)value;


@end
