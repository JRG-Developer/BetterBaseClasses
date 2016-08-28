//
//  BaseContainerViewController.h
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

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  @brief  `BaseContainerViewController` is an abstract, base class meant to be subclassed instead of `UIViewController`. This makes it easier to create container view controllers with a "top" and "bottom" content views or view controllers.
 *
 *  @discussion  This class is meant to be used with the `UIViewController+BetterBaseClasses` category, which provides convenience instantiation methods.
 *
 *  This class calls `commonInit` in each of the initializers provided by its super class. Additionally, it overrides certain view methods (`preferredInterfaceOrientationForPresentation`, `preferredStatusBarStyle`, `shouldAutorotate`, and `supportedInterfaceOrientations`) to forward these onto its child view controller.
 */
@interface BaseContainerViewController : BaseViewController

#pragma mark - Class Configuration

/**
 *  Use this method to get the animation duration used for showing and hiding the top and bottom container views.
 *
 *  @return The animation duration
 */
+ (CGFloat)animationDuration;

/**
 *  Use this method to set the animation duration for showing and hiding the top and bottom container views.
 *
 *  @param animationDuration The animation duration
 */
+ (void)setAnimationDuration:(CGFloat)animationDuration;


#pragma mark - Constraint Properties

/**
 *  Set this constraint if you want the bottom container to automatically show/hide whenever its content view is set via `setBottomContentView` or other related methods.
 */
@property (strong, nonatomic, nullable) IBOutlet NSLayoutConstraint *bottomContainerViewHeightConstraint;

/**
 *  Set this constraint if you want the top container to automatically show/hide whenever its content view is set via `setTopContentView` or related methods.
 */
@property (strong, nonatomic, nullable) IBOutlet NSLayoutConstraint *topContainerViewHeightConstraint;


#pragma mark - View Properties

/**
 *  You MAY set this outlet if you want to have a bottom container view.
 */
@property (strong, nonatomic, nullable) IBOutlet UIView *bottomContainerView;


/**
 *  You MAY set this outlet if you want to have a top container view.
 */
@property (strong, nonatomic, nullable) IBOutlet UIView *topContainerView;


#pragma mark - View Controller Properties

/**
 *  @brief  The bottom view controller
 *
 *  @discussion  This method calls `setBottomViewController: animated: completion:`, passing `YES` for `animated` and `nil` for completion.
 *
 *  @warning  You MUST set the `bottomContainerView` outlet in order for this view controller to be shown.
 */
@property (strong, nonatomic, nullable) UIViewController *bottomViewController;

/**
 *  @brief  The top view controller
 *
 *  @discussion  This method calls `setTopViewController: animated: completion:`, passing `YES` for `animated` and `nil` for completion.
 *
 *  @warning  You MUST set the `topContainerView` outlet in order for this view controller to be shown.
 *
 */
@property (strong, nonatomic, nullable) UIViewController *topViewController;


#pragma mark - Bottom Container View Methods

/**
 *  @brief  Use this method to hide/show the bottom container view.
 *
 *  @discussion  This is a convenience method that calls `setBottomContainerViewHidden: animated: completion:`, passing `YES` for `animated` and `nil` for `completion`.
 *
*  @param hidden   Whether or not the container view should be hidden
 */
- (void)setBottomContainerViewHidden:(BOOL)hidden;

/**
*  @brief  Use this method to hide/show the bottom container view.
*
*  @discussion  This method hides/shows the `bottomContainerView` by setting the `bottomContainerViewHeightConstraint`'s `constant` value. If this property is `nil`, this method doesn't do anything.
*
*  @param hidden   Whether or not the container view should be hidden
*  @param animated Whether or not the change should be animated
*  @param completion  The block to be called upon completion
*/
- (void)setBottomContainerViewHidden:(BOOL)hidden
                            animated:(BOOL)animated
                          completion:(nullable void(^)())completion;

/**
 *  @brief  Use this method to set `bottomContainerView`'s "content" view.
 *
 *  @discussion  If the `bottonContainerView` already has subview(s), they will ALl be replaced by this view.
 *
 *  You may pass `nil` into this method. If you do so, and `bottomContainerViewHeightConstraint` is set, the `bottomContainerViewHeightConstraint`'s `constant` will be animated and set to zero.
 *
 *  @param contentView The new content view
 */
