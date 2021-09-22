//
//  APBVisitMO+CoreDataProperties.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//
//

#import "APBVisitMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface APBVisitMO (CoreDataProperties)

+ (NSFetchRequest<APBVisitMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nonatomic) int32_t dateTime;
@property (nonatomic) BOOL searched;
@property (nullable, nonatomic, retain) APBCoordinateMO *coordinate;
@property (nullable, nonatomic, retain) APBLocationMO *location;

@end

NS_ASSUME_NONNULL_END
