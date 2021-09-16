//
//  APBDashboardLocationCollectionViewCell.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 15/09/2021
//

#import "APBDashboardLocationCollectionViewCell.h"
#import "FLKAutoLayout.h"

@interface APBDashboardLocationCollectionViewCell()

@property (nonatomic) UILabel *titleLabel;

@end

@implementation APBDashboardLocationCollectionViewCell

#pragma mark - Subviews

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: [UIColor whiteColor]];
    }
    return _titleLabel;
}

#pragma mark - View setup

- (void)setupSubviews {

    self.layer.cornerRadius = 5;
    self.backgroundColor = [[UIColor alloc] initWithRed:2 green:2 blue:2 alpha:0.1];

    [self addSubview:self.titleLabel];
}

- (void)setupAutolayout {

    // title label
    [self.titleLabel alignTop:@"12" leading:@"12" toView:self];
}

#pragma mark - Setters

- (void)setData:(id)data {
    _data = data;

    [self updateUIWithLocation:_data];
}

#pragma mark - Private methods

- (void)updateUIWithLocation:(APBLocationMO *)location {

    self.titleLabel.text = location.name;
}

@end