- (void)setBottomContentView:(nullable UIView *)contentView;

/**
 *  @brief  Use this method to set `bottomContainerView`'s "content" view.
 *
 *  @discussion  If the `bottonContainerView` already has subview(s), they will ALL be replaced by this view.
 *
 *  You may pass `nil` into this method. If you do so, and `bottomContainerViewHeightConstraint` is set, the `bottomContainerViewHeightConstraint`'s `constant` will be animated and set to zero.
 *
 *  @param contentView The new content view
 *  @param animated    Whether or not the change should be animated
 *  @param completion  The block to be called upon completion
 */
- (void)setBottomContentView:(nullable UIView *)contentView animated:(BOOL)animated completion:(nullable void(^)())completion;

/**
 *  @brief  Use this method to set the `bottomViewController`.
 *
 *  @discussion  This method removes the existing `bottomViewController` and adds the new view controller as a child view controller of this view controller.
 *
 *  You MAY pass `nil` to remove the `bottomViewController` and its `view`.
 *
 *  @warning  You MUST set the `bottomContainerView` outlet in order for this view controller to be shown.
 *
 *  @param viewController The new bottom view controller
 *  @param animated       Whether or not the change should be animated
 *  @param completion     The block to be called upon completion
 */
- (void)setBottomViewController:(nullable UIViewController *)viewController animated:(BOOL) animated completion:(nullable void(^)())completion;


#pragma mark - Top Container View Methods

/**
 *  @brief  Use this method to hide/show the top container view.
 *
 *  @discussion  This is a convenience method that calls `setTopContainerViewHidden: animated: completion:`, passing `YES` for `animated` and `nil` for `completion`.
 *
 *  @param hidden   Whether or not the container view should be hidden
 */
- (void)setTopContainerViewHidden:(BOOL)hidden;

/**
 *  @brief  Use this method to hide/show the top container view.
 *
 *  @discussion  This method hides/shows the `topContainerView` by setting the `topContainerViewHeightConstraint`'s `constant` value. If this property is `nil`, this method doesn't do anything.
 *
 *  @param hidden   Whether or not the container view should be hidden
 *  @param animated Whether or not the change should be animated
 *  @param completion     The block to be called upon completion
 */
- (void)setTopContainerViewHidden:(BOOL)hidden
                         animated:(BOOL)animated
                       completion:(nullable void(^)())completion;

/**
 *  @brief  Use this method to set `topContainerView`'s "content" view.
 *
 *  @discussion  If the `topContainerView` already has subview(s), they will ALl be replaced by this view.
 *
 *  You may pass `nil` into this method. If you do so, and `topContainerViewHeightConstraint` is set, the `topContainerViewHeightConstraint`'s `constant` will be animated and set to zero.
 *
 *  @param contentView The new content view
 */
- (void)setTopContentView:(nullable UIView *)contentView;

/**
 *  @brief  Use this method to set `topContainerView`'s "content" view.
 *
 *  @discussion  If the `topContainerView` already has subview(s), they will ALl be replaced by this view.
 *
 *  You may pass `nil` into this method. If you do so, and `topContainerViewHeightConstraint` is set, the `topContainerViewHeightConstraint`'s `constant` will be animated and set to zero.
 *
 *  @param contentView The new content view
 *  @param animated    Whether or not the change should be animated
 *  @param completion  The block to be called upon completion
 */
- (void)setTopContentView:(nullable UIView *)contentView animated:(BOOL)animated completion:(nullable void(^)())completion;

/**
 *  @brief  Use this method to set the `topViewController`.
 *
 *  @discussion  This method removes the existing `topViewController` and adds the new view controller as a child view controller of this view controller.
 *
 *  You MAY pass `nil` to remove the `topViewController` and its `view`.
 *
 *  @warning  You MUST set the `topContainerView` outlet in order for this view controller to be shown.
 *
 *  @param viewController The new top view controller
 *  @param animated       Whether or not the change should be animated
 *  @param completion     The block to be called upon completion
 */
- (void)setTopViewController:(nullable UIViewController *)viewController animated:(BOOL) animated completion:(nullable void(^)())completion;

@end

NS_ASSUME_NONNULL_END
