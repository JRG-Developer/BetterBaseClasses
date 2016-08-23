//
//  BaseTabBarController.h
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/23/16.
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

#import "UIViewController+BetterBaseClasses.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  @brief  `BaseTabBarController` is an abstract, base class meant to be subclassed instead of `UITabBarController`.
 *
 *  @discussion  This class is meant to be used with the `UIViewController+BetterBaseClasses` category, which provides convenience instantiation methods.
 *
 *  This class calls `commonInit` in each of the initializers provided by its super class. Additionally, it overrides certain view methods (`preferredInterfaceOrientationForPresentation`, `preferredStatusBarStyle`, `shouldAutorotate`, and `supportedInterfaceOrientations`) to forward these onto the currently showing view controller, which realistically is what you most likely expected it to do anyways... ;]
 */
@interface BaseTabBarController : UITabBarController

/**
 *  @brief  Use this method to configure the tab bar appearance.
 *
 *  @discussion  This method is called within `viewDidLoad`.
 *
 *  @warning Per Apple's documentation, you should NOT attempt to add any bar button items to this tab bar. Instead, you may only use it for appearance configuration (`barTintColor`, etc).
 *
 *  @param tabBar The tab bar belonging to this instance
 */
- (void)configureTabBar:(UITabBar *)tabBar;

@end

NS_ASSUME_NONNULL_END
