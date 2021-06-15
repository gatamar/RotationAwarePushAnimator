//
//  ViewController.m
//  RotationAwarePushAnimator
//
//  Created by Olha Pavliuk on 15.06.2021.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "RotationAwarePushAnimator.h"

@interface FirstViewController () <UINavigationControllerDelegate, RotationAwarePushAnimatorDelegate>
{
    UIButton* _pushButton;
    UIImageView* _imageView;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.view.backgroundColor = UIColor.yellowColor;
    [self addPushButton];
    [self addImageView];
}

- (void)addPushButton
{
    if (!_pushButton)
    {
        _pushButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 150, 50)];
        _pushButton.backgroundColor = UIColor.redColor;
        [_pushButton setTitle:@"push" forState:UIControlStateNormal];
        [_pushButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_pushButton addTarget:self
                        action:@selector(onPushButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_pushButton];
    }
}

- (void)addImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:[self viewFrame0]];
    [_imageView setImage:[UIImage imageNamed:@"pikachu"]];
    [self.view addSubview:_imageView];
}

- (void)onPushButtonPressed
{
    SecondViewController* vc2 = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

//MARK: UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (fromVC == self)
    {
        RotationAwarePushAnimator* obj = [[RotationAwarePushAnimator alloc] init];
        obj.delegate = self;
        return obj;
    }
    return nil;
}

//MARK: RotationAwarePushAnimatorDelegate
- (UIView*)viewForMoving
{
    return _imageView;
}

- (CGRect)viewFrame0
{
    double side = 200, ww = self.view.frame.size.width;
    return CGRectMake((ww-side)/2, 100, side, side);
}

- (CGRect)viewFrame1
{
    double ww = self.view.frame.size.width, hh = self.view.frame.size.height;
    double side = fmin(ww, hh);
    return CGRectMake((ww-side)/2, (hh-side)/2, side, side);
}

@end
