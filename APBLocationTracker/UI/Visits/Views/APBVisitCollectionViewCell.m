//
//  APBVisitCollectionViewCell.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//

#import "APBVisitCollectionViewCell.h"
#import <UIKit/UIKit.h>
#import "FLKAutoLayout.h"
#import "APBLocationMO+CoreDataClass.h"
#import "UIImageView+Animation.h"

@interface APBVisitCollectionViewCell()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLabel;

@end

@implementation APBVisitCollectionViewCell

#pragma mark - Subviews

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];

    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: [UIColor whiteColor]];
    }
    return _titleLabel;
}

#pragma mark - View setup

- (void)setupSubviews {

    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [[UIColor alloc] initWithRed:2 green:2 blue:2 alpha:0.1];

    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

- (void)setupAutolayout {

    // image view
    [self.imageView alignTop:@"0" leading:@"0" toView:self];
    [self.imageView constrainHeightToView:self predicate:@"0"];
    [self.imageView alignAttribute:NSLayoutAttributeWidth
                       toAttribute:NSLayoutAttributeHeight
                            ofView:self.imageView
                         predicate:@"0"];

    // title label
    [self.titleLabel alignTopEdgeWithView:self predicate:@"12"];
    [self.titleLabel alignAttribute:NSLayoutAttributeLeading
                        toAttribute:NSLayoutAttributeTrailing
                             ofView:self.imageView
                          predicate:@"12"];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.imageView.image = nil;
}

#pragma mark - Setters

- (void)setData:(id)data {
    _data = data;

    [self updateUIWithVisit:_data];
}

#pragma mark - Private methods

- (void)updateUIWithVisit:(APBVisitMO *)visit {

    if (visit.location != nil) {
        // image view
        NSURL *imageUrl = [NSURL URLWithString:visit.location.thumbnailUrl];
        [self.imageView setImageWithUrlWithCrossfade:imageUrl];

        self.titleLabel.text = visit.location.name;
    }
}

@end
