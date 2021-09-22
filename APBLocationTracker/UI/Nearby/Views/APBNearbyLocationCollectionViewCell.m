//
//  APBDashboardLocationCollectionViewCell.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 15/09/2021
//

#import "APBNearbyLocationCollectionViewCell.h"
#import "FLKAutoLayout.h"
#import "UIImageView+Animation.h"

@interface APBNearbyLocationCollectionViewCell()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *ratingLabel;
@property (nonatomic) UIImageView *ratingIcon;
@property (nonatomic) UILabel *numberOfRatingsLabel;
@property (nonatomic) UILabel *priceRatingLabel;
@property (nonatomic) UILabel *addressLabel;

@end

@implementation APBNearbyLocationCollectionViewCell

#pragma mark - Subviews

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor: [UIColor whiteColor]];
        [_titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [_titleLabel setNumberOfLines:2];
    }
    return _titleLabel;
}

- (UILabel *)ratingLabel {
    if (_ratingLabel == nil) {
        _ratingLabel = [[UILabel alloc] init];
        [_ratingLabel setTextColor: [UIColor whiteColor]];
        [_ratingLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
    }
    return _ratingLabel;
}

- (UIImageView *)ratingIcon {
    if (_ratingIcon == nil) {
        UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:10];
        UIImage *image = [UIImage systemImageNamed:@"star.fill" withConfiguration:configuration];
        _ratingIcon = [[UIImageView alloc] initWithImage:image];
        [_ratingIcon setContentMode:UIViewContentModeScaleAspectFit];
        [_ratingIcon setTintColor:[UIColor whiteColor]];
    }
    return _ratingIcon;
}

- (UILabel *)numberOfRatingsLabel {
    if (_numberOfRatingsLabel == nil) {
        _numberOfRatingsLabel = [[UILabel alloc] init];
        [_numberOfRatingsLabel setTextColor: [UIColor whiteColor]];
        [_numberOfRatingsLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];

    }
    return _numberOfRatingsLabel;
}

- (UILabel *)priceRatingLabel {
    if (_priceRatingLabel == nil) {
        _priceRatingLabel = [[UILabel alloc] init];
        [_priceRatingLabel setTextColor: [UIColor whiteColor]];
        [_priceRatingLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
    }
    return _priceRatingLabel;
}

- (UILabel *)addressLabel {
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setTextColor: [UIColor whiteColor]];
        [_addressLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
        [_addressLabel setNumberOfLines:2];
    }
    return _addressLabel;
}

#pragma mark - View setup

- (void)setupSubviews {

    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [[UIColor alloc] initWithRed:2 green:2 blue:2 alpha:0.1];

    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.ratingLabel];
    [self addSubview:self.ratingIcon];
    [self addSubview:self.numberOfRatingsLabel];
    [self addSubview:self.priceRatingLabel];
    [self addSubview:self.addressLabel];
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
    [self.titleLabel alignTrailingEdgeWithView:self predicate:@"-12"];

    // rating label
    [self.ratingLabel alignAttribute:NSLayoutAttributeTop
                        toAttribute:NSLayoutAttributeBottom
                             ofView:self.titleLabel
                          predicate:@"7"];
    [self.ratingLabel alignLeadingEdgeWithView:self.titleLabel predicate:@"0"];

    // rating icon
    [self.ratingIcon alignAttribute:NSLayoutAttributeLeading
                        toAttribute:NSLayoutAttributeTrailing
                             ofView:self.ratingLabel
                          predicate:@"2"];
    [self.ratingIcon alignCenterYWithView:self.ratingLabel predicate:@"0"];

    // number of ratings label
    [self.numberOfRatingsLabel alignCenterYWithView:self.ratingLabel predicate:@"0"];
    [self.numberOfRatingsLabel alignAttribute:NSLayoutAttributeLeading
                                  toAttribute:NSLayoutAttributeTrailing
                                       ofView:self.ratingIcon
                                    predicate:@"6"];
    NSLayoutConstraint *trailingConstraint = [self.numberOfRatingsLabel alignTrailingEdgeWithView:self predicate:@"-12"];
    [trailingConstraint setPriority:UILayoutPriorityDefaultLow];

    // price rating label
    [self.priceRatingLabel alignAttribute:NSLayoutAttributeTop
                              toAttribute:NSLayoutAttributeBottom
                                   ofView:self.ratingLabel
                                predicate:@"7"];
    [self.priceRatingLabel alignLeadingEdgeWithView:self.ratingLabel predicate:@"0"];

    // address label
    [self.addressLabel alignBottomEdgeWithView:self predicate:@"-12"];
    [self.addressLabel alignLeadingEdgeWithView:self.titleLabel predicate:@"0"];
    [self.addressLabel alignTrailingEdgeWithView:self predicate:@"-12"];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.imageView.image = nil;
}

#pragma mark - Setters

- (void)setData:(id)data {
    _data = data;

    [self updateUIWithLocation:_data];
}

#pragma mark - Private methods

- (void)updateUIWithLocation:(APBLocationMO *)location {

    // image view
    NSURL *imageUrl = [NSURL URLWithString:location.thumbnailUrl];

    if (imageUrl != nil) {
        [self.imageView setImageWithUrlWithCrossfade:imageUrl];
    }

    [self.titleLabel setText:location.name];
    [self.ratingLabel setText:[NSString stringWithFormat:@"%.1f", location.rating]];
    [self.addressLabel setText:location.vicinity];

    NSString *numberOfRatingsText = [NSString stringWithFormat:@"%hd Reviews", location.userRatingsTotal];
    [self.numberOfRatingsLabel setText:numberOfRatingsText];

    NSString *currencySymbol = [[NSLocale currentLocale] currencySymbol];
    NSString *priceText = [NSString stringWithFormat:@"%@%@%@%@", currencySymbol, currencySymbol, currencySymbol, currencySymbol];

    if (location.priceLevel == 4) {
        [self.priceRatingLabel setTextColor:[UIColor whiteColor]];
        [self.priceRatingLabel setText:priceText];
    } else if (location.priceLevel == 0) {
        [self.priceRatingLabel setTextColor:[UIColor grayColor]];
        [self.priceRatingLabel setText:priceText];
    } else {
        NSMutableAttributedString *priceAttributedText = [[NSMutableAttributedString alloc] initWithString:priceText];
        [priceAttributedText addAttribute:NSForegroundColorAttributeName
                                    value:[UIColor whiteColor]
                                    range:NSMakeRange(0, location.priceLevel - 1)];
        [priceAttributedText addAttribute:NSForegroundColorAttributeName
                                    value:[UIColor grayColor]
                                    range:NSMakeRange(location.priceLevel, priceText.length - location.priceLevel)];
        [self.priceRatingLabel setAttributedText:priceAttributedText];
    }
}

@end
