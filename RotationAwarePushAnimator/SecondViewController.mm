//
//  SecondViewController.m
//  RotationAwarePushAnimator
//
//  Created by Olha Pavliuk on 15.06.2021.
//

#import "SecondViewController.h"

@interface SecondViewController () <RotationAwarePushAnimatorDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    assert(self.animator);
    [self.animator handleRotation];
    
    //TODO: animateAlongsideTransitionInView
    
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {

    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [_animator animateAfterRotationToFrame:[self viewFrame1]];
    }];
}

- (CGRect)viewFrame1
{
    double ww = self.view.frame.size.width, hh = self.view.frame.size.height;
    double side = fmin(ww, hh);
    return CGRectMake((ww-side)/2, (hh-side)/2, side, side);
}

@end
