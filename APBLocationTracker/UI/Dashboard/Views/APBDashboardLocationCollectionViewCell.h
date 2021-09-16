//
//  APBDashboardLocationCollectionViewCell.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 15/09/2021
//

#import <APBFoundation/APBFoundation.h>
#import "APBLocationMO+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBDashboardLocationCollectionViewCell : APBBaseCollectionViewCell {
    APBLocationMO *_data;
}

@end

NS_ASSUME_NONNULL_END
