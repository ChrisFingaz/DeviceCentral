// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to History.h instead.

#import <CoreData/CoreData.h>


extern const struct HistoryAttributes {
	__unsafe_unretained NSString *checkedInDate;
	__unsafe_unretained NSString *checkedOutDate;
} HistoryAttributes;

extern const struct HistoryRelationships {
	__unsafe_unretained NSString *device;
	__unsafe_unretained NSString *user;
} HistoryRelationships;

extern const struct HistoryFetchedProperties {
} HistoryFetchedProperties;

@class Device;
@class User;




@interface HistoryID : NSManagedObjectID {}
@end

@interface _History : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (HistoryID*)objectID;





@property (nonatomic, strong) NSDate* checkedInDate;



//- (BOOL)validateCheckedInDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* checkedOutDate;



//- (BOOL)validateCheckedOutDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Device *device;

//- (BOOL)validateDevice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _History (CoreDataGeneratedAccessors)

@end

@interface _History (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCheckedInDate;
- (void)setPrimitiveCheckedInDate:(NSDate*)value;




- (NSDate*)primitiveCheckedOutDate;
- (void)setPrimitiveCheckedOutDate:(NSDate*)value;





- (Device*)primitiveDevice;
- (void)setPrimitiveDevice:(Device*)value;



- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;


@end
