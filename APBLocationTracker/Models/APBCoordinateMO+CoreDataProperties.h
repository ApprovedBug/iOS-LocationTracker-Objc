//
//  APBCoordinateMO+CoreDataProperties.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 16/09/2021
//
//

#import "APBCoordinateMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface APBCoordinateMO (CoreDataProperties)

+ (NSFetchRequest<APBCoordinateMO *> *)fetchRequest;

@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic) int64_t dateTime;
@property (nonatomic) BOOL searched;

@end

NS_ASSUME_NONNULL_END
