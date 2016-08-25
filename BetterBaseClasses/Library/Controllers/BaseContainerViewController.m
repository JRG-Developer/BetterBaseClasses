//
//  BaseContainerViewController.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/24/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BaseContainerViewController.h"


@interface BaseContainerViewController()
@property (assign, nonatomic) CGFloat bottomContainerViewHeightConstraintConstant;
@property (assign, nonatomic) CGFloat topContainerViewHeightConstraintConstant;
@end

@implementation BaseContainerViewController

static CGFloat _animationDuration = 0.25f;


#pragma mark - Class Configuration

+ (CGFloat)animationDuration {
  return _animationDuration;
}

+ (void)setAnimationDuration:(CGFloat)animationDuration {
  _animationDuration = animationDuration;
}


#pragma mark - Custom Accessors
#pragma mark -- Height Constraints

- (void)setBottomContainerViewHeightConstraint:(NSLayoutConstraint *)constraint {
  
  if (_bottomContainerViewHeightConstraint == constraint) { return; }
  _bottomContainerViewHeightConstraint = constraint;
  self.bottomContainerViewHeightConstraintConstant = constraint.constant;
}

- (void)setTopContainerViewHeightConstraint:(NSLayoutConstraint *)constraint {
  if (_topContainerViewHeightConstraint == constraint) { return; }
  _topContainerViewHeightConstraint = constraint;
  self.topContainerViewHeightConstraintConstant = constraint.constant;
}


#pragma mark -- Bottom View Controller

- (void)setBottomViewController:(UIViewController *)viewController {
  [self setBottomViewController:viewController animated:YES completion:nil];
}

- (void)setBottomViewController:(UIViewController *)viewController
                       animated:(BOOL) animated
                     completion:(void (^)())externalCompletion {
  
  if (_bottomViewController == viewController) { return; }
  
  [_bottomViewController willMoveToParentViewController:nil];
  
  __weak __typeof(self) weakSelf = self;
  __weak __typeof(_bottomViewController) weakExistingViewController = _bottomViewController;
  __weak __typeof(viewController) weakViewController = viewController;
  
  void (^completionClosure)() = ^ {
    __strong __typeof(weakSelf) strongSelf = weakSelf;
    __strong __typeof(weakExistingViewController) strongBottomViewController = weakExistingViewController;
    __strong __typeof(weakViewController) strongViewController = weakViewController;
    
    [strongBottomViewController removeFromParentViewController];
    [strongViewController didMoveToParentViewController:strongSelf];
    if (externalCompletion) { externalCompletion(); }
  };
  
  if (viewController) {
    [self addChildViewController:viewController];
  }

  [self setBottomContentView:viewController.view animated:animated completion:completionClosure];
  _bottomViewController = viewController;
}


#pragma mark -- Top View Controller

- (void)setTopViewController:(UIViewController *)viewController {
  [self setTopViewController:viewController animated:YES completion:nil];
}

- (void)setTopViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                  completion:(void (^)())externalCompletion {
  
  if (_topViewController == viewController) { return; }
  
  [_topViewController willMoveToParentViewController:nil];
  
  __weak __typeof(self) weakSelf = self;
  __weak __typeof(_topViewController) weakTopViewController = _topViewController;
  __weak __typeof(viewController) weakViewController = viewController;
  
  void (^completionClosure)() = ^ {
    __strong __typeof(weakSelf) strongSelf = weakSelf;
    __strong __typeof(weakTopViewController) strongTopViewController = weakTopViewController;
    __strong __typeof(weakViewController) strongViewController = weakViewController;
    [strongTopViewController removeFromParentViewController];
    [strongViewController didMoveToParentViewController:strongSelf];
    if (externalCompletion) { externalCompletion(); }
  };
  
  if (viewController) {
    [self addChildViewController:viewController];
  }
  
  [self setTopContentView:viewController.view animated:animated completion:completionClosure];
  _topViewController = viewController;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self adjustHeightConstraint:self.bottomContainerViewHeightConstraint
            toHideViewIfNeeded:self.bottomContainerView];
  
  [self adjustHeightConstraint:self.topContainerViewHeightConstraint
            toHideViewIfNeeded:self.topContainerView];
}

- (void)adjustHeightConstraint:(NSLayoutConstraint *)constraint toHideViewIfNeeded:(UIView *)view {
  
  if (view == nil || view.subviews.count > 0) { return; }
  constraint.constant = 0;
}


#pragma mark - Container Methods

- (void)setBottomContentView:(UIView *)contentView {
  [self setBottomContentView:contentView animated:YES completion:nil];
}

- (void)setBottomContentView:(UIView *)contentView
                    animated:(BOOL)animated
                  completion:(void(^)())completion {
  
  [self setContentView:contentView
         containerView:self.bottomContainerView
      heightConstraint:self.bottomContainerViewHeightConstraint
                height:self.bottomContainerViewHeightConstraintConstant
              animated:animated
            completion:completion];
}

- (void)setTopContentView:(UIView *)contentView {
  [self setTopContentView:contentView animated:YES completion:nil];
}

