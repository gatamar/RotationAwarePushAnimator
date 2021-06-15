//
//  RotationAwarePushAnimator.hpp
//  RotationAwarePushAnimator
//
//  Created by Olha Pavliuk on 15.06.2021.
//

#import <UIKit/UIKit.h>

@protocol RotationAwarePushAnimatorDelegate <NSObject>
@required

- (UIView*)viewForMoving;
- (CGRect)viewFrame0;
- (CGRect)viewFrame1;

@end

@interface RotationAwarePushAnimator: NSObject <UIViewControllerAnimatedTransitioning>

@property (weak) id<RotationAwarePushAnimatorDelegate> delegate;

- (void)handleRotation;
- (void)animateAfterRotationToFrame:(CGRect)frame1;

@end
