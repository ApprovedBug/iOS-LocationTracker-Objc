//
//  APBVisitCollectionViewCell.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//

#import <APBFoundation/APBFoundation.h>
#import "APBVisitMO+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBVisitCollectionViewCell : APBBaseCollectionViewCell {
    APBVisitMO *_data;
}

@end

NS_ASSUME_NONNULL_END
