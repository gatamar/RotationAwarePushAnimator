//
//  RotationAwarePushAnimator.cpp
//  RotationAwarePushAnimator
//
//  Created by Olha Pavliuk on 15.06.2021.
//

#import "RotationAwarePushAnimator.h"
#import "FirstViewController.h"

@interface RotationAwarePushAnimator ()
{
    id<UIViewImplicitlyAnimating> _animator;
    id<UIViewControllerContextTransitioning> _context;
}

@end

@implementation RotationAwarePushAnimator

- (id<UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_animator) return _animator;
    
    _context = transitionContext;
    
    UIView* containerView = transitionContext.containerView;
    containerView.backgroundColor = UIColor.redColor;
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    //toView.alpha = 0;
    
    UIView* viewForMoving = [_delegate viewForMoving];
    [toView addSubview:viewForMoving];
    viewForMoving.frame = [_delegate viewFrame0];
    
    _animator = [[UIViewPropertyAnimator alloc] initWithDuration:5 curve:UIViewAnimationCurveEaseOut animations:^{
        viewForMoving.frame = [_delegate viewFrame1];
    }];
    
    [_animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        [self->_context finishInteractiveTransition];
        [self->_context completeTransition:YES];
        self->_context = nil;
    }];
    
    return _animator;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    id<UIViewImplicitlyAnimating> anim = [self interruptibleAnimatorForTransition:transitionContext];
    [anim startAnimation];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 10;
}


@end
