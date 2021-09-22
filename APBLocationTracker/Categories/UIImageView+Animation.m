//
//  UIImageView+Animation.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 18/09/2021
//

#import "UIImageView+Animation.h"
#import "APBHttpClient.h"
#import "NSURLSession+Extension.h"

@implementation UIImageView (Animation)

- (void)setImageWithUrlWithCrossfade:(NSURL *)url {

    APBHttpClient *client = [[APBHttpClient alloc] initWithSession:[NSURLSession sharedSession]];

    [client getWithURL:url headers:nil completionHandler:^(NSData * _Nullable data,
                                                           NSURLResponse * _Nullable response,
                                                           NSError * _Nullable error) {
        UIImage *image = [[UIImage alloc] initWithData:data];
        [UIView transitionWithView:self
                duration:0.3f
                options:UIViewAnimationOptionTransitionCrossDissolve
                animations:^{
          self.image = image;
        } completion:nil];
    }];
}

@end