- (void)setTopContentView:(UIView *)contentView
                 animated:(BOOL)animated
               completion:(void(^)())completion
{
  
  [self setContentView:contentView
         containerView:self.topContainerView
      heightConstraint:self.topContainerViewHeightConstraint
                height: self.topContainerViewHeightConstraintConstant
              animated:animated
            completion:completion];
}

- (void)setContentView:(UIView *)contentView
         containerView:(UIView *)containerView
      heightConstraint:(NSLayoutConstraint *)heightConstraint
                height:(CGFloat)maxHeight
              animated:(BOOL) animated
            completion:(void(^)())externalCompletion {
  
  CGFloat animationDuration = animated ? _animationDuration : 0.0f;
  
  if (contentView == nil) {
    [self hideContainerView:containerView
           heightConstraint:heightConstraint
          animationDuration:animationDuration
                 completion:externalCompletion];
    return;
  }
  
  if (containerView.subviews.count == 0) {
    [self setNewContentView:contentView
              containerView:containerView
           heightConstraint:heightConstraint
                     height:maxHeight
          animationDuration:animationDuration
                 completion:externalCompletion];
    return;
  }
  
  [self replaceWithNewContentView:contentView
                    containerView:containerView
                           height:maxHeight
                animationDuration:animationDuration
                       completion:externalCompletion];
}

- (void)hideContainerView:(UIView *)containerView
         heightConstraint:(NSLayoutConstraint *)heightConstraint
        animationDuration:(CGFloat)animationDuration
               completion:(void(^)())externalCompletion {
  
  __weak __typeof(self.view) weakView = self.view;
  __weak __typeof(heightConstraint) weakConstraint = heightConstraint;
  
  void (^animations)() = ^{
    __strong __typeof(weakView) strongView = weakView;
    __strong __typeof(weakConstraint) strongConstraint = weakConstraint;
    strongConstraint.constant = 0.0f;
    [strongView layoutIfNeeded];
  };
  
  __weak __typeof(self) weakSelf = self;
  __weak __typeof(containerView) weakContainerView = containerView;
  void (^completion)(BOOL) = ^(BOOL completion) {
    __strong __typeof(weakSelf) strongSelf = weakSelf;
    __strong __typeof(weakContainerView) strongContainerView = weakContainerView;
    [strongSelf removeSubviewsFromParentView:strongContainerView.subviews];
    if (externalCompletion) { externalCompletion(); }
  };
  
  [UIView animateWithDuration:animationDuration animations:animations completion:completion];
}

- (void)setNewContentView:(UIView *)contentView
            containerView:(UIView *)containerView
         heightConstraint:(NSLayoutConstraint *)heightConstraint
                   height:(CGFloat)maxHeight
        animationDuration:(CGFloat)animationDuration
               completion:(void(^)())externalCompletion {
  
  contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  contentView.frame = containerView.bounds;
  [containerView addSubview:contentView];
  
  __weak __typeof(self.view) weakView = self.view;
  __weak __typeof(containerView) weakContainerView = containerView;
  __weak __typeof(heightConstraint) weakConstraint = heightConstraint;
  
  void (^animations)() = ^{
    __strong __typeof(weakView) strongView = weakView;
    __strong __typeof(weakContainerView) strongContainerView = weakContainerView;
    __strong __typeof(weakConstraint) strongConstraint = weakConstraint;
    strongConstraint.constant = maxHeight;
    [strongView layoutIfNeeded];
    [strongContainerView layoutIfNeeded];
  };
  
  void (^completion)(BOOL) = ^(BOOL completion) {
    if (externalCompletion) { externalCompletion(); }
  };

  [UIView animateWithDuration:animationDuration animations:animations completion:completion];
}

- (void)replaceWithNewContentView:(UIView *)contentView
                    containerView:(UIView *)containerView
                           height: (CGFloat)maxHeight
                animationDuration:(CGFloat)animationDuration
                       completion:(void(^)())externalCompletion {
  
  NSArray<UIView *> *subviews = [containerView.subviews copy]; // shallow copy
  __weak __typeof (subviews) weakSubviews = subviews;
  
  contentView.alpha = 0.0f;
  contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  contentView.frame = containerView.bounds;
  [containerView addSubview:contentView];
  
  
  void (^animations)() = ^{
    __strong __typeof(weakSubviews) strongSubviews = weakSubviews;
    for (UIView *subview in strongSubviews) { subview.alpha = 0.0f; }
    contentView.alpha = 1.0;
  };
  
  __weak __typeof(self) weakSelf = self;
  void (^completion)(BOOL) = ^(BOOL completion) {
    __strong __typeof(weakSelf) strongSelf = weakSelf;
    __strong __typeof(weakSubviews) strongSubviews = weakSubviews;
    [strongSelf removeSubviewsFromParentView:strongSubviews];
    if (externalCompletion) { externalCompletion(); }
  };
  
  [UIView animateWithDuration:animationDuration animations:animations completion:completion];
}

- (void)removeSubviewsFromParentView:(NSArray<UIView *> *)subviews {

  for (UIView *view in subviews) {
    [view removeFromSuperview];
  }
}

@end
