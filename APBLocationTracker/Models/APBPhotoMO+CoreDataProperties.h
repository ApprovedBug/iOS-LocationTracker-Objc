//
//  APBPhotoMO+CoreDataProperties.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBPhotoMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface APBPhotoMO (CoreDataProperties)

+ (NSFetchRequest<APBPhotoMO *> *)fetchRequest;

@property (nonatomic) int16_t height;
@property (nullable, nonatomic, copy) NSString *id;
@property (nonatomic) int16_t width;
@property (nullable, nonatomic, retain) APBLocationMO *location;

@end

NS_ASSUME_NONNULL_END
