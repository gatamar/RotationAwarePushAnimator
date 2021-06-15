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
    UIView* _viewForMoving;
}

@end

@implementation RotationAwarePushAnimator

- (void)handleRotation
{
    //[_animator pauseAnimation];
    [_animator stopAnimation:NO];
    [_animator finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
}

- (void)animateAfterRotationToFrame:(CGRect)frame1
{
    [UIView animateWithDuration:4 animations:^{
            _viewForMoving.frame = frame1;
    }];
//    [_animator addAnimations:^{
//        _viewForMoving.frame = frame1; //TODO: do it with animator
//    }];
//    [_animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
//        [_animator stopAnimation:NO];
//        [_animator finishAnimationAtPosition:finalPosition];
//    }];
//
//    [_animator startAnimation];
}

- (id<UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_animator) return _animator;
    
    _context = transitionContext;
    
    UIView* containerView = transitionContext.containerView;
    containerView.backgroundColor = UIColor.redColor;
    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    //toView.alpha = 0;
    
    _viewForMoving = [_delegate viewForMoving];
    [toView addSubview:_viewForMoving];
    _viewForMoving.frame = [_delegate viewFrame0];
    
    _animator = [[UIViewPropertyAnimator alloc] initWithDuration:5 curve:UIViewAnimationCurveEaseOut animations:^{
        _viewForMoving.frame = [_delegate viewFrame1];
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
